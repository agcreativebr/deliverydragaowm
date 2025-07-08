<?php
@session_start();
require_once("cabecalho.php");

$sessao = @$_SESSION['sessao_usuario'];
$nome_mesa = @$_SESSION['nome_mesa'];
$pedido_balcao = @$_SESSION['pedido_balcao'];
$pedido_balcao = @$_SESSION['pedido_balcao'];
// Formatando a data e hora para exibir apenas horas e minutos
$horario_aberturaF = date('H:i', strtotime($horario_abertura));
// Formatando a data e hora para exibir apenas horas e minutos
$horario_fechamentoF = date('H:i', strtotime($horario_fechamento));


if (@$_SESSION['nome_mesa'] != '') {
  unset($pedido_balcao);
}


$id_edicao = 0;
if (@$_SESSION['id_edicao'] != "") {
  $id_edicao = $_SESSION['id_edicao'];
}


// VERFICAR SE ESTÁ ABERTO O ESTABELICMENTO

if ($nome_mesa == '' and $pedido_balcao == "") {
  if ($status_estabelecimento == "Fechado") {

    echo "<script>
        window.onload = function() {
            Swal.fire({
                title: 'Bem-vindo!',
                text: '$texto_fechamento',
                icon: 'info',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Ação a ser realizada após o clique no botão de confirmação
                    console.log('Botão OK clicado!');
                    // Você pode redirecionar para outra página, se necessário
                    window.location.href = 'index.php';
                }
            });
        };
    </script>";



    //echo "<script>window.alert('$texto_fechamento')</script>";
    //echo "<script>window.location='index.php'</script>";
    exit();
  }


  $data = date('Y-m-d');
  //verificar se está aberto hoje
  $diasemana = array("Domingo", "Segunda-Feira", "Terça-Feira", "Quarta-Feira", "Quinta-Feira", "Sexta-Feira", "Sábado");
  $diasemana_numero = date('w', strtotime($data));
  $dia_procurado = $diasemana[$diasemana_numero];

  //percorrer os dias da semana que ele trabalha
  $query = $pdo->query("SELECT * FROM dias where dia = '$dia_procurado'");
  $res = $query->fetchAll(PDO::FETCH_ASSOC);
  if (@count($res) > 0) {

    echo "<script>
        window.onload = function() {
            Swal.fire({
                title: 'Bem-vindo!',
                text: 'Estamos Fechados! Não funcionamos Hoje!',
                icon: 'info',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Ação a ser realizada após o clique no botão de confirmação
                    console.log('Botão OK clicado!');
                    // Você pode redirecionar para outra página, se necessário
                    window.location.href = 'index.php';
                }
            });
        };
    </script>";

    //echo "<script>window.alert('Estamos Fechados! Não funcionamos Hoje!')</script>";
    //echo "<script>window.location='index.php'</script>";
    exit();
  }


  $hora_atual = date('H:i:s');

  //nova verificação de horarios
  $start = strtotime(date('Y-m-d' . $horario_abertura));
  $end = strtotime(date('Y-m-d' . $horario_fechamento));
  $now = time();

  if ($start <= $now && $now <= $end) {
  } else {

    if ($end < $start) {

      if ($now > $start) {
      } else {
        if (
          $now < $end
        ) {
        } else {

          echo "<script>
        window.onload = function() {
            Swal.fire({
                title: 'Bem-vindo!',
                text: '$texto_fechamento_horario $horario_aberturaF às $horario_fechamentoF',
                icon: 'info',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Ação a ser realizada após o clique no botão de confirmação
                    console.log('Botão OK clicado!');
                    // Você pode redirecionar para outra página, se necessário
                    window.location.href = 'index.php';
                }
            });
        };
    </script>";

          //echo "<script>window.alert('$texto_fechamento_horario')</script>";
          //echo "<script>window.location='index.php'</script>";
          exit();
        }
      }
    } else {


      echo "<script>
        window.onload = function() {
            Swal.fire({
                title: 'Bem-vindo!',
                text: '$texto_fechamento_horario $horario_aberturaF às $horario_fechamentoF',
                icon: 'info',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Ação a ser realizada após o clique no botão de confirmação
                    console.log('Botão OK clicado!');
                    // Você pode redirecionar para outra página, se necessário
                    window.location.href = 'index.php';
                }
            });
        };
    </script>";



      //echo "<script>window.alert('$texto_fechamento_horario')</scripwindow.location=>";
      //echo "<script>window.location='index.php'</script>";
      exit();
    }
  }
}


?>

<style type="text/css">
  body {
    background: #f2f2f2;
  }
</style>

<div class="main-container">

  <nav class="navbar bg-light fixed-top" style="box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.20);">
    <div class="container-fluid">
      <div class="navbar-brand">
        <a href="index"><big><i class="bi bi-arrow-left"></i></big></a>
        <span style="margin-left: 15px; font-size:14px">RESUMO DO PEDIDO <?php echo $nome_mesa ?> <?php echo @$_SESSION['pedido_balcao'] ?></span>

      </div>

      <a class="" href="index.php">
        <div class="">
          <button type="button" class="btn btn-warning btn-sm">Comprar Mais?</button>
        </div>
      </a>


    </div>
  </nav>



  <ol class="list-group" style="margin-top: 65px; margin-bottom: 95px; overflow: scroll; height:100%; scrollbar-width: thin;"
    id="listar-itens-carrinho">
  </ol>


</div>


<div class="area-pedidos">
  <div class="total-pedido" style="border: solid 1px #ababab; border-radius: 10px;">
    <big>
      <span><b>SUB TOTAL</b></span>
      <span class="direita"> <b>R$ <span id="total-do-pedido"></span></b></span>
    </big>
  </div>


  <!-- Remover o bloco de botão duplicado acima do subtotal -->

  <!-- Botão finalizar pedido -->
  <div class="d-grid gap-2 mt-4 abaixo">
    <a href='finalizar' class="btn btn-finalizar btn-lg w-100 mt-2">Finalizar Pedido <i class="bi bi-arrow-right ms-2"></i></a>
  </div>
</div>


<!-- Scripts -->
<script src="js/carrinho.js"></script>
<script>
  $(document).ready(function() {
    // Inicializar carrinho
    listarCarrinho();

    // Inicializar modal
    var modalObs = new bootstrap.Modal(document.getElementById('modalObs'));

    // Prevenir submit do form
    $('#form-obs').on('submit', function(e) {
      e.preventDefault();
      return false;
    });
  });
</script>

</body>

</html>





<!-- Modal de Observações -->
<div class="modal fade" id="modalObs" tabindex="-1" aria-labelledby="modalObsLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalObsLabel">Observações - <span id="nome_item"></span></h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="form-obs" onsubmit="return false;">
          <input type="hidden" id="id_obs" name="id">
          <div class="mb-3">
            <label for="obs" class="form-label">Observações do item</label>
            <textarea class="form-control" id="obs" name="obs" rows="3" maxlength="255" placeholder="Deseja adicionar alguma observação?"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Fechar</button>
        <button type="button" class="btn btn-primary" onclick="salvarObservacao($('#id_obs').val(), $('#obs').val())">Salvar</button>
      </div>
    </div>
  </div>
</div>




<!-- Modal -->
<div class="modal fade" id="modalAdc" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><span id="nome_item_adc"></span></h5>
        <button type="button" id="btn-fechar-adc" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div id="listar-adc-carrinho">

        </div>

      </div>
    </div>
  </div>
</div>


<!-- Modal -->
<div class="modal fade" id="modalGrades" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel"><span id="nome_item_grade"></span></h5>
        <button type="button" id="btn-fechar-grade" class="btn-close" data-dismiss="modal" aria-label="Close"></button>
      </div>

      <div class="modal-body">
        <div id="listar-grade-carrinho">

        </div>

      </div>
    </div>
  </div>
</div>


<script type="text/javascript">
  $(document).ready(function() {
    listarCarrinho()
  });

  function listarCarrinho() {

    $.ajax({
      url: 'js/ajax/listar-itens-carrinho.php',
      method: 'POST',
      data: {},
      dataType: "html",

      success: function(result) {

        $("#listar-itens-carrinho").html(result);

      }
    });
  }
</script>


<script type="text/javascript">
  $("#form-obs").submit(function() {

    event.preventDefault();
    var formData = new FormData(this);

    $.ajax({
      url: 'js/ajax/editar-obs-carrinho.php',
      type: 'POST',
      data: formData,

      success: function(mensagem) {
        $('#mensagem-obs').text('');
        $('#mensagem-obs').removeClass()
        if (mensagem.trim() == "Salvo com Sucesso") {
          $('#btn-fechar-obs').click();
          listarCarrinho();

        } else {

          $('#mensagem-obs').addClass('text-danger')
          $('#mensagem-obs').text(mensagem)
        }


      },

      cache: false,
      contentType: false,
      processData: false,

    });

  });
</script>

<!-- CSS moderno para botões do carrinho -->
<style>
  .carrinho-btn-quant {
    width: 32px;
    height: 32px;
    border-radius: 50%;
    border: none;
    background: #fffbe6;
    color: #333;
    margin: 0 2px;
    transition: box-shadow 0.18s, background 0.18s, color 0.18s, transform 0.18s;
    font-size: 1.1rem;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.04);
  }

  .carrinho-btn-quant:hover {
    background: #ffe066;
    color: #f59e00;
    transform: scale(1.12);
    box-shadow: 0 2px 8px rgba(245, 158, 0, 0.10);
  }

  .carrinho-btn-edit,
  .carrinho-btn-remove {
    background: none;
    border: none;
    font-size: 1.2rem;
    margin-left: 6px;
    color: #888;
    transition: color 0.18s, transform 0.18s;
  }

  .carrinho-btn-edit:hover {
    color: #1976d2;
    transform: scale(1.15);
  }

  .carrinho-btn-remove:hover {
    color: #dc3545;
    transform: scale(1.15);
  }

  .btn-finalizar {
    border-radius: 16px;
    font-weight: 600;
    letter-spacing: 0.5px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    transition: all 0.18s;
    text-transform: capitalize;
    background: linear-gradient(90deg, #ffe066 0%, #f59e00 100%);
    color: #222;
    border: none;
  }

  .btn-finalizar:hover {
    transform: translateY(-2px) scale(1.03);
    box-shadow: 0 4px 16px rgba(245, 158, 0, 0.18);
    background: linear-gradient(90deg, #f59e00 0%, #ffe066 100%);
    color: #111;
  }
</style>

<!-- Exemplo de uso dos botões no HTML do carrinho -->
<!--
<button class="carrinho-btn-quant" onclick="diminuirQuantItem(id)"><i class="bi bi-dash"></i></button>
<input type="text" class="form-control text-center border-0" value="4" readonly style="width: 32px; background: transparent; font-size: 1.1rem; font-weight: 600;">
<button class="carrinho-btn-quant" onclick="aumentarQuantItem(id)"><i class="bi bi-plus"></i></button>
<button class="carrinho-btn-edit" title="Editar"><i class="bi bi-pencil"></i></button>
<button class="carrinho-btn-remove" title="Remover"><i class="bi bi-trash"></i></button>
-->

<!-- Botão finalizar pedido -->