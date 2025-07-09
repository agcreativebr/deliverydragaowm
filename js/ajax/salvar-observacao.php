<?php
header('Content-Type: text/html; charset=UTF-8');
@session_start();

require_once('../../sistema/conexao.php');
require_once('../../sistema/SecureDB.php');

// LOG DE ENTRADA
file_put_contents('../../sistema/logs/security.log', json_encode([
    'event' => 'salvar_observacao_entrada',
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
    if (!isset($_POST['id']) || !isset($_POST['obs'])) {
        throw new Exception("Parâmetros inválidos");
    }

    $id = filter_var($_POST['id'], FILTER_VALIDATE_INT);
    $obs = filter_var($_POST['obs'], FILTER_SANITIZE_STRING);

    if (!$id) {
        throw new Exception("ID inválido");
    }

    // Usar classe segura para salvar observação
    $secureDB = new SecureDB($pdo);
    $secureDB->updateCartItemObservation($id, $sessao, $obs);

    // LOG DO SUCESSO
    file_put_contents('../../sistema/logs/security.log', json_encode([
        'event' => 'salvar_observacao_sucesso',
        'id' => $id,
        'obs' => $obs,
        'hora' => date('Y-m-d H:i:s')
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

    echo "Salvo com Sucesso";
} catch (Exception $e) {
    // LOG DO ERRO
    file_put_contents('../../sistema/logs/security.log', json_encode([
        'event' => 'salvar_observacao_erro',
        'erro' => $e->getMessage(),
        'post' => $_POST,
        'session' => $_SESSION,
        'hora' => date('Y-m-d H:i:s')
    ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

    echo $e->getMessage();
}
