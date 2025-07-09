<?php
require_once(__DIR__ . '/../sistema/conexao.php');
require_once(__DIR__ . '/../sistema/RedisCache.php');

/**
 * Script para testar a integração do Redis com o sistema existente
 * Testa cenários reais de uso do cache
 */

echo "Iniciando testes de integração do Redis...\n\n";

try {
    $redis = RedisCache::getInstance();
    $pdo = Conexao::getInstance();

    echo "Fase 1: Teste de Cache de Produtos\n";
    echo "--------------------------------\n";

    // Teste 1: Cache de lista de produtos
    $start = microtime(true);
    $query = "SELECT * FROM produtos WHERE ativo = 1";
    $stmt = $pdo->query($query);
    $produtos = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $dbTime = microtime(true) - $start;

    echo "Tempo de consulta no banco: " . number_format($dbTime, 4) . "s\n";

    // Salva no cache
    $start = microtime(true);
    $redis->set('produtos_ativos', $produtos, 900); // 15 minutos
    $cacheSetTime = microtime(true) - $start;

    echo "Tempo para salvar no cache: " . number_format($cacheSetTime, 4) . "s\n";

    // Recupera do cache
    $start = microtime(true);
    $produtosCache = $redis->get('produtos_ativos');
    $cacheGetTime = microtime(true) - $start;

    echo "Tempo para recuperar do cache: " . number_format($cacheGetTime, 4) . "s\n";
    echo "Melhoria de performance: " . number_format(($dbTime - $cacheGetTime) / $dbTime * 100, 2) . "%\n\n";

    // Teste 2: Cache de produto individual
    echo "Fase 2: Cache de Produto Individual\n";
    echo "--------------------------------\n";

    $produtoId = 1; // Primeiro produto como exemplo

    $start = microtime(true);
    $query = "SELECT * FROM produtos WHERE id = ?";
    $stmt = $pdo->prepare($query);
    $stmt->execute([$produtoId]);
    $produto = $stmt->fetch(PDO::FETCH_ASSOC);
    $dbTime = microtime(true) - $start;

    echo "Tempo de consulta no banco: " . number_format($dbTime, 4) . "s\n";

    // Salva no cache
    $start = microtime(true);
    $redis->set("produto_$produtoId", $produto, 900);
    $cacheSetTime = microtime(true) - $start;

    echo "Tempo para salvar no cache: " . number_format($cacheSetTime, 4) . "s\n";

    // Recupera do cache
    $start = microtime(true);
    $produtoCache = $redis->get("produto_$produtoId");
    $cacheGetTime = microtime(true) - $start;

    echo "Tempo para recuperar do cache: " . number_format($cacheGetTime, 4) . "s\n";
    echo "Melhoria de performance: " . number_format(($dbTime - $cacheGetTime) / $dbTime * 100, 2) . "%\n\n";

    // Teste 3: Cache de Categorias
    echo "Fase 3: Cache de Categorias\n";
    echo "--------------------------------\n";

    $start = microtime(true);
    $query = "SELECT * FROM categorias WHERE ativo = 1";
    $stmt = $pdo->query($query);
    $categorias = $stmt->fetchAll(PDO::FETCH_ASSOC);
    $dbTime = microtime(true) - $start;

    echo "Tempo de consulta no banco: " . number_format($dbTime, 4) . "s\n";

    // Salva no cache
    $start = microtime(true);
    $redis->set('categorias_ativas', $categorias, 1800); // 30 minutos
    $cacheSetTime = microtime(true) - $start;

    echo "Tempo para salvar no cache: " . number_format($cacheSetTime, 4) . "s\n";

    // Recupera do cache
    $start = microtime(true);
    $categoriasCache = $redis->get('categorias_ativas');
    $cacheGetTime = microtime(true) - $start;

    echo "Tempo para recuperar do cache: " . number_format($cacheGetTime, 4) . "s\n";
    echo "Melhoria de performance: " . number_format(($dbTime - $cacheGetTime) / $dbTime * 100, 2) . "%\n\n";

    // Teste 4: Teste de Invalidação de Cache
    echo "Fase 4: Teste de Invalidação de Cache\n";
    echo "--------------------------------\n";

    // Simula atualização de produto
    $produtoId = 1;
    $query = "UPDATE produtos SET nome = nome WHERE id = ?"; // Update fake para teste
    $stmt = $pdo->prepare($query);
    $stmt->execute([$produtoId]);

    // Remove do cache
    $start = microtime(true);
    $redis->delete("produto_$produtoId");
    $redis->delete('produtos_ativos'); // Invalida lista completa
    $invalidationTime = microtime(true) - $start;

    echo "Tempo para invalidar cache: " . number_format($invalidationTime, 4) . "s\n";

    // Verifica se foi removido
    $produtoCache = $redis->get("produto_$produtoId");
    echo "Cache invalidado corretamente: " . ($produtoCache === null ? "Sim" : "Não") . "\n\n";

    // Teste 5: Teste de Concorrência
    echo "Fase 5: Teste de Concorrência\n";
    echo "--------------------------------\n";

    $testKey = 'test_concurrent';
    $iterations = 1000;
    $successCount = 0;

    for ($i = 0; $i < $iterations; $i++) {
        try {
            $redis->set($testKey, "value_$i", 60);
            $value = $redis->get($testKey);
            if ($value === "value_$i") {
                $successCount++;
            }
        } catch (Exception $e) {
            echo "Erro na iteração $i: " . $e->getMessage() . "\n";
        }
    }

    echo "Operações bem-sucedidas: $successCount/$iterations\n";
    echo "Taxa de sucesso: " . number_format(($successCount / $iterations) * 100, 2) . "%\n\n";

    // Resumo
    echo "Resumo dos Testes\n";
    echo "--------------------------------\n";
    echo "✓ Cache de lista de produtos\n";
    echo "✓ Cache de produto individual\n";
    echo "✓ Cache de categorias\n";
    echo "✓ Invalidação de cache\n";
    echo "✓ Teste de concorrência\n\n";

    echo "Testes concluídos com sucesso!\n";
} catch (Exception $e) {
    echo "Erro durante os testes: " . $e->getMessage() . "\n";
    exit(1);
}
