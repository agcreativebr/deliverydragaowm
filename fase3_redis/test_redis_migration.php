<?php
require_once(__DIR__ . '/../sistema/conexao.php');
require_once(__DIR__ . '/../sistema/QueryOptimizer.php');
require_once(__DIR__ . '/../sistema/RedisCache.php');

try {
    echo "Iniciando testes de migração para Redis...\n\n";

    // Fase 1: Teste de Conexão
    echo "Fase 1: Teste de Conexão\n";
    echo "--------------------------------\n";
    $redis = RedisCache::getInstance();

    if ($redis->isRedisAvailable()) {
        echo "✓ Redis conectado com sucesso\n";
        $stats = $redis->getStats();
        echo "Memória utilizada: " . $stats['redis_info']['used_memory'] . "\n";
        echo "Total de chaves: " . $stats['redis_info']['total_keys'] . "\n";
    } else {
        echo "✗ Redis não disponível - usando cache de fallback\n";
    }
    echo "\n";

    // Fase 2: Teste de Operações Básicas
    echo "Fase 2: Operações Básicas\n";
    echo "--------------------------------\n";

    // Test SET
    $redis->set('test_key', 'test_value', 60);
    echo "✓ SET realizado\n";

    // Test GET
    $value = $redis->get('test_key');
    if ($value === 'test_value') {
        echo "✓ GET funcionando corretamente\n";
    } else {
        echo "✗ Erro no GET\n";
    }

    // Test DELETE
    $redis->delete('test_key');
    if ($redis->get('test_key') === null) {
        echo "✓ DELETE funcionando corretamente\n";
    } else {
        echo "✗ Erro no DELETE\n";
    }
    echo "\n";

    // Fase 3: Teste de Migração
    echo "Fase 3: Migração de Cache\n";
    echo "--------------------------------\n";

    // Cria dados de teste no cache antigo
    $oldCache = [
        'test_1' => ['value' => 'valor1', 'expires' => time() + 3600],
        'test_2' => ['value' => 'valor2', 'expires' => time() + 3600],
        'test_3' => ['value' => 'valor3', 'expires' => time() - 3600] // Expirado
    ];

    // Tenta migrar
    $result = $redis->migrateFromOldCache($oldCache);
    echo "Total migrado: " . $result['migrated'] . "\n";
    echo "Erros: " . $result['errors'] . "\n";

    // Verifica dados migrados
    $success = true;
    foreach ($oldCache as $key => $data) {
        if ($data['expires'] > time()) {
            $value = $redis->get($key);
            if ($value !== $data['value']) {
                $success = false;
                echo "✗ Erro na migração da chave: $key\n";
            }
        }
    }

    if ($success) {
        echo "✓ Migração realizada com sucesso\n";
    }
    echo "\n";

    // Fase 4: Teste de Performance
    echo "Fase 4: Teste de Performance\n";
    echo "--------------------------------\n";

    // Teste com Redis
    $inicio = microtime(true);
    for ($i = 0; $i < 1000; $i++) {
        $redis->set("perf_test_$i", "value_$i", 60);
    }
    $tempo_set = microtime(true) - $inicio;

    $inicio = microtime(true);
    for ($i = 0; $i < 1000; $i++) {
        $redis->get("perf_test_$i");
    }
    $tempo_get = microtime(true) - $inicio;

    echo "Tempo para 1000 SETs: " . number_format($tempo_set, 4) . " segundos\n";
    echo "Tempo para 1000 GETs: " . number_format($tempo_get, 4) . " segundos\n";

    // Limpa dados de teste
    for ($i = 0; $i < 1000; $i++) {
        $redis->delete("perf_test_$i");
    }

    echo "\nTestes concluídos com sucesso!\n";
} catch (Exception $e) {
    echo "Erro durante os testes: " . $e->getMessage() . "\n";
    exit(1);
}
