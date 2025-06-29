<?php
require_once(__DIR__ . '/../sistema/conexao.php');

try {
    // Array com todos os índices a serem criados
    $indices = [
        // Índices para vendas
        "CREATE INDEX IF NOT EXISTS idx_vendas_status_data ON vendas(status, data)",
        "CREATE INDEX IF NOT EXISTS idx_vendas_cliente ON vendas(cliente)",
        "CREATE INDEX IF NOT EXISTS idx_vendas_usuario_baixa ON vendas(usuario_baixa)",

        // Índices para produtos
        "CREATE INDEX IF NOT EXISTS idx_produtos_categoria_ativo ON produtos(categoria, ativo)",
        "CREATE INDEX IF NOT EXISTS idx_produtos_nome ON produtos(nome)",

        // Índices para carrinho
        "CREATE INDEX IF NOT EXISTS idx_carrinho_sessao_pedido ON carrinho(sessao, pedido)",
        "CREATE INDEX IF NOT EXISTS idx_carrinho_produto ON carrinho(produto)",

        // Índices para variações
        "CREATE INDEX IF NOT EXISTS idx_variacoes_produto ON variacoes(produto)",

        // Índices para clientes
        "CREATE INDEX IF NOT EXISTS idx_clientes_nome ON clientes(nome)",
        "CREATE INDEX IF NOT EXISTS idx_clientes_telefone ON clientes(telefone)",

        // Índices para usuários
        "CREATE INDEX IF NOT EXISTS idx_usuarios_nivel ON usuarios(nivel)",
        "CREATE INDEX IF NOT EXISTS idx_usuarios_email ON usuarios(email)"
    ];

    // Contador de índices criados
    $indices_criados = 0;

    // Cria cada índice
    foreach ($indices as $sql) {
        try {
            $pdo->exec($sql);
            $indices_criados++;
            echo "Índice criado com sucesso: " . $sql . "\n";
        } catch (PDOException $e) {
            // Se o índice já existe, apenas ignora
            if ($e->getCode() != '42000') {
                throw $e;
            }
            echo "Índice já existe: " . $sql . "\n";
        }
    }

    echo "\nTotal de índices processados: " . count($indices) . "\n";
    echo "Novos índices criados: " . $indices_criados . "\n";

    // Otimiza as tabelas
    $pdo->exec("OPTIMIZE TABLE vendas, produtos, carrinho, variacoes, clientes, usuarios");
    echo "\nTabelas otimizadas com sucesso!\n";
} catch (PDOException $e) {
    echo "Erro ao criar índices: " . $e->getMessage() . "\n";
    exit(1);
}
