<?php
// Configurações do banco
$db_host = 'localhost';
$db_user = 'root';
$db_pass = '';
$db_name = 'delivery';

try {
    // Tenta conectar ao MySQL
    $pdo = new PDO("mysql:host=$db_host", $db_user, $db_pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

    // Verifica se o banco existe
    $stmt = $pdo->query("SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = '$db_name'");
    $exists = $stmt->fetch();

    if (!$exists) {
        // Cria o banco se não existir
        $pdo->exec("CREATE DATABASE `$db_name` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
        echo "Banco de dados '$db_name' criado com sucesso!\n";

        // Conecta ao banco criado
        $pdo = new PDO("mysql:host=$db_host;dbname=$db_name", $db_user, $db_pass);
        $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

        // Cria as tabelas básicas necessárias
        $pdo->exec("
            CREATE TABLE IF NOT EXISTS `config` (
                `id` int NOT NULL AUTO_INCREMENT,
                `nome_sistema` varchar(50) NOT NULL,
                `email_sistema` varchar(50) NOT NULL,
                `telefone_sistema` varchar(20) NOT NULL,
                PRIMARY KEY (`id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
            
            CREATE TABLE IF NOT EXISTS `usuarios` (
                `id` int NOT NULL AUTO_INCREMENT,
                `nome` varchar(50) NOT NULL,
                `email` varchar(50) NOT NULL,
                `senha` varchar(100) NOT NULL,
                `nivel` varchar(20) NOT NULL,
                `ativo` varchar(5) NOT NULL,
                PRIMARY KEY (`id`)
            ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
        ");

        echo "Tabelas básicas criadas com sucesso!\n";
    } else {
        echo "Banco de dados '$db_name' já existe!\n";
    }
} catch (PDOException $e) {
    echo "Erro: " . $e->getMessage() . "\n";
    exit(1);
}
