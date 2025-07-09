<?php
header('Content-Type: application/json');
@session_start();

require_once('../../sistema/conexao.php');
require_once('../../sistema/SecureDB.php');

// LOG DE ENTRADA
file_put_contents('../../sistema/logs/security.log', json_encode([
	'event' => 'add_carrinho_entrada',
	'post' => $_POST,
	'session' => $_SESSION,
	'hora' => date('Y-m-d H:i:s')
], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

try {
	// Validar sessão
	if (!isset($_SESSION['sessao_usuario'])) {
		$_SESSION['sessao_usuario'] = uniqid();
	}

	$sessao = $_SESSION['sessao_usuario'];

	// Validar dados obrigatórios
	if (!isset($_POST['produto']) || empty($_POST['produto'])) {
		throw new Exception("ID do produto não informado");
	}

	$produto = filter_var($_POST['produto'], FILTER_VALIDATE_INT);
	if ($produto === false) {
		throw new Exception("ID do produto inválido");
	}

	$quantidade = isset($_POST['quantidade']) ? filter_var($_POST['quantidade'], FILTER_VALIDATE_INT) : 1;
	if ($quantidade === false || $quantidade < 1) {
		$quantidade = 1;
	}

	$obs = isset($_POST['obs']) ? filter_input(INPUT_POST, 'obs', FILTER_SANITIZE_STRING) : '';
	$valor_unitario = isset($_POST['valor_unit']) ? filter_var($_POST['valor_unit'], FILTER_VALIDATE_FLOAT) : null;

	// Usar classe segura para adicionar ao carrinho
	$secureDB = new SecureDB($pdo);

	$query = $pdo->query("SELECT * FROM produtos where id = '$produto'");
	$res = $query->fetchAll(PDO::FETCH_ASSOC);
	$id_categoria = $res[0]['categoria'];
	$valor_produto = $res[0]['valor_venda'];

	// Se tiver variação, usar o valor da variação
	$variacao = isset($_POST['variacao']) ? filter_var($_POST['variacao'], FILTER_VALIDATE_INT) : null;
	if ($variacao !== null) {
		$query = $pdo->query("SELECT * FROM variacoes where id = '$variacao'");
		$res = $query->fetchAll(PDO::FETCH_ASSOC);
		if (@count($res) > 0) {
			$valor_produto = $res[0]['valor'];
		}
	}

	// Calcular total do item
	$total_item = null;
	if (isset($_POST['total_item'])) {
		$total_item = filter_var($_POST['total_item'], FILTER_VALIDATE_FLOAT);
	}
	if ($total_item === false || $total_item === null) {
		$total_item = $valor_produto * $quantidade;
	}

	// Inserir no carrinho
	$query = $pdo->prepare("INSERT INTO carrinho SET 
		sessao = :sessao,
		produto = :produto,
		quantidade = :quantidade,
		total_item = :total_item,
		valor_unitario = :valor_unitario,
		obs = :obs,
		pedido = '0',
		data = curDate(),
		hora = curTime()");

	$query->execute([
		':sessao' => $sessao,
		':produto' => $produto,
		':quantidade' => $quantidade,
		':total_item' => $total_item,
		':valor_unitario' => $valor_produto,
		':obs' => $obs
	]);

	// Obter o ID do item do carrinho recém-criado
	$id_carrinho = $pdo->lastInsertId();

	// Vincular adicionais temporários ao item do carrinho
	$pdo->query("UPDATE temp SET carrinho = '$id_carrinho' WHERE sessao = '$sessao' AND carrinho = '0' AND tabela = 'adicionais'");

	echo json_encode(['status' => 'success', 'message' => 'Item adicionado com sucesso']);
} catch (Exception $e) {
	// Log do erro
	file_put_contents('../../sistema/logs/security.log', json_encode([
		'event' => 'add_carrinho_erro',
		'erro' => $e->getMessage(),
		'post' => $_POST,
		'session' => $_SESSION,
		'hora' => date('Y-m-d H:i:s')
	], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

	echo json_encode([
		'status' => 'error',
		'message' => $e->getMessage()
	]);
}
