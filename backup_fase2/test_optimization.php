<?php
require_once(__DIR__ . '/../sistema/conexao.php');
require_once(__DIR__ . '/../sistema/QueryOptimizer.php');

// Inicializa o otimizador
$optimizer = new QueryOptimizer($pdo);

try {
    echo "Iniciando testes de otimização...\n\n";

    // Teste 1: Listagem de Pedidos
    echo "Teste 1: Listagem de Pedidos\n";
    echo "--------------------------------\n";

    // Antes - Query N+1
    $inicio = microtime(true);
    $query = $pdo->query("SELECT * FROM vendas WHERE status = 'Aguardando' LIMIT 10");
    $pedidos = $query->fetchAll(PDO::FETCH_ASSOC);
    foreach ($pedidos as $pedido) {
        $query2 = $pdo->query("SELECT * FROM clientes WHERE id = '{$pedido['cliente']}'");
        $query3 = $pdo->query("SELECT * FROM usuarios WHERE id = '{$pedido['usuario_baixa']}'");
    }
    $tempo_antes = microtime(true) - $inicio;

    // Depois - Query Otimizada
    $inicio = microtime(true);
    $pedidos_otimizado = $optimizer->listarPedidosOtimizado('Aguardando', 10);
    $tempo_depois = microtime(true) - $inicio;

    echo "Tempo antes: " . number_format($tempo_antes, 4) . " segundos\n";
    echo "Tempo depois: " . number_format($tempo_depois, 4) . " segundos\n";
    echo "Melhoria: " . number_format((($tempo_antes - $tempo_depois) / $tempo_antes) * 100, 2) . "%\n\n";

    // Teste 2: Listagem de Produtos com Variações
    echo "Teste 2: Produtos com Variações\n";
    echo "--------------------------------\n";

    // Antes - Query N+1
    $inicio = microtime(true);
    $query = $pdo->query("SELECT * FROM produtos LIMIT 10");
    $produtos = $query->fetchAll(PDO::FETCH_ASSOC);
    foreach ($produtos as $produto) {
        $query2 = $pdo->query("SELECT * FROM variacoes WHERE produto = '{$produto['id']}'");
        $query3 = $pdo->query("SELECT * FROM categorias WHERE id = '{$produto['categoria']}'");
    }
    $tempo_antes = microtime(true) - $inicio;

    // Depois - Query Otimizada
    $inicio = microtime(true);
    $produtos_otimizado = $optimizer->listarProdutosComVariacoes();
    $tempo_depois = microtime(true) - $inicio;

    echo "Tempo antes: " . number_format($tempo_antes, 4) . " segundos\n";
    echo "Tempo depois: " . number_format($tempo_depois, 4) . " segundos\n";
    echo "Melhoria: " . number_format((($tempo_antes - $tempo_depois) / $tempo_antes) * 100, 2) . "%\n\n";

    // Teste 3: Cache
    echo "Teste 3: Sistema de Cache\n";
    echo "--------------------------------\n";

    // Primeira execução (sem cache)
    $inicio = microtime(true);
    $produtos_cache = $optimizer->listarProdutosComVariacoes();
    $tempo_sem_cache = microtime(true) - $inicio;

    // Segunda execução (com cache)
    $inicio = microtime(true);
    $produtos_cache = $optimizer->listarProdutosComVariacoes();
    $tempo_com_cache = microtime(true) - $inicio;

    echo "Tempo sem cache: " . number_format($tempo_sem_cache, 4) . " segundos\n";
    echo "Tempo com cache: " . number_format($tempo_com_cache, 4) . " segundos\n";
    echo "Melhoria: " . number_format((($tempo_sem_cache - $tempo_com_cache) / $tempo_sem_cache) * 100, 2) . "%\n\n";

    echo "Testes concluídos com sucesso!\n";
} catch (Exception $e) {
    echo "Erro durante os testes: " . $e->getMessage() . "\n";
    exit(1);
}
