<?php

/**
 * Script para configurar o monitoramento do Redis no cron
 * Executa a cada 5 minutos
 */

// Caminho absoluto para o script de monitoramento
$scriptPath = realpath(__DIR__ . '/monitor_redis.php');
$logPath = __DIR__ . '/cron.log';

// Comando cron
$cronCommand = "*/5 * * * * /usr/bin/php $scriptPath >> $logPath 2>&1";

// Verifica se estamos no Windows
if (PHP_OS_FAMILY === 'Windows') {
    echo "Configurando tarefa agendada no Windows...\n";

    // Cria arquivo batch para execução
    $batchFile = __DIR__ . '/monitor_redis.bat';
    $batchContent = "@echo off\n";
    $batchContent .= "php \"$scriptPath\" >> \"$logPath\" 2>&1\n";
    file_put_contents($batchFile, $batchContent);

    // Comando para criar tarefa agendada no Windows
    $taskName = "MonitorRedis";
    $command = "schtasks /create /tn \"$taskName\" /tr \"$batchFile\" /sc minute /mo 5 /ru System /f";

    echo "Executando: $command\n";
    exec($command, $output, $return);

    if ($return === 0) {
        echo "✓ Tarefa agendada criada com sucesso!\n";
    } else {
        echo "✗ Erro ao criar tarefa agendada: " . implode("\n", $output) . "\n";
        exit(1);
    }
} else {
    echo "Configurando cron job no Linux/Unix...\n";

    // Obtém crontab atual
    exec('crontab -l', $crontab, $return);

    // Remove entrada antiga se existir
    $crontab = array_filter($crontab, function ($line) use ($scriptPath) {
        return strpos($line, $scriptPath) === false;
    });

    // Adiciona nova entrada
    $crontab[] = $cronCommand;

    // Salva nova crontab
    $tempFile = tempnam(sys_get_temp_dir(), 'cron');
    file_put_contents($tempFile, implode("\n", $crontab) . "\n");

    exec("crontab $tempFile", $output, $return);
    unlink($tempFile);

    if ($return === 0) {
        echo "✓ Cron job configurado com sucesso!\n";
    } else {
        echo "✗ Erro ao configurar cron job: " . implode("\n", $output) . "\n";
        exit(1);
    }
}

// Cria diretório para métricas se não existir
if (!is_dir(__DIR__ . '/metrics')) {
    mkdir(__DIR__ . '/metrics');
    echo "✓ Diretório de métricas criado\n";
}

// Cria arquivo de log se não existir
if (!file_exists($logPath)) {
    touch($logPath);
    echo "✓ Arquivo de log criado\n";
}

echo "\nConfiguração concluída!\n";
echo "O Redis será monitorado a cada 5 minutos\n";
echo "Logs serão salvos em: $logPath\n";
echo "Métricas serão salvas em: " . __DIR__ . "/metrics/\n";
