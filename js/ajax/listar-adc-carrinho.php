<?php
@session_start();
require_once('../../sistema/conexao.php');
$id = $_POST['id'];
$id_sabor = @$_POST['id_sabor'];
$sessao = $_SESSION['sessao_usuario'];
$categoria = @$_POST['cat'];

$query_car = $pdo->query("SELECT * FROM carrinho where id = '$id'");
$id_sabor = 0;

$res_car = $query_car->fetchAll(PDO::FETCH_ASSOC);
$total_reg_car = @count($res_car);

for ($i_car = 0; $i_car < $total_reg_car; $i_car++) {
	$quantidade = $res_car[$i_car]['quantidade'];
	$id = $res_car[$i_car]['id'];
	$item = isset($res_car[$i_car]['item']) ? $res_car[$i_car]['item'] : '';

	$query = $pdo->query("SELECT * FROM temp where carrinho = '$id' and tabela = 'adicionais'");
	$res = $query->fetchAll(PDO::FETCH_ASSOC);
	$total_reg = @count($res);

	if ($total_reg > 0) {

		for ($i = 0; $i < $total_reg; $i++) {
			foreach ($res[$i] as $key => $value) {
			}
			$id_temp = $res[$i]['id'];
			$id_item = $res[$i]['id_item'];
			$quantidade_temp = isset($res[$i]['quantidade']) ? $res[$i]['quantidade'] : 1;

			if ($categoria > 0) {
				$query2 = $pdo->query("SELECT * FROM adicionais_cat where id = '$id_item' AND ativo = 'Sim'");
			} else {
				$query2 = $pdo->query("SELECT * FROM adicionais where id = '$id_item' AND ativo = 'Sim'");
			}

			$res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
			$total_reg2 = @count($res2);

			// Se não encontrar, buscar na itens_grade
			if ($total_reg2 == 0) {
				$query2 = $pdo->query("SELECT texto as nome, valor FROM itens_grade where id = '$id_item'");
				$res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
				$total_reg2 = @count($res2);
			}

			// Verificar se o resultado existe antes de acessar
			if ($total_reg2 > 0 && isset($res2[0]['nome']) && isset($res2[0]['valor'])) {
				$nome_adc = $res2[0]['nome'];
				$valor_adc = ($res2[0]['valor'] * $quantidade_temp) * $quantidade;
				$valor_adcF = number_format($valor_adc, 2, ',', '.');

				echo <<<HTML

		<i class="bi bi-check-lg text-success"></i>
		{$quantidade_temp} {$nome_adc} <span class="text-danger">(R$ {$valor_adcF})</span>
		<a href="#" onclick="excluirAdc('{$id_temp}', '{$id}', '{$valor_adc}', '{$id_sabor}', '{$item}', '{$categoria}')"><i class="bi bi-trash text-danger"></i></a>
		<hr>

HTML;
			}
		}
	} else {
		echo '<div class="text-center text-muted">Nenhum adicional encontrado para este item.</div>';
	}
}
?>


<script type="text/javascript">
	function excluirAdc(id, carrinho, valor, id_sabor, item, cat) {


		$.ajax({
			url: 'js/ajax/excluir-adicionais.php',
			method: 'POST',
			data: {
				id,
				valor,
				carrinho,
				id_sabor,
				item
			},
			dataType: "text",

			success: function(mensagem) {

				if (mensagem.trim() == "Excluido com Sucesso") {
					listarAdicionais(carrinho, id_sabor, cat);
					listarCarrinho();
				}

			},

		});
	}
</script>