// Carregar adicionais ao abrir o modal
function carregarAdicionais(produto_id) {
  $.ajax({
    url: "js/ajax/listar-adicionais.php",
    method: "POST",
    data: { produto: produto_id },
    success: function (response) {
      $("#lista-adicionais").html(response);
    },
    error: function (xhr, status, error) {
      console.error("Erro ao carregar adicionais:", error);
    },
  });
}

// Atualizar quantidade de adicional
function atualizarAdicional(adicional_id, quantidade) {
  $.ajax({
    url: "js/ajax/atualizar-adicional.php",
    method: "POST",
    data: {
      adicional: adicional_id,
      quantidade: quantidade,
    },
    success: function (response) {
      try {
        const data = JSON.parse(response);
        if (data.erro) {
          console.error("Erro ao atualizar adicional:", data.erro);
        }
      } catch (e) {
        console.error("Erro ao processar resposta:", e);
      }
    },
    error: function (xhr, status, error) {
      console.error("Erro na requisição:", error);
    },
  });
}

function atualizarSubtotalAdicionais() {
  const valorProdutoBase = parseFloat($("#valor_produto_base").val()) || 0;
  const quantidadeProduto = parseInt($("#quantidade").val()) || 1;
  const totalProduto = valorProdutoBase * quantidadeProduto;

  let totalAdicionais = 0;
  $(".qtd-adicional").each(function () {
    const quantidadeAdicional = parseInt($(this).val()) || 0;
    const valorAdicional = parseFloat($(this).data("valor")) || 0;
    totalAdicionais += quantidadeAdicional * valorAdicional;
  });

  const subtotal = totalProduto + totalAdicionais;
  $("#subtotal-adicionais").text("R$ " + subtotal.toFixed(2).replace(".", ","));
  $("#valor_item_quantF").text(subtotal.toFixed(2).replace(".", ","));
  console.log("Subtotal atualizado:", subtotal);
}

window.aumentarQuant = function () {
  var quant = $("#quantidade").val();
  var novo_valor = parseInt(quant) + 1;
  $("#quant").text(novo_valor);
  $("#quantidade").val(novo_valor);
  atualizarSubtotalAdicionais();
};

window.diminuirQuant = function () {
  var quant = $("#quantidade").val();
  if (quant > 1) {
    var novo_valor = parseInt(quant) - 1;
    $("#quant").text(novo_valor);
    $("#quantidade").val(novo_valor);
    atualizarSubtotalAdicionais();
  }
};

// Event listeners
$(document).ready(function () {
  // Checkbox de adicional
  $(document).on("change", ".adicional-check", function () {
    const id = $(this).val();
    const checked = $(this).prop("checked");
    const input = $(`.qtd-adicional[data-id="${id}"]`);

    if (checked && input.val() == "0") {
      input.val("1");
      atualizarAdicional(id, 1);
    } else if (!checked) {
      input.val("0");
      atualizarAdicional(id, 0);
    }
  });

  // Botões de + e -
  $(document).on("click", ".minus-adicional", function () {
    const id = $(this).data("id");
    const input = $(`.qtd-adicional[data-id='${id}']`);
    const checkbox = $(`#adicional_${id}`);
    let valor = parseInt(input.val()) || 0;

    if (valor > 0) {
      valor--;
      input.val(valor);
      checkbox.prop("checked", valor > 0);
      atualizarAdicional(id, valor);
      atualizarSubtotalAdicionais();
    }
  });

  $(document).on("click", ".plus-adicional", function () {
    const id = $(this).data("id");
    const input = $(`.qtd-adicional[data-id='${id}']`);
    const checkbox = $(`#adicional_${id}`);
    let valor = parseInt(input.val()) || 0;

    if (valor < 10) {
      valor++;
      input.val(valor);
      checkbox.prop("checked", true);
      atualizarAdicional(id, valor);
      atualizarSubtotalAdicionais();
    }
  });

  // Input de quantidade
  $(document).on("change", ".qtd-adicional", function () {
    const id = $(this).data("id");
    const checkbox = $(`#adicional_${id}`);
    let valor = parseInt($(this).val()) || 0;

    if (valor < 0) valor = 0;
    if (valor > 10) valor = 10;

    $(this).val(valor);
    checkbox.prop("checked", valor > 0);
    atualizarAdicional(id, valor);
  });

  // Atualizar subtotal ao mudar a quantidade do produto
  $(document).on(
    "click change",
    "#quantidade, #quant, .plus-adicional, .minus-adicional, .qtd-adicional",
    function () {
      setTimeout(atualizarSubtotalAdicionais, 50);
    }
  );

  // Forçar atualização ao carregar a página
  atualizarSubtotalAdicionais();
});
