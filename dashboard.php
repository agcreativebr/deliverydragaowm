<?php
@session_start();
require_once("cabecalho.php");
require_once("js/ajax/ApiConfig.php");

$sessao = @$_SESSION['sessao_usuario'];
$id_usuario = @$_SESSION['id'];

// A conexão PDO $pdo é esperada de cabecalho.php (via sistema/conexao.php)

// Função para obter os pedidos mais vendidos
function getTopSellingOrders($pdo_connection, $timeframe) {
    // Consulta ajustada para usar as tabelas 'carrinho', 'produtos', 'vendas'
    // e considerar apenas itens de pedidos pagos.
    $sql = "SELECT p.nome AS produto, SUM(c.quantidade) AS total_vendido
            FROM carrinho c
            JOIN produtos p ON c.produto = p.id
            JOIN vendas v ON c.pedido = v.id
            WHERE v.pago = 'Sim' AND c.pedido != 0"; // Itens de pedidos pagos e finalizados

    if ($timeframe === 'semana') {
        $sql .= " AND v.data >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
    } elseif ($timeframe === 'mes') {
        $sql .= " AND v.data >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)";
    }

    $sql .= " GROUP BY p.nome
             ORDER BY total_vendido DESC
             LIMIT 5"; // Limite para os 5 mais vendidos

    try {
        $stmt = $pdo_connection->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        // Em um ambiente de produção, você pode querer logar o erro em vez de exibi-lo.
        // echo "Erro ao buscar produtos mais vendidos: " . $e->getMessage();
        error_log("Erro em getTopSellingOrders: " . $e->getMessage());
        return []; // Retorna array vazio em caso de erro
    }
}

// Usar a variável $pdo da conexão estabelecida em cabecalho.php
$top_selling_week = getTopSellingOrders($pdo, 'semana');
$top_selling_month = getTopSellingOrders($pdo, 'mes');

// Não é necessário $conn->close() ou $pdo = null; aqui,
// pois a conexão PDO geralmente é fechada automaticamente no final do script.
?>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - <?php echo htmlspecialchars($nome_sistema); ?></title>
    <!-- Bootstrap CSS (já incluído via cabecalho.php, mas bom ter aqui para clareza se este arquivo for usado isoladamente) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- FontAwesome para ícones (opcional, mas bom para dashboards) -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <!-- Chart.js CDN -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Estilos para um visual moderno */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa; /* Cor de fundo mais suave */
            color: #343a40;
            margin: 0;
            display: flex;
            min-height: 100vh;
        }
        .sidebar {
            width: 260px;
            background-color: #343a40; /* Cor escura para sidebar */
            color: white;
            padding: 20px;
            height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            transition: width 0.3s ease;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
        }
        .sidebar-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .sidebar-header h1 {
            font-size: 1.6em;
            margin: 0;
            color: #f8f9fa;
        }
        .sidebar nav ul {
            list-style: none;
            padding: 0;
        }
        .sidebar nav ul li a {
            color: #adb5bd; /* Cor mais suave para links */
            text-decoration: none;
            display: flex; /* Para alinhar ícone e texto */
            align-items: center;
            padding: 12px 15px;
            border-radius: 5px;
            margin-bottom: 8px;
            transition: background-color 0.3s ease, color 0.3s ease, padding-left 0.3s ease;
        }
        .sidebar nav ul li a .nav-icon {
            margin-right: 10px;
            width: 20px; /* Largura fixa para o ícone */
            text-align: center;
        }
        .sidebar nav ul li a:hover,
        .sidebar nav ul li a.active {
            background-color: #495057; /* Cor de hover/ativo */
            color: #fff;
            padding-left: 20px;
        }
        .main-content {
            margin-left: 260px; /* Mesma largura do sidebar */
            padding: 25px;
            width: calc(100% - 260px);
            transition: margin-left 0.3s ease, width 0.3s ease;
            overflow-y: auto; /* Para conteúdo que exceda a altura */
        }
        .header-main {
            background-color: #fff;
            padding: 15px 25px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .header-main h2 {
            margin: 0;
            color: #343a40;
            font-size: 1.8em;
        }
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 25px;
        }
        .card {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-left: 4px solid #007bff; /* Borda colorida */
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.08);
        }
        .card h3 {
            margin-top: 0;
            color: #495057;
            font-size: 1.1em;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .card .stat-value {
            font-size: 2em;
            font-weight: 700;
            color: #007bff;
        }
         .card.green-border { border-left-color: #28a745; }
        .card.green-border .stat-value { color: #28a745; }
        .card.orange-border { border-left-color: #fd7e14; }
        .card.orange-border .stat-value { color: #fd7e14; }

        .chart-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.03);
            margin-bottom: 20px;
        }
        .chart-container h3 {
             margin-top: 0;
            color: #495057;
            font-size: 1.2em;
            margin-bottom: 15px;
            font-weight: 600;
        }
        .chart-container canvas {
            width: 100% !important;
            height: 320px !important; /* Ajuste conforme necessário */
        }

        /* Animação de entrada suave */
        .card, .chart-container {
            opacity: 0;
            transform: translateY(20px);
            animation: fadeInSlideUp 0.6s cubic-bezier(0.25, 0.46, 0.45, 0.94) forwards;
        }

        @keyframes fadeInSlideUp {
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Delay para animação escalonada */
        .stats-cards .card:nth-child(1) { animation-delay: 0.1s; }
        .stats-cards .card:nth-child(2) { animation-delay: 0.2s; }
        .stats-cards .card:nth-child(3) { animation-delay: 0.3s; }
        .row > div:nth-child(1) .chart-container { animation-delay: 0.4s; }
        .row > div:nth-child(2) .chart-container { animation-delay: 0.5s; }

        /* Responsividade */
        @media (max-width: 992px) {
            .sidebar {
                width: 70px; /* Sidebar recolhida */
            }
            .sidebar-header h1, .sidebar nav ul li a span:not(.nav-icon) {
                display: none; /* Esconde texto, mantém ícones */
            }
             .sidebar nav ul li a {
                justify-content: center; /* Centraliza ícone */
            }
            .sidebar nav ul li a .nav-icon {
                margin-right: 0;
            }
            .main-content {
                margin-left: 70px;
                width: calc(100% - 70px);
            }
        }
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
                box-shadow: none;
                display: flex; /* Para menu horizontal mobile */
                justify-content: space-around; /* Distribui os itens */
                padding: 10px 0;
            }
            .sidebar-header { display: none; } /* Esconde header da sidebar no mobile */
            .sidebar nav ul { display: flex; width: 100%; justify-content: space-around; }
            .sidebar nav ul li { margin-bottom: 0; }
            .sidebar nav ul li a { padding: 10px; }
            .sidebar nav ul li a .nav-icon { font-size: 1.2em; } /* Ícones maiores */
            .main-content {
                margin-left: 0;
                width: 100%;
                padding: 15px;
            }
            .header-main {
                flex-direction: column;
                align-items: flex-start;
            }
            .header-main h2 { font-size: 1.5em; margin-bottom: 10px; }
            .stats-cards {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <aside class="sidebar">
        <div class="sidebar-header">
            <h1><?php echo htmlspecialchars($nome_sistema); ?></h1>
        </div>
        <nav>
            <ul>
                <li><a href="dashboard.php" class="active"><i class="fas fa-tachometer-alt nav-icon"></i> <span>Dashboard</span></a></li>
                <li><a href="pedidos.php"><i class="fas fa-box-open nav-icon"></i> <span>Pedidos</span></a></li>
                <li><a href="produtos.php"><i class="fas fa-hamburger nav-icon"></i> <span>Produtos</span></a></li>
                <li><a href="clientes.php"><i class="fas fa-users nav-icon"></i> <span>Clientes</span></a></li>
                <li><a href="configuracoes.php"><i class="fas fa-cog nav-icon"></i> <span>Configurações</span></a></li>
                <li><a href="logout.php"><i class="fas fa-sign-out-alt nav-icon"></i> <span>Sair</span></a></li>
            </ul>
        </nav>
    </aside>

    <div class="main-content">
        <header class="header-main">
            <h2>Visão Geral do Delivery</h2>
            <div>
                <span class="text-muted">Olá, <?php echo isset($_SESSION['nome_usuario']) ? htmlspecialchars($_SESSION['nome_usuario']) : 'Admin'; // Supondo que o nome do usuário esteja na sessão ?></span>
            </div>
        </header>

        <section class="stats-cards">
            <div class="card">
                <h3>Total de Pedidos (Hoje)</h3>
                <p class="stat-value">
                    <?php
                        // Exemplo: buscar total de pedidos do dia
                        // $query_pedidos_hoje = $pdo->query("SELECT COUNT(id) as total FROM vendas WHERE data = CURDATE()");
                        // $total_pedidos_hoje = $query_pedidos_hoje->fetchColumn();
                        // echo $total_pedidos_hoje ?: 0;
                        echo "23"; // Placeholder
                    ?>
                </p>
            </div>
            <div class="card green-border">
                <h3>Receita (Hoje)</h3>
                <p class="stat-value">
                     <?php
                        // Exemplo: buscar receita do dia
                        // $query_receita_hoje = $pdo->query("SELECT SUM(valor) as receita FROM vendas WHERE data = CURDATE() AND pago = 'Sim'");
                        // $receita_hoje = $query_receita_hoje->fetchColumn();
                        // echo "R$ " . number_format($receita_hoje ?: 0, 2, ',', '.');
                        echo "R$ 450,80"; // Placeholder
                    ?>
                </p>
            </div>
            <div class="card orange-border">
                <h3>Ticket Médio (Hoje)</h3>
                <p class="stat-value">
                     <?php
                        // Exemplo: calcular ticket médio
                        // $total_pedidos = $total_pedidos_hoje ?: 1; // Evitar divisão por zero
                        // $ticket_medio = ($receita_hoje ?: 0) / $total_pedidos;
                        // echo "R$ " . number_format($ticket_medio, 2, ',', '.');
                         echo "R$ 19,60"; // Placeholder
                    ?>
                </p>
            </div>
        </section>

        <div class="row">
            <div class="col-lg-6 mb-4">
                <div class="chart-container">
                    <h3><i class="fas fa-chart-bar"></i> Produtos Mais Vendidos (Semana)</h3>
                    <canvas id="topSellingWeekChart"></canvas>
                </div>
            </div>
            <div class="col-lg-6 mb-4">
                <div class="chart-container">
                    <h3><i class="fas fa-chart-pie"></i> Produtos Mais Vendidos (Mês)</h3>
                    <canvas id="topSellingMonthChart"></canvas>
                </div>
            </div>
        </div>
         <!-- Adicione mais seções para outros dados do dashboard aqui -->
    </div>

    <script>
        // Passar dados PHP para JavaScript
        const topSellingWeekData = <?php echo json_encode($top_selling_week); ?>;
        const topSellingMonthData = <?php echo json_encode($top_selling_month); ?>;

        // Função para criar gráficos
        function createChart(canvasId, chartType, label, data, labels, backgroundColors, borderColors) {
            const ctx = document.getElementById(canvasId).getContext('2d');
            new Chart(ctx, {
                type: chartType, // 'bar', 'line', 'pie', etc.
                data: {
                    labels: labels,
                    datasets: [{
                        label: label,
                        data: data,
                        backgroundColor: backgroundColors,
                        borderColor: borderColors,
                        borderWidth: 1,
                        hoverOffset: chartType === 'pie' ? 4 : 0 // Efeito de hover para gráficos de pizza
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: {
                        duration: 1200,
                        easing: 'easeInOutQuart'
                    },
                    scales: chartType === 'bar' || chartType === 'line' ? { // Só adiciona escalas para bar/line
                        y: {
                            beginAtZero: true,
                            ticks: { color: '#555', font: { size: 10 } },
                            grid: { color: '#e9ecef' }
                        },
                        x: {
                             ticks: { color: '#555', font: { size: 10 } },
                            grid: { display: false }
                        }
                    } : {},
                    plugins: {
                        legend: {
                            display: true,
                            position: chartType === 'pie' ? 'bottom' : 'top',
                            labels: { color: '#333', font: { size: 12 } }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0,0,0,0.8)',
                            titleColor: '#fff',
                            bodyColor: '#fff',
                            titleFont: { size: 14 },
                            bodyFont: { size: 12 },
                            padding: 10,
                            callbacks: {
                                label: function(context) {
                                    let label = context.dataset.label || context.label || '';
                                    if (label) {
                                        label += ': ';
                                    }
                                    if (context.parsed.y !== null && chartType !== 'pie') {
                                        label += context.parsed.y + ' unidades';
                                    } else if (context.parsed !== null && chartType === 'pie') {
                                         label += context.parsed + ' unidades';
                                    }
                                    return label;
                                }
                            }
                        }
                    }
                }
            });
        }

        // Paleta de cores moderna e acessível
        const modernColors = [
            'rgba(0, 123, 255, 0.7)',  // Primary Blue
            'rgba(40, 167, 69, 0.7)',  // Success Green
            'rgba(253, 126, 20, 0.7)', // Warning Orange
            'rgba(220, 53, 69, 0.7)',  // Danger Red
            'rgba(23, 162, 184, 0.7)'  // Info Cyan
        ];
        const modernBorderColors = modernColors.map(color => color.replace('0.7', '1'));

        // Preparar dados para o gráfico da semana (Gráfico de Barras)
        if (topSellingWeekData.length > 0) {
            const weekLabels = topSellingWeekData.map(item => item.produto);
            const weekData = topSellingWeekData.map(item => item.total_vendido);
            createChart('topSellingWeekChart', 'bar', 'Unidades Vendidas', weekData, weekLabels, modernColors, modernBorderColors);
        } else {
            document.getElementById('topSellingWeekChart').parentElement.innerHTML += '<p class="text-center text-muted mt-3">Sem dados para exibir no gráfico da semana.</p>';
        }

        // Preparar dados para o gráfico do mês (Gráfico de Pizza/Donut para variar)
        if (topSellingMonthData.length > 0) {
            const monthLabels = topSellingMonthData.map(item => item.produto);
            const monthData = topSellingMonthData.map(item => item.total_vendido);
            // Usando uma fatia diferente das cores para o gráfico de pizza
            createChart('topSellingMonthChart', 'pie', 'Unidades Vendidas', monthData, monthLabels, modernColors.slice().reverse(), modernBorderColors.slice().reverse());
        } else {
             document.getElementById('topSellingMonthChart').parentElement.innerHTML += '<p class="text-center text-muted mt-3">Sem dados para exibir no gráfico do mês.</p>';
        }

    </script>
    <!-- Bootstrap JS (já incluído via cabecalho.php, mas bom ter aqui para clareza) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
