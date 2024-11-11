<?php
require_once("../../../conexao.php");
$tabela = 'adicionais';

$query = $pdo->query("SELECT * FROM $tabela order by id desc");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {

	echo <<<HTML
	<small>
	<table class="table table-hover table-bordered text-nowrap border-bottom dt-responsive" id="tabela">
	<thead> 
	<tr> 
		<th align="center" width="5%" class="text-center">Selecionar</th>
	<th>Nome</th>	
	<th>Valor</th>		
	<th>Ativo</th>		
	<th>Ações</th>
	</tr> 
	</thead> 
	<tbody>	
HTML;

	for ($i = 0; $i < $total_reg; $i++) {
		foreach ($res[$i] as $key => $value) {
		}
		$id = $res[$i]['id'];
		$nome = $res[$i]['nome'];
		$valor = $res[$i]['valor'];
		$valorF = number_format($valor, 2, ',', '.');
		$ativo = $res[$i]['ativo'];

		if ($ativo == 'Sim') {
			$icone = 'fa-check-square';
			$titulo_link = 'Desativar Item';
			$acao = 'Não';
			$classe_linha = '';
		} else {
			$icone = 'fa-square-o';
			$titulo_link = 'Ativar Item';
			$acao = 'Sim';
			$classe_linha = '#c4c4c4';
		}

		echo <<<HTML
<tr>
	<td align="center">
<div class="custom-checkbox custom-control">
<input type="checkbox" class="custom-control-input" id="seletor-{$id}" onchange="selecionar('{$id}')">
<label for="seletor-{$id}" class="custom-control-label mt-1 text-dark"></label>
</div>
</td>

<td style="color:{$classe_linha}">{$nome}</td>
<td style="color:{$classe_linha}">{$valorF}</td>
<td style="color:{$classe_linha}">{$ativo}</td>
<td>
	<a class="btn btn-info-light btn-sm" href="#" onclick="editar('{$id}','{$nome}','{$valor}')" title="Editar Dados"><i class="fa fa-edit"></i></a>

	

<big><a href="#" class="btn btn-danger-light btn-sm" onclick="excluir('{$id}')" title="Excluir"><i class="fa fa-trash-can text-danger"></i></a></big>


			<a class="btn btn-success-light btn-sm" href="#" onclick="ativar('{$id}', '{$acao}')" title="{$titulo_link}"><i class="fa {$icone}"></i></a>


</td>
</tr>
HTML;
	}

	echo <<<HTML
	</tbody>
	<small><div align="center" id="mensagem-excluir"></div></small>
	</table>
	</small>
HTML;
} else {
	echo 'Não possui registros cadastrados!';
}


?>


<script type="text/javascript">
	$(document).ready(function() {
		$('#tabela').DataTable({
			"ordering": false,
			"stateSave": true
		});
		$('#tabela_filter label input').focus();
	});
</script>


<script type="text/javascript">
	function editar(id, nome, valor) {
		$('#id').val(id);
		$('#nome').val(nome);
		$('#valor').val(valor);



		$('#titulo_inserir').text('Editar Registro');
		$('#modalForm').modal('show');

	}


	function limparCampos() {
		$('#id').val('');
		$('#nome').val('');
		$('#valor').val('');
	}
</script>


<script>
	function selecionar(id) {

		var ids = $('#ids').val();

		if ($('#seletor-' + id).is(":checked") == true) {
			var novo_id = ids + id + '-';
			$('#ids').val(novo_id);
		} else {
			var retirar = ids.replace(id + '-', '');
			$('#ids').val(retirar);
		}

		var ids_final = $('#ids').val();
		if (ids_final == "") {
			$('#btn-deletar').hide();
		} else {
			$('#btn-deletar').show();
		}
	}



	function deletarSel() {
		//$('#mensagem-excluir').text('Excluindo...')


		$('body').removeClass('timer-alert');
		swal({
				title: "Deseja Excluir?",
				text: "Você não conseguirá recuperá-lo novamente!",
				type: "error",
				showCancelButton: true,
				confirmButtonClass: "btn btn-danger",
				confirmButtonText: "Sim, Excluir!",
				closeOnConfirm: true

			},
			function() {

				//swal("Excluído(a)!", "Seu arquivo imaginário foi excluído.", "success");

				var ids = $('#ids').val();
				var id = ids.split("-");

				for (i = 0; i < id.length - 1; i++) {
					excluirMultiplos(id[i]);
				}

				setTimeout(() => {
					excluido();
					listar();
				}, 1000);

				limparCampos();

				$('#btn-deletar').hide();



			});

	}
</script>