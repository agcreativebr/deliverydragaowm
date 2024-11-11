<?php 
require_once("../../../conexao.php");
$tabela = 'variacoes_cat';

$sigla = $_POST['sigla'];
$nome = $_POST['nome'];
$descricao = $_POST['descricao'];
$produto = $_POST['id'];
$sabores = $_POST['sabores'];
$id_var_editar = $_POST['id_var_editar'];

$sigla = str_replace(' ', '', $sigla);

//validar sigla
$query = $pdo->query("SELECT * from $tabela where sigla = '$sigla' and categoria = '$produto'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
if(@count($res) > 0){
	echo 'Sigla já Cadastrada, escolha outra!!';
	exit();
}

if($id_var_editar == ""){
$query = $pdo->prepare("INSERT INTO $tabela SET nome = :nome, categoria = '$produto', sigla = :sigla,  descricao = :descricao,  sabores = '$sabores'");
}else{
		$query = $pdo->prepare("UPDATE $tabela SET nome = :nome, categoria = '$produto', sigla = :sigla,  descricao = :descricao,  sabores = '$sabores' WHERE id = '$id_var_editar'");
}


$query->bindValue(":nome", "$nome");
$query->bindValue(":descricao", "$descricao");
$query->bindValue(":sigla", "$sigla");
$query->execute();

echo 'Salvo com Sucesso';