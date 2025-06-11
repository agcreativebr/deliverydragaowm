<?php
require_once('../../sistema/conexao.php'); // Para $access_token de ApiConfig.php e outras configs globais
require_once('ApiConfig.php'); // Garante que $access_token está definido

$codigo_pix_transacao = isset($_POST['codigo_pix']) ? $_POST['codigo_pix'] : null;
$response_data = ['status' => 'pending']; // Default

if (!empty($codigo_pix_transacao)) {
    if (empty($access_token)) {
        $response_data['status'] = 'error_missing_access_token';
    } else {
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => 'https://api.mercadopago.com/v1/payments/' . $codigo_pix_transacao,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_CUSTOMREQUEST => 'GET',
            CURLOPT_HTTPHEADER => array(
                'accept: application/json',
                'Authorization: Bearer ' . $access_token // Usar o $access_token do ApiConfig.php
            ),
        ));
        $api_response_content = curl_exec($curl);
        $http_code = curl_getinfo($curl, CURLINFO_HTTP_CODE);
        $curl_error = curl_error($curl);
        curl_close($curl);

        if ($curl_error) {
            $response_data['status'] = 'error_curl';
            $response_data['message'] = $curl_error;
        } elseif ($http_code == 200 || $http_code == 201) {
            $resultado_api = json_decode($api_response_content);
            if ($resultado_api && isset($resultado_api->status)) {
                $response_data['status'] = $resultado_api->status;
            } else {
                $response_data['status'] = 'error_parsing_api_response';
            }
        } else {
            $response_data['status'] = 'error_api_http_code_' . $http_code;
            $response_data['api_response'] = json_decode($api_response_content); // Para depuração
        }
    }
} else {
    $response_data['status'] = 'no_pix_code_provided';
}

header('Content-Type: application/json');
echo json_encode($response_data);
