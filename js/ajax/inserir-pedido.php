<?php
require_once('../../sistema/conexao.php');
require_once('ApiConfig.php');
@session_start();

// Definição inicial de variáveis
$id_usuario = @$_SESSION['id'] ?? 0;
$sessao_pedido_balcao = @$_SESSION['pedido_balcao'] ?? '';
$tipo_pedido = ($sessao_pedido_balcao == 'BALCÃO') ? 'Balcão' : '';
$sessao = @$_SESSION['sessao_usuario'] ?? '';

// Datas
$data_atual = date('Y-m-d');
$data_dias_retorno = date('Y-m-d', strtotime("+$dias_retorno days", strtotime($data_atual)));

// Sanitização de entradas
$inputs = [
    'pagamento' => FILTER_SANITIZE_STRING,
    'entrega' => FILTER_SANITIZE_STRING,
    'rua' => FILTER_SANITIZE_STRING,
    'numero' => FILTER_SANITIZE_STRING,
    'bairro' => FILTER_SANITIZE_STRING,
    'complemento' => FILTER_SANITIZE_STRING,
    'troco' => FILTER_SANITIZE_STRING,
    'obs' => FILTER_SANITIZE_STRING,
    'nome_cliente' => FILTER_SANITIZE_STRING,
    'tel_cliente' => FILTER_SANITIZE_STRING,
    'id_cliente' => FILTER_SANITIZE_STRING,
    'mesa' => FILTER_SANITIZE_STRING,
    'cupom' => FILTER_SANITIZE_STRING,
    'codigo_pix' => FILTER_SANITIZE_STRING,
    'cep' => FILTER_SANITIZE_STRING,
    'cidade' => FILTER_SANITIZE_STRING,
    'taxa_entrega' => FILTER_SANITIZE_STRING,
    'esta_pago' => FILTER_SANITIZE_STRING,
];

// Filtragem em uma única operação
$filtered = filter_input_array(INPUT_POST, $inputs);

// Atribuir variáveis sanitizadas
$pagamento = $filtered['pagamento'] ?? '';
$entrega = $filtered['entrega'] ?? '';
$rua = $filtered['rua'] ?? '';
$numero = $filtered['numero'] ?? '';
$bairro = $filtered['bairro'] ?? '';
$complemento = $filtered['complemento'] ?? '';
$total_pago = $filtered['troco'] ?? '';
$obs = $filtered['obs'] ?? '';
$nome_cliente_ped = $filtered['nome_cliente'] ?? '';
$tel_cliente = $filtered['tel_cliente'] ?? '';
$cliente = $filtered['id_cliente'] ?? '';
$mesa = $filtered['mesa'] ?? '';
$cupom = $filtered['cupom'] ?? '0';
$codigo_pix = $filtered['codigo_pix'] ?? '';
$cep = $filtered['cep'] ?? '';
$cidade = $filtered['cidade'] ?? '';
$taxa_entrega = $filtered['taxa_entrega'] ?? '0';
$esta_pago = $filtered['esta_pago'] ?? '';

// Formatar valores numéricos
$total_pago = str_replace(',', '.', $total_pago);
$taxa_entrega = str_replace(',', '.', $taxa_entrega);

// Verificar pagamento PIX
require("verificar_pgto.php");
$pago = (@$status_api == 'approved' || $esta_pago == 'Sim') ? 'Sim' : 'Não';

// Verificar pagamento PIX não realizado
if ($pagamento == 'Pix' && $pago == 'Não' && empty($dados_pagamento)) {
    echo 'Pagamento nao realizado!!';
    exit();
}

// Processar dados do cliente
$cliente = 0;
$total_cartoes_cliente = 0;

if (!empty($tel_cliente)) {
    $stmt = $pdo->prepare("SELECT * FROM clientes WHERE telefone = ?");
    $stmt->execute([$tel_cliente]);
    $res = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    if (count($res) > 0) {
        $cliente = $res[0]['id'];
        $total_cartoes_cliente = $res[0]['cartoes'] ?: 0;
        
        // Lógica para cartões de fidelidade
        if ($total_cartoes_cliente < $total_cartoes_config) {
            $total_cartoes_cliente++;
        }
        
        if ($total_cartoes_cliente == $total_cartoes_config && $cupom == $valor_cupom_config) {
            $total_cartoes_cliente = 0;
        }
        
        // Atualizar cliente existente
        $stmt = $pdo->prepare("UPDATE clientes SET 
            nome = ?, 
            endereco = ?, 
            numero = ?, 
            complemento = ?, 
            bairro = ?, 
            cep = ?, 
            cidade = ?, 
            data_mensagem = ?, 
            retorno_enviado = 'Não',
            cartoes = ? 
            WHERE id = ?");
            
        $stmt->execute([
            $nome_cliente_ped,
            $rua,
            $numero,
            $complemento,
            $bairro,
            $cep,
            $cidade,
            $data_dias_retorno,
            $total_cartoes_cliente,
            $cliente
        ]);
        
    } else {
        // Inserir novo cliente
        $stmt = $pdo->prepare("INSERT INTO clientes (
            nome, telefone, endereco, numero, bairro, complemento, 
            data_cad, cep, cidade, data_mensagem, retorno_enviado, cartoes
        ) VALUES (?, ?, ?, ?, ?, ?, curDate(), ?, ?, ?, 'Não', 1)");
        
        $stmt->execute([
            $nome_cliente_ped,
            $tel_cliente,
            $rua,
            $numero,
            $bairro,
            $complemento,
            $cep,
            $cidade,
            $data_dias_retorno
        ]);
        
        $cliente = $pdo->lastInsertId();
    }
}

// Calcular total do carrinho
$total_carrinho = 0;
$stmt = $pdo->prepare("SELECT * FROM carrinho WHERE sessao = ?");
$stmt->execute([$sessao]);
$res = $stmt->fetchAll(PDO::FETCH_ASSOC);

if (count($res) === 0) {
    echo '0';
    exit();
}

// Processar itens do carrinho
foreach ($res as $item) {
    $id = $item['id'];
    $total_item = $item['total_item'];
    $produto = $item['produto'];
    $quantidade = $item['quantidade'];
    
    $total_item = $total_item * $quantidade;
    $total_carrinho += $total_item;
    
    // Verificar estoque
    $stmt = $pdo->prepare("SELECT categoria, valor_venda, estoque, tem_estoque FROM produtos WHERE id = ?");
    $stmt->execute([$produto]);
    $produto_info = $stmt->fetch(PDO::FETCH_ASSOC);
    
    if ($produto_info && $produto_info['tem_estoque'] == 'Sim') {
        $total_produtos = $produto_info['estoque'] - $quantidade;
        $stmt = $pdo->prepare("UPDATE produtos SET estoque = ? WHERE id = ?");
        $stmt->execute([$total_produtos, $produto]);
    }
}

// Ajuste para pagamento com cartão de crédito (acréscimo de 5%)
if ($pagamento == 'Cartão de Crédito') {
    $total_carrinho += ($total_carrinho * 0.05);
}

// Calcular total com frete e cupom
$total_com_frete = $total_carrinho + $taxa_entrega - $cupom;

// Calcular troco
if (empty($total_pago)) {
    $total_pago = $total_com_frete;
}
$troco = $total_pago - $total_com_frete;

// Obter o próximo número de pedido
$stmt = $pdo->query("SELECT pedido FROM vendas WHERE data = curDate() ORDER BY id DESC LIMIT 1");
$res = $stmt->fetch(PDO::FETCH_ASSOC);
$pedido = ($res ? $res['pedido'] : 0) + 1;

// Inserir venda
$stmt = $pdo->prepare("INSERT INTO vendas (
    cliente, valor, total_pago, troco, data, hora, status, pago, obs, taxa_entrega, 
    tipo_pgto, usuario_baixa, entrega, mesa, nome_cliente, cupom, pago_entregador, 
    pedido, ref_api, tipo_pedido
) VALUES (
    ?, ?, ?, ?, curDate(), curTime(), 'Iniciado', ?, ?, ?, ?, '0', ?, ?, ?, ?, 'Não', ?, ?, ?
)");

$stmt->execute([
    $cliente,
    $total_com_frete,
    $total_pago,
    $troco,
    $pago,
    $obs,
    $taxa_entrega,
    $pagamento,
    $entrega,
    $mesa,
    $nome_cliente_ped,
    $cupom,
    $pedido,
    $codigo_pix,
    $tipo_pedido
]);

$id_pedido = $pdo->lastInsertId();
$id_pedido_feito = $id_pedido;

// Relacionar itens do carrinho com o pedido em uma única operação
$stmt = $pdo->prepare("UPDATE carrinho SET cliente = ?, pedido = ? WHERE sessao = ? AND pedido = '0'");
$stmt->execute([$cliente, $id_pedido, $sessao]);

// Limpar a sessão aberta
@$_SESSION['sessao_usuario'] = "";

// Calcular hora prevista de entrega
$hora_pedido = date('H:i', strtotime("+$previsao_entrega minutes", strtotime(date('H:i'))));
echo $hora_pedido . '*';

// Envio de mensagem WhatsApp se API estiver habilitada
if ($api_whatsapp != 'Não' && !empty($tel_cliente)) {
    $telefone_envio = '55' . preg_replace('/[ ()-]+/', '', $tel_cliente);
    $total_com_freteF = number_format($total_com_frete, 2, ',', '.');
    
    // Construir mensagem principal
    $mensagem = '*Pedido:* ' . $pedido . '%0A';
    $mensagem .= '*Cliente:* ' . $nome_cliente_ped . '%0A';
    $mensagem .= '*Telefone:* ' . $tel_cliente . '%0A';
    $mensagem .= '*Valor:* R$ ' . $total_com_freteF . '%0A';
    $mensagem .= '*Pagamento:* ' . $pagamento . '%0A';
    $mensagem .= '*Pago:* ' . $pago . '%0A';
    $mensagem .= '*Previsão Entrega:* ' . $hora_pedido . '%0A';
    $mensagem .= '%0A________________________________%0A%0A';
    $mensagem .= '*_Detalhes do Pedido_* %0A%0A';
    
    // Buscar produtos do pedido com uma única consulta
    $stmt = $pdo->prepare("SELECT c.*, p.nome, p.foto 
                           FROM carrinho c 
                           LEFT JOIN produtos p ON c.produto = p.id 
                           WHERE c.pedido = ? 
                           ORDER BY c.id ASC");
    $stmt->execute([$id_pedido]);
    $dados = $stmt->fetchAll(PDO::FETCH_ASSOC);
    
    // Processar detalhes dos produtos
    foreach ($dados as $carrinho_item) {
        $id_carrinho = $carrinho_item['id'];
        $id_produto = $carrinho_item['produto'];
        $quantidade = $carrinho_item['quantidade'];
        $obs_item = $carrinho_item['obs'];
        $variacao = $carrinho_item['variacao'];
        $nome_produto_tab = $carrinho_item['nome_produto'];
        $sabores = $carrinho_item['sabores'];
        $borda = $carrinho_item['borda'];
        
        // Obter dados da variação
        $sigla_variacao = '';
        if ($variacao) {
            $stmt = $pdo->prepare("SELECT sigla FROM variacoes WHERE id = ?");
            $stmt->execute([$variacao]);
            $var_res = $stmt->fetch(PDO::FETCH_ASSOC);
            $sigla_variacao = $var_res ? '(' . $var_res['sigla'] . ')' : '';
        }
        
        // Obter item de grade
        $sigla_grade = '';
        $stmt = $pdo->prepare("SELECT t.id_item, i.texto 
                              FROM temp t 
                              LEFT JOIN itens_grade i ON t.id_item = i.id 
                              WHERE t.carrinho = ? AND t.tabela = 'Variação' 
                              ORDER BY t.id ASC LIMIT 1");
        $stmt->execute([$id_carrinho]);
        $grade_res = $stmt->fetch(PDO::FETCH_ASSOC);
        if ($grade_res && $grade_res['texto']) {
            $sigla_grade = $grade_res['texto'];
        }
        
        // Definir nome do produto
        $nome_produto = $carrinho_item['nome'] ?: $nome_produto_tab;
        
        // Tabela de adicionais
        $tabela_ad = ($sabores > 0) ? 'adicionais_cat' : 'adicionais';
        
        // Verificar borda
        $nome_borda = '';
        if ($borda) {
            $stmt = $pdo->prepare("SELECT nome FROM bordas WHERE id = ?");
            $stmt->execute([$borda]);
            $borda_res = $stmt->fetch(PDO::FETCH_ASSOC);
            $nome_borda = $borda_res ? ' - ' . $borda_res['nome'] : '';
        }
        
        // Adicionar produto à mensagem
        $mensagem .= '%0A✅' . $quantidade . ' - ' . $nome_produto . ' ' . $sigla_variacao . ' ' . $sigla_grade . '%0A';
        
        if ($nome_borda) {
            $mensagem .= $nome_borda . '%0A';
        }
        
        // Verificar adicionais
        $stmt = $pdo->prepare("SELECT t.id, t.id_item, t.quantidade 
                              FROM temp t 
                              WHERE t.carrinho = ? AND t.tabela = ?");
        $stmt->execute([$id_carrinho, 'adicionais']);
        $adicionais = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        if (count($adicionais) > 0) {
            $texto_adicional = (count($adicionais) > 1) ? 
                count($adicionais) . ' Tipos de Adicionais' : 
                count($adicionais) . ' Tipo de Adicional';
                
            $mensagem .= ' *' . $texto_adicional . '* %0A';
            
            foreach ($adicionais as $index => $adicional) {
                $id_item = $adicional['id_item'];
                $quantidade_temp = $adicional['quantidade'];
                
                $stmt = $pdo->prepare("SELECT nome FROM $tabela_ad WHERE id = ?");
                $stmt->execute([$id_item]);
                $adc_res = $stmt->fetch(PDO::FETCH_ASSOC);
                $nome_adc = $adc_res['nome'];
                
                if ($index < (count($adicionais) - 1)) {
                    $nome_adc .= '%0A';
                }
                
                $mensagem .= '```(' . $quantidade_temp . ') ' . $nome_adc . '```' . '';
            }
            
            $mensagem .= '%0A';
        }
        
        // Verificar grades do produto
        $stmt = $pdo->prepare("SELECT id, nome_comprovante, tipo_item 
                              FROM grades 
                              WHERE produto = ? AND tipo_item != 'Variação'");
        $stmt->execute([$id_produto]);
        $grades = $stmt->fetchAll(PDO::FETCH_ASSOC);
        
        foreach ($grades as $grade) {
            $id_da_grade = $grade['id'];
            $nome_da_grade = $grade['nome_comprovante'];
            $tipo_item_grade = $grade['tipo_item'];
            
            // Buscar itens selecionados pela grade
            $stmt = $pdo->prepare("SELECT t.id, t.id_item, t.tabela, t.tipagem, t.grade, t.quantidade 
                                  FROM temp t 
                                  WHERE t.carrinho = ? AND t.grade = ?");
            $stmt->execute([$id_carrinho, $id_da_grade]);
            $itens_grade = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            if (count($itens_grade) > 0) {
                $mensagem .= '*' . $nome_da_grade . '* %0A';
                
                foreach ($itens_grade as $index => $item_grade) {
                    $id_item = $item_grade['id_item'];
                    $quant_item = $tipo_item_grade == 'Múltiplo' ? '(' . $item_grade['quantidade'] . ')' : '';
                    
                    $stmt = $pdo->prepare("SELECT texto FROM itens_grade WHERE id = ?");
                    $stmt->execute([$id_item]);
                    $texto_res = $stmt->fetch(PDO::FETCH_ASSOC);
                    $nome_item = $texto_res['texto'];
                    
                    if ($index < (count($itens_grade) - 1)) {
                        $nome_item .= ', ';
                    }
                    
                    $mensagem .= '```' . $quant_item . $nome_item . '```%0A';
                }
                
                $mensagem .= '%0A';
            }
        }
        
        // Adicionar observações do item
        if ($obs_item) {
            $mensagem .= ' ' . '```Observações: ' . $obs_item . '```' . '%0A';
        }
    }
    
    // Adicionar observações do pedido
    if ($obs) {
        $mensagem .= '%0A*Observações do Pedido*%0A';
        $mensagem .= '_' . $obs . '_' . '%0A%0A';
    }
    
    // Adicionar endereço do cliente se for delivery
    if ($entrega == "Delivery") {
        $mensagem .= '%0A*Endereço do Cliente*%0A';
        $endereco = $rua . ' ' . $numero . ' ' . $complemento . ' ' . $bairro . ' ' . $cidade;
        $mensagem .= '_' . $endereco . '_';
    }
    
    // Adicionar informações de cartão fidelidade
    if ($total_cartoes_config > 0 && $total_cartoes_cliente > 0) {
        $mensagem .= '%0A%0A' . 'Você ganhou mais um cartão Fidelidade' . '%0A';
        $mensagem .= 'Você agora possui *' . $total_cartoes_cliente . '* cartões!';
    }
    
    if ($total_cartoes_config == $total_cartoes_cliente) {
        $mensagem .= '%0A%0A' . '*Você já completou seus cartões Fidelidade*' . '%0A';
        $mensagem .= 'Na sua próxima compra use o codigo de cupom (cartao) para ter um desconto de ' . $valor_cupom_config . ' reais!';
    }
    
    // Adicionar rodapé da mensagem
    $mensagem .= '%0A%0A' . '```Obrigado pela preferência```' . '%0A';
    $mensagem .= $url_sistema . '%0A%0A';
    $mensagem .= 'Acompanhe o Status do Seu pedido%0A';
    $mensagem .= $url_sistema . 'pedido/' . $id_pedido_feito . '%0A';
    
    // Enviar mensagem
    $data_mensagem = date('Y-m-d H:i:s');
    require("api_texto.php");
}

// Processar informações de pagamento
$id_tipo_pgto = 0;
if ($pagamento) {
    $stmt = $pdo->prepare("SELECT id FROM formas_pgto WHERE nome = ?");
    $stmt->execute([$pagamento]);
    $pgto_res = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($pgto_res) {
        $id_tipo_pgto = $pgto_res['id'];
    }
}

// Processamento do caixa
$id_caixa = 0;
if ($tipo_pedido == 'Balcão') {
    $entrega = 'Balcão';
    
    // Verificar caixa aberto
    $stmt = $pdo->prepare("SELECT id FROM caixas WHERE operador = ? AND data_fechamento IS NULL ORDER BY id DESC LIMIT 1");
    $stmt->execute([$id_usuario]);
    $caixa_res = $stmt->fetch(PDO::FETCH_ASSOC);
    $id_caixa = $caixa_res ? $caixa_res['id'] : 0;
} else {
    $id_usuario = 0;
}

// Registrar pagamento se já estiver pago
if ($pago == 'Sim') {
    $stmt = $pdo->prepare("INSERT INTO receber (
        descricao, cliente, valor, subtotal, data_lanc, hora, pago, vencimento, 
        data_pgto, foto, arquivo, forma_pgto, referencia, caixa, usuario_pgto
    ) VALUES (
        ?, ?, ?, ?, curDate(), curTime(), 'Sim', curDate(), curDate(), 
        'sem-foto.png', 'sem-foto.png', ?, ?, ?, ?
    )");
    
    $stmt->execute([
        $entrega,
        $cliente,
        $total_com_frete,
        $total_com_frete,
        $id_tipo_pgto,
        $entrega,
        $id_caixa,
        $id_usuario
    ]);
}

// Retornar resultado
echo "Pedido Finalizado*" . $id_pedido;
