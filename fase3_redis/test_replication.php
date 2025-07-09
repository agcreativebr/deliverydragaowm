<?php
require_once(__DIR__ . '/../sistema/RedisCache.php');

/**
 * Script para testar replicação do Redis
 * Verifica sincronização entre master e slave
 */

class RedisReplication
{
    private $master;
    private $slave;
    private $testData;
    private $testKeys = 1000;

    public function __construct()
    {
        try {
            // Conecta ao master
            $this->master = new Redis();
            $this->master->connect('127.0.0.1', 6379);
            $this->master->select(0); // Database 0 para master

            // Conecta ao slave
            $this->slave = new Redis();
            $this->slave->connect('127.0.0.1', 6380);
            $this->slave->select(0); // Database 0 para slave

            // Gera dados de teste
            $this->generateTestData();
        } catch (Exception $e) {
            throw new Exception("Erro ao conectar aos servidores Redis: " . $e->getMessage());
        }
    }

    /**
     * Gera dados de teste variados
     */
    private function generateTestData()
    {
        $this->testData = [];

        for ($i = 0; $i < $this->testKeys; $i++) {
            $type = $i % 4;

            switch ($type) {
                case 0: // String simples
                    $this->testData["test_string_$i"] = "Valor de teste $i";
                    break;

                case 1: // Array serializado
                    $this->testData["test_array_$i"] = serialize([
                        'id' => $i,
                        'name' => "Item $i",
                        'timestamp' => time()
                    ]);
                    break;

                case 2: // JSON
                    $this->testData["test_json_$i"] = json_encode([
                        'type' => 'test',
                        'index' => $i,
                        'data' => [
                            'field1' => "value1_$i",
                            'field2' => "value2_$i"
                        ]
                    ]);
                    break;

                case 3: // Dados binários
                    $this->testData["test_binary_$i"] = random_bytes(100);
                    break;
            }
        }
    }

    /**
     * Executa testes de replicação
     */
    public function runTests()
    {
        echo "Iniciando testes de replicação...\n\n";

        // Teste 1: Escrita em massa
        echo "Teste 1: Escrita em Massa\n";
        echo "--------------------------------\n";

        $start = microtime(true);
        $written = 0;

        foreach ($this->testData as $key => $value) {
            try {
                $this->master->set($key, $value);
                $written++;
            } catch (Exception $e) {
                echo "Erro ao escrever chave $key: " . $e->getMessage() . "\n";
            }
        }

        $writeTime = microtime(true) - $start;
        echo "Chaves escritas: $written/$this->testKeys\n";
        echo "Tempo total: " . number_format($writeTime, 4) . "s\n";
        echo "Média por operação: " . number_format($writeTime / $written * 1000, 2) . "ms\n\n";

        // Teste 2: Verificação de Replicação
        echo "Teste 2: Verificação de Replicação\n";
        echo "--------------------------------\n";

        // Aguarda replicação
        sleep(1);

        $start = microtime(true);
        $synced = 0;
        $errors = [];

        foreach ($this->testData as $key => $value) {
            try {
                $masterValue = $this->master->get($key);
                $slaveValue = $this->slave->get($key);

                if ($masterValue === $slaveValue) {
                    $synced++;
                } else {
                    $errors[] = "Valor diferente para chave $key";
                }
            } catch (Exception $e) {
                $errors[] = "Erro ao verificar chave $key: " . $e->getMessage();
            }
        }

        $verifyTime = microtime(true) - $start;
        echo "Chaves sincronizadas: $synced/$this->testKeys\n";
        echo "Tempo total: " . number_format($verifyTime, 4) . "s\n";
        echo "Média por operação: " . number_format($verifyTime / $this->testKeys * 1000, 2) . "ms\n";

        if (!empty($errors)) {
            echo "\nErros encontrados:\n";
            foreach ($errors as $error) {
                echo "- $error\n";
            }
        }

        // Teste 3: Teste de Latência
        echo "\nTeste 3: Teste de Latência\n";
        echo "--------------------------------\n";

        $samples = 100;
        $masterLatency = [];
        $slaveLatency = [];

        for ($i = 0; $i < $samples; $i++) {
            $key = array_rand($this->testData);

            // Latência do master
            $start = microtime(true);
            $this->master->get($key);
            $masterLatency[] = (microtime(true) - $start) * 1000;

            // Latência do slave
            $start = microtime(true);
            $this->slave->get($key);
            $slaveLatency[] = (microtime(true) - $start) * 1000;
        }

        // Calcula estatísticas
        sort($masterLatency);
        sort($slaveLatency);

        $masterAvg = array_sum($masterLatency) / $samples;
        $slaveAvg = array_sum($slaveLatency) / $samples;

        $masterMedian = $masterLatency[floor($samples / 2)];
        $slaveMedian = $slaveLatency[floor($samples / 2)];

        $master95th = $masterLatency[floor($samples * 0.95)];
        $slave95th = $slaveLatency[floor($samples * 0.95)];

        echo "Master:\n";
        echo "- Média: " . number_format($masterAvg, 2) . "ms\n";
        echo "- Mediana: " . number_format($masterMedian, 2) . "ms\n";
        echo "- 95º percentil: " . number_format($master95th, 2) . "ms\n\n";

        echo "Slave:\n";
        echo "- Média: " . number_format($slaveAvg, 2) . "ms\n";
        echo "- Mediana: " . number_format($slaveMedian, 2) . "ms\n";
        echo "- 95º percentil: " . number_format($slave95th, 2) . "ms\n\n";

        // Teste 4: Teste de Failover
        echo "Teste 4: Simulação de Failover\n";
        echo "--------------------------------\n";

        try {
            // Simula queda do master
            $this->master->close();
            echo "Master desconectado\n";

            // Tenta algumas operações no slave
            $start = microtime(true);
            $readCount = 0;

            for ($i = 0; $i < 100; $i++) {
                $key = array_rand($this->testData);
                if ($this->slave->get($key) !== false) {
                    $readCount++;
                }
            }

            $failoverTime = microtime(true) - $start;
            echo "Leituras bem-sucedidas durante failover: $readCount/100\n";
            echo "Tempo total: " . number_format($failoverTime, 4) . "s\n\n";
        } catch (Exception $e) {
            echo "Erro durante teste de failover: " . $e->getMessage() . "\n";
        }

        // Limpa dados de teste
        echo "Limpando dados de teste...\n";
        foreach (array_keys($this->testData) as $key) {
            try {
                $this->slave->del($key);
            } catch (Exception $e) {
                // Ignora erros de limpeza
            }
        }
    }
}

// Executa testes
try {
    $replication = new RedisReplication();
    $replication->runTests();
    echo "\nTestes de replicação concluídos com sucesso!\n";
} catch (Exception $e) {
    echo "Erro durante os testes: " . $e->getMessage() . "\n";
    exit(1);
}
