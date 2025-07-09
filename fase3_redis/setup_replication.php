<?php

/**
 * Script para configurar replicação do Redis
 * Configura um master e um slave para alta disponibilidade
 */

echo "Configurando replicação do Redis...\n\n";

// Verifica se estamos no Windows
$isWindows = PHP_OS_FAMILY === 'Windows';
$redisDir = $isWindows ? 'C:\\Redis' : '/etc/redis';
$redisBin = $isWindows ? 'C:\\Redis\\redis-server.exe' : '/usr/bin/redis-server';

// Configuração do Master
$masterConfig = <<<EOT
port 6379
bind 127.0.0.1
maxmemory 128mb
maxmemory-policy allkeys-lru
appendonly yes
appendfilename "master-appendonly.aof"
dir ./
requirepass masterpass
masterauth masterpass
EOT;

// Configuração do Slave
$slaveConfig = <<<EOT
port 6380
bind 127.0.0.1
maxmemory 128mb
maxmemory-policy allkeys-lru
appendonly yes
appendfilename "slave-appendonly.aof"
dir ./
slaveof 127.0.0.1 6379
masterauth masterpass
requirepass slavepass
EOT;

try {
    // Cria diretório de configuração se não existir
    if (!is_dir($redisDir)) {
        mkdir($redisDir, 0755, true);
        echo "✓ Diretório de configuração criado\n";
    }

    // Salva configurações
    $masterFile = $redisDir . ($isWindows ? '\\' : '/') . 'redis-master.conf';
    $slaveFile = $redisDir . ($isWindows ? '\\' : '/') . 'redis-slave.conf';

    file_put_contents($masterFile, $masterConfig);
    file_put_contents($slaveFile, $slaveConfig);

    echo "✓ Arquivos de configuração criados\n";

    // Cria scripts de inicialização
    if ($isWindows) {
        // Batch para Windows
        $startMaster = "@echo off\n";
        $startMaster .= "echo Iniciando Redis Master...\n";
        $startMaster .= "\"$redisBin\" \"$masterFile\"\n";

        $startSlave = "@echo off\n";
        $startSlave .= "echo Iniciando Redis Slave...\n";
        $startSlave .= "\"$redisBin\" \"$slaveFile\"\n";

        file_put_contents($redisDir . '\\start-master.bat', $startMaster);
        file_put_contents($redisDir . '\\start-slave.bat', $startSlave);

        echo "✓ Scripts batch criados\n";
    } else {
        // Scripts shell para Linux/Unix
        $startMaster = "#!/bin/bash\n";
        $startMaster .= "echo 'Iniciando Redis Master...'\n";
        $startMaster .= "$redisBin $masterFile\n";

        $startSlave = "#!/bin/bash\n";
        $startSlave .= "echo 'Iniciando Redis Slave...'\n";
        $startSlave .= "$redisBin $slaveFile\n";

        $masterScript = $redisDir . '/start-master.sh';
        $slaveScript = $redisDir . '/start-slave.sh';

        file_put_contents($masterScript, $startMaster);
        file_put_contents($slaveScript, $startSlave);

        chmod($masterScript, 0755);
        chmod($slaveScript, 0755);

        echo "✓ Scripts shell criados\n";
    }

    // Cria script de monitoramento
    $monitor = <<<'EOT'
<?php
require_once(__DIR__ . '/RedisCache.php');

function checkRedis($host, $port, $auth) {
    try {
        $redis = new Redis();
        $redis->connect($host, $port);
        $redis->auth($auth);
        
        $info = $redis->info();
        return [
            'status' => 'online',
            'role' => $info['role'],
            'connected_slaves' => isset($info['connected_slaves']) ? $info['connected_slaves'] : 0,
            'used_memory' => $info['used_memory_human'],
            'total_connections_received' => $info['total_connections_received'],
            'total_commands_processed' => $info['total_commands_processed']
        ];
    } catch (Exception $e) {
        return [
            'status' => 'offline',
            'error' => $e->getMessage()
        ];
    }
}

// Verifica master
$master = checkRedis('127.0.0.1', 6379, 'masterpass');
echo "Master Status:\n";
echo "----------------------------------------\n";
foreach ($master as $key => $value) {
    echo "$key: $value\n";
}

echo "\nSlave Status:\n";
echo "----------------------------------------\n";
$slave = checkRedis('127.0.0.1', 6380, 'slavepass');
foreach ($slave as $key => $value) {
    echo "$key: $value\n";
}
EOT;

    file_put_contents(__DIR__ . '/monitor_replication.php', $monitor);
    echo "✓ Script de monitoramento criado\n";

    // Instruções
    echo "\nConfiguração concluída!\n\n";
    echo "Para iniciar o Redis:\n\n";

    if ($isWindows) {
        echo "1. Master:\n";
        echo "   cd $redisDir\n";
        echo "   .\\start-master.bat\n\n";

        echo "2. Slave:\n";
        echo "   cd $redisDir\n";
        echo "   .\\start-slave.bat\n";
    } else {
        echo "1. Master:\n";
        echo "   $masterScript\n\n";

        echo "2. Slave:\n";
        echo "   $slaveScript\n";
    }

    echo "\nPara monitorar a replicação:\n";
    echo "php " . __DIR__ . "/monitor_replication.php\n\n";

    echo "Senhas configuradas:\n";
    echo "- Master: masterpass\n";
    echo "- Slave: slavepass\n\n";

    echo "IMPORTANTE: Mantenha estas senhas em local seguro!\n";
} catch (Exception $e) {
    echo "Erro durante a configuração: " . $e->getMessage() . "\n";
    exit(1);
}
