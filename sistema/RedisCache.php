<?php

/**
 * Classe RedisCache
 * Implementa cache distribuído usando Redis
 * 
 * IMPORTANTE: Esta classe implementa um sistema de fallback para o cache em memória
 * caso o Redis não esteja disponível, garantindo zero downtime durante a migração.
 */
class RedisCache
{
    private $redis;
    private $fallbackCache;
    private $useRedis = false;
    private static $instance = null;

    /**
     * Construtor privado - Singleton Pattern
     */
    private function __construct()
    {
        // Inicializa o cache de fallback
        $this->fallbackCache = [];

        try {
            // Tenta conectar ao Redis
            if (class_exists('Redis')) {
                $this->redis = new Redis();
                $this->redis->connect('127.0.0.1', 6379);
                $this->redis->setOption(Redis::OPT_SERIALIZER, Redis::SERIALIZER_PHP);
                $this->useRedis = true;

                // Log de sucesso
                error_log("Redis conectado com sucesso");
            }
        } catch (Exception $e) {
            // Log do erro
            error_log("Erro ao conectar com Redis: " . $e->getMessage());
            $this->useRedis = false;
        }
    }

    /**
     * Obtém a instância única da classe
     */
    public static function getInstance()
    {
        if (self::$instance === null) {
            self::$instance = new self();
        }
        return self::$instance;
    }

    /**
     * Define um valor no cache
     */
    public function set($key, $value, $ttl = 900)
    {
        try {
            if ($this->useRedis) {
                return $this->redis->setex($key, $ttl, $value);
            }
        } catch (Exception $e) {
            error_log("Erro ao definir valor no Redis: " . $e->getMessage());
            $this->useRedis = false;
        }

        // Fallback para cache em memória
        $this->fallbackCache[$key] = [
            'value' => $value,
            'expires' => time() + $ttl
        ];

        return true;
    }

    /**
     * Obtém um valor do cache
     */
    public function get($key)
    {
        try {
            if ($this->useRedis) {
                $value = $this->redis->get($key);
                if ($value !== false) {
                    return $value;
                }
            }
        } catch (Exception $e) {
            error_log("Erro ao obter valor do Redis: " . $e->getMessage());
            $this->useRedis = false;
        }

        // Fallback para cache em memória
        if (isset($this->fallbackCache[$key])) {
            if ($this->fallbackCache[$key]['expires'] > time()) {
                return $this->fallbackCache[$key]['value'];
            }
            unset($this->fallbackCache[$key]);
        }

        return null;
    }

    /**
     * Remove um valor do cache
     */
    public function delete($key)
    {
        try {
            if ($this->useRedis) {
                $this->redis->del($key);
            }
        } catch (Exception $e) {
            error_log("Erro ao deletar valor do Redis: " . $e->getMessage());
            $this->useRedis = false;
        }

        // Remove do fallback também
        unset($this->fallbackCache[$key]);

        return true;
    }

    /**
     * Limpa todo o cache
     */
    public function clear()
    {
        try {
            if ($this->useRedis) {
                $this->redis->flushDB();
            }
        } catch (Exception $e) {
            error_log("Erro ao limpar Redis: " . $e->getMessage());
            $this->useRedis = false;
        }

        // Limpa o fallback
        $this->fallbackCache = [];

        return true;
    }

    /**
     * Verifica se o Redis está disponível
     */
    public function isRedisAvailable()
    {
        return $this->useRedis;
    }

    /**
     * Obtém estatísticas do cache
     */
    public function getStats()
    {
        $stats = [
            'redis_available' => $this->useRedis,
            'fallback_keys' => count($this->fallbackCache)
        ];

        if ($this->useRedis) {
            try {
                $info = $this->redis->info();
                $stats['redis_info'] = [
                    'used_memory' => $info['used_memory_human'],
                    'total_keys' => $this->redis->dbSize(),
                    'uptime' => $info['uptime_in_seconds']
                ];
            } catch (Exception $e) {
                error_log("Erro ao obter estatísticas do Redis: " . $e->getMessage());
                $stats['redis_error'] = $e->getMessage();
            }
        }

        return $stats;
    }

    /**
     * Migra dados do cache antigo para o Redis
     */
    public function migrateFromOldCache($oldCache)
    {
        $migrated = 0;
        $errors = 0;

        foreach ($oldCache as $key => $data) {
            try {
                if (isset($data['expires']) && $data['expires'] > time()) {
                    $ttl = $data['expires'] - time();
                    $this->set($key, $data['value'], $ttl);
                    $migrated++;
                }
            } catch (Exception $e) {
                error_log("Erro ao migrar chave $key: " . $e->getMessage());
                $errors++;
            }
        }

        return [
            'migrated' => $migrated,
            'errors' => $errors
        ];
    }
}
