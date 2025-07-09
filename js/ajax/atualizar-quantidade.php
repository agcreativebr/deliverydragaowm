<?php
header('Content-Type: text/html; charset=UTF-8');
@session_start();

require_once('../../sistema/conexao.php');
require_once('../../sistema/SecureDB.php');

// LOG DE ENTRADA
file_put_contents('../../sistema/logs/security.log', json_encode([
    'event' => 'atualizar_quantidade_entrada',
    'post' => $_POST,
    'session' => $_SESSION,
    'hora' => date('Y-m-d H:i:s')
], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

try {
    // Validar sessão
    if (!isset($_SESSION['sessao_usuario'])) {
        throw new Exception("Sessão inválida");
    }
    $sessao = $_SESSION['sessao_usuario'];

    // Validar parâmetros
    if (!isset($_POST['id']) || !isset($_POST['quantidade'])) {
        throw new Exception("Parâmetros inválidos");
    }

    $id = filter_var($_POST['id'], FILTER_VALIDATE_INT);
    $quantidade = filter_var($_POST['quantidade'], FILTER_VALIDATE_INT);

    if (!$id || $quantidade < 1) {
        throw new Exception("Valores inválidos");
    }

    // Usar classe segura para atualizar quantidade
    $secureDB = new SecureDB($pdo);
    $secureDB->updateCartItemQuantity($id, $sessao, $quantidade);

    echo "Atualizado com Sucesso";
} catch (Exception $e) {
    // Log do erro
    file_put_contents('../../sistema/logs/security.log', json_encode([
        'event' => 'atualizar_quantidade_erro',
        'erro' => $e->getMessage(),
        'post' => $_POST,
        'session' => $_SESSION,
        'hora' => date('Y-m-d H:i:s')
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

    echo $e->getMessage();
}
