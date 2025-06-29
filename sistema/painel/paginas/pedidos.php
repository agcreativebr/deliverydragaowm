<?php
@session_start();
require_once("verificar.php");
require_once("../conexao.php");

if (@$pedidos == 'ocultar') {
	echo "<script>window.location='../index.php'</script>";
	exit();
}

$query2 = $pdo->query("SELECT * FROM usuarios where id = '$id_usuario'");
$res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
if (@count($res2) > 0) {
	$nome_usuario = $res2[0]['nivel'];
}



//verificar se o caixa está aberto
$query = $pdo->query("SELECT * from caixas where operador = '$id_usuario' and data_fechamento is null");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$linhas = @count($res);
if ($linhas > 0) {
} else {
	if ($abertura_caixa == 'Sim' and $nome_usuario != 'Administrador') {
		echo '<script>alert("Não possui caixa Aberto, abra o caixa!")</script>';
		echo '<script>window.location="caixas"</script>';
	}
}


$pag = 'pedidos';

$segundos = $tempo_atualizar * 1000;

// Contadores para os botões de filtro (exemplo, idealmente viriam do listar.php ou de uma consulta separada)
// Para demonstração, vou deixar como estava, mas o ideal é que esses números sejam atualizados dinamicamente.
$query_contadores = $pdo->query("SELECT status, COUNT(id) as count FROM vendas WHERE data = curDate() AND (status = 'Iniciado' OR status = 'Aceito' OR status = 'Preparando' OR status = 'Entrega') GROUP BY status");
$contadores = $query_contadores->fetchAll(PDO::FETCH_KEY_PAIR);

$ini_pedidos = isset($contadores['Iniciado']) ? $contadores['Iniciado'] : 0;
$ace_pedidos = isset($contadores['Aceito']) ? $contadores['Aceito'] : 0;
$prep_pedidos = isset($contadores['Preparando']) ? $contadores['Preparando'] : 0;
$ent_pedidos = isset($contadores['Entrega']) ? $contadores['Entrega'] : 0;
$todos_pedidos = $ini_pedidos + $ace_pedidos + $prep_pedidos + $ent_pedidos;


?>

<div class="breadcrumb-header justify-content-between">
	<div class="left-content mt-2">
		<!-- Pode adicionar título da página aqui se desejar -->
	</div>
</div>

<div class="bs-example widget-shadow" style="padding:15px; margin-top: -5px">

	<div class="row">
		<div class="col-md-12 filter-buttons-container">

			<button type="button" class="btn filter-btn btn-filter-todas" title="Todos os Pedidos" onclick="buscarContas('')">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-list-ul" viewBox="0 0 16 16">
					<path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm0-4a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1-.5-.5zm-3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2zm0 4a1 1 0 1 0 0-2 1 1 0 0 0 0 2z" />
				</svg>
				<span>TODAS</span>
				<span class="badge bg-light rounded-pill ms-1" id="todos_pedidos"><?php echo $todos_pedidos ?></span>
			</button>

			<button type="button" class="btn filter-btn btn-filter-iniciados" title="Iniciados" onclick="buscarContas('Iniciado')">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clock-history" viewBox="0 0 16 16">
					<path d="M8.515 1.019A7 7 0 0 0 8 1V0a8 8 0 0 1 .589.022l-.074.997zm2.004.45a7.003 7.003 0 0 0-.985-.299l.219-.976c.383.086.76.2 1.126.342l-.36.933zm1.37.71a7.01 7.01 0 0 0-.439-.27l.493-.87a8.025 8.025 0 0 1 .979.654l-.615.789a6.996 6.996 0 0 0-.418-.302zm1.834 1.79a6.99 6.99 0 0 0-.653-.796l.724-.69c.27.285.52.59.747.91l-.818.576zm.744 1.352a7.08 7.08 0 0 0-.214-.468l.893-.45a7.976 7.976 0 0 1 .45 1.088l-.95.313a7.023 7.023 0 0 0-.179-.483zm.53 2.507a6.991 6.991 0 0 0-.1-1.025l.985-.17c.067.386.106.778.116 1.17l-1 .025zm-.131 1.538c-.033-.27-.081-.53-.145-.783l.973-.225c.071.276.126.552.166.83l-.995.185zm-.247 1.443a6.977 6.977 0 0 0-.258-.715l.906-.399c.117.266.214.534.29.81l-.953.372zM9.005 15.08a6.997 6.997 0 0 0 .985-.299l-.219-.976a6.001 6.001 0 0 1-.979.25l.213.976zm-.388-.217a6.994 6.994 0 0 0 .439-.27l-.493-.87a8.025 8.025 0 0 1-.979.654l.615.789a6.996 6.996 0 0 0 .418-.302zm-1.834-1.79a6.99 6.99 0 0 0 .653-.796l-.724-.69c-.27.285-.52.59-.747.91l.818.576zm-.744-1.352a7.08 7.08 0 0 0 .214-.468l-.893-.45a7.976 7.976 0 0 1-.45 1.088l.95.313a7.023 7.023 0 0 0 .179-.483zm-.53-2.507a6.991 6.991 0 0 0 .1-1.025l-.985-.17c-.067.386-.106.778-.116 1.17l1 .025zm.131-1.538c.033-.27.081-.53.145-.783l-.973-.225a8.01 8.01 0 0 1-.166.83l.995.185zm.247-1.443a6.977 6.977 0 0 0 .258-.715l-.906-.399a8.032 8.032 0 0 1-.29.81l.953.372zM13 6.5a.5.5 0 0 1 .5.5v1.886l.39-.013a.5.5 0 0 1 0 .998l-.65.021a.5.5 0 0 1-.445-.72l.25-.886V7a.5.5 0 0 1 .5-.5z" />
					<path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16zm7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0z" />
					<path d="M7.5 3a.5.5 0 0 1 .5.5v5.21l3.248 1.856a.5.5 0 0 1-.496.868l-3.5-2A.5.5 0 0 1 7 9V3.5a.5.5 0 0 1 .5-.5z" />
				</svg>
				<span>INICIADOS</span>
				<span class="badge bg-light rounded-pill ms-1" id="ini_pedidos"><?php echo $ini_pedidos ?></span>
			</button>

			<button type="button" class="btn filter-btn btn-filter-aceitos" title="Aceitos" onclick="buscarContas('Aceito')">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-check-circle" viewBox="0 0 16 16">
					<path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
					<path d="M10.97 4.97a.235.235 0 0 0-.02.022L7.477 9.417 5.384 7.323a.75.75 0 0 0-1.06 1.06L6.97 11.03a.75.75 0 0 0 1.079-.02l3.992-4.99a.75.75 0 0 0-1.071-1.05z" />
				</svg>
				<span>ACEITOS</span>
				<span class="badge bg-light rounded-pill ms-1" id="ace_pedidos"><?php echo $ace_pedidos ?></span>
			</button>

			<button type="button" class="btn filter-btn btn-filter-preparando" title="Preparando" onclick="buscarContas('Preparando')">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-egg-fried" viewBox="0 0 16 16">
					<path d="M8 11a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
					<path d="M13.997 5.17a5 5 0 0 0-8.101-4.09A5 5 0 0 0 1.28 9.342a5 5 0 0 0 8.336 5.109 3.5 3.5 0 0 0 5.201-4.065 3.001 3.001 0 0 0-.822-5.216zm-1-.034a1 1 0 0 0 .668.977 2.001 2.001 0 0 1 .547 3.478 1 1 0 0 0-.341 1.113 2.5 2.5 0 0 1-3.715 2.905 1 1 0 0 0-1.262.152 4 4 0 0 1-6.67-4.087 1 1 0 0 0-.2-1 4 4 0 0 1 3.693-6.61 1 1 0 0 0 .8-.2 4 4 0 0 1 6.48 3.273z" />
				</svg>
				<span>PREPARANDO</span>
				<span class="badge bg-light rounded-pill ms-1" id="prep_pedidos"><?php echo $prep_pedidos ?></span>
			</button>

			<button type="button" class="btn filter-btn btn-filter-rota" title="Em Rota de Entrega" onclick="buscarContas('Entrega')">
				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-truck" viewBox="0 0 16 16">
					<path d="M0 3.5A1.5 1.5 0 0 1 1.5 2h9A1.5 1.5 0 0 1 12 3.5V5h1.02a1.5 1.5 0 0 1 1.17.563l1.481 1.85a1.5 1.5 0 0 1 .329.938V10.5a1.5 1.5 0 0 1-1.5 1.5H14a2 2 0 1 1-4 0H5a2 2 0 1 1-3.998-.085A1.5 1.5 0 0 1 0 10.5v-7zm1.294 7.456A1.999 1.999 0 0 1 4.732 11h5.536a2.01 2.01 0 0 1 .732-.732V3.5a.5.5 0 0 0-.5-.5h-9a.5.5 0 0 0-.5.5v7a.5.5 0 0 0 .294.456zM12 10a2 2 0 0 1 1.732 1h.768a.5.5 0 0 0 .5-.5V8.35a.5.5 0 0 0-.11-.312l-1.48-1.85A.5.5 0 0 0 13.02 6H12v4zm-9 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm9 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" />
				</svg>
				<span>EM ROTA</span>
				<span class="badge bg-light rounded-pill ms-1" id="ent_pedidos"><?php echo $ent_pedidos ?></span>
			</button>

			<input type="hidden" id="buscar-contas">
			<input type="hidden" id="id_pedido">

		</div>
	</div>

	<hr>
	<div id="listar">
		<!-- A tabela de pedidos será carregada aqui pelo AJAX -->
	</div>

</div>


<!-- Modal Dados-->
<div class="modal fade" id="modalDados" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document"> <!-- Aumentado para modal-lg -->
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h4 class="modal-title" id="exampleModalLabel"><span id="nome_dados"></span></h4>
				<button id="btn-fechar-dados" aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"><span class="text-white" aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body" id="listar-pedido">
				<!-- Conteúdo do pedido será carregado aqui -->
			</div>
		</div>
	</div>
</div>


<!-- Modal Baixar-->
<div class="modal fade" id="modalBaixar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h4 class="modal-title" id="exampleModalLabel"><span id="nome_baixar"></span></h4>
				<button id="btn-fechar-baixar" aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"><span class="text-white" aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<form id="form-baixar">
					<div class="row">
						<div class="col-md-8">
							<select class="form-select" id="pgto" name="pgto" style="width:100%;">
								<?php
								$query_pgto = $pdo->query("SELECT * FROM formas_pgto order by id asc");
								$res_pgto = $query_pgto->fetchAll(PDO::FETCH_ASSOC);
								for ($i = 0; $i < @count($res_pgto); $i++) {
									echo '<option value="' . $res_pgto[$i]['nome'] . '">' . $res_pgto[$i]['nome'] . '</option>';
								}
								?>
							</select>
							<input type="hidden" name="id" id="id_baixar">
						</div>
						<div class="col-md-4">
							<button id="btn_confirmar_baixar" type="submit" class="btn btn-primary">Confirmar</button>
						</div>
					</div>
				</form>
				<br><small>
					<div align="center" id="mensagem-baixar"></div>
				</small>
			</div>
		</div>
	</div>
</div>


<!-- Modal Entregador-->
<div class="modal fade" id="modalEntregador" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h4 class="modal-title" id="exampleModalLabel">Selecionar Entregador</h4>
				<button id="btn-fechar-entregador" aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"><span class="text-white" aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<form id="form-entregador">
					<div class="row">
						<div class="col-md-8">
							<select class="form-select" id="entregador" name="entregador" style="width:100%;">
								<?php
								$query_ent = $pdo->query("SELECT * FROM usuarios WHERE nivel = 'Entregador' or nivel = 'Motoboy' or nivel = 'Motoboys' or nivel = 'Entregadores' ORDER BY nome asc");
								$res_ent = $query_ent->fetchAll(PDO::FETCH_ASSOC);
								if (@count($res_ent) > 0) {
									for ($i = 0; $i < @count($res_ent); $i++) {
										echo '<option value="' . $res_ent[$i]['id'] . '">' . $res_ent[$i]['nome'] . '</option>';
									}
								} else {
									echo '<option value="0">Nenhum Entregador Cadastrado</option>';
								}
								?>
							</select>
							<input type="hidden" name="id" id="id_entregador">
						</div>
						<div class="col-md-4">
							<button id="btn_entregador" type="submit" class="btn btn-primary">Selecionar</button>
						</div>
					</div>
				</form>
				<br><small>
					<div align="center" id="mensagem-entregador"></div>
				</small>
			</div>
		</div>
	</div>
</div>


<!-- Modal Desconto-->
<div class="modal fade" id="modalDesconto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h4 class="modal-title" id="exampleModalLabel">Desconto</h4>
				<button id="btn-fechar-desconto" aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"><span class="text-white" aria-hidden="true">&times;</span></button>
			</div>
			<div class="modal-body">
				<form id="form-desconto">
					<div class="row">
						<div class="col-md-8">
							<input class="form-control" type="text" name="valor" id="desconto_valor" placeholder="Valor do Desconto">
							<input type="hidden" name="id" id="id_desconto">
						</div>
						<div class="col-md-4">
							<button id="btn_desconto" type="submit" class="btn btn-primary">Confirmar</button>
						</div>
					</div>
				</form>
				<br><small>
					<div align="center" id="mensagem-desconto"></div>
				</small>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	var pag = "<?= $pag ?>";
	var seg = '<?= $segundos ?>';

	$(document).ready(function() {
		listar(); // Carrega a lista inicial
		if (seg > 0) {
			setInterval(() => {
				listar();
			}, seg);
		}
	});

	function buscarContas(status) {
		$('#buscar-contas').val(status);
		listar();
	}

	function listar() {
		var status = $('#buscar-contas').val();
		$.ajax({
			url: 'paginas/' + pag + "/listar.php",
			method: 'POST',
			data: {
				status: status
			},
			dataType: "html",
			success: function(result) {
				$("#listar").html(result);

				// Destruir a tabela existente antes de reinicializar
				if ($.fn.DataTable.isDataTable('#tabela')) {
					$('#tabela').DataTable().destroy();
				}

				// Inicializar DataTables
				var table = $('#tabela').DataTable({
					"language": {
						"sEmptyTable": "Nenhum registro encontrado",
						"sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
						"sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
						"sInfoFiltered": "(Filtrados de _MAX_ registros)",
						"sInfoPostFix": "",
						"sInfoThousands": ".",
						"sLengthMenu": "_MENU_ resultados por página",
						"sLoadingRecords": "Carregando...",
						"sProcessing": "Processando...",
						"sZeroRecords": "Nenhum registro encontrado",
						"sSearch": "Pesquisar",
						"oPaginate": {
							"sNext": "Próximo",
							"sPrevious": "Anterior",
							"sFirst": "Primeiro",
							"sLast": "Último"
						},
						"oAria": {
							"sSortAscending": ": Ordenar colunas de forma ascendente",
							"sSortDescending": ": Ordenar colunas de forma descendente"
						}
					},
					"pageLength": 25,
					"order": [
						[0, "desc"]
					],
					"responsive": true,
					"autoWidth": false,
					"drawCallback": function() {
						// Restaurar os botões e funcionalidades após cada redesenho da tabela
						$('.btn-excluir').off('click').on('click', function() {
							var id = $(this).attr('id');
							excluir(id);
						});

						$('.btn-editar').off('click').on('click', function() {
							var id = $(this).attr('id');
							editar(id);
						});

						$('.btn-visualizar').off('click').on('click', function() {
							var id = $(this).attr('id');
							visualizar(id);
						});

						// Adicionar event listeners para ordenação
						const headers = document.querySelectorAll("#tabela th.sortable-th");
						if (headers && headers.length > 0) {
							headers.forEach(header => {
								if (header) {
									// Remover event listeners antigos
									header.removeEventListener("click", header.clickHandler);

									// Adicionar novo event listener
									header.clickHandler = function() {
										const column = this.dataset.column;
										const type = this.dataset.type || 'string';
										sortTable(document.querySelector("#tabela"), column, type, currentSortOrder);
									};
									header.addEventListener("click", header.clickHandler);
								}
							});
						}
					}
				});
			},
			error: function(xhr, status, error) {
				console.error("Erro ao carregar lista de pedidos: ", status, error);
			}
		});
	}

	// Variáveis para guardar o estado da ordenação
	let currentSortColumn = null;
	let currentSortOrder = 'asc'; // 'asc' ou 'desc'

	// Função para ordenar a tabela
	function sortTable(table, column, type, order) {
		if (!table) return;

		const tbody = table.querySelector("tbody");
		if (!tbody) return;

		const rows = Array.from(tbody.querySelectorAll("tr"));
		const columnIndex = Array.from(table.querySelectorAll("th")).findIndex(th => th.dataset.column === column);

		if (columnIndex === -1) return;

		rows.sort((a, b) => {
			let valA = a.querySelectorAll("td")[columnIndex]?.textContent.trim().toLowerCase() || '';
			let valB = b.querySelectorAll("td")[columnIndex]?.textContent.trim().toLowerCase() || '';

			if (type === 'number') {
				valA = parseFloat(valA.replace("r$", "").replace(/\./g, "").replace(",", ".").trim()) || 0;
				valB = parseFloat(valB.replace("r$", "").replace(/\./g, "").replace(",", ".").trim()) || 0;
			} else if (type === 'date' || type === 'datetime') {
				valA = new Date(valA.split('/').reverse().join('-'));
				valB = new Date(valB.split('/').reverse().join('-'));
			}

			if (valA < valB) return order === 'asc' ? -1 : 1;
			if (valA > valB) return order === 'asc' ? 1 : -1;
			return 0;
		});

		while (tbody.firstChild) {
			tbody.removeChild(tbody.firstChild);
		}
		rows.forEach(row => tbody.appendChild(row));
	}

	// Funções AJAX para modais (manter as originais do seu arquivo ajax.js ou incluí-las aqui se necessário)
	// Exemplo: modalDados, modalExcluir, modalStatus, etc.
	// Certifique-se de que o arquivo js/ajax.js está sendo incluído corretamente na página principal do painel.
	// Se as funções de modalDados, etc., estiverem em js/ajax.js, não precisa duplicá-las aqui.

	$("#form-baixar").submit(function(event) { // Adicionado 'event'
		event.preventDefault();
		var formData = new FormData(this);
		$('#mensagem-baixar').text('Carregando!!');
		$('#btn_confirmar_baixar').hide(); // Corrigido ID do botão

		$.ajax({
			url: 'paginas/' + pag + "/baixar.php",
			type: 'POST',
			data: formData,
			success: function(mensagem) {
				$('#mensagem-baixar').text('');
				$('#mensagem-baixar').removeClass()
				if (mensagem.trim() == "Baixado com Sucesso") {
					// baixado() // Se 'baixado' for uma função global, mantenha. Senão, defina-a.
					$('#btn-fechar-baixar').click();
					listar();
				} else {
					$('#mensagem-baixar').addClass('text-danger')
					$('#mensagem-baixar').text(mensagem)
				}
				$('#btn_confirmar_baixar').show(); // Corrigido ID do botão
			},
			cache: false,
			contentType: false,
			processData: false,
		});
	});

	$("#form-entregador").submit(function(event) { // Adicionado 'event'
		$('#mensagem-entregador').text('Carregando!!');
		$('#btn_entregador').hide();
		event.preventDefault();
		var formData = new FormData(this);

		$.ajax({
			url: 'paginas/' + pag + "/entregador.php",
			type: 'POST',
			data: formData,
			success: function(mensagem) {
				$('#mensagem-entregador').text('');
				$('#mensagem-entregador').removeClass()
				if (mensagem.trim() == "Salvo com Sucesso") {
					$('#btn_entregador').show();
					$('#btn-fechar-entregador').click();
					listar();
				} else {
					$('#mensagem-entregador').addClass('text-danger')
					$('#mensagem-entregador').text(mensagem)
				}
				$('#btn_entregador').show();
			},
			cache: false,
			contentType: false,
			processData: false,
		});
	});

	$("#form-desconto").submit(function(event) { // Adicionado 'event'
		$('#mensagem-desconto').text('Carregando!!');
		$('#btn_desconto').hide();
		event.preventDefault();
		var formData = new FormData(this);

		$.ajax({
			url: 'paginas/' + pag + "/desconto.php",
			type: 'POST',
			data: formData,
			success: function(mensagem) {
				$('#mensagem-desconto').text('');
				$('#mensagem-desconto').removeClass()
				if (mensagem.trim() == "Baixado com Sucesso") { // Assumindo que a mensagem de sucesso é essa
					$('#btn_desconto').show();
					$('#desconto_valor').val('');
					$('#btn-fechar-desconto').click();
					listar();
				} else {
					$('#mensagem-desconto').addClass('text-danger')
					$('#mensagem-desconto').text(mensagem)
				}
				$('#btn_desconto').show();
			},
			cache: false,
			contentType: false,
			processData: false,
		});
	});

	// Função para carregar dados do pedido no modal (já existente no seu ajax.js, adaptada aqui para referência)
	function listarPedido(id) {
		$.ajax({
			url: 'paginas/' + pag + "/listar-pedido.php", // Certifique-se que este é o endpoint correto
			method: 'POST',
			data: {
				id: id
			}, // Enviando o ID
			dataType: "html",
			success: function(result) {
				$("#listar-pedido").html(result); // Coloca o resultado no corpo do modal
				$('#nome_dados').text("Detalhes do Pedido Nº " + id); // Atualiza o título do modal
				var modal = new bootstrap.Modal(document.getElementById('modalDados'));
				modal.show();
			},
			error: function(xhr, status, error) {
				console.error("Erro ao carregar detalhes do pedido: ", status, error);
			}
		});
	}
</script>