<?php
header('Content-Type: text/html; charset=UTF-8');
@session_start();

require_once('../../sistema/conexao.php');

if (!isset($_SESSION['sessao_usuario'])) {
    $_SESSION['sessao_usuario'] = uniqid();
}

$sessao = $_SESSION['sessao_usuario'];
$produto = filter_input(INPUT_POST, 'produto', FILTER_VALIDATE_INT);

if (!$produto) {
    echo json_encode(['erro' => 'Produto inválido']);
    exit;
}

try {
    // Buscar adicionais ativos
    $query = $pdo->prepare("SELECT * FROM adicionais WHERE ativo = 'Sim' ORDER BY nome");
    $query->execute();
    $adicionais = $query->fetchAll(PDO::FETCH_ASSOC);

    // Buscar adicionais já selecionados na tabela temp
    $query = $pdo->prepare("SELECT id_item, quantidade FROM temp WHERE sessao = ? AND tabela = 'adicionais' AND carrinho = '0'");
    $query->execute([$sessao]);
    $selecionados = $query->fetchAll(PDO::FETCH_KEY_PAIR);

    $html = '';
    foreach ($adicionais as $adicional) {
        $id = $adicional['id'];
        $nome = $adicional['nome'];
        $valor = number_format($adicional['valor'], 2, ',', '.');
        $quantidade = $selecionados[$id] ?? 0;
        $checked = $quantidade > 0 ? 'checked' : '';

        $html .= <<<HTML
        <div class="row mb-2">
            <div class="col-8">
                <div class="form-check">
                    <input class="form-check-input adicional-check" type="checkbox" value="{$id}" id="adicional_{$id}" {$checked}>
                    <label class="form-check-label" for="adicional_{$id}">
                        {$nome} (R$ {$valor})
                    </label>
                </div>
            </div>
            <div class="col-4">
                <div class="input-group input-group-sm">
                    <button type="button" class="btn btn-outline-secondary btn-sm minus-adicional" data-id="{$id}">-</button>
                    <input type="number" class="form-control form-control-sm text-center qtd-adicional" value="{$quantidade}" min="0" max="10" data-id="{$id}">
                    <button type="button" class="btn btn-outline-secondary btn-sm plus-adicional" data-id="{$id}">+</button>
                </div>
            </div>
        </div>
        HTML;
    }

    echo $html;
} catch (Exception $e) {
    echo json_encode(['erro' => $e->getMessage()]);
}
