<?php
header('Content-Type: text/html; charset=UTF-8');
@session_start();

require_once('../../sistema/conexao.php');

if (!isset($_SESSION['sessao_usuario'])) {
    $_SESSION['sessao_usuario'] = uniqid();
}

$sessao = $_SESSION['sessao_usuario'];
$adicional = filter_input(INPUT_POST, 'adicional', FILTER_VALIDATE_INT);
$quantidade = filter_input(INPUT_POST, 'quantidade', FILTER_VALIDATE_INT);

if (!$adicional) {
    echo json_encode(['erro' => 'Adicional inválido']);
    exit;
}

if ($quantidade === false || $quantidade < 0) {
    $quantidade = 0;
}

try {
    if ($quantidade > 0) {
        // Verificar se já existe na tabela temp
        $query = $pdo->prepare("SELECT id FROM temp WHERE sessao = ? AND tabela = 'adicionais' AND id_item = ? AND carrinho = '0'");
        $query->execute([$sessao, $adicional]);

        if ($query->rowCount() > 0) {
            // Atualizar quantidade
            $query = $pdo->prepare("UPDATE temp SET quantidade = ? WHERE sessao = ? AND tabela = 'adicionais' AND id_item = ? AND carrinho = '0'");
            $query->execute([$quantidade, $sessao, $adicional]);
        } else {
            // Inserir novo
            $query = $pdo->prepare("INSERT INTO temp (sessao, tabela, id_item, quantidade, carrinho) VALUES (?, 'adicionais', ?, ?, '0')");
            $query->execute([$sessao, $adicional, $quantidade]);
        }
    } else {
        // Remover da tabela temp
        $query = $pdo->prepare("DELETE FROM temp WHERE sessao = ? AND tabela = 'adicionais' AND id_item = ? AND carrinho = '0'");
        $query->execute([$sessao, $adicional]);
    }

    echo json_encode(['success' => true]);
} catch (Exception $e) {
    echo json_encode(['erro' => $e->getMessage()]);
}
