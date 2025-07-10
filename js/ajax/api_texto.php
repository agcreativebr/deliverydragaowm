<?php
header('Content-Type: text/html; charset=UTF-8');
mb_internal_encoding('UTF-8');

// LOG DA MENSAGEM RECEBIDA
$logDir = __DIR__ . '/../../sistema/logs';
$logFile = $logDir . '/security.log';
if (!is_dir($logDir)) {
  mkdir($logDir, 0777, true);
}
if (!file_exists($logFile)) {
  file_put_contents($logFile, '');
}
file_put_contents($logFile, json_encode([
  'event' => 'api_texto_entrada',
  'mensagem' => $mensagem ?? null,
  'mensagem_whatsapp' => $mensagem_whatsapp ?? null,
  'api' => $api_whatsapp,
  'hora' => date('Y-m-d H:i:s')
], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

if ($api_whatsapp == 'menuia') {
  // Garantir que todas as quebras de linha estão como \n
  if (!isset($mensagem_whatsapp) || $mensagem_whatsapp === null) $mensagem_whatsapp = '';
  $mensagem_whatsapp = str_replace(["\r\n", "\r", "%0A"], "\n", ($mensagem ?? $mensagem_whatsapp) ?: '');

  // Converter emojis para formato Unicode
  $mensagem_whatsapp = preg_replace_callback('/[\x{1F300}-\x{1F6FF}]/u', function ($matches) {
    return mb_convert_encoding($matches[0], 'UTF-8', 'UTF-8');
  }, $mensagem_whatsapp);

  $curl = curl_init();
  curl_setopt_array($curl, array(
    CURLOPT_URL => 'https://chatbot.menuia.com/api/create-message',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => 'UTF-8',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => array(
      'appkey' => $token_whatsapp,
      'authkey' => $instancia_whatsapp,
      'to' => $telefone_envio,
      'message' => $mensagem_whatsapp,
      'sandbox' => 'false'
    ),
  ));

  $response = curl_exec($curl);
  $curl_error = curl_error($curl);
  curl_close($curl);

  // Log da resposta
  file_put_contents($logFile, json_encode([
    'event' => 'api_menuia_response',
    'response' => $response,
    'error' => $curl_error,
    'hora' => date('Y-m-d H:i:s')
  ], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);
}

if ($api_whatsapp == 'wm') {
  // Garantir que todas as quebras de linha estão como \n
  $mensagem = str_replace(["\r\n", "\r", "%0A"], "\n", $mensagem);

  // Converter emojis para formato Unicode
  $mensagem = preg_replace_callback('/[\x{1F300}-\x{1F6FF}]/u', function ($matches) {
    return mb_convert_encoding($matches[0], 'UTF-8', 'UTF-8');
  }, $mensagem);

  $url = "http://api.wordmensagens.com.br/send-text";
  $data = array(
    'instance' => $instancia_whatsapp,
    'to' => $telefone_envio,
    'token' => $token_whatsapp,
    'message' => $mensagem
  );

  $options = array(
    'http' => array(
      'method' => 'POST',
      'header' => 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8',
      'content' => http_build_query($data)
    )
  );

  $stream = stream_context_create($options);
  $result = @file_get_contents($url, false, $stream);

  // Log da resposta
  file_put_contents($logFile, json_encode([
    'event' => 'api_wm_response',
    'result' => $result,
    'hora' => date('Y-m-d H:i:s')
  ]) . "\n", FILE_APPEND);
}

if ($api_whatsapp == 'newtek') {
  // Garantir que todas as quebras de linha estão como \n
  if (!isset($mensagem_whatsapp) || $mensagem_whatsapp === null) $mensagem_whatsapp = '';
  $mensagem_whatsapp = str_replace(["\r\n", "\r", "%0A"], "\n", $mensagem_whatsapp);

  $curl = curl_init();
  curl_setopt_array($curl, array(
    CURLOPT_URL => 'https://webapi.newteksoft.com.br/enviar-texto',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_ENCODING => 'UTF-8',
    CURLOPT_MAXREDIRS => 10,
    CURLOPT_TIMEOUT => 0,
    CURLOPT_FOLLOWLOCATION => true,
    CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
    CURLOPT_CUSTOMREQUEST => 'POST',
    CURLOPT_POSTFIELDS => json_encode(
      array(
        "instancia" => $instancia_whatsapp,
        "token" => $token_whatsapp,
        "mensagem" => $mensagem_whatsapp,
        "para" => array($telefone_envio),
        "delay" => "1"
      ),
      JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
    ),
    CURLOPT_HTTPHEADER => array(
      'Content-Type: application/json; charset=UTF-8'
    ),
  ));

  $response = curl_exec($curl);
  $curl_error = curl_error($curl);
  curl_close($curl);

  // Log da resposta
  file_put_contents($logFile, json_encode([
    'event' => 'api_newtek_response',
    'response' => $response,
    'error' => $curl_error,
    'hora' => date('Y-m-d H:i:s')
  ]) . "\n", FILE_APPEND);
}
