<?php

/**
 * Script para visualizar métricas do Redis
 * Gera um relatório HTML com gráficos usando Chart.js
 */

// Obtém arquivos de métricas das últimas 24h
$metricsDir = __DIR__ . '/metrics';
$files = glob($metricsDir . '/redis_*.json');
$yesterday = time() - (24 * 60 * 60);

$files = array_filter($files, function ($file) use ($yesterday) {
    return filemtime($file) >= $yesterday;
});

sort($files);

// Processa dados
$data = [
    'labels' => [],
    'memory' => [
        'used' => [],
        'peak' => [],
        'fragmentation' => []
    ],
    'performance' => [
        'ops_per_sec' => [],
        'hit_rate' => []
    ],
    'connections' => [
        'connected' => [],
        'blocked' => [],
        'rejected' => []
    ]
];

$alerts = [];

foreach ($files as $file) {
    $metrics = json_decode(file_get_contents($file), true);

    // Formata timestamp
    $timestamp = date('H:i', $metrics['timestamp']);
    $data['labels'][] = $timestamp;

    // Memória
    $data['memory']['used'][] = round($metrics['memory']['used'] / 1024 / 1024, 2); // MB
    $data['memory']['peak'][] = round($metrics['memory']['peak'] / 1024 / 1024, 2); // MB
    $data['memory']['fragmentation'][] = round($metrics['memory']['fragmentation'], 2);

    // Performance
    $data['performance']['ops_per_sec'][] = $metrics['performance']['ops_per_sec'];
    $data['performance']['hit_rate'][] = round($metrics['performance']['hit_rate'], 2);

    // Conexões
    $data['connections']['connected'][] = $metrics['connections']['connected'];
    $data['connections']['blocked'][] = $metrics['connections']['blocked'];
    $data['connections']['rejected'][] = $metrics['connections']['rejected'];

    // Alertas
    if (!empty($metrics['alerts'])) {
        $alerts[] = [
            'time' => $timestamp,
            'alerts' => $metrics['alerts']
        ];
    }
}

// Gera HTML
header('Content-Type: text/html; charset=utf-8');
?>
<!DOCTYPE html>
<html lang="pt-BR">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Métricas Redis - Últimas 24h</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background: #f5f5f5;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        .chart-container {
            background: white;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h1,
        h2 {
            color: #333;
        }

        .alerts {
            background: #fff3cd;
            border: 1px solid #ffeeba;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 20px;
        }

        .alert-item {
            margin-bottom: 10px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ffeeba;
        }

        .alert-time {
            font-weight: bold;
            color: #856404;
        }
    </style>
</head>

<body>
    <div class="container">
        <h1>Métricas Redis - Últimas 24h</h1>

        <?php if (!empty($alerts)): ?>
            <div class="alerts">
                <h2>Alertas</h2>
                <?php foreach ($alerts as $alert): ?>
                    <div class="alert-item">
                        <span class="alert-time"><?php echo $alert['time']; ?></span>
                        <ul>
                            <?php foreach ($alert['alerts'] as $message): ?>
                                <li><?php echo htmlspecialchars($message); ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <div class="chart-container">
            <h2>Uso de Memória (MB)</h2>
            <canvas id="memoryChart"></canvas>
        </div>

        <div class="chart-container">
            <h2>Performance</h2>
            <canvas id="performanceChart"></canvas>
        </div>

        <div class="chart-container">
            <h2>Conexões</h2>
            <canvas id="connectionsChart"></canvas>
        </div>
    </div>

    <script>
        // Configuração dos gráficos
        const ctx1 = document.getElementById('memoryChart').getContext('2d');
        new Chart(ctx1, {
            type: 'line',
            data: {
                labels: <?php echo json_encode($data['labels']); ?>,
                datasets: [{
                    label: 'Uso Atual',
                    data: <?php echo json_encode($data['memory']['used']); ?>,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }, {
                    label: 'Pico',
                    data: <?php echo json_encode($data['memory']['peak']); ?>,
                    borderColor: 'rgb(255, 99, 132)',
                    tension: 0.1
                }, {
                    label: 'Fragmentação',
                    data: <?php echo json_encode($data['memory']['fragmentation']); ?>,
                    borderColor: 'rgb(153, 102, 255)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        const ctx2 = document.getElementById('performanceChart').getContext('2d');
        new Chart(ctx2, {
            type: 'line',
            data: {
                labels: <?php echo json_encode($data['labels']); ?>,
                datasets: [{
                    label: 'Operações/s',
                    data: <?php echo json_encode($data['performance']['ops_per_sec']); ?>,
                    borderColor: 'rgb(255, 159, 64)',
                    tension: 0.1
                }, {
                    label: 'Hit Rate %',
                    data: <?php echo json_encode($data['performance']['hit_rate']); ?>,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        const ctx3 = document.getElementById('connectionsChart').getContext('2d');
        new Chart(ctx3, {
            type: 'line',
            data: {
                labels: <?php echo json_encode($data['labels']); ?>,
                datasets: [{
                    label: 'Conectados',
                    data: <?php echo json_encode($data['connections']['connected']); ?>,
                    borderColor: 'rgb(75, 192, 192)',
                    tension: 0.1
                }, {
                    label: 'Bloqueados',
                    data: <?php echo json_encode($data['connections']['blocked']); ?>,
                    borderColor: 'rgb(255, 99, 132)',
                    tension: 0.1
                }, {
                    label: 'Rejeitados',
                    data: <?php echo json_encode($data['connections']['rejected']); ?>,
                    borderColor: 'rgb(255, 159, 64)',
                    tension: 0.1
                }]
            },
            options: {
                responsive: true,
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>

</html>