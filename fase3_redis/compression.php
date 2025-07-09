<?php
require_once(__DIR__ . '/../sistema/RedisCache.php');

/**
 * Script para implementar e testar compressão de dados no Redis
 * Usa diferentes algoritmos de compressão para otimizar uso de memória
 */

class RedisCompression
{
    private $redis;
    private $algorithms = ['gzip', 'bzip2', 'lzf'];
    private $testData;

    public function __construct()
    {
        $this->redis = RedisCache::getInstance();

        // Gera dados de teste
        $this->testData = [
            'small' => str_repeat('a', 100),
            'medium' => str_repeat('abcdefghij', 1000),
            'large' => str_repeat('abcdefghijklmnopqrstuvwxyz', 10000),
            'json' => json_encode([
                'id' => 1,
                'name' => 'Test Product',
                'description' => str_repeat('Lorem ipsum dolor sit amet ', 100),
                'attributes' => array_fill(0, 100, [
                    'key' => 'value',
                    'number' => 123,
                    'boolean' => true
                ])
            ])
        ];
    }

    /**
     * Comprime dados usando o algoritmo especificado
     */
    private function compress($data, $algorithm)
    {
        switch ($algorithm) {
            case 'gzip':
                return gzencode($data, 9);
            case 'bzip2':
                return bzcompress($data, 9);
            case 'lzf':
                return lzf_compress($data);
            default:
                throw new Exception("Algoritmo não suportado: $algorithm");
        }
    }

    /**
     * Descomprime dados usando o algoritmo especificado
     */
    private function decompress($data, $algorithm)
    {
        switch ($algorithm) {
            case 'gzip':
                return gzdecode($data);
            case 'bzip2':
                return bzdecompress($data);
            case 'lzf':
                return lzf_decompress($data);
            default:
                throw new Exception("Algoritmo não suportado: $algorithm");
        }
    }

    /**
     * Testa compressão com diferentes algoritmos e tamanhos de dados
     */
    public function runTests()
    {
        echo "Iniciando testes de compressão...\n\n";

        foreach ($this->testData as $size => $data) {
            echo "Testando dados de tamanho $size (" . strlen($data) . " bytes)\n";
            echo "----------------------------------------\n";

            // Sem compressão (baseline)
            $start = microtime(true);
            $this->redis->set("test_raw_$size", $data, 3600);
            $setTime = microtime(true) - $start;

            $start = microtime(true);
            $rawData = $this->redis->get("test_raw_$size");
            $getTime = microtime(true) - $start;

            echo "Sem compressão:\n";
            echo "- Tamanho original: " . strlen($data) . " bytes\n";
            echo "- Tempo SET: " . number_format($setTime, 4) . "s\n";
            echo "- Tempo GET: " . number_format($getTime, 4) . "s\n";
            echo "- Integridade: " . ($data === $rawData ? "OK" : "FALHA") . "\n\n";

            // Testa cada algoritmo
            foreach ($this->algorithms as $algorithm) {
                echo "Algoritmo: $algorithm\n";

                // Comprime
                $start = microtime(true);
                $compressed = $this->compress($data, $algorithm);
                $compressTime = microtime(true) - $start;

                // Salva no Redis
                $start = microtime(true);
                $this->redis->set("test_{$algorithm}_{$size}", $compressed, 3600);
                $setTime = microtime(true) - $start;

                // Recupera e descomprime
                $start = microtime(true);
                $compressedData = $this->redis->get("test_{$algorithm}_{$size}");
                $getTime = microtime(true) - $start;

                $start = microtime(true);
                $decompressed = $this->decompress($compressedData, $algorithm);
                $decompressTime = microtime(true) - $start;

                // Resultados
                $compressionRatio = (1 - strlen($compressed) / strlen($data)) * 100;

                echo "- Tamanho comprimido: " . strlen($compressed) . " bytes\n";
                echo "- Taxa de compressão: " . number_format($compressionRatio, 2) . "%\n";
                echo "- Tempo compressão: " . number_format($compressTime, 4) . "s\n";
                echo "- Tempo SET: " . number_format($setTime, 4) . "s\n";
                echo "- Tempo GET: " . number_format($getTime, 4) . "s\n";
                echo "- Tempo descompressão: " . number_format($decompressTime, 4) . "s\n";
                echo "- Tempo total: " . number_format($compressTime + $setTime + $getTime + $decompressTime, 4) . "s\n";
                echo "- Integridade: " . ($data === $decompressed ? "OK" : "FALHA") . "\n\n";
            }

            echo "\n";
        }

        // Limpa dados de teste
        foreach ($this->testData as $size => $data) {
            $this->redis->delete("test_raw_$size");
            foreach ($this->algorithms as $algorithm) {
                $this->redis->delete("test_{$algorithm}_{$size}");
            }
        }
    }

    /**
     * Retorna recomendações baseadas nos resultados dos testes
     */
    public function getRecommendations()
    {
        echo "Recomendações de Uso\n";
        echo "----------------------------------------\n";
        echo "1. Para dados pequenos (< 1KB):\n";
        echo "   - Não usar compressão (overhead não compensa)\n\n";

        echo "2. Para dados médios (1KB - 10KB):\n";
        echo "   - Usar LZF (melhor equilíbrio velocidade/compressão)\n\n";

        echo "3. Para dados grandes (> 10KB):\n";
        echo "   - Usar GZIP para máxima compressão\n";
        echo "   - Usar LZF se performance for crítica\n\n";

        echo "4. Para dados JSON:\n";
        echo "   - Sempre usar compressão (alta redundância)\n";
        echo "   - GZIP oferece melhores resultados\n\n";

        echo "5. Considerações de Memória vs CPU:\n";
        echo "   - GZIP: Maior uso de CPU, melhor compressão\n";
        echo "   - LZF: Menor uso de CPU, compressão moderada\n";
        echo "   - BZIP2: Maior uso de CPU, melhor compressão para textos\n\n";
    }
}

// Executa testes
try {
    $compression = new RedisCompression();
    $compression->runTests();
    $compression->getRecommendations();
} catch (Exception $e) {
    echo "Erro durante os testes: " . $e->getMessage() . "\n";
    exit(1);
}
