<?php
@session_start();
$id_usuario = @$_SESSION['id'];

require_once("cabecalho.php");
$url_completa = $_GET['url'];

$sessao = date('Y-m-d-H:i:s-') . rand(0, 1500);


$nome_mesa = @$_SESSION['nome_mesa'];
$id_ab_mesa = @$_SESSION['id_ab_mesa'];
$id_mesa = @$_SESSION['id_mesa'];
$pedido_balcao = @$_SESSION['pedido_balcao'];
// Formatando a data e hora para exibir apenas horas e minutos
$horario_aberturaF = date('H:i', strtotime($horario_abertura));
// Formatando a data e hora para exibir apenas horas e minutos
$horario_fechamentoF = date('H:i', strtotime($horario_fechamento));


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


if (@$_SESSION['sessao_usuario'] == "") {
    $_SESSION['sessao_usuario'] = $sessao;
}

$nova_sessao = $_SESSION['sessao_usuario'];

$separar_url = explode("_", $url_completa);
$url = $separar_url[0];

$pdo->query("DELETE FROM temp where carrinho = '0' and sessao = '$nova_sessao'");

$tem_variação = 'Não';

$data = date('Y-m-d');


$query = $pdo->query("SELECT * FROM produtos where url = '$url'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {
    $nome = $res[0]['nome'];
    $descricao = $res[0]['descricao'];
    $foto = $res[0]['foto'];
    $id_prod = $res[0]['id'];
    $valor = $res[0]['valor_venda'];

    $categoria = $res[0]['categoria'];
    $val_promocional = $res[0]['val_promocional'];
    $promocao = $res[0]['promocao'];

    if ($promocao == 'Sim') {
        $valor = $val_promocional;
    }

    $valorF = number_format($valor, 2, ',', '.');


    $query2 = $pdo->query("SELECT * FROM categorias where id = '$categoria'");
    $res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
    $total_reg2 = @count($res2);
    if ($total_reg2 > 0) {
        $url_cat = $res2[0]['url'];
    }


    $valor_total_do_item = $valor;
}
?>

<div class="main-container">



    <nav class="navbar bg-light fixed-top" style="box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.20);">
        <div class="container-fluid">
            <div class="navbar-brand">

                <a href="categoria-<?php echo $url_cat ?>"><big><i class="bi bi-arrow-left"></i></big></a>

                <span style="margin-left: 15px; font-size:14px"><?php echo $nome ?> - <?php echo $nome_mesa ?></span>
            </div>

            <?php require_once("icone-carrinho.php") ?>

        </div>
    </nav>

    <div class="destaque" style="border: solid 1px #ababab; border-radius: 10px;">
        <b><?php echo mb_strtoupper($nome); ?></b>
        <div class="col-lg-4 col-md-6">
            <div class="tpbanner__item">
                <img class="ocultar_img" src="sistema/painel/images/produtos/<?php echo $foto ?>" width="70%" height="70%" style="border-radius: 10px">
            </div>

        </div>
    </div>

    <div id="" style='margin-top: 15px'>
        <?php
        $query = $pdo->query("SELECT * FROM grades where produto = '$id_prod' and ativo = 'Sim' order by id asc");
        $res = $query->fetchAll(PDO::FETCH_ASSOC);
        $total_reg = @count($res);
        if ($total_reg > 0) {
            for ($i = 0; $i < $total_reg; $i++) {
                $id_grade = $res[$i]['id'];
                $tipo_item = $res[$i]['tipo_item'];
                $valor_item = $res[$i]['valor_item'];
                $texto = $res[$i]['texto'];
                $limite = $res[$i]['limite'];

                if ($tipo_item == 'Variação') {
                    $tem_variação = 'Sim';
                }


        ?>

                <div class="titulo-itens">
                    <input type="hidden" id="qt_<?php echo $id_grade ?>">
                    <?php echo $texto ?> <?php if ($limite > 0) {
                                                echo ' <span style="font-size:13px; color:#000">(até ' . $limite . ' itens!)</span>';
                                            } ?>
                </div>
                <ol class="list-group">

                    <?php
                    $query2 = $pdo->query("SELECT * FROM itens_grade where grade = '$id_grade' and ativo = 'Sim' order by id asc");
                    $res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
                    $total_reg2 = @count($res2);
                    if ($total_reg2 > 0) {
                        for ($i2 = 0; $i2 < $total_reg2; $i2++) {
                            $id_item = $res2[$i2]['id'];
                            $texto_item = $res2[$i2]['texto'];
                            $valor_item_grade = $res2[$i2]['valor'];
                            $limite_item = $res2[$i2]['limite'];
                            $valor_item_gradeF = number_format($valor_item_grade, 2, ',', '.');

                            $ocultar_valor = 'ocultar';
                            if ($valor_item_grade > 0) {
                                $ocultar_valor = '';
                            }

                    ?>


                            <li class="list-group-item">
                                <span style="font-size: 12px"><?php echo $texto_item ?></span> <span class="valor-item <?php echo $ocultar_valor ?>">(R$ <?php echo $valor_item_gradeF ?>) </span> <?php if ($limite_item > 0) {
                                                                                                                                                                                                        echo ' <span style="font-size:11px; color:red">(até ' . $limite_item . ' itens!)</span>';
                                                                                                                                                                                                    } ?>
                                <?php if ($tipo_item == '1 de Cada') { ?>
                                    <span class="form-switch direita">
                                        <input class="form-check-input" type="checkbox" id="<?php echo $id_item ?>" onchange="itens('<?php echo $id_item ?>', '<?php echo $id_grade ?>', '<?php echo $valor_item_grade ?>', '<?php echo $tipo_item ?>', '1', '<?php echo $valor_item ?>', '<?php echo $limite ?>' )">
                                    </span>
                                <?php } ?>

                                <?php if ($tipo_item == 'Múltiplo') { ?>
                                    <span class="direita" style="font-size:14px">

                                        <span><button class="minus-adicional" data-id="<?php echo $id_item ?>">-</button></span>
                                        <span> <b><input type="text" class="qtd-adicional" data-id="<?php echo $id_item ?>" data-valor="<?php echo $valor_item_grade ?>" value="0" readonly style="width: 30px; text-align: center;" /></b> </span>
                                        <span><button class="plus-adicional" data-id="<?php echo $id_item ?>">+</button></span>

                                    </span>


                                <?php } ?>


                                <?php if ($tipo_item == 'Único' || $tipo_item == 'Variação') { ?>
                                    <span class="direita">

                                        <input class="form-check-input" type="radio" value="Sim" name="<?php echo $id_grade ?>" id="<?php echo $id_grade ?>" onchange="itens('<?php echo $id_item ?>', '<?php echo $id_grade ?>', '<?php echo $valor_item_grade ?>', '<?php echo $tipo_item ?>', '1', '<?php echo $valor_item ?>' )">

                                    </span>
                                <?php } ?>


                            </li>


                <?php }
                    }
                } ?>


    </div>
<?php




            $valor_total_pedidoF = @number_format($valor_total_do_item, 2, ',', '.');
        } ?>

<!-- Grupo de quantidade moderno -->
<div class="destaque-qtd" style="border:  solid 1px #ababab; border-radius: 10px;">
    <b>QUANTIDADE</b>
    <div class="input-group input-group-sm quantidade-group" style="max-width: 120px; margin: 0 auto;">
        <button class="btn btn-light border rounded-circle btn-quantidade" type="button" onclick="diminuirQuant()" aria-label="Diminuir">
            <i class="bi bi-dash"></i>
        </button>
        <input type="text" class="form-control text-center border-0" id="quant" value="1" readonly style="width: 40px; background: transparent; font-size: 1.1rem; font-weight: 600;">
        <button class="btn btn-light border rounded-circle btn-quantidade" type="button" onclick="aumentarQuant()" aria-label="Aumentar">
            <i class="bi bi-plus"></i>
        </button>
    </div>
</div>

<div class="destaque-qtd" style="border:  solid 1px #ababab; border-radius: 10px;">
    <b>Subtotal</b>
    <span class="direita">
        <input type="hidden" id="valor_total_produto" value="<?php echo $valor_total_do_item ?>">
        <input type="hidden" id="valor_total_input" value="<?php echo $valor_total_do_item ?>">
        <b>R$ <span id="valor_item_quantF"><?php echo $valor_total_pedidoF ?></span></b>
    </span>
</div>

<div class="total">

</div>



<?php

$texto_botao = 'Adicionar ao Carrinho';
$funcao_botao = 'finalizarItem()';


if (@$_SESSION['sessao_usuario'] == "") {
    $sessao = date('Y-m-d-H:i:s-') . rand(0, 1500);
    $_SESSION['sessao_usuario'] = $sessao;
} else {
    $sessao = $_SESSION['sessao_usuario'];
}



if (@$_SESSION['id'] != "") {
    $id_usuario = $_SESSION['id'];
} else {
    $id_usuario = '';
}

$query = $pdo->query("SELECT * FROM carrinho where sessao = '$sessao'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {
    $id_cliente = $res[0]['cliente'];
    $mesa_carrinho = $res[0]['mesa'];
    $nome_cli_pedido = $res[0]['nome_cliente'];


    $query = $pdo->query("SELECT * FROM clientes where id = '$id_cliente'");
    $res = $query->fetchAll(PDO::FETCH_ASSOC);
    if (@count($res) > 0) {
        $nome_cliente = $res[0]['nome'];
        $telefone_cliente = $res[0]['telefone'];
    } else {
        $nome_cliente = $nome_cli_pedido;
        $telefone_cliente = '';
    }
}

$separar_url = explode("_", $url_completa);
$url = $separar_url[0];


$query = $pdo->query("SELECT * FROM produtos where url = '$url'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {
    $nome = $res[0]['nome'];
    $descricao = $res[0]['descricao'];
    $foto = $res[0]['foto'];
    $id_prod = $res[0]['id'];
    $valor = $res[0]['valor_venda'];
    $valorF = number_format($valor, 2, ',', '.');
    $categoria = $res[0]['categoria'];
}

$query = $pdo->query("SELECT * FROM categorias where id = '$categoria'");
$res = $query->fetchAll(PDO::FETCH_ASSOC);
$total_reg = @count($res);
if ($total_reg > 0) {
    $url_cat = $res[0]['url'];
}



if (@$id_mesa == "" and $pedido_balcao == "") {

    if ($status_estabelecimento == "Fechado") {
        echo "<script>window.alert('$texto_fechamento')</script>";
        echo "<script>window.location='index.php'</script>";
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
        echo "<script>window.alert('Estamos Fechados! Não funcionamos Hoje!')</script>";
        echo "<script>window.location='index.php'</script>";
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
                if ($now < $end) {
                } else {
                    echo "<script>window.alert('$texto_fechamento_horario')</script>";
                    echo "<script>window.location='index.php'</script>";
                    exit();
                }
            }
        } else {
            echo "<script>window.alert('$texto_fechamento_horario')</script>";
            echo "<script>window.location='index.php'</script>";
            exit();
        }
    }
}


?>

<hr>





<input type="hidden" id="quantidade" value="1">
<input type="hidden" id="valor_produto_base" value="<?php echo $valor_total_do_item ?>" />


<div class="destaque-qtd" style="border:  solid 1px #ababab; border-radius: 10px;">
    <b>OBSERVAÇÕES</b>
    <div class="form-group mt-3">
        <textarea maxlength="255" class="form-control" type="text" name="obs" id="obs" placeholder="Deseja adicionar alguma Observação?"></textarea>
    </div>
</div>



</div>


<!-- Botão moderno adicionar ao carrinho -->
<div class="d-grid gap-2 col-8 mx-auto mt-4">
    <button onclick="addCarrinho()" class="btn btn-warning btn-lg w-100 shadow-sm btn-modern" style="border-radius: 18px; font-weight: 500; letter-spacing: 0.5px; transition: all 0.2s; text-transform: capitalize;">
        <i class="bi bi-cart-plus me-2"></i>Adicionar ao carrinho
    </button>
</div>

<br>

</body>

</html>


<script type="text/javascript">
    $(document).ready(function() {

    });

    function itens(id, grade, valor, tipo, quantidade, tipagem, limite_grade) {


        var marcado = $("#" + grade).val();
        var qtd_marcada = $("#qt_" + grade).val();
        if (qtd_marcada == "") {
            qtd_marcada = 0;
        }

        if (tipo == '1 de Cada' && limite_grade > 0) {
            if ($('#' + id).is(":checked") == true) {
                qtd_marcada_final = parseFloat(qtd_marcada) + 1;
            } else {
                qtd_marcada_final = parseFloat(qtd_marcada) - 1;
            }

            if (qtd_marcada_final > limite_grade) {
                alert('O limite para essa escolha é de ' + limite_grade + ' Itens!');
                $('#' + id).prop("checked", false);
                return;
            } else {
                $("#qt_" + grade).val(qtd_marcada_final);
            }
        }


        $.ajax({
            url: 'js/ajax/adicionar_item.php',
            method: 'POST',
            data: {
                id,
                grade,
                valor,
                tipo,
                marcado,
                quantidade,
                tipagem
            },
            dataType: "text",

            success: function(mensagem) {
                //alert(mensagem)
                if (mensagem.trim() == "Alterado com Sucesso") {
                    listarItens();
                }

            },

        });
    }




    function listarItens() {


        var id = '<?= $id_prod ?>';

        $.ajax({
            url: 'js/ajax/listar_itens_grade.php',
            method: 'POST',
            data: {
                id
            },
            dataType: "html",

            success: function(result) {
                //alert(result)
                var split = result.split('*');

                $("#valor_total_input").val(split[0]);
                $("#valor_item_quantF").text(split[1]);
                $("#valor_total_produto").val(split[2]);
            }
        });
    }
</script>




<script type="text/javascript">
    $(document).ready(function() {
        // Inicialização
        var quant = $("#quantidade").val();
        $("#quant").text(quant);
        listarCarrinhoIcone();

        // Funções do carrinho
        window.listarCarrinhoIcone = function() {
            $.ajax({
                url: 'js/ajax/listar-itens-carrinho-icone.php',
                method: 'POST',
                data: {},
                dataType: "html",
                success: function(result) {
                    $("#listar-itens-carrinho-icone").html(result);
                },
                error: function(xhr, status, error) {
                    console.error("Erro ao atualizar carrinho:", error);
                }
            });
        };

        window.addCarrinho = function() {
            var quantidade = $('#quantidade').val();
            var total_item = $('#valor_total_input').val();
            var produto = "<?= $id_prod ?>";
            var obs = $('#obs').val();
            var tem_var = "<?= $tem_variação ?>";
            var mesa = "<?= $id_ab_mesa ?>";
            var valor_produto = $('#valor_total_produto').val();

            if (total_item <= 0 && valor_produto <= 0) {
                alert("O valor do Pedido é zero, selecione as opções!");
                return;
            }

            if (valor_produto <= 0 && tem_var == 'Sim') {
                alert("Selecione a Variação do Item");
                return;
            }

            $.ajax({
                url: 'js/ajax/add-carrinho.php',
                method: 'POST',
                data: {
                    quantidade,
                    total_item,
                    produto,
                    obs,
                    valor_produto,
                    mesa
                },
                dataType: "json",
                success: function(response) {
                    if (response.status === 'success') {
                        // Redirecionar para a página do carrinho
                        window.location.href = 'carrinho';
                    } else {
                        alert(response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Erro ao adicionar ao carrinho:", error);
                    alert("Erro ao adicionar ao carrinho. Por favor, tente novamente.");
                }
            });
        };

        // Funções de quantidade
        // Remover completamente as funções abaixo do script inline:
        // window.aumentarQuant = function() { ... }
        // window.diminuirQuant = function() { ... }
    });
</script>
<script src="js/adicionais.js"></script>
</body>

</html>