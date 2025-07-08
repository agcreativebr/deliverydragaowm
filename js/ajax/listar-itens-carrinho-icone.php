<?php
header('Content-Type: text/html; charset=UTF-8');
@session_start();

require_once('../../sistema/conexao.php');

// LOG DE ENTRADA
file_put_contents('../../sistema/logs/security.log', json_encode([
	'event' => 'listar_carrinho_icone_entrada',
	'session' => $_SESSION,
	'hora' => date('Y-m-d H:i:s')
], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

try {
	$sessao = @$_SESSION['sessao_usuario'];

	if (!$sessao) {
		throw new Exception('Nenhum item adicionado!');
	}

	// Limpar itens órfãos (sem pedido e mais antigos que 24h)
	$pdo->query("DELETE FROM carrinho WHERE pedido = '0' AND DATE_ADD(data, INTERVAL 24 HOUR) < NOW()");

	// Limpar itens sem produto válido
	$pdo->query("DELETE FROM carrinho WHERE pedido = '0' AND (produto = '0' OR produto NOT IN (SELECT id FROM produtos WHERE ativo = 'Sim'))");

	// Buscar itens do carrinho
	$query = $pdo->prepare("
		SELECT c.*, p.nome as nome_produto, p.foto as foto_produto,
			COALESCE(c.valor_unitario, CASE 
				WHEN c.total_item > 0 AND c.quantidade > 0 THEN c.total_item / c.quantidade 
				ELSE 0 
			END) as valor_unitario
		FROM carrinho c 
		INNER JOIN produtos p ON c.produto = p.id 
		WHERE c.sessao = ? AND c.pedido = '0' AND p.ativo = 'Sim'
		ORDER BY c.id DESC
	");

	$query->execute([$sessao]);
	$res = $query->fetchAll(PDO::FETCH_ASSOC);

	if (count($res) == 0) {
		echo '<li class="text-center">Nenhum item no carrinho</li>';
		// Zerar totais quando não houver itens
		echo "<script>
			$('#total-carrinho-icone').text('0,00');
			$('#total-itens-carrinho').text('0');
			$('#total-carrinho-finalizar').text('0,00');
		</script>";
		exit();
	}

	$total_carrinho = 0;

	foreach ($res as $item) {
		$total_item = $item['total_item'];
		$total_carrinho += $total_item;
		$nome_produto = $item['nome_produto'];
		$quantidade = $item['quantidade'];
		$foto = $item['foto_produto'];
		$id = $item['id'];

		// Formatar valores
		$total_itemF = number_format($total_item, 2, ',', '.');
		$valor_unitarioF = number_format($item['valor_unitario'], 2, ',', '.');

		echo <<<HTML
		<li class="d-flex align-items-start justify-content-between">
			<div class="tpcart__item d-flex">
				<div class="tpcart__img">
					<img src="sistema/painel/images/produtos/$foto" alt="$nome_produto">
					<div class="tpcart__del">
						<a href="javascript:void(0)" onclick="excluirCarrinhoIcone($id)"><i class="icon-x-circle"></i></a>
					</div>
				</div>
				<div class="tpcart__content">
					<h4 class="tpcart__title"><a href="#">$nome_produto</a></h4>
					<div class="tpcart__price">
						<span class="quantity">$quantidade x</span>
						<span class="new-price">R$ $valor_unitarioF</span>
					</div>
				</div>
			</div>
		</li>
		HTML;
	}

	$total_carrinhoF = number_format($total_carrinho, 2, ',', '.');

	// Atualizar total do carrinho
	echo "<script>
		$('#total-carrinho-icone').text('$total_carrinhoF');
		$('#total-itens-carrinho').text('" . count($res) . "');
		$('#total-carrinho-finalizar').text('$total_carrinhoF');
	</script>";
} catch (Exception $e) {
	// Log do erro
	file_put_contents('../../sistema/logs/security.log', json_encode([
		'event' => 'listar_carrinho_icone_erro',
		'erro' => $e->getMessage(),
		'session' => $_SESSION,
		'hora' => date('Y-m-d H:i:s')
	], JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES) . "\n", FILE_APPEND);

	echo '<li class="text-center">Nenhum item no carrinho</li>';
}
