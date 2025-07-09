<?php
require_once("../../../conexao.php");
$tabela = 'vendas';

header('Content-Type: application/json');

if (!isset($_POST['ids']) || !is_array($_POST['ids']) || count($_POST['ids']) == 0) {
    echo json_encode(['sucesso' => false, 'mensagem' => 'Nenhum pedido selecionado.']);
    exit;
}

$ids = $_POST['ids'];
$sucesso = true;
$erros = [];

try {
    $pdo->beginTransaction();
    foreach ($ids as $id) {
        $id = filter_var($id, FILTER_SANITIZE_NUMBER_INT);
        // Remover os itens da venda do estoque
        $query = $pdo->prepare("SELECT * FROM carrinho WHERE pedido = :id");
        $query->bindParam(':id', $id, PDO::PARAM_INT);
        $query->execute();
        $res = $query->fetchAll(PDO::FETCH_ASSOC);
        foreach ($res as $item) {
            $id_produto = $item['produto'];
            $quantidade = $item['quantidade'];
            $query2 = $pdo->prepare("SELECT * FROM produtos WHERE id = :id_produto");
            $query2->bindParam(':id_produto', $id_produto, PDO::PARAM_INT);
            $query2->execute();
            $res2 = $query2->fetchAll(PDO::FETCH_ASSOC);
            if (count($res2) > 0) {
                $estoque = $res2[0]['estoque'];
                $tem_estoque = $res2[0]['tem_estoque'];
                if ($tem_estoque == 'Sim') {
                    $novo_estoque = $estoque + $quantidade;
                    $query3 = $pdo->prepare("UPDATE produtos SET estoque = :novo_estoque WHERE id = :id_produto");
                    $query3->bindParam(':novo_estoque', $novo_estoque, PDO::PARAM_INT);
                    $query3->bindParam(':id_produto', $id_produto, PDO::PARAM_INT);
                    $query3->execute();
                }
            }
        }
        // Excluir o pedido
        $query4 = $pdo->prepare("DELETE FROM $tabela WHERE id = :id");
        $query4->bindParam(':id', $id, PDO::PARAM_INT);
        $query4->execute();
        // Excluir os itens do carrinho
        $query5 = $pdo->prepare("DELETE FROM carrinho WHERE pedido = :id");
        $query5->bindParam(':id', $id, PDO::PARAM_INT);
        $query5->execute();
    }
    $pdo->commit();
    echo json_encode(['sucesso' => true, 'mensagem' => 'Pedidos excluídos com sucesso!']);
} catch (PDOException $e) {
    $pdo->rollBack();
    echo json_encode(['sucesso' => false, 'mensagem' => 'Erro ao excluir pedidos: ' . $e->getMessage()]);
}
