<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
header('Content-Type: text/html; charset=UTF-8');
require_once('../../sistema/conexao.php');
require_once('ApiConfig.php');
@session_start();

$id_usuario = @$_SESSION['id'];

$sessao_pedido_balcao = @$_SESSION['pedido_balcao'];
$tipo_pedido = '';
if ($sessao_pedido_balcao == 'BALCÃO') {
  $tipo_pedido = 'Balcão';
}

$data_atual = date('Y-m-d');
$data_dias_retorno = date('Y-m-d', strtotime("+$dias_retorno days", strtotime($data_atual)));


$pagamento = filter_var(@$_POST['pagamento'], @FILTER_SANITIZE_STRING);
$entrega = filter_var(@$_POST['entrega'], @FILTER_SANITIZE_STRING);
$rua = filter_var(@$_POST['rua'], @FILTER_SANITIZE_STRING);
$numero = filter_var(@$_POST['numero'], @FILTER_SANITIZE_STRING);
$bairro = filter_var(@$_POST['bairro'], @FILTER_SANITIZE_STRING);
$complemento = filter_var(@$_POST['complemento'], @FILTER_SANITIZE_STRING);
$total_pago = filter_var(@$_POST['troco'], @FILTER_SANITIZE_STRING);
$obs = filter_var(@$_POST['obs'], @FILTER_SANITIZE_STRING);
$sessao = @$_SESSION['sessao_usuario'];
$total_pago = str_replace(',', '.', $total_pago);
$nome_cliente_ped = filter_var(@$_POST['nome_cliente'], @FILTER_SANITIZE_STRING);
$tel_cliente = filter_var(@$_POST['tel_cliente'], @FILTER_SANITIZE_STRING);
$cliente = filter_var(@$_POST['id_cliente'], @FILTER_SANITIZE_STRING);
$mesa = filter_var(@$_POST['mesa'], @FILTER_SANITIZE_STRING);
$cupom = filter_var(@$_POST['cupom'], @FILTER_SANITIZE_STRING);
$codigo_pix = filter_var(@$_POST['codigo_pix'], @FILTER_SANITIZE_STRING);
$cep = filter_var(@$_POST['cep'], @FILTER_SANITIZE_STRING);
$cidade = filter_var(@$_POST['cidade'], @FILTER_SANITIZE_STRING);
$taxa_entrega = filter_var(@$_POST['taxa_entrega'], @FILTER_SANITIZE_STRING);
$taxa_entrega = str_replace(',', '.', $taxa_entrega);
$total_pago = str_replace(',', '.', $total_pago);

$esta_pago = filter_var(@$_POST['esta_pago'], @FILTER_SANITIZE_STRING);


//verificar pgto pix
require("verificar_pgto.php");
if (@$status_api == 'approved' or $esta_pago == 'Sim') {
  $pago = 'Sim';
} else {
  $pago = 'Não';
}


if ($pagamento == 'Pix' and $pago == 'Não' and $dados_pagamento == "") {
  echo 'Pagamento nao realizado!!';
  exit();
}

if ($cupom == "") {
  $cupom = 0;
}

if ($taxa_entrega == "") {
  $taxa_entrega = 0;
}

$cliente = 0;
$total_cartoes_cliente = 0;

if ($tel_cliente != "") {
  // Limpa a máscara do telefone para busca e para salvar no banco
  $tel_cliente_limpo = preg_replace('/[^0-9]/', '', $tel_cliente);

  $query = $pdo->prepare("SELECT * FROM clientes where telefone = :telefone ");
  $query->bindValue(":telefone", "$tel_cliente_limpo");
  $query->execute();
  $res = $query->fetchAll(PDO::FETCH_ASSOC);
  if (@count($res) > 0) {
    $cliente = $res[0]['id'];
    $total_cartoes_cliente = $res[0]['cartoes'];
    if ($total_cartoes_cliente == "") {
      $total_cartoes_cliente = 0;
    }
    if ($total_cartoes_cliente < $total_cartoes_config) {
      $total_cartoes_cliente = $total_cartoes_cliente + 1;
    }

    if ($total_cartoes_cliente == $total_cartoes_config and $cupom == $valor_cupom_config) {
      $total_cartoes_cliente = 0;
    }


    //atualiza os dados do cliente
    $query = $pdo->prepare("UPDATE clientes SET nome = :nome, endereco = :rua, numero = :numero, complemento = :complemento, bairro = :bairro, cep = :cep, cidade = :cidade, data_mensagem = '$data_dias_retorno', retorno_enviado = 'Não', cartoes = '$total_cartoes_cliente' where id = '$cliente'");
    $query->bindValue(":nome", "$nome_cliente_ped");
    $query->bindValue(":rua", "$rua");
    $query->bindValue(":numero", "$numero");
    $query->bindValue(":complemento", "$complemento");
    $query->bindValue(":bairro", "$bairro");
    $query->bindValue(":cep", "$cep");
    $query->bindValue(":cidade", "$cidade");

    $query->execute();
  } else {
    $query = $pdo->prepare("INSERT INTO clientes SET nome = :nome, telefone = :telefone, endereco = :rua, numero = :numero, bairro = :bairro, complemento = :complemento, data_cad = curDate(), cep = :cep, cidade = :cidade, data_mensagem = '$data_dias_retorno', retorno_enviado = 'Não', cartoes = '1'");
    $query->bindValue(":nome", "$nome_cliente_ped");
    $query->bindValue(":telefone", "$tel_cliente_limpo");
    $query->bindValue(":rua", "$rua");
    $query->bindValue(":numero", "$numero");
    $query->bindValue(":bairro", "$bairro");
    $query->bindValue(":complemento", "$complemento");
    $query->bindValue(":cep", "$cep");
    $query->bindValue(":cidade", "$cidade");
    $query->execute();
    $cliente = $pdo->lastInsertId();
  }
}



$total_carrinho = 0;
$query = $pdo->query("SELECT * FROM carrinho where sessao = '$sessao'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {
  // Coletar todos os IDs de produtos do carrinho
  $ids_produtos = array_column($res, 'produto');
  $ids_produtos_unicos = array_unique(array_map('intval', $ids_produtos));
  $ids_produtos_str = implode(',', $ids_produtos_unicos);

  // Buscar todos os produtos de uma vez
  $query_produtos = $pdo->query("SELECT id, categoria, valor_venda, estoque, tem_estoque FROM produtos WHERE id IN ($ids_produtos_str)");
  $produtos = [];
  foreach ($query_produtos->fetchAll(PDO::FETCH_ASSOC) as $prod) {
    $produtos[$prod['id']] = $prod;
  }

  for ($i = 0; $i < $total_reg; $i++) {
    $id = $res[$i]['id'];
    $total_item = $res[$i]['total_item'];
    $produto = $res[$i]['produto'];
    $quantidade = $res[$i]['quantidade'];

    // O total_item já inclui a quantidade, não precisa multiplicar novamente
    $total_carrinho += $total_item;

    $prod = $produtos[$produto] ?? null;
    if ($prod && $prod['tem_estoque'] == 'Sim') {
      $novo_estoque = $prod['estoque'] - $quantidade;
      $pdo->query("UPDATE produtos SET estoque = '$novo_estoque' WHERE id = '$produto'");
    }
  }
} else {
  echo '0';
  exit();
}

//if($pagamento == 'Cartão de Crédito'){

//   @$total_carrinho = @$total_carrinho + (@$total_carrinho * 0.05);
//}




// ====================================================================
// ============== INÍCIO DA MODIFICAÇÃO CIRÚRGICA =====================
// ====================================================================
// Justificativa: Substitui a taxa fixa de 5% pela taxa configurável do banco.
$taxa_aplicada = 0;
if ($pagamento == 'Cartão de Crédito') {
  $query_taxa = $pdo->query("SELECT taxa_cartao FROM config where id = 1");
  $res_taxa = $query_taxa->fetch(PDO::FETCH_ASSOC);
  $taxa_cartao_db = $res_taxa['taxa_cartao'] ?? 0;

  if ($taxa_cartao_db > 0) {
    $taxa_aplicada = $total_carrinho * ($taxa_cartao_db / 100);
    $total_carrinho = $total_carrinho + $taxa_aplicada;
  }
}
// ====================================================================
// =============== FIM DA MODIFICAÇÃO CIRÚRGICA =======================
// ====================================================================





@$total_com_frete = @$total_carrinho + @$taxa_entrega - @$cupom;



if ($total_pago == "") {
  $total_pago = $total_com_frete;
}
$troco = $total_pago - $total_com_frete;

//recuperar número do pedido
$query = $pdo->query("SELECT * FROM vendas where data = curDate() order by id desc limit 1");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$num_pedido = @$res[0]['pedido'];
if ($num_pedido == "") {
  $num_pedido = 0;
}
$pedido = $num_pedido + 1;

$query = $pdo->prepare("INSERT INTO vendas SET cliente = '$cliente', valor = '$total_com_frete', total_pago = '$total_pago', troco = '$troco', data = curDate(), hora = curTime(), status = 'Iniciado', pago = '$pago', obs = :obs, taxa_entrega = '$taxa_entrega', tipo_pgto = '$pagamento', usuario_baixa = '0', entrega = '$entrega', mesa = '$mesa', nome_cliente = '$nome_cliente_ped', cupom = '$cupom', pago_entregador = 'Não', pedido = '$pedido', ref_api = '$codigo_pix', tipo_pedido = '$tipo_pedido'");
$query->bindValue(":obs", "$obs");
$query->execute();
$id_pedido = $pdo->lastInsertId();
$id_pedido_feito = $pdo->lastInsertId();



//relacionar itens do carrinho com o pedido
$pdo->query("UPDATE carrinho SET cliente = '$cliente', pedido = '$id_pedido_feito' WHERE sessao = '$sessao' AND pedido = '0'");
// Limpar apenas itens do carrinho sem pedido
$pdo->query("DELETE FROM carrinho WHERE sessao = '$sessao' AND pedido = '0'");

//limpar a sessao aberta
@$_SESSION['sessao_usuario'] = "";
//session_destroy();

$hora_pedido = date('H:i', strtotime("+$previsao_entrega minutes", strtotime(date('H:i'))));
echo $hora_pedido . '*';





// ================= MONTAGEM DA MENSAGEM WHATSAPP CLIENTE =====================
// Inicializar variável para evitar warning
$mensagem_cliente = '';
$data_hora_pedido = date('d/m/Y H:i');
$total_com_freteF = number_format($total_com_frete, 2, ',', '.');
$link_status = $url_sistema . 'pedido/' . $id_pedido_feito;

// Montar mensagem detalhada com todos os itens, adicionais, valores, taxas, cupom, total
$mensagem_cliente = "🛒 Olá $nome_cliente_ped!\n";
$mensagem_cliente .= "Seu pedido foi realizado com sucesso em $data_hora_pedido!\n";
$mensagem_cliente .= "------------------------------------\n";
$mensagem_cliente .= "📦 *Detalhes do Pedido:*\n";

// Buscar itens do pedido já vinculados
$query_itens = $pdo->query("SELECT c.id, c.quantidade, c.total_item, c.obs, c.categoria, c.produto, p.nome as nome_produto FROM carrinho c LEFT JOIN produtos p ON c.produto = p.id WHERE c.pedido = '$id_pedido_feito'");
$res_itens = $query_itens->fetchAll(PDO::FETCH_ASSOC);
foreach ($res_itens as $item) {
  $qtd = $item['quantidade'];
  $nome = $item['nome_produto'] ?? 'Produto removido';
  $valor = number_format($item['total_item'], 2, ',', '.');
  $obs_item = $item['obs'] ? " [Obs: {$item['obs']}]" : "";
  $mensagem_cliente .= "• {$qtd}x {$nome} (R$ {$valor}){$obs_item}\n";
  // Adicionais (usando função replicada do carrinho)
  $id_carrinho = $item['id'];
  $categoria = isset($item['categoria']) ? $item['categoria'] : 0;
  $mensagem_cliente .= montarAdicionaisPedido($pdo, $id_carrinho, $qtd, $categoria);
}
$mensagem_cliente .= "------------------------------------\n";
$mensagem_cliente .= "💰 Subtotal: R$ " . number_format($total_carrinho, 2, ',', '.') . "\n";
if ($taxa_entrega > 0) {
  $mensagem_cliente .= "🚚 Frete: R$ " . number_format($taxa_entrega, 2, ',', '.') . "\n";
}
if ($taxa_aplicada > 0) {
  $mensagem_cliente .= "💳 Taxa Cartão: R$ " . number_format($taxa_aplicada, 2, ',', '.') . "\n";
}
if ($cupom > 0) {
  $mensagem_cliente .= "🏷️ Desconto/Cupom: -R$ " . number_format($cupom, 2, ',', '.') . "\n";
}
$mensagem_cliente .= "------------------------------------\n";
$mensagem_cliente .= "💵 Total a Pagar: R$ $total_com_freteF\n";
$mensagem_cliente .= "💳 Pagamento: $pagamento\n";
$mensagem_cliente .= "📄 Status do Pagamento: $pago\n";
if ($tipo_pedido == 'Delivery') {
  $mensagem_cliente .= "🏠 Endereço: $rua, $numero, $complemento, $bairro, $cidade\n";
}
if ($obs) {
  $mensagem_cliente .= "📝 Observações do Pedido: $obs\n";
}
$mensagem_cliente .= "🙏 Agradecemos pela preferência!\n";
$mensagem_cliente .= "🔔 Em breve você receberá atualizações sobre o status do seu pedido.\n";
$mensagem_cliente .= "🔗 Para acompanhar o status do seu pedido, acesse:\n$link_status";

// ENVIO WHATSAPP EMPRESA
if ($api_whatsapp != 'Não') {
  $telefone_empresa = $config['telefone_empresa'] ?? '';
  if (empty($telefone_empresa)) {
    $telefone_empresa = $telefone_sistema ?? '';
  }
  // Remove tudo que não for número
  $telefone_empresa = preg_replace('/[^0-9]/', '', $telefone_empresa);
  // Se ainda assim ficar vazio, logar erro crítico
  if (empty($telefone_empresa)) {
    file_put_contents('../../sistema/logs/security.log', json_encode([
      'event' => 'erro_telefone_vazio',
      'fonte_config' => $config['telefone_empresa'] ?? null,
      'tel_sistema' => $telefone_sistema ?? null,
      'hora' => date('Y-m-d H:i:s')
    ]) . "\n", FILE_APPEND);
  }
  if ($telefone_empresa) {
    $telefone_envio = '55' . preg_replace('/[ ()-]+/', '', $telefone_empresa);
    $mensagem_empresa = $mensagem_cliente; // mensagem detalhada já montada
    file_put_contents('../../sistema/logs/security.log', json_encode(['event' => 'whatsapp_empresa', 'tel' => $telefone_envio, 'msg' => $mensagem_empresa, 'pedido' => $id_pedido_feito, 'hora' => date('Y-m-d H:i:s')]) . "\n", FILE_APPEND);
    require("api_texto.php");
  }
}

// === ENVIO PARA CLIENTE/EMPRESA DE ACORDO COM CONFIG ===
$telefone_cliente_envio = preg_replace('/[^0-9]/', '', $tel_cliente);
if (strlen($telefone_cliente_envio) == 11) {
  $telefone_cliente_envio = '55' . $telefone_cliente_envio;
}
// Buscar telefone da empresa do config ou fallback
$telefone_empresa = $config['telefone_sistema'] ?? ($telefone_sistema ?? '');
$telefone_empresa = preg_replace('/[^0-9]/', '', $telefone_empresa);
if (strlen($telefone_empresa) == 11) {
  $telefone_empresa = '55' . $telefone_empresa;
}

// Controle de envio WhatsApp conforme painel
if ($api_whatsapp == 'Não') {
  // Não envia mensagem para ninguém
  echo "Pedido Finalizado*{$id_pedido_feito}";
  exit();
} elseif ($api_whatsapp == 'manual') {
  // Modo manual: apenas empresa recebe via link WhatsApp Web
  $mensagem_empresa = "🛒 Olá! Novo pedido recebido em $data_hora_pedido!\n";
  $mensagem_empresa .= "------------------------------------\n";
  $mensagem_empresa .= "📦 *Detalhes do Pedido:*\n";
  $query_itens = $pdo->query("SELECT c.*, p.nome as nome_produto FROM carrinho c LEFT JOIN produtos p ON c.produto = p.id WHERE c.pedido = '$id_pedido_feito'");
  $res_itens = $query_itens->fetchAll(PDO::FETCH_ASSOC);
  if (count($res_itens) == 0) {
    file_put_contents('../../sistema/logs/security.log', date('Y-m-d H:i:s') . " - ERRO: Nenhum item encontrado para o pedido {$id_pedido_feito}\n", FILE_APPEND);
    echo "Pedido Finalizado*{$id_pedido_feito}";
    exit();
  }
  foreach ($res_itens as $item) {
    $qtd = $item['quantidade'];
    $nome = $item['nome_produto'] ?? 'Produto removido';
    $valor = number_format($item['total_item'], 2, ',', '.');
    $obs_item = $item['obs'] ? " [Obs: {$item['obs']}]" : "";
    $mensagem_empresa .= "• {$qtd}x {$nome} (R$ {$valor}){$obs_item}\n";
    $id_carrinho = $item['id'];
    $categoria = isset($item['categoria']) ? $item['categoria'] : 0;
    $mensagem_empresa .= montarAdicionaisPedido($pdo, $id_carrinho, $qtd, $categoria);
  }
  // Adicionar totais, frete, taxa, cupom, etc (ajustar conforme variáveis já existentes)
  $mensagem_empresa .= "------------------------------------\n";
  $mensagem_empresa .= "Subtotal: R$ " . number_format($total_carrinho ?? 0, 2, ',', '.') . "\n";
  if (isset($taxa_entrega) && $taxa_entrega > 0) $mensagem_empresa .= "Frete: R$ " . number_format($taxa_entrega, 2, ',', '.') . "\n";
  if (isset($taxa_aplicada) && $taxa_aplicada > 0) $mensagem_empresa .= "Taxa: R$ " . number_format($taxa_aplicada, 2, ',', '.') . "\n";
  if (isset($cupom) && $cupom > 0) $mensagem_empresa .= "Cupom: -R$ " . number_format($cupom, 2, ',', '.') . "\n";
  $mensagem_empresa .= "TOTAL: R$ " . number_format($total_com_frete ?? 0, 2, ',', '.') . "\n";
  $mensagem_empresa .= "------------------------------------\n";
  // Remover emojis para o link
  if (!function_exists('removerEmojis')) {
    function removerEmojis($text)
    {
      return preg_replace('/[\x{1F600}-\x{1F64F}\x{1F300}-\x{1F5FF}\x{1F680}-\x{1F6FF}\x{2600}-\x{26FF}\x{2700}-\x{27BF}]+/u', '', $text);
    }
  }
  $mensagem_empresa_sem_emoji = removerEmojis($mensagem_empresa);
  $mensagem_url = rawurlencode($mensagem_empresa_sem_emoji);
  $link_whatsapp_empresa = "https://wa.me/{$telefone_empresa}?text={$mensagem_url}";
  echo "Pedido Finalizado*{$id_pedido_feito}*{$link_whatsapp_empresa}";
  exit();
} else {
  // API: envia para cliente e empresa via API
  $enviar_cliente = true;
  $enviar_empresa = true;
}

if ($enviar_cliente) {
  if (!empty($telefone_cliente_envio)) {
    $mensagem_whatsapp = $mensagem_cliente;
    $telefone_envio = $telefone_cliente_envio;
    require('api_texto.php');
    file_put_contents('../../sistema/logs/security.log', json_encode([
      'event' => 'whatsapp_cliente_api',
      'api' => $api_whatsapp,
      'tel' => $telefone_envio,
      'msg' => $mensagem_whatsapp,
      'pedido' => $id_pedido_feito,
      'hora' => date('Y-m-d H:i:s')
    ]) . "\n", FILE_APPEND);
  }
}

if ($enviar_empresa) {
  if (!empty($telefone_empresa)) {
    $mensagem_whatsapp = $mensagem_cliente;
    $telefone_envio = $telefone_empresa;
    require('api_texto.php');
    file_put_contents('../../sistema/logs/security.log', json_encode([
      'event' => 'whatsapp_empresa_api',
      'api' => $api_whatsapp,
      'tel' => $telefone_envio,
      'msg' => $mensagem_whatsapp,
      'pedido' => $id_pedido_feito,
      'hora' => date('Y-m-d H:i:s')
    ]) . "\n", FILE_APPEND);
  }
}

// LOG DA MENSAGEM ANTES DO ENCODE
file_put_contents('../../sistema/logs/security.log', json_encode([
  'event' => 'mensagem_whatsapp_pre_encode',
  'mensagem' => $mensagem_cliente,
  'hora' => date('Y-m-d H:i:s')
]) . "\n", FILE_APPEND);

// Função para remover emojis (caracteres fora do Basic Multilingual Plane)
function removerEmojis($texto)
{
  return preg_replace('/[\x{1F600}-\x{1F64F}\x{1F300}-\x{1F5FF}\x{1F680}-\x{1F6FF}\x{2600}-\x{26FF}\x{2700}-\x{27BF}\x{1F1E0}-\x{1F1FF}]/u', '', $texto);
}

// Limitar tamanho preservando quebras de linha
$limite_whatsapp = 1800;
if (mb_strlen($mensagem_cliente) > $limite_whatsapp) {
  $mensagem_cliente = mb_substr($mensagem_cliente, 0, $limite_whatsapp) . '... (resumido, veja detalhes no link abaixo)';
}

// Garantir UTF-8 puro antes do encode
$mensagem_cliente_utf8 = mb_convert_encoding($mensagem_cliente, 'UTF-8', 'UTF-8');

// Remover emojis apenas do texto do link wa.me
$mensagem_cliente_sem_emoji = removerEmojis($mensagem_cliente_utf8);

// Log antes do encode
file_put_contents('../../sistema/logs/security.log', json_encode([
  'event' => 'mensagem_whatsapp_pre_rawurlencode',
  'mensagem' => $mensagem_cliente_utf8,
  'mensagem_sem_emoji' => $mensagem_cliente_sem_emoji,
  'hora' => date('Y-m-d H:i:s')
]) . "\n", FILE_APPEND);

// Encode final para URL (rawurlencode para suportar emojis)
$mensagem_url = rawurlencode($mensagem_cliente_sem_emoji);
$link_whatsapp = "https://wa.me/55{$telefone_empresa}?text={$mensagem_url}";

// Log após o encode
file_put_contents('../../sistema/logs/security.log', json_encode([
  'event' => 'mensagem_whatsapp_pos_rawurlencode',
  'mensagem_url' => $mensagem_url,
  'link_whatsapp' => $link_whatsapp,
  'hora' => date('Y-m-d H:i:s')
]) . "\n", FILE_APPEND);

// TESTE TEMPORÁRIO: link WhatsApp com emojis hardcoded
$mensagem_teste_emoji = "✅ Pedido realizado com sucesso! 🍔🍟 Obrigado! 🚀";
$mensagem_teste_emoji_utf8 = mb_convert_encoding($mensagem_teste_emoji, 'UTF-8', 'UTF-8');
$link_teste_emoji = "https://wa.me/55{$telefone_empresa}?text=" . rawurlencode($mensagem_teste_emoji_utf8);
file_put_contents('../../sistema/logs/security.log', json_encode([
  'event' => 'link_whatsapp_teste_emoji',
  'link' => $link_teste_emoji,
  'hora' => date('Y-m-d H:i:s')
]) . "\n", FILE_APPEND);

// RESPOSTA PADRÃO PARA O FRONTEND
if ($api_whatsapp == 'manual') {
  echo "Pedido Finalizado*{$id_pedido_feito}*{$link_whatsapp}";
  exit();
} else {
  echo "Pedido Finalizado*{$id_pedido_feito}";
  exit();
}

$query2 = $pdo->query("SELECT * FROM formas_pgto WHERE nome = '$pagamento'");
$res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
if (@count($res2) > 0) {
  $id_tipo_pgto = $res2[0]['id'];
}

$id_caixa = 0;

if ($tipo_pedido == 'Balcão') {
  $entrega = 'Balcão';

  //verificar caixa aberto
  $query1 = $pdo->query("SELECT * from caixas where operador = '$id_usuario' and data_fechamento is null order by id desc limit 1");
  $res1 = $query1->fetchAll(PDO::FETCH_ASSOC);
  if (@count($res1) > 0) {
    $id_caixa = @$res1[0]['id'];
  } else {
    $id_caixa = 0;
  }
} else {
  $id_usuario = 0;
}



if ($pago == 'Sim') {
  $pdo->query("INSERT INTO receber SET descricao = '$entrega', cliente = '$cliente', valor = '$total_com_frete', subtotal = '$total_com_frete', data_lanc = curDate(), hora = curTime(), pago = 'Sim', vencimento = curDate(), data_pgto = curDate(), foto = 'sem-foto.png', arquivo = 'sem-foto.png', forma_pgto = '$id_tipo_pgto', referencia = '$entrega', caixa = '$id_caixa', usuario_pgto = '$id_usuario'");
}



// Validação obrigatória da forma de pagamento
if (empty($pagamento)) {
  echo 'Erro: Forma de pagamento obrigatória.';
  exit();
}

// Função para montar string dos adicionais de um item (replica lógica do carrinho)
function montarAdicionaisPedido($pdo, $id_carrinho, $quantidade_item, $categoria = 0)
{
  $str = '';
  $query = $pdo->query("SELECT * FROM temp WHERE carrinho = '$id_carrinho' AND tabela = 'adicionais'");
  $res = $query->fetchAll(PDO::FETCH_ASSOC);
  $total_reg = @count($res);
  if ($total_reg > 0) {
    $str .= "   Adicionais: ";
    for ($i = 0; $i < $total_reg; $i++) {
      $id_item = $res[$i]['id_item'];
      $quantidade_temp = isset($res[$i]['quantidade']) ? $res[$i]['quantidade'] : 1;
      // Buscar nome e valor do adicional
      if ($categoria > 0) {
        $query2 = $pdo->query("SELECT * FROM adicionais_cat WHERE id = '$id_item' AND ativo = 'Sim'");
      } else {
        $query2 = $pdo->query("SELECT * FROM adicionais WHERE id = '$id_item' AND ativo = 'Sim'");
      }
      $res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
      $total_reg2 = @count($res2);
      // Se não encontrar, buscar na itens_grade
      if ($total_reg2 == 0) {
        $query2 = $pdo->query("SELECT texto as nome, valor FROM itens_grade WHERE id = '$id_item'");
        $res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
        $total_reg2 = @count($res2);
      }
      if ($total_reg2 > 0 && isset($res2[0]['nome']) && isset($res2[0]['valor'])) {
        $nome_adc = $res2[0]['nome'];
        $valor_adc = ($res2[0]['valor'] * $quantidade_temp) * $quantidade_item;
        $valor_adcF = number_format($valor_adc, 2, ',', '.');
        $qtd_str = $quantidade_temp > 1 ? $quantidade_temp . 'x ' : '';
        $str .= "+ {$qtd_str}{$nome_adc} (R$ {$valor_adcF}) ";
      }
    }
    $str .= "\n";
  }
  return $str;
}
