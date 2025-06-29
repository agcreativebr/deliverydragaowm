<?php
@session_start();
require_once('../../sistema/conexao.php');
require_once('../../js/ajax/ApiConfig.php');

// Log de entrada no endpoint Pix
file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'pix_php_entrada', 'post' => $_POST, 'sessao' => isset($_SESSION['sessao_usuario']) ? $_SESSION['sessao_usuario'] : null]) . "\n", FILE_APPEND);

$sessao = isset($_SESSION['sessao_usuario']) ? $_SESSION['sessao_usuario'] : null;
if (!$sessao) {
    file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'pix_php_erro', 'msg' => 'Sessão não encontrada', 'sessao' => $sessao]) . "\n", FILE_APPEND);
    http_response_code(400);
    echo 'Sessão não encontrada.';
    exit();
}

// Verifica se já existe Pix pendente para esta sessão
$query = $pdo->prepare("SELECT id, ref_api FROM vendas WHERE sessao = ? AND tipo_pgto = 'Pix' AND pago = 'Não' AND ref_api IS NOT NULL AND ref_api != '' ORDER BY id DESC LIMIT 1");
$query->execute([$sessao]);
$res = $query->fetch(PDO::FETCH_ASSOC);

if ($res && !empty($res['ref_api'])) {
    // Consultar status no Mercado Pago
    $codigo_pix_existente = $res['ref_api'];
    $curl = curl_init();
    curl_setopt_array($curl, array(
        CURLOPT_URL => 'https://api.mercadopago.com/v1/payments/' . $codigo_pix_existente,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_HTTPHEADER => array(
            'accept: application/json',
            'Authorization: Bearer ' . $access_token
        ),
    ));
    $response = curl_exec($curl);
    $resultado = json_decode($response);
    curl_close($curl);
    // Log da resposta Mercado Pago reutilização
    file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'mp_response_reutilizacao', 'response' => $response, 'sessao' => $sessao, 'ref_api' => $codigo_pix_existente]) . "\n", FILE_APPEND);
    if ($resultado && isset($resultado->status) && $resultado->status === 'pending') {
        // Retorna o QRCode já existente
        $codigo_pix = $resultado->point_of_interaction->transaction_data->qr_code;
        $qrcode_base64 = $resultado->point_of_interaction->transaction_data->qr_code_base64 ?? '';
        if ($qrcode_base64) {
            echo "<div style='text-align:center'><img style='display:block;margin:auto;' width='200px' id='base64image' alt='QR Code Pix' src='data:image/jpeg;base64, $qrcode_base64'/></div>";
        } else {
            echo "<div class='alert alert-warning text-center'>Não foi possível gerar o QRCode. Copie a chave Pix abaixo para pagar manualmente.</div>";
        }
        echo '<div style="display:flex;align-items:center;justify-content:center;margin-top:10px;gap:10px;">';
        echo '<input type="text" id="chave_pix_copia" value="' . $codigo_pix . '" style="background: #f8f9fa; border:1px solid #ccc; border-radius:4px; width:80%; padding:4px; font-size:13px;" readonly>';
        echo '<button type="button" onclick="copiar()" class="btn btn-primary btn-sm" style="margin-left:5px;"><i class="bi bi-clipboard"></i> Copiar Chave Pix</button>';
        echo '</div>';
        echo '<input type="hidden" id="codigo_pix" value="' . $codigo_pix_existente . '">';
        echo '<input type="hidden" id="pix_reutilizado" value="1">';
        // Log de tentativa de múltiplos QRCodes
        $log = [
            'timestamp' => date('Y-m-d H:i:s'),
            'ip' => $_SERVER['REMOTE_ADDR'],
            'user_agent' => $_SERVER['HTTP_USER_AGENT'],
            'event' => 'pix_qrcode_reutilizado',
            'details' => [
                'sessao' => $sessao,
                'ref_api' => $codigo_pix_existente
            ]
        ];
        file_put_contents('../../sistema/logs/security.log', json_encode($log) . "\n", FILE_APPEND);
        exit();
    } else {
        file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'mp_response_reutilizacao_status', 'status' => isset($resultado->status) ? $resultado->status : null, 'sessao' => $sessao, 'ref_api' => $codigo_pix_existente]) . "\n", FILE_APPEND);
    }
}

if ($dados_pagamento != "") {
    file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'pix_php_saida_dados_pagamento', 'dados_pagamento' => $dados_pagamento, 'sessao' => $sessao]) . "\n", FILE_APPEND);
    echo '<b>Chave Pix</b><br>';
    echo '<b>' . $tipo_chave . '</b> : ' . $dados_pagamento;
    exit();
}

$valor = $_POST['valor'];

$curl = curl_init();

$dados["transaction_amount"] = (float) $valor;
$dados["description"] = "Venda Delivery";
$dados["external_reference"] = "2";
$dados["payment_method_id"] = "pix";
$dados["notification_url"] = "https://google.com";
$dados["payer"]["email"] = "deliverye@hotmail.com";
$dados["payer"]["first_name"] = "Delivery";
$dados["payer"]["last_name"] = "Pagamento";

$dados["payer"]["identification"]["type"] = "CPF";
$dados["payer"]["identification"]["number"] = "34152426764";

$dados["payer"]["address"]["zip_code"] = "06233200";
$dados["payer"]["address"]["street_name"] = "Av. das Nações Unidas";
$dados["payer"]["address"]["street_number"] = "3003";
$dados["payer"]["address"]["neighborhood"] = "Bonfim";
$dados["payer"]["address"]["city"] = "Osasco";
$dados["payer"]["address"]["federal_unit"] = "SP";

curl_setopt_array(
    $curl,
    array(
        CURLOPT_URL => 'https://api.mercadopago.com/v1/payments',
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_CUSTOMREQUEST => 'POST',
        CURLOPT_POSTFIELDS => json_encode($dados),
        CURLOPT_HTTPHEADER => array(
            'accept: application/json',
            'content-type: application/json',
            'X-Idempotency-Key: ' . date('Y-m-d-H:i:s-') . rand(0, 1500),
            'Authorization: Bearer ' . $access_token
        ),
    )
);
$response = curl_exec($curl);
$resultado = json_decode($response);
// Log da resposta Mercado Pago geração
file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'mp_response_geracao', 'response' => $response, 'sessao' => $sessao, 'dados_enviados' => $dados]) . "\n", FILE_APPEND);

$id = $dados["external_reference"];
//var_dump($response);
curl_close($curl);
$codigo_pix = $resultado->point_of_interaction->transaction_data->qr_code;
$qrcode_base64 = $resultado->point_of_interaction->transaction_data->qr_code_base64 ?? '';
if ($qrcode_base64) {
    echo "<div style='text-align:center'><img style='display:block;margin:auto;' width='200px' id='base64image' alt='QR Code Pix' src='data:image/jpeg;base64, $qrcode_base64'/></div>";
} else {
    echo "<div class='alert alert-warning text-center'>Não foi possível gerar o QRCode. Copie a chave Pix abaixo para pagar manualmente.</div>";
}
echo '<div style="display:flex;align-items:center;justify-content:center;margin-top:10px;gap:10px;">';
echo '<input type="text" id="chave_pix_copia" value="' . $codigo_pix . '" style="background: #f8f9fa; border:1px solid #ccc; border-radius:4px; width:80%; padding:4px; font-size:13px;" readonly>';
echo '<button type="button" onclick="copiar()" class="btn btn-primary btn-sm" style="margin-left:5px;"><i class="bi bi-clipboard"></i> Copiar Chave Pix</button>';
echo '</div>';
echo '<input type="hidden" id="codigo_pix" value="' . $resultado->id . '">';
