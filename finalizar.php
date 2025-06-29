<?php
@session_start();
require_once("cabecalho.php");
require_once("js/ajax/ApiConfig.php");

$sessao = @$_SESSION['sessao_usuario'];
$id_usuario = @$_SESSION['id'];

$sessao_pedido_balcao = @$_SESSION['pedido_balcao'];



$total_carrinho = 0;
$total_carrinhoF = 0;
$query = $pdo->query("SELECT * FROM carrinho where sessao = '$sessao'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);


if ($total_reg == 0) {
  echo "<script>window.location='index'</script>";
  exit();
} else {
  for ($i = 0; $i < $total_reg; $i++) {
    foreach ($res[$i] as $key => $value) {
    }

    $id = $res[$i]['id'];
    $total_item = $res[$i]['total_item'];
    $produto = $res[$i]['produto'];
    $pedido = $res[$i]['pedido'];
    $quantidade_it = $res[$i]['quantidade'];

    $total_item = $total_item * $quantidade_it;

    $total_carrinho += $total_item;
  }
  $total_carrinhoF = number_format($total_carrinho, 2, ',', '.');
}


$_SESSION['total_carrinho'] = $total_carrinho; // Salva o subtotal puro para o backend

// Busca a taxa configurável do banco para ser usada no JavaScript.
$query_taxa = $pdo->query("SELECT taxa_cartao FROM config WHERE id = 1");
$dados_taxa = $query_taxa->fetch(PDO::FETCH_ASSOC);
$taxa_cartao_db = $dados_taxa['taxa_cartao'] ?? 0;


$esconder_opc_delivery = '';
$valor_entrega = '';
$clicar_sim = '#collapseTwo';
$numero_colapse = '4';

$taxa_entregaF = 0;
$taxa_entrega = 0;

$nome_cliente = "";
$tel_cliente = "";
$rua = "";
$numero = "";
$bairro = "";
$complemento = "";

?>

<div class="main-container">

  <nav class="navbar bg-light fixed-top" style="box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.20);">
    <div class="container-fluid">
      <a class="navbar-brand" href="index.php">
        <img src="sistema/img/<?php echo $logo_sistema ?>" alt="" width="80px" class="d-inline-block align-text-top">
        Finalizar Pedido
      </a>

      <?php require_once("icone-carrinho.php") ?>

    </div>
  </nav>



  <div class="accordion" id="accordionExample"
    style="margin-top: 55px; margin-bottom: 130px; overflow: scroll; height:100%; scrollbar-width: thin; z-index: 100">
    <div class="accordion-item">
      <h2 class="accordion-header" id="headingOne">
        <button id="btn_ident" class="accordion-button" type="button" data-bs-toggle="collapse"
          data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne" style="font-size:14px">
          1 - IDENTIFICAÇÃO
        </button>
      </h2>
      <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne"
        data-bs-parent="#accordionExample">
        <div class="accordion-body" align="center">
          <input onblur="buscarNome()" type="tel" class="input telefone_user" name="telefone" id="telefone" required value=""
            placeholder="(00) 00000-0000" style="width:200px; text-align: center; border:0; margin-top: -15px; font-size: 19px">
          <img src="img/user.jpg" width="50px" height="50px">

          <div class="nome_user"> <input onclick="" type="text" class="input" name="nome" id="nome" required value="" placeholder="Seu Nome" style="width:200px; text-align: center; border:0"></div>



          <hr>
          <div><b>Finalizar seu Pedido?</b></div>
          <hr>
          <div class="row">
            <div class="col-6">
              <a href="index" class="btn btn-danger botao_nao">NÃO</a>

            </div>

            <div class="col-6">

              <a class="btn btn-success botao_sim" onclick="dados(); buscarNome()">SIM</a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="accordion-item <?php echo $esconder_opc_delivery ?>">
      <h2 class="accordion-header" id="headingTwo">
        <button id="colapse-2" class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo" style="font-size:14px">
          2 - MODO DE ENTREGA
        </button>
      </h2>



      <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo"
        data-bs-parent="#accordionExample">
        <div class="accordion-body">

          <ul class="list-group form-check">
            <li onclick="retirar()" class="list-group-item d-flex justify-content-between align-items-center">
              Retirar no Local
              <input onchange="retirar()" class="form-check-input" type="radio" name="radio_retirar" id="radio_retirar">
            </li>

            <li onclick="local()" class="list-group-item d-flex justify-content-between align-items-center">
              Consumir no Local
              <input onchange="local()" class="form-check-input" type="radio" name="radio_local" id="radio_local">
            </li>

            <li onclick="entrega()" class="list-group-item d-flex justify-content-between align-items-center">
              Entrega Delivery
              <input onchange="entrega()" class="form-check-input" type="radio" name="radio_entrega" id="radio_entrega">
            </li>

          </ul>

        </div>
      </div>






    </div>
    <div class="accordion-item <?php echo $esconder_opc_delivery ?>">
      <h2 class="accordion-header" id="headingThree">
        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree" id="colapse-3"
          style="font-size:14px">
          3 - ENDEREÇO OU UNIDADE DE RETIRADA
        </button>
      </h2>
      <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree"
        data-bs-parent="#accordionExample">
        <div class="accordion-body">

          <div id="area-retirada">
            <a href="" class="" data-bs-toggle="collapse" data-bs-target="#collapse4"
              style="text-decoration: none; color:#000">
              <div>
                <b> <span id="consumir-local">Endereço da nossa Loja </span></b><br>
                <?php echo $endereco_sistema ?>
                <i class="bi bi-check-lg"></i>
              </div>
            </a>
          </div>


          <div id="area-endereco">

            <?php // O campo CEP será sempre mostrado para Delivery, a lógica de cálculo de frete (distância ou bairro) será tratada no JS 
            ?>
            <div class="row">
              <div class="col-md-4 col-sm-6 col-12">
                <div class="group">
                  <input type="text" class="input" name="cep" id="cep" required>
                  <span class="highlight"></span>
                  <span class="bar"></span>
                  <label class="label">CEP*</label>
                </div>
              </div>
            </div>


            <div class="row">
              <div class="col-md-9 col-sm-8 col-12">
                <div class="group">
                  <input type="text" class="input" name="endereco" id="rua" required>
                  <span class="highlight"></span>
                  <span class="bar"></span>
                  <label class="label">Rua* </label>
                </div>
              </div>

              <div class="col-md-3 col-sm-4 col-12">
                <div class="group">
                  <input type="text" class="input" name="numero" id="numero" required>
                  <span class="highlight"></span>
                  <span class="bar"></span>
                  <label class="label">Número*</label>
                </div>
              </div>
            </div>


            <div class="row">
              <div class="col-md-5 col-sm-6 col-12">
                <div class="group">
                  <input type="text" class="input" name="complemento" id="complemento">
                  <span class="highlight"></span>
                  <span class="bar"></span>
                  <label class="label">Complemento</label>
                </div>
              </div>

              <?php if ($entrega_distancia != "Sim" || empty($chave_api_maps)) { ?>
                <div class="col-md-7 col-sm-6 col-12">
                  <div class="group">
                    <select class="input" name="bairro" id="bairro" required style="background: transparent;"
                      onchange="calcularFrete()">
                      <option value="">Selecione um Bairro</option>
                      <?php
                      $query_bairros_select = $pdo->query("SELECT * FROM bairros ORDER BY nome asc");
                      $res_bairros_select = $query_bairros_select->fetchAll(PDO::FETCH_ASSOC);
                      foreach ($res_bairros_select as $b_sel) {
                        $valor_b_sel = $b_sel['valor'];
                        $valorF_b_sel = 'R$ ' . number_format($valor_b_sel, 2, ',', '.');
                        // A seleção dinâmica do bairro será feita via JavaScript ao buscar cliente
                        echo '<option value="' . htmlspecialchars($b_sel['nome']) . '">' . htmlspecialchars($b_sel['nome']) . ' - ' . $valorF_b_sel . '</option>';
                      }
                      if (count($res_bairros_select) == 0) {
                        echo '<option value="">Cadastre um Bairro</option>';
                      }
                      ?>
                    </select>
                    <span class="highlight"></span>
                    <span class="bar"></span>
                  </div>
                </div>
              <?php } else { ?>
                <div class="col-md-7 col-sm-6 col-12">
                  <div class="group">
                    <input type="text" class="input" name="bairro" id="bairro" required>
                    <span class="highlight"></span>
                    <span class="bar"></span>
                    <label class="label">Bairro*</label>
                  </div>
                </div>
              <?php } ?>
            </div>

            <div class="row">
              <div class="col-12">
                <div class="group">
                  <input type="text" class="input" name="cidade" id="cidade">
                  <span class="highlight"></span>
                  <span class="bar"></span>
                  <label class="label">Cidade*</label>
                </div>
              </div>
            </div>


            <div align="center" class="avancar-pgto">
              <a id="colap-4" href="#" class="btn btn-success btn-sm" data-bs-toggle="collapse"
                data-bs-target="#collapse4">Avançar para Pagamento</a>
            </div>

          </div>
        </div>
      </div>
    </div>
    <div class="accordion-item">
      <h2 class="accordion-header" id="heading4">
        <button id="collapse-4" class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
          data-bs-target="#collapse4" aria-expanded="false" aria-controls="collapse4">
          <?php echo $numero_colapse ?> - PAGAMENTO
        </button>
      </h2>
      <div id="collapse4" class="accordion-collapse collapse" aria-labelledby="heading4"
        data-bs-parent="#accordionExample">
        <div class="accordion-body">

          <div class="row" style="font-size:14px">

            <div class="col-3 form-check">
              <small>Dinheiro
                <input onchange="dinheiro()" class="form-check-input" type="radio" name="forma_pgto_radio"
                  id="radio_dinheiro">
              </small>
            </div>

            <div class="col-2 form-check">
              <small>Pix
                <input onchange="pix()" class="form-check-input" type="radio" name="forma_pgto_radio" id="radio_pix">
              </small>
            </div>


            <div class="col-3 form-check">
              <small>Crédito
                <input onchange="credito()" class="form-check-input" type="radio" name="forma_pgto_radio"
                  id="radio_credito">
              </small>
            </div>

            <div class="col-3 form-check">
              <small>Débito
                <input onchange="debito()" class="form-check-input" type="radio" name="forma_pgto_radio" id="radio_debito">
              </small>
            </div>

          </div>

          <?php if ($sessao_pedido_balcao == 'BALCÃO') { ?>
            <div>
              <br>
              <select class="form-select form-select-sm" name="esta_pago_select" id="esta_pago_select" style="width:200px" onchange="$('#esta_pago').val(this.value)">
                <option value="Não">Não está Pago</option>
                <option value="Sim">Já está Pago</option>
              </select>
            </div>
          <?php } ?>

          <div id="pagar_pix" style="margin-top: 15px">
            <div id="listar_pix">

            </div>
          </div>


          <div id="pagar_dinheiro" style="margin-top: 15px">
            <b>Dinheiro na Entrega </b><br>
            <div class="row">
              <div class="col-5">
                <small>Precisa de Troco? </small>
              </div>
              <div class="col-7" style="margin-top: -13px">
                <div class="group">
                  <input type="text" class="input" name="troco" id="troco">
                  <span class="highlight"></span>
                  <span class="bar"></span>
                  <label class="label">Vou precisar de troco para</label>
                </div>
              </div>
            </div>

          </div>



          <div id="pagar_credito" style="margin-top: 15px">
            <b>Pagar com Cartão de Crédito </b><br>
            <small>O Pagamento será efetuado no ato da entrega com cartão de crédito</small>
            <div id="mensagem-taxa-cartao" class="text-danger small mt-1"></div>
          </div>

          <div id="pagar_debito" style="margin-top: 15px">
            <b>Pagar com Cartão de Débito </b><br>
            <small>O Pagamento será efetuado no ato da entrega com cartão de débito</small>
          </div>



        </div>



        <div class="row" style="margin:10px" id="div_cupom">
          <small><b>Tem Cupom?</b></small>
          <div class="col-md-2 col-9">
            <input class="form-control" type="text" name="cupom_input" id="cupom_input" placeholder="Código do Cupom">
          </div>
          <div class="col-md-1 col-3">
            <button onclick="aplicarCupom()" class="btn btn-primary" type="button" name="btn_cupom" id="btn_cupom"><i
                class="bi bi-search"></i></button>
          </div>
        </div>


        <div class="group mt-4 mx-4" id="area-obs">
          <input type="text" class="input" name="obs" id="obs" value="">
          <span class="highlight"></span>
          <span class="bar"></span>
          <label class="label">Observações do Pedido</label>
        </div>
      </div>



    </div>





  </div>


</div>


<input type="hidden" id="entrega" value="<?php echo $valor_entrega ?>">
<input type="hidden" id="pagamento">
<input type="hidden" id="taxa-entrega-input">
<input type="hidden" id="id_cliente">
<input type="hidden" id="valor-cupom">
<input type="hidden" id="codigo_pix" value="">
<input type="hidden" id="valor_total_final" value="">
<input type="hidden" id="esta_pago" value="Não"> <!-- Campo para controle do PIX pago no balcão -->


<div class="total-finalizar">
  <div class="total-pedido" style="border: solid 1px #ababab; border-radius: 10px;">
    <span id="area-taxa">
      <span class="previsao_entrega">Taxa de Entrega: <span class="text-danger">R$ <span id="taxa-entrega">0,00</span>
        </span></span>
      <span class="previsao_entrega mx-2">Previsão <?php echo $previsao_entrega ?> Minutos</span>

    </span>
    <br>
    <div id="desconto_div" style="display:none; ">
      <span><b>Desconto do Cupom</b></span>
      <span class="direita"> <b>R$ <span id="total_cupom"></span></b></span>
    </div>
    <div id="taxa_cartao_div" style="display:none;">

      <span><b>Taxa do Cartão</b></span>
      <span class="direita"> <b>R$ <span id="valor_taxa_cartao"></span></b></span>
    </div>

    <br>
    <big>
      <span><b>TOTAL À PAGAR</b></span>
      <span class="direita"> <b>R$ <span id="total-carrinho-finalizar"><?php echo $total_carrinhoF ?></span></b></span>
    </big>
  </div>


  <div class="d-grid gap-2 mt-4 abaixo">
    <a href='#' id="botao_finalizar" onclick="finalizarPedido()" class="btn btn-warning btn-lg">Concluir
      Pedido</a>

    <div align="center" id="div_img" style="display:none"><img src="img/loading.gif" width="100%" height="40px"></div>
  </div>
</div>


</body>

</html>


<!-- jQery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- Mascaras JS -->
<script type="text/javascript" src="js/mascaras.js"></script>

<!-- Ajax para funcionar Mascaras JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.11/jquery.mask.min.js"></script>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<!-- SweetAlert2 JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>


<script>
  function copiar() {
    var input = document.querySelector("#chave_pix_copia");
    input.select();
    input.setSelectionRange(0, 99999); // Para mobile
    document.execCommand("copy");
    // Feedback visual moderno
    if (window.Swal) {
      Swal.fire({
        toast: true,
        position: 'top-end',
        icon: 'success',
        title: 'Chave Pix copiada!',
        showConfirmButton: false,
        timer: 2000,
        timerProgressBar: true
      });
    } else {
      alert('Chave Pix Copiada! Use a opção Copie e Cole para Pagar');
    }
  }
</script>

<script type="text/javascript">
  function retirar() {
    document.getElementById('radio_retirar').checked = true;
    document.getElementById('radio_local').checked = false;
    document.getElementById('radio_entrega').checked = false;
    $('#colapse-3').click();
    $('#entrega').val('Retirar');
    $('#consumir-local').text('Endereço de Retirada');

    document.getElementById('area-retirada').style.display = "block";
    document.getElementById('area-endereco').style.display = "none";

    document.getElementById('area-taxa').style.display = "none";
    $('#taxa-entrega').text('0,00'); // Zera a taxa de entrega na exibição
    $('#taxa-entrega-input').val('0.00'); // Zera a taxa de entrega no input
    atualizarTotalGeral();
  }
</script>


<script type="text/javascript">
  $(document).ready(function() {

    var pedido_balcao = "<?= $sessao_pedido_balcao ?>";

    if (pedido_balcao != 'BALCÃO') {
      var nome_cl = localStorage.nome_cli_del;
      var tel_cl = localStorage.telefone_cli_del;
      $('#telefone').val(tel_cl);
      $('#nome').val(nome_cl);
      if (tel_cl) buscarNome(); // Tenta buscar nome se houver telefone no localStorage
    }


    var id_usuario = "";

    $('#telefone').focus();
    document.getElementById('area-endereco').style.display = "none";
    document.getElementById('area-obs').style.display = "none";
    document.getElementById('area-taxa').style.display = "none";

    document.getElementById('pagar_pix').style.display = "none";
    document.getElementById('pagar_debito').style.display = "none";
    document.getElementById('pagar_credito').style.display = "none";
    document.getElementById('pagar_dinheiro').style.display = "none";
    atualizarTotalGeral();
  });



  function local() {
    document.getElementById('radio_retirar').checked = false;
    document.getElementById('radio_local').checked = true;
    document.getElementById('radio_entrega').checked = false;
    $('#colapse-3').click();
    $('#entrega').val('Consumir Local');
    $('#consumir-local').text('Endereço da nossa unidade');

    document.getElementById('area-retirada').style.display = "block";
    document.getElementById('area-endereco').style.display = "none";

    document.getElementById('area-taxa').style.display = "none";
    $('#taxa-entrega').text('0,00');
    $('#taxa-entrega-input').val('0.00');
    atualizarTotalGeral();
  }


  function entrega() {
    document.getElementById('radio_retirar').checked = false;
    document.getElementById('radio_local').checked = false;
    document.getElementById('radio_entrega').checked = true;
    $('#colapse-3').click();
    $('#entrega').val('Delivery');

    document.getElementById('area-retirada').style.display = "none";
    document.getElementById('area-endereco').style.display = "block";
    document.getElementById('area-taxa').style.display = "inline-block";

    // Ao selecionar delivery, o CEP será o foco. O cálculo de frete ocorrerá no onblur do CEP.
    // Se já houver um bairro preenchido (ex: cliente buscou pelo telefone), recalcula.
    if ($('#bairro').val()) {
      if ("<?= $entrega_distancia ?>" === "Sim" && "<?= $chave_api_maps ?>" !== "") {
        // Se o CEP também estiver preenchido, calcularFreteDistancia pode ser chamado
        // Mas o ideal é que o cálculo seja acionado pelo blur do CEP.
        // Se o CEP não estiver preenchido, o usuário precisará preenchê-lo.
      } else {
        calcularFrete(); // Calcula frete por bairro se não for por distância
      }
    } else {
      // Limpa a taxa de entrega se não houver bairro/CEP ainda
      $('#taxa-entrega').text('0,00');
      $('#taxa-entrega-input').val('0.00');
    }


    var access_token = "<?= $access_token ?>";
    if (access_token != "") {
      // Não chama pix() automaticamente aqui, espera o usuário interagir com as formas de pagamento.
      // document.getElementById('radio_pix').checked = true; // Pode ser uma opção, mas deixa o usuário escolher
    }
    atualizarTotalGeral();
  }
</script>


<script type="text/javascript">
  function verificarCamposMinimosParaFinalizacao() {
    var nome = $('#nome').val();
    var telefone = $('#telefone').val().replace(/\D/g, '');
    var pedido_balcao = "<?= $sessao_pedido_balcao ?>";
    var modo_entrega_selecionado = ($('#radio_retirar').is(':checked') || $('#radio_local').is(':checked') || $('#radio_entrega').is(':checked'));

    if (pedido_balcao === "") { // Não é balcão, validações mais estritas
      if (nome === "") return {
        valido: false,
        mensagem: "Preencha seu Nome."
      };
      if (telefone.length < 10) return {
        valido: false,
        mensagem: "Preencha um Telefone válido (com DDD)."
      };
      if (!modo_entrega_selecionado) return {
        valido: false,
        mensagem: "Escolha um Modo de Entrega."
      };

      var entrega_val = $('#entrega').val();
      if (entrega_val === "Delivery") {
        if ($('#rua').val() === "") return {
          valido: false,
          mensagem: "Preencha a Rua para entrega."
        };
        if ($('#numero').val() === "") return {
          valido: false,
          mensagem: "Preencha o Número para entrega."
        };
        if ($('#bairro').val() === "" || $('#bairro').val() === null) return {
          valido: false,
          mensagem: "Preencha o CEP para buscar o Bairro."
        };
        if ($('#taxa-entrega-input').val() === "" || parseFloat($('#taxa-entrega-input').val().replace(',', '.')) < 0) {
          return {
            valido: false,
            mensagem: "Calcule o frete informando o CEP."
          };
        }
      }
    }
    return {
      valido: true,
      mensagem: ""
    };
  }


  function pix() {
    document.getElementById('radio_credito').checked = false;
    document.getElementById('radio_debito').checked = false;
    document.getElementById('radio_dinheiro').checked = false;
    $('#pagamento').val('Pix');
    atualizarTotalGeral();

    var codigo_pix_existente_na_pagina = $('#codigo_pix').val();

    if (codigo_pix_existente_na_pagina) {
      $.ajax({
        url: 'js/ajax/verificar_pgto_api.php',
        method: 'POST',
        data: {
          codigo_pix: codigo_pix_existente_na_pagina
        },
        dataType: "json",
        success: function(response_direto) {
          if (response_direto.status === 'approved') {
            $('#esta_pago').val('Sim');
            var validacaoCampos = verificarCamposMinimosParaFinalizacao();
            if (validacaoCampos.valido) {
              Swal.fire({
                title: 'Pagamento Confirmado!',
                text: 'Seu pagamento PIX foi confirmado. Finalizando pedido...',
                icon: 'success',
                showConfirmButton: false,
                timer: 2500
              }).then(() => {
                finalizarPedido('Sim');
              });
            } else {
              Swal.fire({
                title: 'Pagamento Confirmado!',
                html: 'Seu PIX foi pago com sucesso!<br>Por favor, <b>' + validacaoCampos.mensagem + '</b><br>E clique em "Concluir Pedido".',
                icon: 'info'
              });
              $('#listar_pix').html('<p class="text-success text-center fw-bold my-3">Pagamento PIX já realizado e confirmado!</p>');
              $('#botao_finalizar').show();
              $('#div_img').hide();
            }
          } else {
            if ($('#listar_pix').html().trim() === "") {
              gerarNovoQrCodePix();
            } else {
              verficarpgto();
            }
          }
        },
        error: function() {
          gerarNovoQrCodePix();
        }
      });
    } else {
      gerarNovoQrCodePix();
    }
  }

  function gerarNovoQrCodePix() {
    var total_compra = parseFloat("<?= $_SESSION['total_carrinho'] ?>");
    var taxa_entrega = parseFloat($('#taxa-entrega-input').val().replace(",", ".")) || 0;
    var cupom_val = parseFloat($('#valor-cupom').val()) || 0;
    var total_compra_final = total_compra + taxa_entrega - cupom_val;
    var valor_a_cobrar = total_compra_final.toFixed(2);

    $('#listar_pix').html('<div class="text-center"><img src="img/loading.gif" width="80px"></div>');

    $.ajax({
      url: 'js/ajax/pix.php',
      method: 'POST',
      data: {
        valor: valor_a_cobrar
      },
      dataType: "html",
      success: function(result_qr) {
        $('#listar_pix').html(result_qr);
        // Só exibe o alerta se for reutilização (campo hidden #pix_reutilizado)
        if ($('#pix_reutilizado').length) {
          Swal.fire({
            title: 'Atenção!',
            html: 'Já existe um pagamento PIX pendente para este pedido.<br>Utilize o QRCode exibido para concluir o pagamento.',
            icon: 'info',
            timer: 6000,
            showConfirmButton: false
          });
        }
        verficarpgto();
      },
      error: function(xhr) {
        let msg = 'Erro ao gerar QR Code. Tente novamente.';
        if (xhr && xhr.responseText) {
          msg += '<br>' + xhr.responseText;
        }
        $('#listar_pix').html('<p class="text-danger text-center">' + msg + '</p>');
      }
    });

    document.getElementById('pagar_pix').style.display = "block";
    document.getElementById('pagar_debito').style.display = "none";
    document.getElementById('pagar_credito').style.display = "none";
    document.getElementById('pagar_dinheiro').style.display = "none";
    document.getElementById('area-obs').style.display = "block";
    atualizarTotalGeral();
  }

  var intervalVerificarPgto;

  function verficarpgto() {
    if (intervalVerificarPgto) {
      clearInterval(intervalVerificarPgto);
    }

    intervalVerificarPgto = setInterval(function() {
      var codigo_pix_atual_na_pagina = $('#codigo_pix').val();
      if ($('#pagamento').val() === "Pix" && codigo_pix_atual_na_pagina) {
        $.ajax({
          url: 'js/ajax/verificar_pgto_api.php',
          method: 'POST',
          data: {
            codigo_pix: codigo_pix_atual_na_pagina
          },
          dataType: "json",
          success: function(response) {
            if (response.status === 'approved') {
              clearInterval(intervalVerificarPgto);
              $('#esta_pago').val('Sim');
              var validacaoCampos = verificarCamposMinimosParaFinalizacao();
              if (validacaoCampos.valido) {
                finalizarPedido('Sim');
              } else {
                Swal.fire({
                  title: 'Pagamento PIX Confirmado!',
                  html: 'Detectamos que seu pagamento PIX foi aprovado.<br>Por favor, complete seus dados e clique em <b>Concluir Pedido</b>.',
                  icon: 'success',
                  toast: true,
                  position: 'top-end',
                  showConfirmButton: false,
                  timer: 7000,
                  timerProgressBar: true
                });
                $('#botao_finalizar').show();
                $('#div_img').hide();
              }
            }
          }
        });
      } else {
        clearInterval(intervalVerificarPgto);
      }
    }, 7000);
  }

  function dinheiro() {
    if (intervalVerificarPgto) clearInterval(intervalVerificarPgto);
    document.getElementById('radio_credito').checked = false;
    document.getElementById('radio_debito').checked = false;
    document.getElementById('radio_pix').checked = false;
    $('#listar_pix').html('');
    $('#codigo_pix').val('');
    $('#esta_pago').val('Não');
    $('#pagamento').val('Dinheiro');
    document.getElementById('pagar_pix').style.display = "none";
    document.getElementById('pagar_debito').style.display = "none";
    document.getElementById('pagar_credito').style.display = "none";
    document.getElementById('pagar_dinheiro').style.display = "block";
    document.getElementById('area-obs').style.display = "block";
    atualizarTotalGeral();
  }

  function debito() {
    if (intervalVerificarPgto) clearInterval(intervalVerificarPgto);
    document.getElementById('radio_credito').checked = false;
    document.getElementById('radio_pix').checked = false;
    document.getElementById('radio_dinheiro').checked = false;
    $('#listar_pix').html('');
    $('#codigo_pix').val('');
    $('#esta_pago').val('Não');
    $('#pagamento').val('Cartão de Débito');
    document.getElementById('pagar_pix').style.display = "none";
    document.getElementById('pagar_debito').style.display = "block";
    document.getElementById('pagar_credito').style.display = "none";
    document.getElementById('pagar_dinheiro').style.display = "none";
    document.getElementById('area-obs').style.display = "block";
    atualizarTotalGeral();
  }


  function credito() {
    if (intervalVerificarPgto) clearInterval(intervalVerificarPgto);
    document.getElementById('radio_pix').checked = false;
    document.getElementById('radio_debito').checked = false;
    document.getElementById('radio_dinheiro').checked = false;
    $('#listar_pix').html('');
    $('#codigo_pix').val('');
    $('#esta_pago').val('Não');
    $('#pagamento').val('Cartão de Crédito');
    document.getElementById('pagar_pix').style.display = "none";
    document.getElementById('pagar_debito').style.display = "none";
    document.getElementById('pagar_credito').style.display = "block";
    document.getElementById('pagar_dinheiro').style.display = "none";
    document.getElementById('area-obs').style.display = "block";
    atualizarTotalGeral();
  }
</script>


<script type="text/javascript">
  function finalizarPedido(pedidoauto) {
    // Validação antes de prosseguir
    var validacao = verificarCamposMinimosParaFinalizacao();
    var pagamento = $('#pagamento').val();
    var esta_pago = $('#esta_pago').val();
    if (pagamento === 'Pix' && esta_pago !== 'Sim' && pedidoauto !== 'Sim') {
      if (window.Swal) {
        Swal.fire({
          icon: 'warning',
          title: 'Atenção',
          text: 'Finalize o pagamento via Pix antes de concluir o pedido.',
          timer: 3500,
          showConfirmButton: false
        });
      } else {
        alert('Finalize o pagamento via Pix antes de concluir o pedido.');
      }
      return;
    }
    if (!validacao.valido && pedidoauto !== 'Sim') { // Se não for finalização automática, mostra alerta de validação
      alert(validacao.mensagem);
      // Foca no primeiro campo problemático (exemplo simples)
      if (validacao.mensagem.includes("Nome")) $('#nome').focus();
      else if (validacao.mensagem.includes("Telefone")) $('#telefone').focus();
      else if (validacao.mensagem.includes("Modo de Entrega")) $('#colapse-2').click();
      else if (validacao.mensagem.includes("Rua")) $('#rua').focus();
      else if (validacao.mensagem.includes("Número")) $('#numero').focus();
      else if (validacao.mensagem.includes("Bairro") || validacao.mensagem.includes("CEP")) $('#cep').focus();
      return;
    }


    $('#botao_finalizar').hide();
    $('#div_img').show();

    var pedido_balcao = "<?= $sessao_pedido_balcao ?>";
    var codigo_pix_val = $('#codigo_pix').val();
    var nome = $('#nome').val();
    var telefone = $('#telefone').val().replace(/\D/g, '');
    var mesa = ""; // Ajustar se houver campo mesa
    var id_usuario = "";

    localStorage.setItem('nome_cli_del', nome);
    localStorage.setItem('telefone_cli_del', $('#telefone').val());

    var nome_cliente = $('#nome').val();
    var tel_cliente = $('#telefone').val();
    var id_cliente = $('#id_cliente').val();
    var entrega_val = $('#entrega').val();
    var rua_val = $('#rua').val();
    var numero_val = $('#numero').val();
    var complemento_val = $('#complemento').val();
    var bairro_val = $('#bairro').val();
    var troco_val = $('#troco').val();
    var obs_val = $('#obs').val();
    var taxa_entrega_val = $('#taxa-entrega-input').val().replace(',', '.');
    var cupom_val = $('#valor-cupom').val();

    var esta_pago_val = (pedidoauto === 'Sim') ? 'Sim' : ($('#esta_pago_select').length ? $('#esta_pago_select').val() : $('#esta_pago').val());


    var cep_val = $('#cep').val();
    var cidade_val = $('#cidade').val();

    if (cupom_val == "") cupom_val = 0;
    if (taxa_entrega_val == "") taxa_entrega_val = 0;

    var total_compra_php = parseFloat("<?= $_SESSION['total_carrinho'] ?>");
    var pedido_minimo = parseFloat("<?= $pedido_minimo ?>");

    if (pedido_minimo > 0 && total_compra_php < pedido_minimo && pedido_balcao == "") {
      alert('Seu pedido precisar ser superior a R$' + pedido_minimo.toFixed(2).replace('.', ','));
      $('#botao_finalizar').show();
      $('#div_img').hide();
      return;
    }

    // Recalcula o total final para consistência, incluindo taxa do cartão se houver
    var taxa_cartao_percentual_js = parseFloat('<?php echo $taxa_cartao_db; ?>') || 0;
    var valor_taxa_cartao_js = 0;
    if (pagamento === 'Cartão de Crédito' && taxa_cartao_percentual_js > 0) {
      valor_taxa_cartao_js = total_compra_php * (taxa_cartao_percentual_js / 100);
    }
    var total_compra_final_js = total_compra_php + parseFloat(taxa_entrega_val) - parseFloat(cupom_val) + valor_taxa_cartao_js;

    if (pagamento == "Dinheiro" && troco_val != "" && parseFloat(troco_val.replace(',', '.')) < total_compra_final_js && parseFloat(troco_val.replace(',', '.')) > 0) {
      alert('O valor do troco precisa ser maior ou igual ao total da compra!');
      $('#troco').focus();
      $('#botao_finalizar').show();
      $('#div_img').hide();
      return;
    }

    var abrir_comprovante = "<?= $abrir_comprovante ?>";

    $.ajax({
      url: 'js/ajax/inserir-pedido.php',
      method: 'POST',
      data: {
        pagamento: pagamento,
        entrega: entrega_val,
        rua: rua_val,
        numero: numero_val,
        bairro: bairro_val,
        complemento: complemento_val,
        troco: troco_val,
        obs: obs_val,
        nome_cliente: nome_cliente,
        tel_cliente: tel_cliente,
        id_cliente: id_cliente,
        mesa: mesa,
        cupom: cupom_val,
        codigo_pix: codigo_pix_val,
        cep: cep_val,
        cidade: cidade_val,
        taxa_entrega: taxa_entrega_val,
        esta_pago: esta_pago_val
      },
      dataType: "html",
      success: function(mensagem) {
        $('#mensagem').text('').removeClass();

        if (mensagem.includes('Pagamento nao realizado!!')) {
          if (pedidoauto !== 'Sim') {
            Swal.fire('Pagamento Pendente', 'Realize o Pagamento PIX antes de Prosseguir!', 'warning');
          }
          $('#botao_finalizar').show();
          $('#div_img').hide();
          return;
        }

        const msg_parts = mensagem.split("*");
        const previsao_entrega_msg = msg_parts[0]?.trim() || '';
        const status_pedido_msg = msg_parts[1]?.trim() || '';
        const id_pedido_msg = msg_parts[2]?.trim() || '';

        if (status_pedido_msg === "Pedido Finalizado") {
          localStorage.removeItem('nome_cli_del');
          localStorage.removeItem('telefone_cli_del');

          if (pedido_balcao === 'BALCÃO') {
            Swal.fire('Pedido Finalizado!', 'Seu pedido foi registrado com sucesso!', 'success').then(() => {
              window.location = 'index.php';
            });
          } else {
            if (pedidoauto !== 'Sim') {
              Swal.fire('Pedido Finalizado!', 'Seu pedido foi enviado com sucesso! Previsão de entrega: ' + previsao_entrega_msg, 'success');
            }

            if (abrir_comprovante !== 'Não' && id_pedido_msg) {
              window.open(`sistema/painel/rel/comprovante2_class.php?id=${id_pedido_msg}&enviar=sim`);
            }

            setTimeout(() => {
              if (id_pedido_msg) window.location = `pedido/${id_pedido_msg}`;
              else window.location = 'index.php';
            }, pedidoauto === 'Sim' ? 500 : 2000);
          }
        } else if (mensagem.trim() === "0") {
          Swal.fire('Carrinho Vazio', 'Seu carrinho está vazio, adicione itens antes de finalizar.', 'error');
          $('#botao_finalizar').show();
          $('#div_img').hide();
        } else {
          Swal.fire('Erro', 'Não foi possível finalizar o pedido: ' + mensagem, 'error');
          $('#botao_finalizar').show();
          $('#div_img').hide();
        }
      },
      error: function(xhr, status, error) {
        Swal.fire('Erro na comunicação', 'Ocorreu um erro ao tentar finalizar o pedido. Tente novamente.', 'error');
        $('#botao_finalizar').show();
        $('#div_img').hide();
      }
    });
  }
</script>

<script type="text/javascript">
  function calcularFrete() {
    var bairro = $('#bairro').val();
    var total_compra = "<?= $_SESSION['total_carrinho'] ?>";
    var entrega = $('#entrega').val();

    if (entrega !== 'Delivery' || bairro === "") {
      $('#taxa-entrega').text('0,00');
      $('#taxa-entrega-input').val('0.00');
      atualizarTotalGeral();
      return;
    }

    $.ajax({
      url: 'js/ajax/calcular-frete.php',
      method: 'POST',
      data: {
        bairro,
        total_compra,
        entrega
      },
      dataType: "html",
      success: function(result) {
        var split = result.split("-");
        $('#taxa-entrega').text(split[0].replace('.', ','));
        $('#taxa-entrega-input').val(split[0].replace(',', '.'));
        atualizarTotalGeral();
      }
    });
  }
</script>

<script type="text/javascript">
  function buscarNome() {
    var tel = $('#telefone').val().replace(/\D/g, '');

    if (tel.length < 10) return;

    $.ajax({
      url: 'js/ajax/listar-nome.php',
      method: 'POST',
      data: {
        tel
      },
      dataType: "text",
      success: function(result) {
        var split = result.split("**");
        // console.log("AJAX listar-nome.php result:", result); 
        if (split[0].trim() !== "") {
          $('#nome').val(split[0]);
        }
        $('#rua').val(split[1]);
        $('#numero').val(split[2]);

        // Define o valor do select de bairro e dispara o evento change
        // para que o cálculo de frete por bairro seja acionado, se aplicável.
        var bairroRetornado = split[3];
        $('#bairro').val(bairroRetornado);
        if ("<?= $entrega_distancia ?>" !== "Sim" || "<?= $chave_api_maps ?>" === "") {
          if (bairroRetornado) $('#bairro').change(); // Aciona cálculo de frete por bairro
        }


        $('#complemento').val(split[4]);
        $('#id_cliente').val(split[7]);
        $('#cep').val(split[8]);
        $('#cidade').val(split[9]);
        // console.log("Assigned values:", { nome: $('#nome').val(), rua: $('#rua').val(), bairro: $('#bairro').val(), id_cliente: $('#id_cliente').val() });

        // Se o CEP foi retornado e o frete é por distância, tenta calcular
        if (split[8] && "<?= $entrega_distancia ?>" === "Sim" && "<?= $chave_api_maps ?>" !== "") {
          // A função fetchAddressData já faz o cálculo de frete por distância no blur do CEP.
          // Se o CEP foi preenchido aqui, e o usuário não vai dar blur, podemos chamar diretamente.
          // No entanto, é melhor manter a consistência e deixar o blur do CEP ou o preenchimento manual acionar.
          // Apenas atualiza o total geral.
        }
        atualizarTotalGeral();
      }
    });
  }
</script>

<script type="text/javascript">
  function dados() {
    $('#nome').show();
    var nome = $('#nome').val();
    var telefone = $('#telefone').val();
    var pedido_balcao = "<?= $sessao_pedido_balcao ?>";

    if (pedido_balcao == "") {
      if (telefone.replace(/\D/g, '').length < 10) {
        alert("Coloque o número de telefone completo (DDD + número).");
        $('#telefone').focus();
        return;
      }
      if (nome == "") {
        alert('Preencha seu Nome');
        $('#nome').focus();
        return;
      }
    }
    $('#colapse-2').click();
  }

  function aplicarCupom() { // Renomeada para evitar conflito com variável 'cupom'
    var total_compra = parseFloat("<?= $_SESSION['total_carrinho'] ?>");
    var taxa_entrega = parseFloat($('#taxa-entrega-input').val().replace(",", ".")) || 0;
    var telefone_cliente = $('#telefone').val().replace(/\D/g, '');

    var total_final_para_cupom = total_compra + taxa_entrega;
    var codigo_cupom_val = $('#cupom_input').val(); // Usar o ID correto do input

    if (codigo_cupom_val == "") {
      alert("Preencha o código do cupom");
      return;
    }

    $.ajax({
      url: 'js/ajax/cupom.php',
      method: 'POST',
      data: {
        total_final: total_final_para_cupom,
        codigo_cupom: codigo_cupom_val,
        telefone_cliente
      },
      dataType: "text",
      success: function(mensagem) {
        var split = mensagem.split('**')
        if (split[0].trim() == '0') {
          alert('Código do Cupom Inválido');
        } else if (split[0].trim() == '1') {
          alert('Este cupom está vencido!');
        } else if (split[0].trim() == '2') {
          alert('Este cupom não é mais válido!');
        } else if (split[0].trim() == '3') {
          alert('Este cupom só é válido para compras acima de R$' + parseFloat(split[1]).toFixed(2).replace('.', ','));
        } else {
          $('#valor-cupom').val(split[1]);
          $('#div_cupom').hide();
          $('#desconto_div').show();
          $('#total_cupom').text(split[2]);
          alert('Cupom Inserido!');
          atualizarTotalGeral();
        }
      },
    });
  }
</script>

<script>
  var restaurantCoords = {
    latitude: "<?= $latitude_rest ?>",
    longitude: "<?= $longitude_rest ?>"
  };

  function initMap() {
    /* Pode deixar vazio se não usar para inicializar mapa na página */
  }

  function calcularFreteDistancia() {
    var chave_api = "<?= $chave_api_maps ?>";
    var distancia_km_permitida = "<?= $distancia_entrega_km ?>";
    // event.preventDefault(); // Removido pois não está dentro de um form submit
    var cep = document.getElementById('cep').value;
    var address = document.getElementById('rua').value;
    var number = document.getElementById('numero').value;
    var bairro_val = document.getElementById('bairro').value;
    var cidade_val = document.getElementById('cidade').value;
    var complement = document.getElementById('complemento').value;

    if (address == "" || number == "" || bairro_val == "" || cidade_val == "") {
      // Não mostra alerta aqui, pois o ViaCEP pode não ter preenchido tudo.
      // A validação final será no `finalizarPedido`.
      return;
    }

    var encodedAddress = encodeURIComponent(address + ', ' + number + ', ' + bairro_val + ', ' + cidade_val + ', ' + complement);

    fetch('https://maps.googleapis.com/maps/api/geocode/json?address=' + encodedAddress + '&key=' + chave_api)
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        if (data.status === 'OK' && data.results.length > 0) {
          var deliveryCoords = {
            latitude: data.results[0].geometry.location.lat,
            longitude: data.results[0].geometry.location.lng
          };
          var distance = calculateDistance(restaurantCoords, deliveryCoords);

          if (distance <= parseFloat(distancia_km_permitida)) {
            var deliveryCost = calculateDeliveryCost(distance);
            $('#taxa-entrega').text(deliveryCost.toFixed(2).replace('.', ','));
            $('#taxa-entrega-input').val(deliveryCost.toFixed(2));
            atualizarTotalGeral();
          } else {
            alert('Endereço fora da área de entrega (' + distancia_km_permitida + 'km). Distância: ' + distance.toFixed(2) + 'km');
            $('#taxa-entrega').text('0,00');
            $('#taxa-entrega-input').val('0.00');
            atualizarTotalGeral();
          }
        } else {
          alert('Não foi possível calcular a distância para o endereço. Verifique os dados ou a chave da API do Google Maps.');
          $('#taxa-entrega').text('0,00');
          $('#taxa-entrega-input').val('0.00');
          atualizarTotalGeral();
        }
      })
      .catch(function(error) {
        console.error("Erro ao calcular frete por distância:", error);
        alert("Erro ao calcular frete por distância.");
      });
  }

  function fetchAddressData(cep) {
    fetch('https://viacep.com.br/ws/' + cep.replace(/\D/g, '') + '/json/', {
        headers: {
          'Accept': 'application/json'
        }
      })
      .then(function(response) {
        return response.json();
      })
      .then(function(data) {
        if (!data.erro) {
          $('#rua').val(data.logradouro || '');
          $('#bairro').val(data.bairro || '');
          $('#cidade').val(data.localidade || '');
          $('#numero').focus(); // Foca no número para o usuário preencher

          if ("<?= $entrega_distancia ?>" === "Sim" && "<?= $chave_api_maps ?>" !== "") {
            // Se a rua e bairro foram preenchidos, tenta calcular por distância
            // O usuário ainda precisará preencher o número.
            // O ideal é que o cálculo de distância seja chamado após o número também,
            // mas para uma resposta imediata, pode-se chamar aqui se os campos principais estiverem OK.
            if ($('#rua').val() && $('#bairro').val() && $('#cidade').val()) {
              // Não chama calcularFreteDistancia() aqui, espera o usuário preencher o número e dar blur ou finalizar.
              // Apenas atualiza o total geral, pois o frete por bairro (se aplicável) pode ter mudado.
            }
          } else {
            // Se não for por distância, o cálculo de frete é por bairro.
            // Disparar o evento change no campo bairro para acionar calcularFrete()
            if ($('#bairro').val()) {
              $('#bairro').change();
            } else {
              // Se o ViaCEP não retornou bairro, zera a taxa e espera seleção manual
              $('#taxa-entrega').text('0,00');
              $('#taxa-entrega-input').val('0.00');
            }
          }
          atualizarTotalGeral(); // Atualiza o total em todos os casos
        } else {
          alert("CEP não encontrado. Verifique o número digitado.");
          $('#rua').val('');
          $('#bairro').val('');
          $('#cidade').val('');
          $('#taxa-entrega').text('0,00');
          $('#taxa-entrega-input').val('0.00');
          atualizarTotalGeral();
        }
      })
      .catch(function(error) {
        console.error("Erro ao buscar CEP:", error);
        alert("Erro ao buscar CEP. Verifique sua conexão ou tente novamente.");
      });
  }

  document.addEventListener('DOMContentLoaded', function() {
    const cepInput = document.getElementById('cep');
    if (cepInput) {
      cepInput.addEventListener('blur', function(event) {
        var cep_val = event.target.value.replace(/\D/g, '');
        if (cep_val.length === 8) {
          fetchAddressData(cep_val);
        }
      });
    }
    // Adiciona listener para o campo número, para recalcular frete por distância após preenchimento
    const numeroInput = document.getElementById('numero');
    if (numeroInput && "<?= $entrega_distancia ?>" === "Sim" && "<?= $chave_api_maps ?>" !== "") {
      numeroInput.addEventListener('blur', function(event) {
        if (document.getElementById('rua').value && document.getElementById('bairro').value && document.getElementById('cidade').value && this.value) {
          calcularFreteDistancia();
        }
      });
    }
  });


  function calculateDistance(coord1, coord2) {
    var lat1 = toRadians(coord1.latitude);
    var lon1 = toRadians(coord1.longitude);
    var lat2 = toRadians(coord2.latitude);
    var lon2 = toRadians(coord2.longitude);
    var R = 6371;
    var dLat = lat2 - lat1;
    var dLon = lon2 - lon1;
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dLon / 2) * Math.sin(dLon / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  function toRadians(degrees) {
    return degrees * (Math.PI / 180);
  }

  function calculateDeliveryCost(distance) {
    var valor_km = parseFloat("<?= $valor_km ?>") || 1;
    var roundedDistance = Math.ceil(distance);
    return roundedDistance * valor_km;
  }
</script>

<?php if (!empty($chave_api_maps)) { // Só carrega a API do Google se a chave estiver definida 
?>
  <script loading="async" async defer
    src="https://maps.googleapis.com/maps/api/js?key=<?= $chave_api_maps ?>&libraries=places&callback=initMap">
  </script>
<?php } ?>

<script>
  function atualizarTotalGeral() {
    var subtotal = parseFloat('<?php echo $_SESSION['total_carrinho']; ?>');
    var taxa_entrega_str = $('#taxa-entrega-input').val();
    var taxa_entrega = (taxa_entrega_str != "" && taxa_entrega_str != undefined) ? parseFloat(taxa_entrega_str.replace(",", ".")) : 0;

    var cupom_str = $('#valor-cupom').val();
    var cupom = (cupom_str != "" && cupom_str != undefined) ? parseFloat(cupom_str) : 0;

    var pagamento_selecionado = $('#pagamento').val();
    var taxa_cartao_config = parseFloat('<?php echo $taxa_cartao_db; ?>');
    var valor_taxa_cartao_calc = 0;

    if (pagamento_selecionado === 'Cartão de Crédito' && !isNaN(taxa_cartao_config) && taxa_cartao_config > 0) {
      valor_taxa_cartao_calc = subtotal * (taxa_cartao_config / 100);
      $('#valor_taxa_cartao').text(valor_taxa_cartao_calc.toFixed(2).replace(".", ","));
      $('#taxa_cartao_div').show();
      $('#mensagem-taxa-cartao').text('Taxa de ' + taxa_cartao_config.toFixed(2).replace(".", ",") + '% aplicada.');
    } else {
      $('#taxa_cartao_div').hide();
      $('#mensagem-taxa-cartao').text('');
    }

    var total_final_calc = subtotal + taxa_entrega - cupom + valor_taxa_cartao_calc;

    $('#total-carrinho-finalizar').text(total_final_calc.toFixed(2).replace(".", ","));
    $('#valor_total_final').val(total_final_calc.toFixed(2)); // Para o backend
  }

  $(document).ready(function() {
    atualizarTotalGeral();
    $('#taxa-entrega-input, #valor-cupom, #pagamento, #radio_dinheiro, #radio_pix, #radio_credito, #radio_debito').on('change input', function() {
      atualizarTotalGeral();
    });
    $('#bairro').on('change', function() {
      if ("<?= $entrega_distancia ?>" !== "Sim" || "<?= $chave_api_maps ?>" === "") {
        calcularFrete(); // Calcula frete por bairro apenas se não for por distância
      }
    });
  });
</script>