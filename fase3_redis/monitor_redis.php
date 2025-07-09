<?php
require_once(__DIR__ . '/../sistema/conexao.php');
require_once(__DIR__ . '/../sistema/RedisCache.php');

/**
 * Script de monitoramento do Redis
 * Executa a cada 5 minutos via cron para coletar métricas
 */

function formatBytes($bytes, $precision = 2) {
    $units = ['B', 'KB', 'MB', 'GB', 'TB'];
    $bytes = max($bytes, 0);
    $pow = floor(($bytes ? log($bytes) : 0) / log(1024));
    $pow = min($pow, count($units) - 1);
    return round($bytes / pow(1024, $pow), $precision) . ' ' . $units[$pow];
}

function logMetric($metric, $value) {
    $logFile = __DIR__ . '/redis_metrics.log';
    $timestamp = date('Y-m-d H:i:s');
    file_put_contents($logFile, "[$timestamp] $metric: $value\n", FILE_APPEND);
}

try {
    echo "Iniciando monitoramento do Redis...\n";
    
    $redis = RedisCache::getInstance();
    
    if (!$redis->isRedisAvailable()) {
        throw new Exception("Redis não está disponível");
    }
    
    // Coleta métricas básicas
    $stats = $redis->getStats();
    $info = $stats['redis_info'];
    
    // Métricas de memória
    $memoryUsed = $info['used_memory'];
    $memoryPeak = $info['used_memory_peak'];
    $memoryFragmentation = $info['mem_fragmentation_ratio'];
    
    echo "Memória:\n";
    echo "- Uso atual: " . formatBytes($memoryUsed) . "\n";
    echo "- Pico: " . formatBytes($memoryPeak) . "\n";
    echo "- Fragmentação: {$memoryFragmentation}x\n\n";
    
    logMetric('memory_used', formatBytes($memoryUsed));
    logMetric('memory_peak', formatBytes($memoryPeak));
    logMetric('memory_fragmentation', $memoryFragmentation);
    
    // Métricas de performance
    $totalCommands = $info['total_commands_processed'];
    $opsPerSec = $info['instantaneous_ops_per_sec'];
    $hitRate = isset($info['keyspace_hits']) ? 
        ($info['keyspace_hits'] / ($info['keyspace_hits'] + $info['keyspace_misses'])) * 100 : 0;
    
    echo "Performance:\n";
    echo "- Comandos processados: $totalCommands\n";
    echo "- Operações/segundo: $opsPerSec\n";
    echo "- Hit rate: " . number_format($hitRate, 2) . "%\n\n";
    
    logMetric('total_commands', $totalCommands);
    logMetric('ops_per_sec', $opsPerSec);
    logMetric('hit_rate', number_format($hitRate, 2));
    
    // Métricas de conexão
    $connectedClients = $info['connected_clients'];
    $blockedClients = $info['blocked_clients'];
    $rejectedConns = $info['rejected_connections'];
    
    echo "Conexões:\n";
    echo "- Clientes conectados: $connectedClients\n";
    echo "- Clientes bloqueados: $blockedClients\n";
    echo "- Conexões rejeitadas: $rejectedConns\n\n";
    
    logMetric('connected_clients', $connectedClients);
    logMetric('blocked_clients', $blockedClients);
    logMetric('rejected_connections', $rejectedConns);
    
    // Verifica limites críticos
    $alerts = [];
    
    if ($memoryFragmentation > 3) {
        $alerts[] = "Alta fragmentação de memória: {$memoryFragmentation}x";
    }
    
    if ($hitRate < 50) {
        $alerts[] = "Hit rate baixo: " . number_format($hitRate, 2) . "%";
    }
    
    if ($rejectedConns > 0) {
        $alerts[] = "Conexões estão sendo rejeitadas: $rejectedConns";
    }
    
    if ($blockedClients > 0) {
        $alerts[] = "Existem clientes bloqueados: $blockedClients";
    }
    
    // Registra alertas se houver
    if (!empty($alerts)) {
        echo "ALERTAS:\n";
        foreach ($alerts as $alert) {
            echo "! $alert\n";
            logMetric('ALERT', $alert);
        }
    }
    
    // Salva métricas para análise histórica
    $metrics = [
        'timestamp' => time(),
        'memory' => [
            'used' => $memoryUsed,
            'peak' => $memoryPeak,
            'fragmentation' => $memoryFragmentation
        ],
        'performance' => [
            'total_commands' => $totalCommands,
            'ops_per_sec' => $opsPerSec,
            'hit_rate' => $hitRate
        ],
        'connections' => [
            'connected' => $connectedClients,
            'blocked' => $blockedClients,
            'rejected' => $rejectedConns
        ],
        'alerts' => $alerts
    ];
    
    $metricsFile = __DIR__ . '/metrics/redis_' . date('Y-m-d_H-i-s') . '.json';
    if (!is_dir(__DIR__ . '/metrics')) {
        mkdir(__DIR__ . '/metrics');
    }
    
    file_put_contents($metricsFile, json_encode($metrics, JSON_PRETTY_PRINT));
    echo "\nMétricas salvas em: $metricsFile\n";
    
    // Limpa arquivos antigos (mantém últimas 24h)
    $files = glob(__DIR__ . '/metrics/redis_*.json');
    $yesterday = time() - (24 * 60 * 60);
    
    foreach ($files as $file) {
        if (filemtime($file) < $yesterday) {
            unlink($file);
        }
    }
    
} catch (Exception $e) {
    $error = "Erro no monitoramento: " . $e->getMessage() . "\n";
    echo $error;
    error_log($error);
    exit(1); 