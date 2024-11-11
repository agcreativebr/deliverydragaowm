<?php 
require_once("../../../conexao.php");
$tabela = 'variacoes';

$id = $_POST['id'];

$query = $pdo->query("SELECT * FROM $tabela where produto = '$id' order by id desc");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if($total_reg > 0){

echo <<<HTML
	<small>
	<table class="table table-hover table-bordered text-nowrap border-bottom dt-responsive">
	<thead> 
	<tr> 
	<th>Nome</th>	
	<th>Sigla</th> 	
	<th>Valor</th> 		
	<th>Ações</th>
	</tr> 
	</thead> 
	<tbody>	
HTML;

for($i=0; $i < $total_reg; $i++){
	foreach ($res[$i] as $key => $value){}
		$id = $res[$i]['id'];
		$nome = $res[$i]['nome'];
		$sigla = $res[$i]['sigla'];
		$valor = $res[$i]['valor'];		
	$ativo = $res[$i]['ativo'];

	$valorF = number_format($valor, 2, ',', '.');
	

		if($ativo == 'Sim'){
			$icone = 'fa-check-square';
			$titulo_link = 'Desativar Item';
			$acao = 'Não';
			$classe_linha = '';
		}else{
			$icone = 'fa-square-o';
			$titulo_link = 'Ativar Item';
			$acao = 'Sim';
			$classe_linha = '#c4c4c4';
		}


		
echo <<<HTML
<tr>
<td style="color:{$classe_linha}">{$nome}</td>
<td style="color:{$classe_linha}">{$sigla}</td>
<td style="color:{$classe_linha}">R$ {$valorF}</td>

<td>
	
<div class="dropdown" style="display: inline-block;">                      
		<a class="btn btn-danger-light btn-sm" href="#" aria-expanded="false" aria-haspopup="true" data-bs-toggle="dropdown" class="dropdown"><i class="fa fa-trash-o"></i> </a>
		<div  class="dropdown-menu tx-13">
		<div class="dropdown-item-text botao_excluir">
		<p>Confirmar Exclusão? <a href="#" onclick="excluirVar('{$id}')"><span class="text-danger"><button class="btn-danger">Sim</button></span></a></p>
		</div>
		</div>
		</div>


		<a class="btn btn-success-light btn-sm" href="#" onclick="ativarVar('{$id}', '{$acao}')" title="{$titulo_link}"><i class="fa {$icone}"></i></a>




</td>
</tr>
HTML;

}

echo <<<HTML
	</tbody>
	<small><div align="center" id="mensagem-excluir-var"></div></small>
	</table>
	</small>
HTML;


}else{
	echo '<small>Não possui nenhuma variação cadastrada!</small>';
}



