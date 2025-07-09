<?php
require_once(__DIR__ . '/../sistema/conexao.php');
require_once(__DIR__ . '/../sistema/RedisCache.php');

echo "Iniciando procedimento de rollback do Redis...\n\n";

try {
    // Verifica se existe arquivo de status
    if (!file_exists(__DIR__ . '/redis_status.json')) {
        die("Arquivo de status não encontrado. Rollback não é necessário.\n");
    }

    $status = json_decode(file_get_contents(__DIR__ . '/redis_status.json'), true);
    echo "Status anterior:\n";
    echo "Versão: " . $status['version'] . "\n";
    echo "Instalado em: " . $status['timestamp'] . "\n\n";

    // Obtém instância do Redis
    $redis = RedisCache::getInstance();

    if ($redis->isRedisAvailable()) {
        echo "Iniciando backup dos dados do Redis...\n";

        // Backup das chaves atuais
        $stats = $redis->getStats();
        $backupFile = __DIR__ . '/redis_backup_' . date('Y-m-d_H-i-s') . '.json';

        $backup = [
            'timestamp' => date('Y-m-d H:i:s'),
            'total_keys' => $stats['redis_info']['total_keys'],
            'data' => []
        ];

        // Obtém todas as chaves e seus valores
        if ($redis->isRedisAvailable()) {
            try {
                $keys = $redis->redis->keys('*');
                foreach ($keys as $key) {
                    $value = $redis->get($key);
                    if ($value !== null) {
                        $backup['data'][$key] = $value;
                    }
                }

                file_put_contents($backupFile, json_encode($backup, JSON_PRETTY_PRINT));
                echo "✓ Backup realizado com sucesso: $backupFile\n";
            } catch (Exception $e) {
                echo "! Erro ao fazer backup: " . $e->getMessage() . "\n";
            }
        }

        // Limpa o Redis
        echo "\nLimpando dados do Redis...\n";
        $redis->clear();
        echo "✓ Dados do Redis limpos\n";

        // Restaura cache antigo
        echo "\nRestaurando sistema para cache em memória...\n";
        if (file_exists($backupFile)) {
            $backup = json_decode(file_get_contents($backupFile), true);
            foreach ($backup['data'] as $key => $value) {
                $redis->set($key, $value, 3600); // 1 hora de TTL padrão
            }
            echo "✓ Dados restaurados para cache em memória\n";
        }
    } else {
        echo "Redis não está disponível - rollback não é necessário\n";
    }

    // Remove arquivo de status
    unlink(__DIR__ . '/redis_status.json');
    echo "\n✓ Rollback concluído com sucesso!\n";
    echo "Um backup dos dados foi salvo em: $backupFile\n";
} catch (Exception $e) {
    echo "Erro durante o rollback: " . $e->getMessage() . "\n";
    exit(1);
}
