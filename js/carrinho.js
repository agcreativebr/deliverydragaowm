// Função para excluir item do carrinho
function excluirCarrinho(id) {
  if (!confirm("Deseja realmente excluir este item?")) {
    return;
  }

  // Desabilitar botão excluir
  const deleteBtn = document.querySelector(
    `button[onclick*="excluirCarrinho(${id}"]`
  );
  if (deleteBtn) deleteBtn.disabled = true;

  $.ajax({
    url: "js/ajax/excluir-carrinho.php",
    method: "POST",
    data: { id },
    dataType: "text",
    success: function (mensagem) {
      if (mensagem.trim() == "Excluído com Sucesso") {
        listarCarrinho();
        listarCarrinhoIcone();
      } else {
        alert(mensagem);
        listarCarrinho();
      }
    },
    error: function (xhr, status, error) {
      alert("Erro ao excluir item: " + error);
      listarCarrinho();
    },
    complete: function () {
      // Re-habilitar botão excluir
      if (deleteBtn) deleteBtn.disabled = false;
    },
  });
}

// Função para atualizar quantidade
function atualizarQuantidade(id, quantidade) {
  // Desabilitar botões durante a atualização
  const buttons = document.querySelectorAll(
    `button[onclick*="atualizarQuantidade(${id}"]`
  );
  buttons.forEach((btn) => (btn.disabled = true));

  $.ajax({
    url: "js/ajax/atualizar-quantidade.php",
    method: "POST",
    data: {
      id,
      quantidade,
    },
    dataType: "text",
    success: function (mensagem) {
      if (mensagem.trim() == "Atualizado com Sucesso") {
        listarCarrinho();
        listarCarrinhoIcone();
      } else {
        // Mostrar erro em um toast/alert
        alert(mensagem);
        // Recarregar carrinho para garantir estado consistente
        listarCarrinho();
      }
    },
    error: function (xhr, status, error) {
      alert("Erro ao atualizar quantidade: " + error);
      listarCarrinho();
    },
    complete: function () {
      // Re-habilitar botões
      buttons.forEach((btn) => (btn.disabled = false));
    },
  });
}

// Função para salvar observação
function salvarObservacao(id, obs) {
  // Desabilitar botão salvar
  const saveBtn = document.querySelector("#modalObs .btn-primary");
  if (saveBtn) saveBtn.disabled = true;

  $.ajax({
    url: "js/ajax/salvar-observacao.php",
    method: "POST",
    data: {
      id,
      obs,
    },
    dataType: "text",
    success: function (mensagem) {
      if (mensagem.trim() == "Salvo com Sucesso") {
        listarCarrinho();
        $("#modalObs").modal("hide");
      } else {
        alert(mensagem);
      }
    },
    error: function (xhr, status, error) {
      alert("Erro ao salvar observação: " + error);
    },
    complete: function () {
      // Re-habilitar botão salvar
      if (saveBtn) saveBtn.disabled = false;
    },
  });
}

// Função para listar itens do carrinho
function listarCarrinho() {
  $.ajax({
    url: "js/ajax/listar-itens-carrinho.php",
    method: "POST",
    data: {},
    dataType: "html",
    success: function (result) {
      $("#listar-itens-carrinho").html(result);
    },
    error: function (xhr, status, error) {
      $("#listar-itens-carrinho").html(
        '<div class="alert alert-danger">Erro ao carregar itens: ' +
          error +
          "</div>"
      );
    },
  });
}

// Função para atualizar ícone do carrinho
function listarCarrinhoIcone() {
  $.ajax({
    url: "js/ajax/listar-itens-carrinho-icone.php",
    method: "POST",
    data: {},
    dataType: "html",
    success: function (result) {
      $("#listar-itens-carrinho-icone").html(result);
    },
    error: function (xhr, status, error) {
      console.error("Erro ao atualizar ícone do carrinho:", error);
    },
  });
}

// Inicializar carrinho quando documento estiver pronto
$(document).ready(function () {
  listarCarrinho();
  listarCarrinhoIcone();

  // Prevenir submit do form de observações
  $("#form-obs").on("submit", function (e) {
    e.preventDefault();
    return false;
  });

  // Limpar observação ao fechar modal
  $("#modalObs").on("hidden.bs.modal", function () {
    $("#obs").val("");
    $("#id_obs").val("");
    $("#nome_item").text("");
  });
});
