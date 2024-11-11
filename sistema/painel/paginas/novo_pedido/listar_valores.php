<?php
require_once("../../../conexao.php");
$tabela = 'valor_adiantamento';

$id = @$_POST['id'];


$query = $pdo->query("SELECT * FROM $tabela where abertura = '$id' order by id desc");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {

	echo <<<HTML
	<small>
	<table class="table table-hover table-bordered text-nowrap border-bottom dt-responsive" id="">
	<thead> 
	<tr> 
	<th width="60%">Nome</th>	
	<th>Valor</th>		
	<th>Excluir</th>
	</tr> 
	</thead> 
	<tbody>	
HTML;
	$total_valor = 0;
	$total_valorF = 0;
	for ($i = 0; $i < $total_reg; $i++) {
		$id = $res[$i]['id'];
		$nome = $res[$i]['nome'];
		$valor = $res[$i]['valor'];

		$valorF = number_format($valor, 2, ',', '.');

		$total_valor += $valor;
		$total_valorF = number_format($total_valor, 2, ',', '.');

		echo <<<HTML
<tr>
<td>{$nome}</td>
<td>{$valorF}</td>
<td>



													<div class="dropdown" style="display: inline-block;">                      
                        <a href="#" aria-expanded="false" aria-haspopup="true" data-bs-toggle="dropdown" class="dropdown"><i class="fe fe-trash-2 text-danger"></i> </a>
                        <div  class="dropdown-menu tx-13">
                        <div style="width: 240px; padding:15px 5px 0 10px;" class="dropdown-item-text">
                        <p>Confirmar Exclusão? <a href="#" onclick="excluirValor('{$id}')"><span class="text-danger">Sim</span></a></p>
                        </div>
                        </div>
                        </div>




</td>
</tr>
HTML;
	}

	echo <<<HTML
	</tbody>
	<small><div align="center" id="mensagem-excluir"></div>	</small>
	</table>
	<div align="right"><b>Total R$ </b><span style="color:green">{$total_valorF}</span></div>
	</small>
HTML;
} else {
	echo 'Não possui valores lançados!';
}


?>


<script type="text/javascript">
	function excluirValor(id) {
		$.ajax({
			url: 'paginas/' + pag + "/excluir_valor.php",
			method: 'POST',
			data: {
				id
			},
			dataType: "text",

			success: function(mensagem) {
				if (mensagem.trim() == "Excluído com Sucesso") {

					listarValores();
				} else {
					$('#mensagem-valor').addClass('text-danger')
					$('#mensagem-valor').text(mensagem)
				}

			},

		});
	}
</script>