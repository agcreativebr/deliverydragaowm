<?php
@session_start();
require_once('../../sistema/conexao.php');

$id = $_POST['id'];
$acao = $_POST['acao'];
$quantidade = $_POST['quantidade'];

if ($acao == 'menos') {
	$quant = $quantidade - 1;
} else {
	$quant = $quantidade + 1;
}





$query = $pdo->query("SELECT * FROM carrinho where id = '$id'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_item = @$res[0]['total_item'];
$quantidade = @$res[0]['quantidade'];
$produto = @$res[0]['produto'];

// Buscar o valor unitário do produto
$query = $pdo->query("SELECT * FROM produtos where id = '$produto'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$valor_unit = @$res[0]['valor_venda'];

// Calcular novo valor total
$novo_valor = $quant * $valor_unit;

$pdo->query("UPDATE carrinho set quantidade = '$quant', total_item = '$novo_valor' WHERE id = '$id'");

echo 'Alterado com Sucesso';
