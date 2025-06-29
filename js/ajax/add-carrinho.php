<?php
@session_start();
require_once('../../sistema/conexao.php');
require_once('../../sistema/SecureDB.php');

// Inicializar sistema seguro
$secureDB = new SecureDB($pdo);

// Sanitizar e validar entradas
$produto = (int) $_POST['produto'];
$quantidade = (int) filter_var(@$_POST['quantidade'], @FILTER_SANITIZE_NUMBER_INT);
$total_item = (float) filter_var(@$_POST['total_item'], @FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
$obs = SecureDB::sanitize(@$_POST['obs']);
$sessao = SecureDB::sanitize(@$_SESSION['sessao_usuario']);
$valor_produto = (float) filter_var(@$_POST['valor_produto'], @FILTER_SANITIZE_NUMBER_FLOAT, FILTER_FLAG_ALLOW_FRACTION);
$mesa = (int) $_POST['mesa'];

// Validar dados obrigatórios
if ($produto <= 0) {
	echo 'Produto inválido';
	exit();
}

if ($quantidade <= 0) {
	echo 'Quantidade deve ser maior que zero';
	exit();
}

// Buscar dados do produto com prepared statement
$produto_data = $secureDB->find('produtos', ['id' => $produto]);

if (!$produto_data) {
	echo 'Produto não encontrado';
	exit();
}

$id_categoria = $produto_data['categoria'];
$estoque = $produto_data['estoque'];
$tem_estoque = $produto_data['tem_estoque'];
$valor_venda = $produto_data['valor_venda'];
$preparado = $produto_data['preparado'];

$status = '';
if ($preparado === 'Sim' and $mesa != "") {
	$status = 'Aguardando';
}

if ($valor_produto == "") {
	$valor_produto = $valor_venda;
}

//ver se possui a quantidade de produtos comprados
if ($quantidade > $estoque and $tem_estoque == 'Sim') {
	echo 'Quantidade em Estoque insuficiente, possui apenas ' . $estoque . ' Itens';
	exit();
}


$id_edicao = 0;
if (@$_SESSION['id_edicao'] != "") {
	$id_edicao = (int) $_SESSION['id_edicao'];

	// Buscar dados da venda com prepared statement
	$venda_data = $secureDB->find('vendas', ['id' => $id_edicao]);

	if ($venda_data) {
		$valor_venda_atual = (float) $venda_data['valor'];
		$total_venda = $valor_venda_atual + ($total_item * $quantidade);

		// Atualizar valor da venda com prepared statement
		$secureDB->update(
			'vendas',
			['valor' => $total_venda],
			['id' => $id_edicao]
		);
	}
}

// Inserir no carrinho com prepared statement
$carrinho_data = [
	'sessao' => $sessao,
	'cliente' => 0,
	'produto' => $produto,
	'quantidade' => $quantidade,
	'total_item' => $total_item,
	'obs' => $obs,
	'pedido' => $id_edicao,
	'data' => date('Y-m-d'),
	'mesa' => $mesa,
	'nome_cliente' => '',
	'valor_unitario' => $valor_produto,
	'status' => $status,
	'hora' => date('H:i:s')
];

$id_carrinho = $secureDB->insert('carrinho', $carrinho_data);

// Log da operação para auditoria
SecurityLogger::logSecurityEvent('carrinho_add', [
	'produto_id' => $produto,
	'quantidade' => $quantidade,
	'valor_total' => $total_item * $quantidade,
	'carrinho_id' => $id_carrinho
]);

echo 'Inserido com Sucesso';

// Atualizar ingredientes e adicionais com prepared statement
$secureDB->update(
	'temp',
	['carrinho' => $id_carrinho],
	['sessao' => $sessao, 'carrinho' => '0']
);
