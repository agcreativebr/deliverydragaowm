<?php
require_once ("../../../conexao.php");
$tabela = 'vendas';

@session_start();
$id_usuario = @$_SESSION['id'];

$id = $_POST['id'];
$acao = $_POST['acao'];
$telefone = @$_POST['telefone'];
$total = @$_POST['total'];
$pagamento = @$_POST['pagamento'];
$texto = @$_POST['texto'];


$query = $pdo->query("SELECT * FROM vendas where id = '$id'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {
	$valor = $res[0]['valor'];
	$entrega = $res[0]['entrega'];
	$cliente = $res[0]['cliente'];
	$forma_pgto = $res[0]['tipo_pgto'];
}


//verificar caixa aberto
$query1 = $pdo->query("SELECT * from caixas where operador = '$id_usuario' and data_fechamento is null order by id desc limit 1");
$res1 = $query1->fetchAll(PDO::FETCH_ASSOC);
if (@count($res1) > 0) {
	$id_caixa = @$res1[0]['id'];
} else {
	$id_caixa = 0;
}



if ($acao == 'Finalizado') {
	$pdo->query("UPDATE $tabela SET status = '$acao', pago = 'Sim', usuario_baixa = $id_usuario where id = '$id'");


	$pdo->query("INSERT INTO receber SET descricao = '$entrega', cliente = '$cliente', valor = '$valor', subtotal = '$valor', data_lanc = curDate(), hora = curTime(), pago = 'Sim', usuario_pgto = '$id_usuario', vencimento = curDate(), data_pgto = curDate(), foto = 'sem-foto.png', arquivo = 'sem-foto.png', forma_pgto = '$forma_pgto', caixa = '$id_caixa', referencia = '$entrega'");

	$pdo->query("UPDATE entregadores SET pago = 'Sim', status = '$acao', data = curDate() where id = '$id'");

} else {
	$pdo->query("UPDATE $tabela SET status = '$acao' where id = '$id'");
}




echo 'Alterado com Sucesso***';


if ($api_whatsapp != 'Não' and $acao == 'Entrega') {
	$mensagem = '*----------ATENÇÃO----------* %0A%0A';

	$mensagem .= $texto . '%0A';
	$mensagem .= '*Total:* R$ ' . $total . '%0A';
	$mensagem .= '*Pagamento:* ' . $pagamento . '%0A';
	$data_mensagem = date('Y-m-d H:i:s');
	$telefone_envio = $telefone;
	require ("../../../../js/ajax/api_texto.php");
}

?>