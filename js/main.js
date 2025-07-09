$(document).ready(function () {
  $("div.blog-post").hover(
    function () {
      $(this).find("div.content-hide").slideToggle("fast");
    },
    function () {
      $(this).find("div.content-hide").slideToggle("fast");
    }
  );

  $(".flexslider").flexslider({
    prevText: "",
    nextText: "",
  });

  $(".testimonails-slider").flexslider({
    animation: "slide",
    slideshowSpeed: 5000,
    prevText: "",
    nextText: "",
    controlNav: false,
  });

  $(function () {
    // Instantiate MixItUp:

    $("#Container").mixItUp();

    $(document).ready(function () {
      $(".fancybox").fancybox();
    });
  });
});

function mudarQuant(id, quantidade, acao) {
  if (acao == "menos" && quantidade == 1) {
    excluirCarrinho(id);
  }
  $.ajax({
    url: "js/ajax/mudar-quant-carrinho.php",
    method: "POST",
    data: {
      id,
      quantidade,
      acao,
    },
    dataType: "text",

    success: function (mensagem) {
      if (mensagem.trim() == "Alterado com Sucesso!!") {
        listarCarrinho();
      } else {
        alert(mensagem);
        listarCarrinho();
      }
    },
  });
}

function excluirCarrinho(id) {
  $.ajax({
    url: "js/ajax/excluir-carrinho.php",
    method: "POST",
    data: {
      id,
    },
    dataType: "text",

    success: function (mensagem) {
      if (mensagem.trim() == "Excluído com Sucesso!!") {
        listarCarrinho();
      }
    },
  });
}

function excluir(id) {
  var popup = "popup-excluir" + id;
  document.getElementById(popup).style.display = "block";
}

function fecharExcluir(id) {
  var popup = "popup-excluir" + id;
  document.getElementById(popup).style.display = "none";
}

function obs(nome, obs, id) {
  $("#obs").val("");
  $("#nome_item").text(nome);
  $("#obs").val(obs);
  $("#id_obs").val(id);
  var myModal = new bootstrap.Modal(document.getElementById("modalObs"), {
    //backdrop: 'static',
  });
  myModal.show();
}

function adicionais(nome, id, id_sabor, cat) {
  $("#nome_item_adc").text(nome);
  listarAdicionais(id, id_sabor, cat);

  var myModal = new bootstrap.Modal(document.getElementById("modalAdc"), {
    //backdrop: 'static',
  });
  myModal.show();
}

function listarAdicionais(id, id_sabor, cat) {
  $.ajax({
    url: "js/ajax/listar-adc-carrinho.php",
    method: "POST",
    data: {
      id,
      id_sabor,
      cat,
    },
    dataType: "html",

    success: function (result) {
      $("#listar-adc-carrinho").html(result);
    },
  });
}

function grades(nome, id, produto) {
  $("#nome_item_grade").text(nome);
  listarGrades(id, produto);

  var myModal = new bootstrap.Modal(document.getElementById("modalGrades"), {
    //backdrop: 'static',
  });
  myModal.show();
}

function listarGrades(id, produto) {
  $.ajax({
    url: "js/ajax/listar-grades-carrinho.php",
    method: "POST",
    data: {
      id,
      produto,
    },
    dataType: "html",

    success: function (result) {
      $("#listar-grade-carrinho").html(result);
    },
  });
}
