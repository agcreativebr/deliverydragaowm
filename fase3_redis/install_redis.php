<?php
echo "Verificando requisitos para instalação do Redis...\n\n";

// Verifica se o PHP está instalado e sua versão
if (version_compare(PHP_VERSION, '7.0.0', '<')) {
    die("Erro: PHP 7.0.0 ou superior é necessário. Versão atual: " . PHP_VERSION . "\n");
}

// Verifica se a extensão Redis está instalada
if (!extension_loaded('redis')) {
    echo "Extensão Redis não está instalada.\n";
    echo "Por favor, siga os passos abaixo:\n\n";

    if (PHP_OS_FAMILY === 'Windows') {
        echo "1. Baixe o Redis para Windows em: https://github.com/microsoftarchive/redis/releases\n";
        echo "2. Instale o Redis seguindo as instruções do instalador\n";
        echo "3. Baixe a DLL do PHP Redis em: https://windows.php.net/downloads/pecl/releases/redis/\n";
        echo "4. Copie php_redis.dll para " . PHP_EXTENSION_DIR . "\n";
        echo "5. Adicione extension=redis ao seu php.ini\n";
        echo "6. Reinicie o servidor web\n";
    } else {
        echo "1. Instale o Redis Server:\n";
        echo "   sudo apt-get install redis-server\n\n";
        echo "2. Instale a extensão PHP Redis:\n";
        echo "   sudo pecl install redis\n\n";
        echo "3. Adicione extension=redis.so ao seu php.ini\n";
        echo "4. Reinicie o servidor web\n";
    }

    die("\nPor favor, instale os requisitos e execute este script novamente.\n");
}

// Verifica se o Redis está rodando
try {
    $redis = new Redis();
    $redis->connect('127.0.0.1', 6379);
    $info = $redis->info();
    echo "✓ Redis está instalado e rodando\n";
    echo "Versão do Redis: " . $info['redis_version'] . "\n";
    echo "Memória utilizada: " . $info['used_memory_human'] . "\n";
    echo "Tempo de atividade: " . $info['uptime_in_days'] . " dias\n";
} catch (Exception $e) {
    echo "✗ Redis não está rodando ou não está acessível\n";
    echo "Erro: " . $e->getMessage() . "\n";

    if (PHP_OS_FAMILY === 'Windows') {
        echo "\nPara iniciar o Redis no Windows:\n";
        echo "1. Abra o Prompt de Comando como Administrador\n";
        echo "2. Execute: redis-server\n";
    } else {
        echo "\nPara iniciar o Redis:\n";
        echo "sudo service redis-server start\n";
    }

    die("\nPor favor, inicie o Redis e execute este script novamente.\n");
}

// Verifica configurações recomendadas
echo "\nVerificando configurações do Redis...\n";

$config = [
    'maxmemory' => '128mb',
    'maxmemory-policy' => 'allkeys-lru',
    'appendonly' => 'yes'
];

$needsConfig = false;
foreach ($config as $key => $value) {
    try {
        $currentValue = $redis->config('GET', $key);
        if (!isset($currentValue[$key]) || $currentValue[$key] !== $value) {
            echo "✗ Configuração recomendada para $key: $value (atual: " . ($currentValue[$key] ?? 'não definido') . ")\n";
            $needsConfig = true;
        } else {
            echo "✓ $key está configurado corretamente\n";
        }
    } catch (Exception $e) {
        echo "! Não foi possível verificar $key: " . $e->getMessage() . "\n";
    }
}

if ($needsConfig) {
    echo "\nPara otimizar o Redis, adicione as seguintes linhas ao redis.conf:\n\n";
    foreach ($config as $key => $value) {
        echo "$key $value\n";
    }
}

echo "\nInstalação e verificação concluídas!\n";

// Cria arquivo de status
$status = [
    'installed' => true,
    'version' => $info['redis_version'],
    'memory' => $info['used_memory_human'],
    'uptime' => $info['uptime_in_days'],
    'timestamp' => date('Y-m-d H:i:s')
];

file_put_contents(__DIR__ . '/redis_status.json', json_encode($status, JSON_PRETTY_PRINT));
