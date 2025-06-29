<?php
// Configurações de backup
date_default_timezone_set('America/Sao_Paulo');
$data = date('Y-m-d_H-i-s');
$arquivo_backup = __DIR__ . "/backup_pre_fase2_" . $data . ".sql";

// Configurações do banco
$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'delivery';

// Comando de backup
$command = sprintf(
    'C:\\xampp\\mysql\\bin\\mysqldump --host=%s --user=%s --password=%s %s > %s',
    $db_host,
    $db_user,
    $db_pass,
    $db_name,
    $arquivo_backup
);

// Executa o backup
exec($command, $output, $return_var);

// Verifica se o backup foi bem sucedido
if ($return_var === 0) {
    echo "Backup criado com sucesso em: " . $arquivo_backup;

    // Cria arquivo de verificação
    $verify_file = __DIR__ . "/backup_verify.txt";
    file_put_contents(
        $verify_file,
        "Backup realizado em: " . date('d/m/Y H:i:s') . "\n" .
            "Arquivo: " . $arquivo_backup . "\n" .
            "Status: Sucesso\n"
    );
} else {
    echo "Erro ao criar backup. Código de retorno: " . $return_var;
    echo "\nOutput: " . implode("\n", $output);
}
