<?php
header('Content-Type: text/html; charset=UTF-8');
@session_start();

require_once('../../sistema/conexao.php');
require_once('../../sistema/SecureDB.php');

// LOG DE ENTRADA
file_put_contents('../../sistema/logs/security.log', json_encode([
	'event' => 'listar_carrinho_entrada',
	'session' => $_SESSION,
	'hora' => date('Y-m-d H:i:s')
], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

file_put_contents(__DIR__ . '/../../sistema/logs/checkout_debug.log', '[LISTAR-ENTRY] ' . json_encode([
	'session_id' => session_id(),
	'sessao_usuario' => @$_SESSION['sessao_usuario'],
	'hora' => date('Y-m-d H:i:s')
]) . "\n", FILE_APPEND);

try {
	$sessao = @$_SESSION['sessao_usuario'];

	if (!$sessao) {
		throw new Exception('Nenhum item adicionado!');
	}

	// Usar classe segura para limpar e buscar itens
	$secureDB = new SecureDB($pdo);
	$secureDB->cleanupCart();
	$res = $secureDB->getCartItems($sessao);
	file_put_contents(__DIR__ . '/../../sistema/logs/checkout_debug.log', '[LISTAR-RESULT] ' . json_encode([
		'sessao' => $sessao,
		'result' => $res,
		'hora' => date('Y-m-d H:i:s')
	]) . "\n", FILE_APPEND);

	if (count($res) == 0) {
		echo '<li class="text-center">Nenhum item no carrinho</li>';
		echo "<script>$('#total-do-pedido').text('0,00');</script>";
		exit();
	}

	file_put_contents(__DIR__ . '/../../sistema/logs/checkout_debug.log', '[SESSION-LISTAR] ' . json_encode([
		'session_id' => session_id(),
		'sessao_usuario' => @$_SESSION['sessao_usuario'],
		'hora' => date('Y-m-d H:i:s')
	]) . "\n", FILE_APPEND);

	file_put_contents(__DIR__ . '/../../sistema/logs/checkout_debug.log', '[LISTAR-CARRINHO] ' . json_encode([
		'sessao' => @$_SESSION['sessao_usuario'],
		'itens' => count($res),
		'hora' => date('Y-m-d H:i:s')
	]) . "\n", FILE_APPEND);

	$total_carrinho = 0;

	foreach ($res as $item) {
		$total_item = $item['total_item'];
		$total_carrinho += $total_item;
		$nome_produto = $item['nome_produto'];
		$quantidade = $item['quantidade'];
		$foto = $item['foto_produto'];
		$id = $item['id'];
		$obs = $item['obs'];
		$valor_unitario = $item['valor_unitario'];

		// Verificar se há adicionais vinculados ao item
		$query_adc = $pdo->query("SELECT COUNT(*) as total FROM temp WHERE carrinho = '$id' AND tabela = 'adicionais'");
		$res_adc = $query_adc->fetch(PDO::FETCH_ASSOC);
		$tem_adicionais = $res_adc && $res_adc['total'] > 0;

		// Formatar valores
		$total_itemF = number_format($total_item, 2, ',', '.');
		$valor_unitarioF = number_format($valor_unitario, 2, ',', '.');

		// Botões de quantidade
		$btn_menos = $quantidade > 1 ?
			"<button type=\"button\" class=\"carrinho-btn-quant\" onclick=\"atualizarQuantidade({$id}, " . ($quantidade - 1) . ")\"><i class='bi bi-dash'></i></button>" :
			"<button type=\"button\" class=\"carrinho-btn-quant\" disabled><i class='bi bi-dash'></i></button>";

		$btn_mais = "<button type=\"button\" class=\"carrinho-btn-quant\" onclick=\"atualizarQuantidade({$id}, " . ($quantidade + 1) . ")\"><i class='bi bi-plus'></i></button>";

		// Botão de adicionais (só se houver)
		$btn_adicionais = '';
		if ($tem_adicionais) {
			$btn_adicionais = "<button type=\"button\" class=\"btn btn-sm btn-warning ms-2\" onclick=\"abrirAdicionais({$id})\"><i class='bi bi-plus-square'></i> Adicionais</button>";
		}

		echo <<<HTML
		<li class="list-group-item">
			<div class="d-flex mb-3 align-items-center">
				<div class="flex-shrink-0">
					<img src="sistema/painel/images/produtos/{$foto}" alt="{$nome_produto}" width="100">
				</div>
				<div class="flex-grow-1 ms-3">
					<h6 class="mb-0">{$nome_produto}</h6>
					<p class="mb-0 text-muted">
						<small>
							R$ {$valor_unitarioF} x {$quantidade} = R$ {$total_itemF}
							<br>
							{$obs}
						</small>
					</p>
					<div class="mt-2">
						<div class="d-flex align-items-center gap-1 flex-wrap">
							{$btn_menos}
							<button type="button" class="btn btn-sm btn-outline-secondary" disabled>{$quantidade}</button>
							{$btn_mais}
							<button type="button" class="carrinho-btn-edit" onclick="$('#modalObs').modal('show'); $('#id_obs').val({$id}); $('#obs').val('{$obs}'); $('#nome_item').text('{$nome_produto}')">
								<i class="bi bi-pencil"></i>
							</button>
							<button type="button" class="carrinho-btn-remove" onclick="excluirCarrinho({$id})">
								<i class="bi bi-trash"></i>
							</button>
							{$btn_adicionais}
						</div>
					</div>
				</div>
			</div>
		</li>
		HTML;
	}

	// Atualizar total do carrinho
	$total_carrinhoF = number_format($total_carrinho, 2, ',', '.');
	echo "<script>$('#total-do-pedido').text('{$total_carrinhoF}');</script>";
} catch (Exception $e) {
	http_response_code(200);
	echo '<li class="text-center">Nenhum item no carrinho</li>';
	echo "<script>$('#total-do-pedido').text('0,00');</script>";
}
?>

<script>
	function abrirAdicionais(id) {
		$('#modalAdc').modal('show');
		$.ajax({
			url: 'js/ajax/listar-adc-carrinho.php',
			method: 'POST',
			data: {
				id: id
			},
			success: function(result) {
				$('#listar-adc-carrinho').html(result);
			},
			error: function() {
				$('#listar-adc-carrinho').html('<div class="text-danger">Erro ao carregar adicionais.</div>');
			}
		});
	}

	function atualizarQuantidade(id, quantidade) {
		$.ajax({
			url: 'js/ajax/atualizar-quantidade.php',
			method: 'POST',
			data: {
				id: id,
				quantidade: quantidade
			},
			success: function(result) {
				if (result.includes('Sucesso')) {
					// Recarregar lista do carrinho para mostrar valores atualizados
					if (typeof listarCarrinho === 'function') {
						listarCarrinho();
					} else {
						// Fallback - recarregar a página se função não existir
						location.reload();
					}
				} else {
					alert('Erro ao atualizar quantidade: ' + result);
				}
			},
			error: function() {
				alert('Erro na comunicação com o servidor');
			}
		});
	}
</script>