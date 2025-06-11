<?php
session_start();
require_once('../../sistema/conexao.php');
require_once('ApiConfig.php');

$sessao = $_POST['sessao'];

$query = $pdo->prepare("SELECT ref_api FROM vendas WHERE sessao = ? AND tipo_pgto = 'Pix' ORDER BY id DESC LIMIT 1");
$query->execute([$sessao]);
$res = $query->fetch(PDO::FETCH_ASSOC);

$response = array('status' => 'PENDENTE', 'codigo_pix' => '');

if ($res) {
    $codigo_pix = $res['ref_api'];

    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => 'https://api.mercadopago.com/v1/payments/' . $codigo_pix,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array(
            'Authorization: Bearer ' . $access_token
        ),
    ));

    $curl_response = curl_exec($curl);
    $resultado = json_decode($curl_response);
    curl_close($curl);

    if ($resultado && $resultado->status === 'approved') {
        $response['status'] = 'PAGO';
        $response['codigo_pix'] = $codigo_pix;
    }
}

header('Content-Type: application/json');
echo json_encode($response);
