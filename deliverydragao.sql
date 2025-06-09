-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 10-Jun-2025 às 01:39
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `deliverydragao`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `abertura_mesa`
--

CREATE TABLE `abertura_mesa` (
  `id` int(11) NOT NULL,
  `mesa` int(11) NOT NULL,
  `total` decimal(8,2) DEFAULT NULL,
  `cliente` varchar(50) DEFAULT NULL,
  `data` date NOT NULL,
  `horario_abertura` time NOT NULL,
  `horario_fechamento` time DEFAULT NULL,
  `garcon` int(11) NOT NULL,
  `status` varchar(30) DEFAULT NULL,
  `obs` varchar(255) DEFAULT NULL,
  `pessoas` int(11) NOT NULL,
  `comissao_garcon` decimal(8,2) DEFAULT NULL,
  `couvert` decimal(8,2) DEFAULT NULL,
  `subtotal` decimal(8,2) DEFAULT NULL,
  `forma_pgto` varchar(35) DEFAULT NULL,
  `valor_adiantado` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `abertura_mesa`
--

INSERT INTO `abertura_mesa` (`id`, `mesa`, `total`, `cliente`, `data`, `horario_abertura`, `horario_fechamento`, `garcon`, `status`, `obs`, `pessoas`, `comissao_garcon`, `couvert`, `subtotal`, `forma_pgto`, `valor_adiantado`) VALUES
(1, 22, 29.99, 'Teste', '2025-02-25', '18:35:46', '18:36:11', 18, 'Fechada', '', 1, 3.00, 6.00, 38.99, '1', 0.00),
(2, 25, 23.99, 'Teste', '2025-02-25', '18:48:22', '18:48:35', 18, 'Fechada', '', 2, 2.40, 12.00, 38.39, '1', 0.00),
(3, 25, 23.00, 'João Mesa 5', '2025-02-25', '19:04:33', '19:04:48', 18, 'Fechada', '', 1, 2.30, 6.00, 31.30, '12', 0.00),
(4, 22, 50.00, 'carla', '2025-04-13', '18:46:58', '18:52:44', 18, 'Fechada', '', 2, 0.00, 0.00, -5.00, '2', 55.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `acessos`
--

CREATE TABLE `acessos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `chave` varchar(50) NOT NULL,
  `grupo` int(11) NOT NULL,
  `pagina` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `acessos`
--

INSERT INTO `acessos` (`id`, `nome`, `chave`, `grupo`, `pagina`) VALUES
(1, 'Home', 'home', 0, 'Sim'),
(2, 'Configurações', 'configuracoes', 0, 'Não'),
(3, 'Usuários', 'usuarios', 1, 'Sim'),
(4, 'Acessos', 'acessos', 2, 'Sim'),
(5, 'Grupos Acesso', 'grupo_acessos', 2, 'Sim'),
(8, 'Funcionários', 'funcionarios', 1, 'Sim'),
(9, 'Fornecedores', 'fornecedores', 1, 'Sim'),
(10, 'Formas de Pagamento', 'formas_pgto', 2, 'Sim'),
(11, 'Cargos', 'cargos', 2, 'Sim'),
(12, 'Frequências', 'frequencias', 2, 'Sim'),
(13, 'Contas à Receber', 'receber', 4, 'Sim'),
(14, 'Contas à Pagar', 'pagar', 4, 'Sim'),
(15, 'Clientes', 'clientes', 1, 'Sim'),
(23, 'Caixas', 'caixas', 7, 'Sim'),
(25, 'Tarefas', 'tarefas', 0, 'Sim'),
(26, 'Lançar Tarefas', 'lancar_tarefas', 0, 'Não'),
(28, 'Bairro / Locais', 'bairros', 2, 'Sim'),
(29, 'Dias Fechado', 'dias', 2, 'Sim'),
(30, 'Banner Rotativo', 'banner_rotativo', 2, 'Sim'),
(31, 'Mesas', 'mesas', 2, 'Sim'),
(32, 'Cupom Desconto', 'cupons', 2, 'Sim'),
(33, 'Formas Pgto', 'formas_pgto', 2, 'Sim'),
(34, 'Adicionais', 'adicionais', 2, 'Sim'),
(35, 'Produtos', 'produtos', 9, 'Sim'),
(36, 'Categorias', 'categorias', 9, 'Sim'),
(37, 'Estoque', 'estoque', 9, 'Sim'),
(38, 'Entradas', 'entradas', 9, 'Sim'),
(39, 'Saídas', 'saidas', 9, 'Sim'),
(40, 'Vendas / Pedidos', 'vendas', 4, 'Sim'),
(41, 'Compras', 'compras', 4, 'Sim'),
(42, 'Rel Produtos', 'rel_produtos', 10, 'Sim'),
(43, 'Rel Vendas / Pedidos', 'rel_vendas', 10, 'Sim'),
(44, 'Rel Financeiro', 'rel_financeiro', 10, 'Sim'),
(45, 'Rel Lucro', 'rel_lucro', 0, 'Sim'),
(46, 'Rel Sintético Desp', 'rel_sintetico_despesas', 10, 'Sim'),
(47, 'Rel Sintético	Recb', 'rel_sintetico_receber', 10, 'Sim'),
(48, 'Rel Balanço Anual', 'rel_balanco', 10, 'Sim'),
(49, 'Pedidos', 'pedidos', 0, 'Sim'),
(50, 'Pedidos Esteira', 'pedidos_esteiras', 0, 'Sim'),
(51, 'Novo Pedido', 'novo_pedido', 0, 'Sim'),
(52, 'Anotações', 'anotacoes', 0, 'Sim'),
(53, 'Pedidos Cozinha', 'pedidos_mesa', 0, 'Sim'),
(54, 'Lista Pedidos Mesas', 'lista_pedidos_mesas', 4, 'Sim'),
(55, 'Pedido Balcão', 'pedido_site', 0, 'Sim'),
(56, 'Minhas Comissões', 'minhas_comissoes', 0, 'Sim'),
(57, 'Lista de Comissões', 'comissoes', 4, 'Sim');

-- --------------------------------------------------------

--
-- Estrutura da tabela `adicionais`
--

CREATE TABLE `adicionais` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `valor` decimal(8,2) DEFAULT NULL,
  `ativo` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `adicionais`
--

INSERT INTO `adicionais` (`id`, `nome`, `valor`, `ativo`) VALUES
(1, 'Bacon', 6.00, 'Sim'),
(15, 'Amendoim', 0.00, 'Sim'),
(16, 'Farinha Lacta', 0.00, 'Sim'),
(17, 'Paçoca', 0.00, 'Sim'),
(18, 'Neston', 0.00, 'Sim'),
(19, 'Ovomaltine', 0.00, 'Sim'),
(20, 'Granola', 0.00, 'Sim'),
(21, 'Castanha', 0.00, 'Sim'),
(22, 'Leite em pó', 0.00, 'Sim'),
(23, 'Gota de Chocolate', 0.00, 'Sim'),
(24, 'Jujuba', 0.00, 'Sim'),
(25, 'Carne de Hambúrguer', 4.00, 'Sim'),
(26, 'Carne de Hambúrguer Picanha', 5.00, 'Sim'),
(27, 'Queijo', 2.00, 'Sim'),
(28, 'Presunto', 2.00, 'Sim'),
(29, 'Carneiro', 6.00, 'Sim'),
(30, 'Camarão', 6.00, 'Sim'),
(31, 'Bacalhau', 6.00, 'Sim'),
(32, 'Outros', 5.00, 'Sim');

-- --------------------------------------------------------

--
-- Estrutura da tabela `adicionais_cat`
--

CREATE TABLE `adicionais_cat` (
  `id` int(11) NOT NULL,
  `categoria` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `valor` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `adicionais_cat`
--

INSERT INTO `adicionais_cat` (`id`, `categoria`, `nome`, `ativo`, `valor`) VALUES
(2, 1, 'Bacon', 'Sim', 4.00),
(3, 1, 'Catupiri', 'Sim', 4.00),
(5, 1, 'Cheddar', 'Sim', 5.00),
(6, 1, 'Ovo', 'Sim', 2.00),
(7, 17, 'Bacon', 'Sim', 5.00),
(8, 17, 'Cebola', 'Sim', 2.00),
(15, 23, 'Chocloate', 'Sim', 3.00),
(16, 23, 'Leite Moça', 'Sim', 4.00),
(17, 23, 'Granulado', 'Sim', 3.00),
(18, 24, 'Banana', 'Sim', 3.00),
(19, 24, 'Pizza Doce', 'Sim', 4.00),
(20, 24, 'Coco Ralado', 'Sim', 2.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `anotacoes`
--

CREATE TABLE `anotacoes` (
  `id` int(11) NOT NULL,
  `titulo` varchar(250) NOT NULL,
  `msg` text NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` date NOT NULL,
  `mostrar_home` varchar(5) NOT NULL,
  `privado` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Extraindo dados da tabela `anotacoes`
--

INSERT INTO `anotacoes` (`id`, `titulo`, `msg`, `usuario`, `data`, `mostrar_home`, `privado`) VALUES
(19, 'Anotação Teste', '<span style=\"font-size: 13.0509px;\"><span style=\"font-weight: normal;\">Teste de anotação</span><br></span>', 1, '2024-08-10', 'Sim', 'Sim'),
(21, 'teste', 'rererdwdwdede', 1, '2024-11-17', 'Não', 'Não'),
(22, 'mercado pago', '<span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">APP_USR-8196343785496139-041616-3e2c930fc9fc302ab85d806175c1fde1-54016730</span><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"><br></span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"><br></span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">public</span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">APP_USR-13e5d4c4-1a49-4370-82ff-ef607f6e7f74</span><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"></span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"><br></span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">id</span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">8196343785496139</span><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"></span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"><br></span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">secret</span></div><div><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\">L7df4IENuuAPESJO2Q5bZ5p7BE9ox7Ul</span><span style=\"color: rgba(0, 0, 0, 0.9); font-family: &quot;Proxima Nova&quot;, -apple-system, Roboto, Arial, sans-serif; font-size: 16px; font-weight: 400; white-space: pre; background-color: rgb(237, 237, 237);\"></span></div>', 1, '2025-04-16', 'Não', 'Não');

-- --------------------------------------------------------

--
-- Estrutura da tabela `arquivos`
--

CREATE TABLE `arquivos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `arquivo` varchar(100) DEFAULT NULL,
  `data_cad` date NOT NULL,
  `registro` varchar(50) DEFAULT NULL,
  `id_reg` int(11) NOT NULL,
  `usuario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `arquivos`
--

INSERT INTO `arquivos` (`id`, `nome`, `descricao`, `arquivo`, `data_cad`, `registro`, `id_reg`, `usuario`) VALUES
(1, 'Conta X', NULL, '05-09-2023-18-06-02-09-11-2021-09-21-26-conta3.jpg', '2023-09-05', 'Conta à Receber', 11, 15),
(3, 'dgfd', NULL, '05-09-2023-20-28-50-09-11-2021-09-21-26-conta3.jpg', '2023-09-05', 'Conta à Pagar', 21, 18),
(5, 'aaaaaaaaaaa', NULL, '05-09-2023-20-29-16-09-11-2021-13-07-43-pdfteste.pdf', '2023-09-05', 'Conta à Pagar', 22, 18),
(6, 'aaaaaaaaaaa', NULL, '05-09-2023-20-29-16-09-11-2021-13-07-43-pdfteste.pdf', '2023-09-05', 'Funcionário', 16, 18),
(7, 'fdfdsfsdfsf', NULL, '05-09-2023-20-34-13-09-11-2021-13-08-20-arquivoteste.docx', '2023-09-05', 'Funcionário', 16, 18),
(8, 'fsdff', NULL, '05-09-2023-20-34-31-09-11-2021-13-07-43-pdfteste.pdf', '2023-09-05', 'Funcionário', 22, 18),
(9, 'dsdsad', NULL, '05-09-2023-20-54-02-09-11-2021-13-07-27-conta3.jpg', '2023-09-05', 'Conta à Receber', 27, 15),
(10, 'dasdfsf', NULL, '05-09-2023-20-54-08-09-11-2021-13-07-43-pdfteste.pdf', '2023-09-05', 'Conta à Receber', 27, 15),
(12, 'aaa', NULL, '11-09-2023-17-38-11-09-11-2021-14-59-23-pdfteste.pdf', '2023-09-11', 'Conta à Receber', 8, 15),
(13, 'aaa', NULL, '11-09-2023-17-38-11-09-11-2021-14-59-23-pdfteste.pdf', '2023-09-11', 'Cliente', 4, 15),
(14, 'fada', NULL, '26-09-2023-15-07-47-favicon.png', '2023-09-26', 'Cliente', 7, 15),
(17, 'aaa', NULL, '26-09-2023-19-44-38-logo.png', '2023-09-26', 'Cliente', 4, 15),
(19, 'dwdw', NULL, '26-07-2024-17-30-26-ICON.png', '2024-07-26', 'Cliente', 18, 1),
(21, 'logo', NULL, '27-07-2024-09-00-08-LOGO-BRANCA.jpg', '2024-07-27', 'Cliente', 20, 1),
(22, 'ter', NULL, '15-08-2024-15-55-10-#PoupatempoTaOn---Portal-Poupatempo.pdf', '2024-08-15', 'Cliente', 6, 1),
(23, 'dwd', NULL, '15-08-2024-18-15-59-ACADMIA.png', '2024-08-15', 'Conta à Pagar', 11, 1),
(26, 'teste', NULL, '06-11-2024-16-03-59-813400f8d0e227d8603c20aac9240fe1.jpg', '2024-11-06', 'Conta à Pagar', 77, 1),
(28, 'Teste', NULL, '06-11-2024-18-50-39-ACADMIA.png', '2024-11-06', 'Conta à Receber', 5, 1),
(29, 'Teste', NULL, '06-11-2024-18-50-39-ACADMIA.png', '2024-11-06', 'Cliente', 16, 1),
(30, 'teste', NULL, '06-11-2024-21-56-27-ACADMIA.png', '2024-11-06', 'Conta à Receber', 22, 1),
(31, 'teste', NULL, '06-11-2024-21-56-27-ACADMIA.png', '2024-11-06', 'Cliente', 16, 1),
(33, 'teste', NULL, '17-11-2024-12-22-03-Hangar-combo.png', '2024-11-17', 'Cliente', 2, 1),
(35, 'teste', NULL, '17-11-2024-12-30-27-Hangar-combo.png', '2024-11-17', 'Cliente', 5, 1),
(36, 'teste', NULL, '17-11-2024-16-40-26-banana.png', '2024-11-17', 'Conta à Pagar', 24, 1),
(38, 'teste', NULL, '17-11-2024-16-49-41-rel-clientes(6).xls', '2024-11-17', 'Conta à Pagar', 35, 1),
(40, 'teste', NULL, '17-11-2024-17-06-18-rel-clientes(5).xls', '2024-11-17', 'Cliente', 3, 1),
(41, 'teste', NULL, '17-11-2024-18-23-44-rel-clientes(6).xls', '2024-11-17', 'Conta à Pagar', 38, 1),
(42, 'teste', NULL, '17-11-2024-18-23-44-rel-clientes(6).xls', '2024-11-17', 'Funcionário', 16, 1),
(43, 'teste', NULL, '17-11-2024-18-24-03-rel-clientes(7).xls', '2024-11-17', 'Conta à Receber', 31, 1),
(44, 'teste', NULL, '17-11-2024-18-24-03-rel-clientes(7).xls', '2024-11-17', 'Cliente', 3, 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `bairros`
--

CREATE TABLE `bairros` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `valor` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `bairros`
--

INSERT INTO `bairros` (`id`, `nome`, `valor`) VALUES
(1, 'Siqueira Campos', 6.00),
(2, '18 do forte', 4.00),
(5, 'Santos Dumont', 3.00),
(7, 'Cidade Nova', 4.00),
(8, 'Japãozinho', 4.00),
(9, 'Dom Luciano', 3.00),
(10, 'Bahamas', 3.00),
(11, 'Soledade (Bomfim)', 4.00),
(12, 'Rosa do Sol', 3.00),
(13, 'Jardim Bahia', 3.00),
(14, 'Lamarão', 4.00),
(15, 'Jardim Indara', 4.00),
(16, 'Santo Antônio', 4.00),
(17, 'bairro industrial ', 6.00),
(18, 'bairro américa ', 6.00),
(19, 'isabel martins', 3.00),
(20, 'Soledade', 3.00),
(21, 'Porto dantas', 6.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `banner_rotativo`
--

CREATE TABLE `banner_rotativo` (
  `id` int(11) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `categoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `banner_rotativo`
--

INSERT INTO `banner_rotativo` (`id`, `foto`, `categoria`) VALUES
(11, '13-04-2025-08-41-08-2.jpg', 25),
(15, '13-04-2025-08-47-05-1.jpg', 1),
(16, '13-04-2025-08-47-16-3.jpg', 6),
(17, '13-04-2025-08-47-33-4.jpg', 27);

-- --------------------------------------------------------

--
-- Estrutura da tabela `bordas`
--

CREATE TABLE `bordas` (
  `id` int(11) NOT NULL,
  `categoria` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `valor` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `bordas`
--

INSERT INTO `bordas` (`id`, `categoria`, `nome`, `ativo`, `valor`) VALUES
(1, 1, 'Borda Cheddar', 'Sim', 5.00),
(2, 1, 'Borda Catupiri', 'Sim', 4.00),
(3, 1, 'Borda Cream Chese', 'Sim', 5.00),
(13, 23, 'Chocolate', 'Sim', 3.00),
(14, 23, 'Doçe de Leite', 'Sim', 4.00),
(15, 23, 'Banana', 'Sim', 5.50),
(16, 24, 'Chocloate', 'Sim', 4.00),
(17, 24, 'Doce de Leite', 'Sim', 6.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `caixas`
--

CREATE TABLE `caixas` (
  `id` int(11) NOT NULL,
  `operador` int(11) NOT NULL,
  `data_abertura` date NOT NULL,
  `data_fechamento` date DEFAULT NULL,
  `valor_abertura` decimal(8,2) NOT NULL,
  `valor_fechamento` decimal(8,2) DEFAULT NULL,
  `quebra` decimal(8,2) DEFAULT NULL,
  `usuario_abertura` int(11) NOT NULL,
  `usuario_fechamento` int(11) DEFAULT NULL,
  `obs` varchar(255) DEFAULT NULL,
  `sangrias` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `caixas`
--

INSERT INTO `caixas` (`id`, `operador`, `data_abertura`, `data_fechamento`, `valor_abertura`, `valor_fechamento`, `quebra`, `usuario_abertura`, `usuario_fechamento`, `obs`, `sangrias`) VALUES
(1, 1, '2025-02-08', '2025-02-08', 50.00, 95.00, 38.01, 1, 1, '', NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cargos`
--

CREATE TABLE `cargos` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `cargos`
--

INSERT INTO `cargos` (`id`, `nome`) VALUES
(1, 'Administrador'),
(4, 'Gerente'),
(5, 'Recepcionista'),
(6, 'Atendente'),
(8, 'Faxineiro'),
(9, 'Garçon'),
(11, 'Entregador'),
(15, 'Balconista');

-- --------------------------------------------------------

--
-- Estrutura da tabela `carrinho`
--

CREATE TABLE `carrinho` (
  `id` int(11) NOT NULL,
  `sessao` varchar(35) NOT NULL,
  `cliente` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `total_item` decimal(8,2) NOT NULL,
  `obs` varchar(255) DEFAULT NULL,
  `pedido` int(11) DEFAULT NULL,
  `data` date DEFAULT NULL,
  `id_sabor` int(11) DEFAULT NULL,
  `categoria` int(11) DEFAULT NULL,
  `item` int(11) DEFAULT NULL,
  `variacao` int(11) DEFAULT NULL,
  `mesa` varchar(25) DEFAULT NULL,
  `nome_cliente` varchar(50) DEFAULT NULL,
  `nome_produto` varchar(100) DEFAULT NULL,
  `sabores` int(11) DEFAULT NULL,
  `borda` int(11) DEFAULT NULL,
  `valor_unitario` decimal(8,2) DEFAULT NULL,
  `status` varchar(25) DEFAULT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `carrinho`
--

INSERT INTO `carrinho` (`id`, `sessao`, `cliente`, `produto`, `quantidade`, `total_item`, `obs`, `pedido`, `data`, `id_sabor`, `categoria`, `item`, `variacao`, `mesa`, `nome_cliente`, `nome_produto`, `sabores`, `borda`, `valor_unitario`, `status`, `hora`) VALUES
(18, '2025-04-12-20:18:59-6', 0, 216, 1, 28.00, '', 0, '2025-04-12', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '20:22:43'),
(19, '2025-04-13-08:35:48-309', 0, 216, 1, 18.00, '', 0, '2025-04-13', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '09:35:10'),
(21, '2025-04-13-16:08:39-570', 0, 244, 1, 35.00, '', 0, '2025-04-13', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0.00, '', '16:28:58'),
(22, '2025-04-13-16:08:39-570', 0, 222, 1, 5.00, '', 0, '2025-04-13', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0.00, '', '17:19:16'),
(24, '2025-04-13-18:47:52-999', 0, 16, 1, 36.00, '', 0, '2025-04-13', NULL, NULL, NULL, NULL, '4', '', NULL, NULL, NULL, 18.00, '', '18:48:21'),
(25, '2025-04-13-18:47:52-999', 0, 244, 1, 14.00, '', 0, '2025-04-13', NULL, NULL, NULL, NULL, '4', '', NULL, NULL, NULL, 0.00, '', '18:50:06'),
(26, '2025-04-16-09:25:25-1108', 11, 222, 1, 2.00, '', 14, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0.00, '', '09:25:42'),
(27, '2025-04-16-13:07:08-428', 11, 224, 1, 2.00, '', 15, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 2.00, '', '13:07:12'),
(28, '2025-04-16-21:48:45-515', 11, 216, 1, 18.00, '', 16, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '21:48:49'),
(29, '2025-04-16-22:13:12-788', 11, 224, 1, 2.00, '', 17, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 2.00, '', '22:13:14'),
(30, '2025-04-16-23:16:22-462', 11, 224, 1, 2.00, '', 18, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 2.00, '', '23:16:24'),
(31, '2025-04-16-23:16:22-462', 11, 103, 1, 15.00, '', 18, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '23:32:45'),
(32, '2025-04-16-23:54:16-356', 11, 100, 1, 18.00, '', 19, '2025-04-16', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '23:54:19'),
(33, '2025-04-17-00:05:05-1010', 11, 100, 1, 18.00, '', 20, '2025-04-17', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '00:05:08'),
(34, '2025-04-17-13:33:57-1136', 11, 44, 1, 19.00, '', 21, '2025-04-17', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 19.00, '', '13:34:00'),
(35, '2025-04-18-11:29:39-1365', 11, 165, 1, 20.00, '', 22, '2025-04-18', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '11:29:42'),
(36, '2025-04-18-12:09:59-685', 11, 220, 1, 5.00, '', 23, '2025-04-18', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 5.00, '', '12:10:00'),
(37, '2025-05-04-10:09:45-19', 11, 99, 1, 21.00, '', 24, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '10:10:01'),
(38, '2025-05-04-10:45:41-1158', 11, 16, 1, 30.00, '', 28, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '10:45:50'),
(39, '2025-05-04-11:00:39-476', 11, 208, 1, 8.00, '', 25, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '11:00:41'),
(40, '2025-05-04-11:07:05-731', 11, 208, 1, 8.00, '', 26, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '11:07:08'),
(41, '2025-05-04-11:18:48-541', 11, 69, 1, 16.00, '', 27, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 16.00, '', '11:18:50'),
(42, '2025-05-04-11:24:15-70', 11, 103, 1, 15.00, '', 29, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '11:24:17'),
(43, '2025-05-04-11:35:55-86', 11, 103, 1, 15.00, '', 30, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '11:36:04'),
(44, '2025-05-04-11:43:05-1337', 11, 30, 1, 5.00, '', 31, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 5.00, '', '11:43:07'),
(45, '2025-05-04-11:47:05-78', 11, 103, 1, 15.00, '', 32, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '11:47:10'),
(46, '2025-05-04-11:52:07-1317', 11, 43, 1, 14.00, '', 33, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 14.00, '', '11:52:10'),
(47, '2025-05-04-11:57:40-1387', 11, 206, 1, 5.00, '', 34, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 5.00, '', '11:57:42'),
(48, '2025-05-04-12:00:17-285', 11, 207, 1, 8.00, '', 35, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '12:00:19'),
(49, '2025-05-04-12:00:43-839', 11, 79, 1, 17.00, '', 36, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 17.00, '', '12:00:45'),
(50, '2025-05-04-12:07:00-591', 11, 207, 1, 8.00, '', 37, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '12:07:02'),
(51, '2025-05-04-12:12:25-697', 11, 72, 1, 20.00, '', 38, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '12:12:33'),
(52, '2025-05-04-12:17:12-659', 11, 208, 1, 8.00, '', 39, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '12:17:14'),
(53, '2025-05-04-12:28:55-1421', 11, 98, 1, 14.00, '', 40, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 14.00, '', '12:28:57'),
(54, '2025-05-04-12:35:40-176', 11, 101, 1, 20.00, '', 41, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '12:35:44'),
(55, '2025-05-04-13:20:18-170', 11, 84, 1, 15.00, '', 42, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '13:20:27'),
(56, '2025-05-04-14:09:45-320', 0, 99, 1, 15.00, '', 0, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '14:09:48'),
(59, '2025-05-04-17:21:08-884', 11, 208, 1, 8.00, '', 43, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '17:23:01'),
(60, '2025-05-04-17:36:35-1356', 11, 207, 1, 8.00, '', 44, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '17:36:41'),
(61, '2025-05-04-17:40:57-306', 11, 99, 1, 15.00, '', 45, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '17:41:00'),
(62, '2025-05-04-17:44:57-473', 11, 69, 1, 16.00, '', 46, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 16.00, '', '17:45:00'),
(63, '2025-05-04-18:02:01-161', 11, 102, 1, 22.00, '', 47, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 22.00, '', '18:02:03'),
(64, '2025-05-04-18:12:42-761', 11, 209, 1, 10.00, '', 48, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 10.00, '', '18:12:43'),
(65, '2025-05-04-18:17:53-1016', 11, 209, 1, 10.00, '', 49, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 10.00, '', '18:17:55'),
(66, '2025-05-04-18:17:53-1016', 11, 16, 1, 18.00, '', 50, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '18:23:06'),
(67, '2025-05-04-18:37:08-1408', 11, 16, 1, 18.00, '', 51, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '18:37:11'),
(68, '2025-05-04-18:39:40-1469', 11, 16, 1, 18.00, '', 52, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '18:39:43'),
(69, '2025-05-04-18:47:35-1404', 11, 16, 1, 18.00, '', 53, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '18:47:45'),
(70, '2025-05-04-18:50:27-168', 11, 207, 1, 8.00, '', 54, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '18:58:47'),
(71, '2025-05-04-19:04:47-1470', 11, 98, 1, 14.00, '', 55, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 14.00, '', '19:04:50'),
(72, '2025-05-04-19:15:05-480', 11, 99, 1, 15.00, '', 56, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '19:15:07'),
(73, '2025-05-04-19:34:15-463', 11, 16, 1, 18.00, '', 57, '2025-05-04', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '19:34:21'),
(74, '2025-05-05-06:00:46-963', 11, 103, 1, 15.00, '', 58, '2025-05-05', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '06:00:50'),
(75, '2025-05-18-10:47:00-985', 11, 99, 1, 15.00, '', 59, '2025-05-18', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '10:47:02'),
(76, '2025-05-18-10:53:32-880', 11, 16, 1, 33.00, '', 60, '2025-05-18', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '10:53:37'),
(77, '2025-05-18-12:10:51-7', 0, 16, 1, 18.00, '', 0, '2025-05-18', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '12:10:54'),
(78, '2025-05-31-22:57:55-568', 11, 98, 1, 20.00, '', 61, '2025-05-31', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 14.00, '', '22:58:02'),
(79, '2025-06-05-22:57:32-1325', 11, 224, 1, 2.00, '', 62, '2025-06-05', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 2.00, '', '22:57:36'),
(80, '2025-06-05-23:01:35-363', 11, 224, 1, 2.00, '', 63, '2025-06-05', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 2.00, '', '23:01:40'),
(81, '2025-06-07-12:21:10-444', 0, 222, 1, 2.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 0.00, '', '12:21:19'),
(82, '2025-06-07-12:22:27-610', 0, 14, 1, 20.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '12:22:29'),
(87, '2025-06-07-13:15:06-244', 0, 84, 1, 15.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '14:14:24'),
(88, '2025-06-07-14:15:48-1426', 0, 100, 1, 18.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '14:15:51'),
(91, '2025-06-07-17:21:54-1417', 0, 103, 1, 15.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '17:21:56'),
(94, '2025-06-07-18:16:07-1068', 0, 103, 1, 15.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '18:16:09'),
(95, '2025-06-07-16:15:48-908', 0, 216, 1, 18.00, '', 64, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '18:46:29'),
(96, '2025-06-07-18:51:17-874', 11, 16, 1, 18.00, '', 65, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '18:51:19'),
(97, '2025-06-07-18:51:17-874', 11, 108, 1, 20.00, '', 65, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '18:51:28'),
(98, '2025-06-07-19:15:32-700', 0, 14, 1, 20.00, '', 0, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '19:15:34'),
(99, '2025-06-07-18:51:17-874', 11, 103, 1, 15.00, '', 65, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '19:19:38'),
(100, '2025-06-07-18:51:17-874', 11, 14, 1, 20.00, '', 65, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '19:22:04'),
(101, '2025-06-07-18:51:17-874', 11, 16, 1, 18.00, '', 65, '2025-06-07', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '19:23:11'),
(102, '2025-06-08-08:54:39-723', 11, 84, 1, 15.00, '', 66, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '08:54:40'),
(103, '2025-06-08-11:11:19-1490', 11, 16, 1, 18.00, '', 67, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '11:11:21'),
(104, '2025-06-08-11:11:19-1490', 11, 103, 1, 15.00, '', 67, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '18:32:10'),
(105, '2025-06-08-19:41:39-364', 11, 14, 1, 20.00, '', 68, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '19:41:41'),
(106, '2025-06-08-20:15:17-1465', 11, 85, 1, 20.00, '', 69, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '20:15:19'),
(107, '2025-06-08-20:28:41-735', 11, 100, 1, 18.00, '', 70, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '20:28:47'),
(108, '2025-06-08-20:32:41-113', 11, 224, 1, 2.00, '', 71, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 2.00, '', '20:32:43'),
(109, '2025-06-08-21:00:06-649', 11, 207, 1, 8.00, '', 72, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 8.00, '', '21:00:08'),
(110, '2025-06-08-21:00:06-649', 11, 14, 1, 20.00, '', 72, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '21:04:26'),
(111, '2025-06-08-21:21:09-1468', 11, 103, 1, 15.00, '', 73, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 15.00, '', '21:21:11'),
(112, '2025-06-08-21:21:48-147', 11, 17, 1, 20.00, '', 74, '2025-06-08', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 20.00, '', '21:21:50'),
(114, '2025-06-08-21:23:53-258', 11, 100, 1, 80.00, '', 75, '2025-06-09', NULL, NULL, NULL, NULL, '', '', NULL, NULL, NULL, 18.00, '', '06:13:13');

-- --------------------------------------------------------

--
-- Estrutura da tabela `categorias`
--

CREATE TABLE `categorias` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `cor` varchar(30) NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `url` varchar(100) NOT NULL,
  `mais_sabores` varchar(5) NOT NULL,
  `delivery` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`, `descricao`, `foto`, `cor`, `ativo`, `url`, `mais_sabores`, `delivery`) VALUES
(1, 'Especiais', 'Sanduíches Especiais', '23-12-2023-22-29-39-ESPECIAL.jpg', 'azul', 'Sim', 'especiais', 'Não', 'Sim'),
(2, 'Carneiro', 'Sanduíches de Carneiro', '23-12-2023-22-29-27-CARNEIRO.jpg', 'rosa', 'Sim', 'carneiro', 'Não', 'Sim'),
(4, 'Bebidas', 'Refrigerantes, Sucos, Agua, diversos', '15-01-2024-12-31-51-Story-para-adega-de-bebidas-com-delivery-chamativo-preto-(1).png', 'azul-escuro', 'Sim', 'bebidas', 'Não', 'Sim'),
(6, 'Cachorro Quente', 'Deliciosos Cachorro Quente', '15-01-2024-13-13-45-Story-para-adega-de-bebidas-com-delivery-chamativo-preto-(2).png', 'verde', 'Sim', 'cachorro-quente', 'Não', 'Sim'),
(7, 'Coração', 'Sanduíches de Coração', '23-12-2023-22-29-05-CORAÇÃO.jpg', 'roxo', 'Sim', 'coracao', 'Não', 'Sim'),
(9, 'Frango', 'Sanduíches de Frango', '23-12-2023-22-28-44-FRANGO.jpg', 'verde-escuro', 'Sim', 'frango', 'Não', 'Sim'),
(10, 'Tradicionais', 'Sanduíches Tradicionais', '23-12-2023-22-28-30-TRADICIONAIS.jpg', 'laranja', 'Sim', 'tradicionais', 'Não', 'Sim'),
(12, 'Filé', 'Sanduiche de filé bovino', '23-12-2023-22-27-55-FILE.jpg', 'laranja', 'Sim', 'file', 'Não', 'Sim'),
(13, 'Porco', 'Sanduíches de Porco', '23-12-2023-22-30-07-PORCO.jpg', 'azul', 'Sim', 'porco', 'Não', 'Sim'),
(14, 'Picanha', 'Sanduíches de Picanha', '23-12-2023-22-30-26-PICANHA.jpg', 'azul', 'Sim', 'picanha', 'Não', 'Sim'),
(15, 'Lombo', 'Sanduíches de Lombo', '23-12-2023-22-37-47-LOMBO.jpg', 'azul', 'Sim', 'lombo', 'Não', 'Sim'),
(16, 'Camarão', 'Sanduíches de Camarão', '23-12-2023-22-38-21-CAMARAO.jpg', 'azul', 'Sim', 'camarao', 'Não', 'Sim'),
(17, 'Charque', 'Sanduíches de Charque', '23-12-2023-22-39-04-CHARQUE.jpg', 'azul', 'Sim', 'charque', 'Não', 'Sim'),
(18, 'Bacalhau', 'Sanduíches de Bacalhau', '23-12-2023-22-39-31-BACALHAU.jpg', 'azul', 'Sim', 'bacalhau', 'Não', 'Sim'),
(19, 'Bacon', 'Sanduíches de Bacon', '23-12-2023-22-42-22-BACON.jpg', 'azul', 'Sim', 'bacon', 'Não', 'Sim'),
(20, 'Calabresa', 'Sanduíches de Calabresa', '23-12-2023-22-42-42-CALABRESA.jpg', 'azul', 'Sim', 'calabresa', 'Não', 'Sim'),
(21, 'Carne do Sol', 'Sanduíches de Carne do Sol', '23-12-2023-22-43-10-CARNE-DO-SOL.jpg', 'azul', 'Sim', 'carne-do-sol', 'Não', 'Sim'),
(22, 'Toscana', 'Sanduíches de Toscana', '23-12-2023-23-03-29-TOSCANA.jpg', 'azul', 'Sim', 'toscana', 'Não', 'Sim'),
(23, 'Salsicha', 'Sanduiches de salsicha', '15-01-2024-12-04-05-SALSICHA.jpg', 'azul', 'Sim', 'salsicha', 'Não', 'Sim'),
(24, 'Açaí', '', '17-01-2024-18-20-54-acai.png', 'vermelho', 'Sim', 'acai', 'Não', 'Sim'),
(25, 'Batata Frita', 'batata frita', '18-12-2024-20-34-19-batata-frita-porcao.png', 'azul', 'Sim', 'batata-frita', 'Não', 'Sim'),
(26, 'Sobremesa', 'doces diversos', '12-02-2025-00-12-32-sobremesa.jpeg', 'vermelho', 'Sim', 'sobremesa', 'Não', 'Sim'),
(27, 'combos', 'Combos', '13-04-2025-08-54-19-Instagram-retrato-de-hambúrguer-ousado-marrom-e-laranja-(540-x-540-px).jpg', '', 'Sim', 'combos', 'Não', 'Sim');

-- --------------------------------------------------------

--
-- Estrutura da tabela `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `cpf` varchar(25) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cep` varchar(20) DEFAULT NULL,
  `data_cad` date NOT NULL,
  `data_nasc` date DEFAULT NULL,
  `usuario` int(11) DEFAULT NULL,
  `data_mensagem` date DEFAULT NULL,
  `retorno_enviado` varchar(5) DEFAULT NULL,
  `cartoes` int(11) DEFAULT NULL,
  `marketing` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `clientes`
--

INSERT INTO `clientes` (`id`, `nome`, `cpf`, `telefone`, `email`, `endereco`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `cep`, `data_cad`, `data_nasc`, `usuario`, `data_mensagem`, `retorno_enviado`, `cartoes`, `marketing`) VALUES
(11, 'Wesley', NULL, '(79) 98121-0784', NULL, 'Rua Frei Santa Cecília', '320', '', 'Lamarão', '', NULL, '', '2025-03-07', NULL, NULL, '2025-06-16', 'Não', 2, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `config`
--

CREATE TABLE `config` (
  `nome` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `logo` varchar(100) DEFAULT NULL,
  `icone` varchar(100) DEFAULT NULL,
  `logo_rel` varchar(100) DEFAULT NULL,
  `id` int(11) NOT NULL,
  `ativo` varchar(5) DEFAULT NULL,
  `multa_atraso` decimal(8,2) DEFAULT NULL,
  `juros_atraso` decimal(8,2) DEFAULT NULL,
  `marca_dagua` varchar(5) DEFAULT NULL,
  `assinatura_recibo` varchar(5) DEFAULT NULL,
  `impressao_automatica` varchar(5) DEFAULT NULL,
  `cnpj` varchar(25) DEFAULT NULL,
  `entrar_automatico` varchar(5) DEFAULT NULL,
  `mostrar_preloader` varchar(5) DEFAULT NULL,
  `ocultar_mobile` varchar(5) DEFAULT NULL,
  `api_whatsapp` varchar(25) DEFAULT NULL,
  `token_whatsapp` varchar(70) DEFAULT NULL,
  `instancia_whatsapp` varchar(70) DEFAULT NULL,
  `dados_pagamento` varchar(100) DEFAULT NULL,
  `telefone_fixo` varchar(20) DEFAULT NULL,
  `tipo_rel` varchar(10) DEFAULT NULL,
  `tipo_miniatura` varchar(10) DEFAULT NULL,
  `previsao_entrega` int(11) DEFAULT NULL,
  `horario_abertura` time DEFAULT NULL,
  `horario_fechamento` time DEFAULT NULL,
  `texto_fechamento_horario` varchar(255) DEFAULT NULL,
  `status_estabelecimento` varchar(20) DEFAULT NULL,
  `texto_fechamento` varchar(255) DEFAULT NULL,
  `tempo_atualizar` int(11) DEFAULT NULL,
  `tipo_chave` varchar(35) DEFAULT NULL,
  `dias_apagar` int(11) DEFAULT NULL,
  `banner_rotativo` varchar(5) DEFAULT NULL,
  `pedido_minimo` decimal(8,2) DEFAULT NULL,
  `mostrar_aberto` varchar(5) DEFAULT NULL,
  `entrega_distancia` varchar(5) DEFAULT NULL,
  `chave_api_maps` varchar(255) DEFAULT NULL,
  `latitude_rest` varchar(100) DEFAULT NULL,
  `longitude_rest` varchar(100) DEFAULT NULL,
  `distancia_entrega_km` int(11) DEFAULT NULL,
  `valor_km` int(11) DEFAULT NULL,
  `mais_sabores` varchar(30) NOT NULL,
  `abrir_comprovante` varchar(5) NOT NULL,
  `mostrar_acessos` varchar(5) NOT NULL,
  `fonte_comprovante` int(11) DEFAULT NULL,
  `mensagem_auto` varchar(5) DEFAULT NULL,
  `data_cobranca` date DEFAULT NULL,
  `api_merc` varchar(255) DEFAULT NULL,
  `couvert` int(11) DEFAULT NULL,
  `comissao_garcon` decimal(8,2) DEFAULT NULL,
  `abertura_caixa` varchar(5) DEFAULT NULL,
  `dias_retorno` int(11) DEFAULT NULL,
  `mensagem_retorno` varchar(255) DEFAULT NULL,
  `link_retorno` varchar(100) DEFAULT NULL,
  `total_cartoes` int(11) DEFAULT NULL,
  `valor_cupom` int(11) DEFAULT NULL,
  `taxa_cartao` decimal(5,2) DEFAULT 5.00 COMMENT 'Taxa do cartão em percentual (ex: 5.00 para 5%)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `config`
--

INSERT INTO `config` (`nome`, `email`, `telefone`, `endereco`, `instagram`, `logo`, `icone`, `logo_rel`, `id`, `ativo`, `multa_atraso`, `juros_atraso`, `marca_dagua`, `assinatura_recibo`, `impressao_automatica`, `cnpj`, `entrar_automatico`, `mostrar_preloader`, `ocultar_mobile`, `api_whatsapp`, `token_whatsapp`, `instancia_whatsapp`, `dados_pagamento`, `telefone_fixo`, `tipo_rel`, `tipo_miniatura`, `previsao_entrega`, `horario_abertura`, `horario_fechamento`, `texto_fechamento_horario`, `status_estabelecimento`, `texto_fechamento`, `tempo_atualizar`, `tipo_chave`, `dias_apagar`, `banner_rotativo`, `pedido_minimo`, `mostrar_aberto`, `entrega_distancia`, `chave_api_maps`, `latitude_rest`, `longitude_rest`, `distancia_entrega_km`, `valor_km`, `mais_sabores`, `abrir_comprovante`, `mostrar_acessos`, `fonte_comprovante`, `mensagem_auto`, `data_cobranca`, `api_merc`, `couvert`, `comissao_garcon`, `abertura_caixa`, `dias_retorno`, `mensagem_retorno`, `link_retorno`, `total_cartoes`, `valor_cupom`, `taxa_cartao`) VALUES
('Dragão Lanches', 'agcreativebr@gmail.com', '(79) 98121-0784', 'Rua X Número 150 Bairro Teste X', 'portal_hugo_cursos', 'logo.png', 'icone.png', 'logo.jpg', 1, 'Sim', 15.00, 0.50, 'Sim', 'Não', 'Não', '00.000.000/0000-00', 'Sim', 'Sim', '', 'menuia', '50e2552e-bc77-40a2-9c81-e0c9a33c8736', 'Kh9mX3mkay0hGuWoBsTPaLnTbbkqd4nPPnrN5OCEoQRwMwoJNl', '', '(33) 3333-3333', 'PDF', '', 30, '05:00:00', '02:00:00', 'Olá, Não estamos funcionando nesse momento. Nosso Horário de funcionamento é de Terça a Domingo, das', 'Aberto', 'Fechado ', 30, 'Código', 60, 'Sim', 0.00, 'Sim', 'Não', 'AIzaSyDfR2j-4LcCCNwlZdKdkM4ybT5HiIkNJ9Y', '-10.887669821047524', '-37.08352866787898', 50, 0, 'Média', 'Não', 'Sim', 12, 'Não', '2024-08-01', 'APP_USR-8196343785496139-041616-3e2c930fc9fc302ab85d806175c1fde1-54016730', 0, 0.00, 'Não', 7, 'Vi que já faz alguns dias que você efetuou seu pedido, temos ofertas e promoções hoje!', 'http://localhost/delivery', 0, 10, 50.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `cupons`
--

CREATE TABLE `cupons` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data` date DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `valor_minimo` decimal(8,2) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `cupons`
--

INSERT INTO `cupons` (`id`, `codigo`, `valor`, `data`, `quantidade`, `valor_minimo`, `tipo`) VALUES
(1, '5', 5.00, '0000-00-00', 0, 0.00, 'R$');

-- --------------------------------------------------------

--
-- Estrutura da tabela `dias`
--

CREATE TABLE `dias` (
  `id` int(11) NOT NULL,
  `dia` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `disparos`
--

CREATE TABLE `disparos` (
  `id` int(11) NOT NULL,
  `campanha` int(11) NOT NULL,
  `cliente` int(11) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `telefone` varchar(25) DEFAULT NULL,
  `hora` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `dispositivos`
--

CREATE TABLE `dispositivos` (
  `id` bigint(20) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `appkey` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `status_api` varchar(100) DEFAULT NULL,
  `horario` datetime DEFAULT NULL,
  `empresa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `dispositivos`
--

INSERT INTO `dispositivos` (`id`, `telefone`, `appkey`, `status`, `status_api`, `horario`, `empresa`) VALUES
(4, NULL, 'appkey_67bf8874a0b1b2.97420645', '', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `entradas`
--

CREATE TABLE `entradas` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `entradas`
--

INSERT INTO `entradas` (`id`, `produto`, `quantidade`, `motivo`, `usuario`, `data`) VALUES
(1, 45, 1, 'Achou', 1, '2024-11-17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `formas_pgto`
--

CREATE TABLE `formas_pgto` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `taxa` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `formas_pgto`
--

INSERT INTO `formas_pgto` (`id`, `nome`, `taxa`) VALUES
(1, 'Dinheiro', 0),
(2, 'Pix', 0),
(3, 'Cartão de Crédito', 5),
(4, 'Cartão de Débito', 3),
(12, 'Pix (Banco NuBank)', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedores`
--

CREATE TABLE `fornecedores` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `endereco` varchar(100) DEFAULT NULL,
  `pix` varchar(50) DEFAULT NULL,
  `tipo_chave` varchar(50) NOT NULL,
  `data` date NOT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `complemento` varchar(100) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cep` varchar(20) DEFAULT NULL,
  `usuario` int(11) NOT NULL,
  `cnpj` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `fornecedores`
--

INSERT INTO `fornecedores` (`id`, `nome`, `telefone`, `email`, `endereco`, `pix`, `tipo_chave`, `data`, `numero`, `complemento`, `bairro`, `cidade`, `estado`, `cep`, `usuario`, `cnpj`) VALUES
(8, 'Funcionário 01', '(11) 11111-1111', 'funcionario01@gmail.com', 'Quadra ACSV SE 71', 'funcionario01@gmail.com', 'Email', '2024-07-27', '150', 'Casa 5', 'Plano Diretor Sul', 'Palmas', 'TO', '77022-322', 1, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `frequencias`
--

CREATE TABLE `frequencias` (
  `id` int(11) NOT NULL,
  `frequencia` varchar(25) NOT NULL,
  `dias` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `frequencias`
--

INSERT INTO `frequencias` (`id`, `frequencia`, `dias`) VALUES
(1, 'Nenhuma', 0),
(2, 'Diária', 1),
(3, 'Semanal', 7),
(4, 'Mensal', 30),
(5, 'Trimestral', 90),
(6, 'Semestral', 180),
(7, 'Anual', 365);

-- --------------------------------------------------------

--
-- Estrutura da tabela `grades`
--

CREATE TABLE `grades` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `tipo_item` varchar(30) NOT NULL,
  `valor_item` varchar(30) NOT NULL,
  `texto` varchar(70) NOT NULL,
  `limite` int(11) DEFAULT NULL,
  `ativo` varchar(5) DEFAULT NULL,
  `nome_comprovante` varchar(70) DEFAULT NULL,
  `adicional` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `grades`
--

INSERT INTO `grades` (`id`, `produto`, `tipo_item`, `valor_item`, `texto`, `limite`, `ativo`, `nome_comprovante`, `adicional`) VALUES
(1, 33, 'Múltiplo', 'Sem Valor', 'Escolha as Opções de Sabores', 0, 'Sim', 'Sabores', 'Não'),
(8, 39, 'Múltiplo', 'Agregado', 'Adicionais', 4, 'Sim', 'Adicionais', 'Sim'),
(9, 39, '1 de Cada', 'Sem Valor', 'Remover', 0, 'Sim', 'Itens Removido', 'Não'),
(15, 3, 'Variação', 'Único', 'Escolha o Tamanho', 1, 'Sim', 'Tamanho', 'Não'),
(16, 3, '1 de Cada', 'Sem Valor', 'Escolha os Adicional', 2, 'Sim', 'Adicional Grátis', 'Sim'),
(17, 3, 'Múltiplo', 'Agregado', 'Mais Adiconal?', 2, 'Sim', 'Adiconal Extra', 'Sim'),
(20, 51, 'Único', 'Único', 'Escolha o Tamanho', 0, 'Sim', 'Tamanho', 'Não'),
(21, 20, 'Múltiplo', 'Agregado', 'Inserrir Adicionais?', 0, 'Sim', 'Adiconal', 'Sim'),
(22, 20, '1 de Cada', 'Sem Valor', 'Marque para Remover Ingredientes', 0, 'Sim', 'Remover Ingredientes', 'Não'),
(23, 20, 'Múltiplo', 'Agregado', 'Acresentar Bebida', 0, 'Sim', 'Bebida', 'Não'),
(24, 19, 'Múltiplo', 'Agregado', 'Escolha os Adicionais', 0, 'Sim', 'Adicionais Escolhidos', 'Sim'),
(26, 216, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(27, 14, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(28, 16, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(29, 17, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(30, 28, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(31, 29, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(32, 34, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(33, 35, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(34, 36, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(35, 37, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(36, 38, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(37, 39, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(38, 40, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(39, 41, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(40, 42, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(41, 43, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(42, 45, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(43, 47, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(44, 49, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(45, 51, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(46, 53, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(47, 55, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(48, 57, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(49, 59, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(50, 61, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(51, 63, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(52, 65, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(53, 67, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(54, 69, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(55, 71, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(56, 73, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(57, 80, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(58, 81, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(59, 82, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(60, 84, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(61, 85, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(62, 86, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(63, 87, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(64, 88, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(65, 89, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(66, 90, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(67, 91, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(68, 92, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(69, 93, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(70, 94, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(71, 95, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(72, 96, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(73, 97, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(74, 165, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(75, 166, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(76, 167, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(77, 168, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(78, 170, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(79, 171, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(80, 172, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(81, 173, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(82, 174, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(83, 175, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(84, 176, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(85, 177, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(86, 178, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(87, 179, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(88, 180, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(89, 181, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(90, 182, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(91, 183, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(92, 184, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(93, 185, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(94, 186, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(95, 188, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(96, 189, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(97, 190, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(98, 191, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(99, 194, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(100, 195, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(101, 214, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(102, 215, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(103, 98, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(104, 99, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(105, 100, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(106, 101, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(107, 102, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(108, 103, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(109, 104, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(110, 105, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(111, 106, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(112, 107, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(113, 108, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(114, 109, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(115, 110, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(116, 111, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(117, 112, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(118, 113, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(119, 114, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(120, 115, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(121, 116, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(122, 117, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(123, 118, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(124, 119, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(125, 46, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(126, 158, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(127, 44, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(128, 142, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(129, 143, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(130, 144, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(131, 145, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(132, 146, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(133, 147, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(134, 148, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(135, 149, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(136, 150, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(137, 151, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(138, 152, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(139, 153, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(140, 154, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(141, 155, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(142, 156, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(143, 157, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(144, 158, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(145, 159, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(146, 160, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(147, 161, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(148, 162, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(149, 163, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(150, 120, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(151, 121, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(152, 122, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(153, 123, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(154, 124, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(155, 125, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(156, 126, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(157, 127, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(158, 128, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(159, 129, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(160, 130, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(161, 131, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(162, 132, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(163, 133, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(164, 134, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(165, 135, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(166, 136, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(167, 137, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(168, 138, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(169, 139, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(170, 140, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(171, 141, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(172, 197, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(173, 196, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(174, 193, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(175, 192, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(176, 187, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(177, 169, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(178, 79, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(179, 78, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(180, 77, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(181, 76, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(182, 229, 'Múltiplo', 'Agregado', 'Adicionais', 0, 'Sim', 'Adicionais', 'Sim'),
(183, 244, 'Múltiplo', 'Único', 'Sabor', 0, 'Sim', 'Sabor', 'Não'),
(186, 222, 'Múltiplo', 'Único', 'Variações ', 0, 'Sim', 'Escolha sua água ', 'Não');

-- --------------------------------------------------------

--
-- Estrutura da tabela `grupo_acessos`
--

CREATE TABLE `grupo_acessos` (
  `id` int(11) NOT NULL,
  `nome` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `grupo_acessos`
--

INSERT INTO `grupo_acessos` (`id`, `nome`) VALUES
(1, 'Pessoas'),
(2, 'Cadastros'),
(4, 'Financeiro'),
(7, 'Caixas'),
(9, 'Produtos'),
(10, 'Relatórios');

-- --------------------------------------------------------

--
-- Estrutura da tabela `itens_grade`
--

CREATE TABLE `itens_grade` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `texto` varchar(70) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `limite` int(11) NOT NULL,
  `ativo` varchar(5) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `adicional` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `itens_grade`
--

INSERT INTO `itens_grade` (`id`, `produto`, `texto`, `valor`, `limite`, `ativo`, `grade`, `adicional`) VALUES
(15, 39, 'Manteiga', 0.00, 1, 'Sim', 37, 0),
(17, 39, 'Bacon', 6.00, 2, 'Sim', 37, 1),
(19, 39, 'Gema', 0.00, 1, 'Sim', 37, 0),
(37, 33, 'Bolinho de Carne', 0.99, 0, 'Sim', 1, 0),
(38, 33, 'Mini Pizza', 2.50, 0, 'Sim', 1, 0),
(39, 33, 'Mini Pastel de Carne', 0.99, 0, 'Sim', 1, 0),
(40, 33, 'Mini Pastel de Frago', 0.99, 0, 'Sim', 1, 0),
(41, 33, 'Bolinho de Pizza', 1.50, 0, 'Sim', 1, 0),
(42, 33, 'Enroladinho', 0.99, 0, 'Sim', 1, 0),
(43, 33, 'Risole', 1.30, 0, 'Sim', 1, 0),
(52, 3, 'Pequena', 10.00, 0, 'Sim', 15, 0),
(53, 3, 'Média', 15.00, 0, 'Sim', 15, 0),
(54, 3, 'Grande', 20.00, 0, 'Sim', 15, 0),
(73, 51, '300ml', 8.00, 0, 'Sim', 45, 0),
(74, 51, '600ML', 12.00, 0, 'Sim', 45, 0),
(75, 51, '800ml', 15.00, 0, 'Sim', 45, 0),
(76, 20, 'Bacon', 6.00, 2, 'Sim', 21, 1),
(78, 20, 'Cebola', 0.00, 0, 'Sim', 22, 0),
(79, 20, 'Molho de Tomate', 0.00, 0, 'Sim', 22, 0),
(80, 20, 'Coca Cola 350Ml', 5.00, 0, 'Sim', 23, 0),
(81, 20, 'Coca Cola 600ml', 7.00, 0, 'Sim', 23, 0),
(82, 20, 'Coca Cola 1 L', 12.00, 0, 'Sim', 23, 0),
(83, 19, 'Bacon', 6.00, 0, 'Sim', 24, 1),
(86, 216, 'Bacalhau', 6.00, 0, 'Sim', 26, 31),
(87, 216, 'Bacon', 6.00, 0, 'Sim', 26, 1),
(88, 216, 'Camarão', 6.00, 0, 'Sim', 26, 30),
(89, 216, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 26, 25),
(90, 216, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 26, 26),
(91, 216, 'Carneiro', 6.00, 0, 'Sim', 26, 29),
(92, 216, 'Presunto', 2.00, 0, 'Sim', 26, 28),
(93, 216, 'Queijo', 2.00, 0, 'Sim', 26, 27),
(94, 216, 'Outros', 5.00, 0, 'Sim', 26, 32),
(95, 14, 'Bacalhau', 6.00, 0, 'Sim', 27, 31),
(96, 14, 'Bacon', 6.00, 0, 'Sim', 27, 1),
(97, 14, 'Camarão', 6.00, 0, 'Sim', 27, 30),
(98, 14, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 27, 25),
(99, 14, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 27, 26),
(100, 14, 'Carneiro', 6.00, 0, 'Sim', 27, 29),
(101, 14, 'Presunto', 2.00, 0, 'Sim', 27, 28),
(102, 14, 'Queijo', 2.00, 0, 'Sim', 27, 27),
(103, 14, 'Outros', 5.00, 0, 'Sim', 27, 32),
(104, 16, 'Bacalhau', 6.00, 0, 'Sim', 28, 31),
(105, 16, 'Bacon', 6.00, 0, 'Sim', 28, 1),
(106, 16, 'Camarão', 6.00, 0, 'Sim', 28, 30),
(107, 16, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 28, 25),
(108, 16, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 28, 26),
(109, 16, 'Carneiro', 6.00, 0, 'Sim', 28, 29),
(110, 16, 'Presunto', 2.00, 0, 'Sim', 28, 28),
(111, 16, 'Queijo', 2.00, 0, 'Sim', 28, 27),
(112, 16, 'Outros', 5.00, 0, 'Sim', 28, 32),
(113, 17, 'Bacalhau', 6.00, 0, 'Sim', 29, 31),
(114, 17, 'Bacon', 6.00, 0, 'Sim', 29, 1),
(115, 17, 'Camarão', 6.00, 0, 'Sim', 29, 30),
(116, 17, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 29, 25),
(117, 17, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 29, 26),
(118, 17, 'Carneiro', 6.00, 0, 'Sim', 29, 29),
(119, 17, 'Presunto', 2.00, 0, 'Sim', 29, 28),
(120, 17, 'Queijo', 2.00, 0, 'Sim', 29, 27),
(121, 17, 'Outros', 5.00, 0, 'Sim', 29, 32),
(122, 28, 'Bacalhau', 6.00, 0, 'Sim', 30, 31),
(123, 28, 'Bacon', 6.00, 0, 'Sim', 30, 1),
(124, 28, 'Camarão', 6.00, 0, 'Sim', 30, 30),
(125, 28, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 30, 25),
(126, 28, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 30, 26),
(127, 28, 'Carneiro', 6.00, 0, 'Sim', 30, 29),
(128, 28, 'Presunto', 2.00, 0, 'Sim', 30, 28),
(129, 28, 'Queijo', 2.00, 0, 'Sim', 30, 27),
(130, 28, 'Outros', 5.00, 0, 'Sim', 30, 32),
(131, 29, 'Bacalhau', 6.00, 0, 'Sim', 31, 31),
(132, 29, 'Bacon', 6.00, 0, 'Sim', 31, 1),
(133, 29, 'Camarão', 6.00, 0, 'Sim', 31, 30),
(134, 29, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 31, 25),
(135, 29, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 31, 26),
(136, 29, 'Carneiro', 6.00, 0, 'Sim', 31, 29),
(137, 29, 'Presunto', 2.00, 0, 'Sim', 31, 28),
(138, 29, 'Queijo', 2.00, 0, 'Sim', 31, 27),
(139, 29, 'Outros', 5.00, 0, 'Sim', 31, 32),
(140, 34, 'Bacalhau', 6.00, 0, 'Sim', 32, 31),
(141, 34, 'Bacon', 6.00, 0, 'Sim', 32, 1),
(142, 34, 'Camarão', 6.00, 0, 'Sim', 32, 30),
(143, 34, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 32, 25),
(144, 34, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 32, 26),
(145, 34, 'Carneiro', 6.00, 0, 'Sim', 32, 29),
(146, 34, 'Presunto', 2.00, 0, 'Sim', 32, 28),
(147, 34, 'Queijo', 2.00, 0, 'Sim', 32, 27),
(148, 34, 'Outros', 5.00, 0, 'Sim', 32, 32),
(149, 35, 'Bacalhau', 6.00, 0, 'Sim', 33, 31),
(150, 35, 'Bacon', 6.00, 0, 'Sim', 33, 1),
(151, 35, 'Camarão', 6.00, 0, 'Sim', 33, 30),
(152, 35, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 33, 25),
(153, 35, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 33, 26),
(154, 35, 'Carneiro', 6.00, 0, 'Sim', 33, 29),
(155, 35, 'Presunto', 2.00, 0, 'Sim', 33, 28),
(156, 35, 'Queijo', 2.00, 0, 'Sim', 33, 27),
(157, 35, 'Outros', 5.00, 0, 'Sim', 33, 32),
(158, 36, 'Bacalhau', 6.00, 0, 'Sim', 34, 31),
(159, 36, 'Bacon', 6.00, 0, 'Sim', 34, 1),
(160, 36, 'Camarão', 6.00, 0, 'Sim', 34, 30),
(161, 36, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 34, 25),
(162, 36, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 34, 26),
(163, 36, 'Carneiro', 6.00, 0, 'Sim', 34, 29),
(164, 36, 'Presunto', 2.00, 0, 'Sim', 34, 28),
(165, 36, 'Queijo', 2.00, 0, 'Sim', 34, 27),
(166, 36, 'Outros', 5.00, 0, 'Sim', 34, 32),
(167, 37, 'Bacalhau', 6.00, 0, 'Sim', 35, 31),
(168, 37, 'Bacon', 6.00, 0, 'Sim', 35, 1),
(169, 37, 'Camarão', 6.00, 0, 'Sim', 35, 30),
(170, 37, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 35, 25),
(171, 37, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 35, 26),
(172, 37, 'Carneiro', 6.00, 0, 'Sim', 35, 29),
(173, 37, 'Presunto', 2.00, 0, 'Sim', 35, 28),
(174, 37, 'Queijo', 2.00, 0, 'Sim', 35, 27),
(175, 37, 'Outros', 5.00, 0, 'Sim', 35, 32),
(176, 38, 'Bacalhau', 6.00, 0, 'Sim', 36, 31),
(177, 38, 'Bacon', 6.00, 0, 'Sim', 36, 1),
(178, 38, 'Camarão', 6.00, 0, 'Sim', 36, 30),
(179, 38, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 36, 25),
(180, 38, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 36, 26),
(181, 38, 'Carneiro', 6.00, 0, 'Sim', 36, 29),
(182, 38, 'Presunto', 2.00, 0, 'Sim', 36, 28),
(183, 38, 'Queijo', 2.00, 0, 'Sim', 36, 27),
(184, 38, 'Outros', 5.00, 0, 'Sim', 36, 32),
(185, 39, 'Bacalhau', 6.00, 0, 'Sim', 37, 31),
(186, 39, 'Bacon', 6.00, 0, 'Sim', 37, 1),
(187, 39, 'Camarão', 6.00, 0, 'Sim', 37, 30),
(188, 39, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 37, 25),
(189, 39, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 37, 26),
(190, 39, 'Carneiro', 6.00, 0, 'Sim', 37, 29),
(191, 39, 'Presunto', 2.00, 0, 'Sim', 37, 28),
(192, 39, 'Queijo', 2.00, 0, 'Sim', 37, 27),
(193, 39, 'Outros', 5.00, 0, 'Sim', 37, 32),
(194, 40, 'Bacalhau', 6.00, 0, 'Sim', 38, 31),
(195, 40, 'Bacon', 6.00, 0, 'Sim', 38, 1),
(196, 40, 'Camarão', 6.00, 0, 'Sim', 38, 30),
(197, 40, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 38, 25),
(198, 40, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 38, 26),
(199, 40, 'Carneiro', 6.00, 0, 'Sim', 38, 29),
(200, 40, 'Presunto', 2.00, 0, 'Sim', 38, 28),
(201, 40, 'Queijo', 2.00, 0, 'Sim', 38, 27),
(202, 40, 'Outros', 5.00, 0, 'Sim', 38, 32),
(203, 41, 'Bacalhau', 6.00, 0, 'Sim', 39, 31),
(204, 41, 'Bacon', 6.00, 0, 'Sim', 39, 1),
(205, 41, 'Camarão', 6.00, 0, 'Sim', 39, 30),
(206, 41, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 39, 25),
(207, 41, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 39, 26),
(208, 41, 'Carneiro', 6.00, 0, 'Sim', 39, 29),
(209, 41, 'Presunto', 2.00, 0, 'Sim', 39, 28),
(210, 41, 'Queijo', 2.00, 0, 'Sim', 39, 27),
(211, 41, 'Outros', 5.00, 0, 'Sim', 39, 32),
(212, 42, 'Bacalhau', 6.00, 0, 'Sim', 40, 31),
(213, 42, 'Bacon', 6.00, 0, 'Sim', 40, 1),
(214, 42, 'Camarão', 6.00, 0, 'Sim', 40, 30),
(215, 42, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 40, 25),
(216, 42, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 40, 26),
(217, 42, 'Carneiro', 6.00, 0, 'Sim', 40, 29),
(218, 42, 'Presunto', 2.00, 0, 'Sim', 40, 28),
(219, 42, 'Queijo', 2.00, 0, 'Sim', 40, 27),
(220, 42, 'Outros', 5.00, 0, 'Sim', 40, 32),
(221, 43, 'Bacalhau', 6.00, 0, 'Sim', 41, 31),
(222, 43, 'Bacon', 6.00, 0, 'Sim', 41, 1),
(223, 43, 'Camarão', 6.00, 0, 'Sim', 41, 30),
(224, 43, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 41, 25),
(225, 43, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 41, 26),
(226, 43, 'Carneiro', 6.00, 0, 'Sim', 41, 29),
(227, 43, 'Presunto', 2.00, 0, 'Sim', 41, 28),
(228, 43, 'Queijo', 2.00, 0, 'Sim', 41, 27),
(229, 43, 'Outros', 5.00, 0, 'Sim', 41, 32),
(230, 45, 'Bacalhau', 6.00, 0, 'Sim', 42, 31),
(231, 45, 'Bacon', 6.00, 0, 'Sim', 42, 1),
(232, 45, 'Camarão', 6.00, 0, 'Sim', 42, 30),
(233, 45, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 42, 25),
(234, 45, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 42, 26),
(235, 45, 'Carneiro', 6.00, 0, 'Sim', 42, 29),
(236, 45, 'Presunto', 2.00, 0, 'Sim', 42, 28),
(237, 45, 'Queijo', 2.00, 0, 'Sim', 42, 27),
(238, 45, 'Outros', 5.00, 0, 'Sim', 42, 32),
(239, 47, 'Bacalhau', 6.00, 0, 'Sim', 43, 31),
(240, 47, 'Bacon', 6.00, 0, 'Sim', 43, 1),
(241, 47, 'Camarão', 6.00, 0, 'Sim', 43, 30),
(242, 47, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 43, 25),
(243, 47, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 43, 26),
(244, 47, 'Carneiro', 6.00, 0, 'Sim', 43, 29),
(245, 47, 'Presunto', 2.00, 0, 'Sim', 43, 28),
(246, 47, 'Queijo', 2.00, 0, 'Sim', 43, 27),
(247, 47, 'Outros', 5.00, 0, 'Sim', 43, 32),
(248, 49, 'Bacalhau', 6.00, 0, 'Sim', 44, 31),
(249, 49, 'Bacon', 6.00, 0, 'Sim', 44, 1),
(250, 49, 'Camarão', 6.00, 0, 'Sim', 44, 30),
(251, 49, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 44, 25),
(252, 49, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 44, 26),
(253, 49, 'Carneiro', 6.00, 0, 'Sim', 44, 29),
(254, 49, 'Presunto', 2.00, 0, 'Sim', 44, 28),
(255, 49, 'Queijo', 2.00, 0, 'Sim', 44, 27),
(256, 49, 'Outros', 5.00, 0, 'Sim', 44, 32),
(257, 51, 'Bacalhau', 6.00, 0, 'Sim', 45, 31),
(258, 51, 'Bacon', 6.00, 0, 'Sim', 45, 1),
(259, 51, 'Camarão', 6.00, 0, 'Sim', 45, 30),
(260, 51, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 45, 25),
(261, 51, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 45, 26),
(262, 51, 'Carneiro', 6.00, 0, 'Sim', 45, 29),
(263, 51, 'Presunto', 2.00, 0, 'Sim', 45, 28),
(264, 51, 'Queijo', 2.00, 0, 'Sim', 45, 27),
(265, 51, 'Outros', 5.00, 0, 'Sim', 45, 32),
(266, 53, 'Bacalhau', 6.00, 0, 'Sim', 46, 31),
(267, 53, 'Bacon', 6.00, 0, 'Sim', 46, 1),
(268, 53, 'Camarão', 6.00, 0, 'Sim', 46, 30),
(269, 53, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 46, 25),
(270, 53, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 46, 26),
(271, 53, 'Carneiro', 6.00, 0, 'Sim', 46, 29),
(272, 53, 'Presunto', 2.00, 0, 'Sim', 46, 28),
(273, 53, 'Queijo', 2.00, 0, 'Sim', 46, 27),
(274, 53, 'Outros', 5.00, 0, 'Sim', 46, 32),
(275, 55, 'Bacalhau', 6.00, 0, 'Sim', 47, 31),
(276, 55, 'Bacon', 6.00, 0, 'Sim', 47, 1),
(277, 55, 'Camarão', 6.00, 0, 'Sim', 47, 30),
(278, 55, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 47, 25),
(279, 55, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 47, 26),
(280, 55, 'Carneiro', 6.00, 0, 'Sim', 47, 29),
(281, 55, 'Presunto', 2.00, 0, 'Sim', 47, 28),
(282, 55, 'Queijo', 2.00, 0, 'Sim', 47, 27),
(283, 55, 'Outros', 5.00, 0, 'Sim', 47, 32),
(284, 57, 'Bacalhau', 6.00, 0, 'Sim', 48, 31),
(285, 57, 'Bacon', 6.00, 0, 'Sim', 48, 1),
(286, 57, 'Camarão', 6.00, 0, 'Sim', 48, 30),
(287, 57, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 48, 25),
(288, 57, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 48, 26),
(289, 57, 'Carneiro', 6.00, 0, 'Sim', 48, 29),
(290, 57, 'Presunto', 2.00, 0, 'Sim', 48, 28),
(291, 57, 'Queijo', 2.00, 0, 'Sim', 48, 27),
(292, 57, 'Outros', 5.00, 0, 'Sim', 48, 32),
(293, 59, 'Bacalhau', 6.00, 0, 'Sim', 49, 31),
(294, 59, 'Bacon', 6.00, 0, 'Sim', 49, 1),
(295, 59, 'Camarão', 6.00, 0, 'Sim', 49, 30),
(296, 59, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 49, 25),
(297, 59, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 49, 26),
(298, 59, 'Carneiro', 6.00, 0, 'Sim', 49, 29),
(299, 59, 'Presunto', 2.00, 0, 'Sim', 49, 28),
(300, 59, 'Queijo', 2.00, 0, 'Sim', 49, 27),
(301, 59, 'Outros', 5.00, 0, 'Sim', 49, 32),
(302, 61, 'Bacalhau', 6.00, 0, 'Sim', 50, 31),
(303, 61, 'Bacon', 6.00, 0, 'Sim', 50, 1),
(304, 61, 'Camarão', 6.00, 0, 'Sim', 50, 30),
(305, 61, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 50, 25),
(306, 61, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 50, 26),
(307, 61, 'Carneiro', 6.00, 0, 'Sim', 50, 29),
(308, 61, 'Presunto', 2.00, 0, 'Sim', 50, 28),
(309, 61, 'Queijo', 2.00, 0, 'Sim', 50, 27),
(310, 61, 'Outros', 5.00, 0, 'Sim', 50, 32),
(311, 63, 'Bacalhau', 6.00, 0, 'Sim', 51, 31),
(312, 63, 'Bacon', 6.00, 0, 'Sim', 51, 1),
(313, 63, 'Camarão', 6.00, 0, 'Sim', 51, 30),
(314, 63, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 51, 25),
(315, 63, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 51, 26),
(316, 63, 'Carneiro', 6.00, 0, 'Sim', 51, 29),
(317, 63, 'Presunto', 2.00, 0, 'Sim', 51, 28),
(318, 63, 'Queijo', 2.00, 0, 'Sim', 51, 27),
(319, 63, 'Outros', 5.00, 0, 'Sim', 51, 32),
(320, 65, 'Bacalhau', 6.00, 0, 'Sim', 52, 31),
(321, 65, 'Bacon', 6.00, 0, 'Sim', 52, 1),
(322, 65, 'Camarão', 6.00, 0, 'Sim', 52, 30),
(323, 65, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 52, 25),
(324, 65, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 52, 26),
(325, 65, 'Carneiro', 6.00, 0, 'Sim', 52, 29),
(326, 65, 'Presunto', 2.00, 0, 'Sim', 52, 28),
(327, 65, 'Queijo', 2.00, 0, 'Sim', 52, 27),
(328, 65, 'Outros', 5.00, 0, 'Sim', 52, 32),
(329, 67, 'Bacalhau', 6.00, 0, 'Sim', 53, 31),
(330, 67, 'Bacon', 6.00, 0, 'Sim', 53, 1),
(331, 67, 'Camarão', 6.00, 0, 'Sim', 53, 30),
(332, 67, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 53, 25),
(333, 67, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 53, 26),
(334, 67, 'Carneiro', 6.00, 0, 'Sim', 53, 29),
(335, 67, 'Presunto', 2.00, 0, 'Sim', 53, 28),
(336, 67, 'Queijo', 2.00, 0, 'Sim', 53, 27),
(337, 67, 'Outros', 5.00, 0, 'Sim', 53, 32),
(338, 69, 'Bacalhau', 6.00, 0, 'Sim', 54, 31),
(339, 69, 'Bacon', 6.00, 0, 'Sim', 54, 1),
(340, 69, 'Camarão', 6.00, 0, 'Sim', 54, 30),
(341, 69, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 54, 25),
(342, 69, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 54, 26),
(343, 69, 'Carneiro', 6.00, 0, 'Sim', 54, 29),
(344, 69, 'Presunto', 2.00, 0, 'Sim', 54, 28),
(345, 69, 'Queijo', 2.00, 0, 'Sim', 54, 27),
(346, 69, 'Outros', 5.00, 0, 'Sim', 54, 32),
(347, 71, 'Bacalhau', 6.00, 0, 'Sim', 55, 31),
(348, 71, 'Bacon', 6.00, 0, 'Sim', 55, 1),
(349, 71, 'Camarão', 6.00, 0, 'Sim', 55, 30),
(350, 71, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 55, 25),
(351, 71, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 55, 26),
(352, 71, 'Carneiro', 6.00, 0, 'Sim', 55, 29),
(353, 71, 'Presunto', 2.00, 0, 'Sim', 55, 28),
(354, 71, 'Queijo', 2.00, 0, 'Sim', 55, 27),
(355, 71, 'Outros', 5.00, 0, 'Sim', 55, 32),
(356, 73, 'Bacalhau', 6.00, 0, 'Sim', 56, 31),
(357, 73, 'Bacon', 6.00, 0, 'Sim', 56, 1),
(358, 73, 'Camarão', 6.00, 0, 'Sim', 56, 30),
(359, 73, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 56, 25),
(360, 73, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 56, 26),
(361, 73, 'Carneiro', 6.00, 0, 'Sim', 56, 29),
(362, 73, 'Presunto', 2.00, 0, 'Sim', 56, 28),
(363, 73, 'Queijo', 2.00, 0, 'Sim', 56, 27),
(364, 73, 'Outros', 5.00, 0, 'Sim', 56, 32),
(365, 80, 'Bacalhau', 6.00, 0, 'Sim', 57, 31),
(366, 80, 'Bacon', 6.00, 0, 'Sim', 57, 1),
(367, 80, 'Camarão', 6.00, 0, 'Sim', 57, 30),
(368, 80, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 57, 25),
(369, 80, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 57, 26),
(370, 80, 'Carneiro', 6.00, 0, 'Sim', 57, 29),
(371, 80, 'Presunto', 2.00, 0, 'Sim', 57, 28),
(372, 80, 'Queijo', 2.00, 0, 'Sim', 57, 27),
(373, 80, 'Outros', 5.00, 0, 'Sim', 57, 32),
(374, 81, 'Bacalhau', 6.00, 0, 'Sim', 58, 31),
(375, 81, 'Bacon', 6.00, 0, 'Sim', 58, 1),
(376, 81, 'Camarão', 6.00, 0, 'Sim', 58, 30),
(377, 81, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 58, 25),
(378, 81, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 58, 26),
(379, 81, 'Carneiro', 6.00, 0, 'Sim', 58, 29),
(380, 81, 'Presunto', 2.00, 0, 'Sim', 58, 28),
(381, 81, 'Queijo', 2.00, 0, 'Sim', 58, 27),
(382, 81, 'Outros', 5.00, 0, 'Sim', 58, 32),
(383, 82, 'Bacalhau', 6.00, 0, 'Sim', 59, 31),
(384, 82, 'Bacon', 6.00, 0, 'Sim', 59, 1),
(385, 82, 'Camarão', 6.00, 0, 'Sim', 59, 30),
(386, 82, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 59, 25),
(387, 82, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 59, 26),
(388, 82, 'Carneiro', 6.00, 0, 'Sim', 59, 29),
(389, 82, 'Presunto', 2.00, 0, 'Sim', 59, 28),
(390, 82, 'Queijo', 2.00, 0, 'Sim', 59, 27),
(391, 82, 'Outros', 5.00, 0, 'Sim', 59, 32),
(392, 84, 'Bacalhau', 6.00, 0, 'Sim', 60, 31),
(393, 84, 'Bacon', 6.00, 0, 'Sim', 60, 1),
(394, 84, 'Camarão', 6.00, 0, 'Sim', 60, 30),
(395, 84, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 60, 25),
(396, 84, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 60, 26),
(397, 84, 'Carneiro', 6.00, 0, 'Sim', 60, 29),
(398, 84, 'Presunto', 2.00, 0, 'Sim', 60, 28),
(399, 84, 'Queijo', 2.00, 0, 'Sim', 60, 27),
(400, 84, 'Outros', 5.00, 0, 'Sim', 60, 32),
(401, 85, 'Bacalhau', 6.00, 0, 'Sim', 61, 31),
(402, 85, 'Bacon', 6.00, 0, 'Sim', 61, 1),
(403, 85, 'Camarão', 6.00, 0, 'Sim', 61, 30),
(404, 85, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 61, 25),
(405, 85, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 61, 26),
(406, 85, 'Carneiro', 6.00, 0, 'Sim', 61, 29),
(407, 85, 'Presunto', 2.00, 0, 'Sim', 61, 28),
(408, 85, 'Queijo', 2.00, 0, 'Sim', 61, 27),
(409, 85, 'Outros', 5.00, 0, 'Sim', 61, 32),
(410, 86, 'Bacalhau', 6.00, 0, 'Sim', 62, 31),
(411, 86, 'Bacon', 6.00, 0, 'Sim', 62, 1),
(412, 86, 'Camarão', 6.00, 0, 'Sim', 62, 30),
(413, 86, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 62, 25),
(414, 86, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 62, 26),
(415, 86, 'Carneiro', 6.00, 0, 'Sim', 62, 29),
(416, 86, 'Presunto', 2.00, 0, 'Sim', 62, 28),
(417, 86, 'Queijo', 2.00, 0, 'Sim', 62, 27),
(418, 86, 'Outros', 5.00, 0, 'Sim', 62, 32),
(419, 87, 'Bacalhau', 6.00, 0, 'Sim', 63, 31),
(420, 87, 'Bacon', 6.00, 0, 'Sim', 63, 1),
(421, 87, 'Camarão', 6.00, 0, 'Sim', 63, 30),
(422, 87, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 63, 25),
(423, 87, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 63, 26),
(424, 87, 'Carneiro', 6.00, 0, 'Sim', 63, 29),
(425, 87, 'Presunto', 2.00, 0, 'Sim', 63, 28),
(426, 87, 'Queijo', 2.00, 0, 'Sim', 63, 27),
(427, 87, 'Outros', 5.00, 0, 'Sim', 63, 32),
(428, 88, 'Bacalhau', 6.00, 0, 'Sim', 64, 31),
(429, 88, 'Bacon', 6.00, 0, 'Sim', 64, 1),
(430, 88, 'Camarão', 6.00, 0, 'Sim', 64, 30),
(431, 88, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 64, 25),
(432, 88, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 64, 26),
(433, 88, 'Carneiro', 6.00, 0, 'Sim', 64, 29),
(434, 88, 'Presunto', 2.00, 0, 'Sim', 64, 28),
(435, 88, 'Queijo', 2.00, 0, 'Sim', 64, 27),
(436, 88, 'Outros', 5.00, 0, 'Sim', 64, 32),
(437, 89, 'Bacalhau', 6.00, 0, 'Sim', 65, 31),
(438, 89, 'Bacon', 6.00, 0, 'Sim', 65, 1),
(439, 89, 'Camarão', 6.00, 0, 'Sim', 65, 30),
(440, 89, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 65, 25),
(441, 89, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 65, 26),
(442, 89, 'Carneiro', 6.00, 0, 'Sim', 65, 29),
(443, 89, 'Presunto', 2.00, 0, 'Sim', 65, 28),
(444, 89, 'Queijo', 2.00, 0, 'Sim', 65, 27),
(445, 89, 'Outros', 5.00, 0, 'Sim', 65, 32),
(446, 90, 'Bacalhau', 6.00, 0, 'Sim', 66, 31),
(447, 90, 'Bacon', 6.00, 0, 'Sim', 66, 1),
(448, 90, 'Camarão', 6.00, 0, 'Sim', 66, 30),
(449, 90, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 66, 25),
(450, 90, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 66, 26),
(451, 90, 'Carneiro', 6.00, 0, 'Sim', 66, 29),
(452, 90, 'Presunto', 2.00, 0, 'Sim', 66, 28),
(453, 90, 'Queijo', 2.00, 0, 'Sim', 66, 27),
(454, 90, 'Outros', 5.00, 0, 'Sim', 66, 32),
(455, 91, 'Bacalhau', 6.00, 0, 'Sim', 67, 31),
(456, 91, 'Bacon', 6.00, 0, 'Sim', 67, 1),
(457, 91, 'Camarão', 6.00, 0, 'Sim', 67, 30),
(458, 91, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 67, 25),
(459, 91, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 67, 26),
(460, 91, 'Carneiro', 6.00, 0, 'Sim', 67, 29),
(461, 91, 'Presunto', 2.00, 0, 'Sim', 67, 28),
(462, 91, 'Queijo', 2.00, 0, 'Sim', 67, 27),
(463, 91, 'Outros', 5.00, 0, 'Sim', 67, 32),
(464, 92, 'Bacalhau', 6.00, 0, 'Sim', 68, 31),
(465, 92, 'Bacon', 6.00, 0, 'Sim', 68, 1),
(466, 92, 'Camarão', 6.00, 0, 'Sim', 68, 30),
(467, 92, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 68, 25),
(468, 92, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 68, 26),
(469, 92, 'Carneiro', 6.00, 0, 'Sim', 68, 29),
(470, 92, 'Presunto', 2.00, 0, 'Sim', 68, 28),
(471, 92, 'Queijo', 2.00, 0, 'Sim', 68, 27),
(472, 92, 'Outros', 5.00, 0, 'Sim', 68, 32),
(473, 93, 'Bacalhau', 6.00, 0, 'Sim', 69, 31),
(474, 93, 'Bacon', 6.00, 0, 'Sim', 69, 1),
(475, 93, 'Camarão', 6.00, 0, 'Sim', 69, 30),
(476, 93, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 69, 25),
(477, 93, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 69, 26),
(478, 93, 'Carneiro', 6.00, 0, 'Sim', 69, 29),
(479, 93, 'Presunto', 2.00, 0, 'Sim', 69, 28),
(480, 93, 'Queijo', 2.00, 0, 'Sim', 69, 27),
(481, 93, 'Outros', 5.00, 0, 'Sim', 69, 32),
(482, 94, 'Bacalhau', 6.00, 0, 'Sim', 70, 31),
(483, 94, 'Bacon', 6.00, 0, 'Sim', 70, 1),
(484, 94, 'Camarão', 6.00, 0, 'Sim', 70, 30),
(485, 94, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 70, 25),
(486, 94, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 70, 26),
(487, 94, 'Carneiro', 6.00, 0, 'Sim', 70, 29),
(488, 94, 'Presunto', 2.00, 0, 'Sim', 70, 28),
(489, 94, 'Queijo', 2.00, 0, 'Sim', 70, 27),
(490, 94, 'Outros', 5.00, 0, 'Sim', 70, 32),
(491, 95, 'Bacalhau', 6.00, 0, 'Sim', 71, 31),
(492, 95, 'Bacon', 6.00, 0, 'Sim', 71, 1),
(493, 95, 'Camarão', 6.00, 0, 'Sim', 71, 30),
(494, 95, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 71, 25),
(495, 95, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 71, 26),
(496, 95, 'Carneiro', 6.00, 0, 'Sim', 71, 29),
(497, 95, 'Presunto', 2.00, 0, 'Sim', 71, 28),
(498, 95, 'Queijo', 2.00, 0, 'Sim', 71, 27),
(499, 95, 'Outros', 5.00, 0, 'Sim', 71, 32),
(500, 96, 'Bacalhau', 6.00, 0, 'Sim', 72, 31),
(501, 96, 'Bacon', 6.00, 0, 'Sim', 72, 1),
(502, 96, 'Camarão', 6.00, 0, 'Sim', 72, 30),
(503, 96, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 72, 25),
(504, 96, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 72, 26),
(505, 96, 'Carneiro', 6.00, 0, 'Sim', 72, 29),
(506, 96, 'Presunto', 2.00, 0, 'Sim', 72, 28),
(507, 96, 'Queijo', 2.00, 0, 'Sim', 72, 27),
(508, 96, 'Outros', 5.00, 0, 'Sim', 72, 32),
(509, 97, 'Bacalhau', 6.00, 0, 'Sim', 73, 31),
(510, 97, 'Bacon', 6.00, 0, 'Sim', 73, 1),
(511, 97, 'Camarão', 6.00, 0, 'Sim', 73, 30),
(512, 97, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 73, 25),
(513, 97, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 73, 26),
(514, 97, 'Carneiro', 6.00, 0, 'Sim', 73, 29),
(515, 97, 'Presunto', 2.00, 0, 'Sim', 73, 28),
(516, 97, 'Queijo', 2.00, 0, 'Sim', 73, 27),
(517, 97, 'Outros', 5.00, 0, 'Sim', 73, 32),
(518, 165, 'Bacalhau', 6.00, 0, 'Sim', 74, 31),
(519, 165, 'Bacon', 6.00, 0, 'Sim', 74, 1),
(520, 165, 'Camarão', 6.00, 0, 'Sim', 74, 30),
(521, 165, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 74, 25),
(522, 165, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 74, 26),
(523, 165, 'Carneiro', 6.00, 0, 'Sim', 74, 29),
(524, 165, 'Presunto', 2.00, 0, 'Sim', 74, 28),
(525, 165, 'Queijo', 2.00, 0, 'Sim', 74, 27),
(526, 165, 'Outros', 5.00, 0, 'Sim', 74, 32),
(527, 166, 'Bacalhau', 6.00, 0, 'Sim', 75, 31),
(528, 166, 'Bacon', 6.00, 0, 'Sim', 75, 1),
(529, 166, 'Camarão', 6.00, 0, 'Sim', 75, 30),
(530, 166, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 75, 25),
(531, 166, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 75, 26),
(532, 166, 'Carneiro', 6.00, 0, 'Sim', 75, 29),
(533, 166, 'Presunto', 2.00, 0, 'Sim', 75, 28),
(534, 166, 'Queijo', 2.00, 0, 'Sim', 75, 27),
(535, 166, 'Outros', 5.00, 0, 'Sim', 75, 32),
(536, 167, 'Bacalhau', 6.00, 0, 'Sim', 76, 31),
(537, 167, 'Bacon', 6.00, 0, 'Sim', 76, 1),
(538, 167, 'Camarão', 6.00, 0, 'Sim', 76, 30),
(539, 167, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 76, 25),
(540, 167, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 76, 26),
(541, 167, 'Carneiro', 6.00, 0, 'Sim', 76, 29),
(542, 167, 'Presunto', 2.00, 0, 'Sim', 76, 28),
(543, 167, 'Queijo', 2.00, 0, 'Sim', 76, 27),
(544, 167, 'Outros', 5.00, 0, 'Sim', 76, 32),
(545, 168, 'Bacalhau', 6.00, 0, 'Sim', 77, 31),
(546, 168, 'Bacon', 6.00, 0, 'Sim', 77, 1),
(547, 168, 'Camarão', 6.00, 0, 'Sim', 77, 30),
(548, 168, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 77, 25),
(549, 168, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 77, 26),
(550, 168, 'Carneiro', 6.00, 0, 'Sim', 77, 29),
(551, 168, 'Presunto', 2.00, 0, 'Sim', 77, 28),
(552, 168, 'Queijo', 2.00, 0, 'Sim', 77, 27),
(553, 168, 'Outros', 5.00, 0, 'Sim', 77, 32),
(554, 170, 'Bacalhau', 6.00, 0, 'Sim', 78, 31),
(555, 170, 'Bacon', 6.00, 0, 'Sim', 78, 1),
(556, 170, 'Camarão', 6.00, 0, 'Sim', 78, 30),
(557, 170, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 78, 25),
(558, 170, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 78, 26),
(559, 170, 'Carneiro', 6.00, 0, 'Sim', 78, 29),
(560, 170, 'Presunto', 2.00, 0, 'Sim', 78, 28),
(561, 170, 'Queijo', 2.00, 0, 'Sim', 78, 27),
(562, 170, 'Outros', 5.00, 0, 'Sim', 78, 32),
(563, 171, 'Bacalhau', 6.00, 0, 'Sim', 79, 31),
(564, 171, 'Bacon', 6.00, 0, 'Sim', 79, 1),
(565, 171, 'Camarão', 6.00, 0, 'Sim', 79, 30),
(566, 171, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 79, 25),
(567, 171, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 79, 26),
(568, 171, 'Carneiro', 6.00, 0, 'Sim', 79, 29),
(569, 171, 'Presunto', 2.00, 0, 'Sim', 79, 28),
(570, 171, 'Queijo', 2.00, 0, 'Sim', 79, 27),
(571, 171, 'Outros', 5.00, 0, 'Sim', 79, 32),
(572, 172, 'Bacalhau', 6.00, 0, 'Sim', 80, 31),
(573, 172, 'Bacon', 6.00, 0, 'Sim', 80, 1),
(574, 172, 'Camarão', 6.00, 0, 'Sim', 80, 30),
(575, 172, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 80, 25),
(576, 172, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 80, 26),
(577, 172, 'Carneiro', 6.00, 0, 'Sim', 80, 29),
(578, 172, 'Presunto', 2.00, 0, 'Sim', 80, 28),
(579, 172, 'Queijo', 2.00, 0, 'Sim', 80, 27),
(580, 172, 'Outros', 5.00, 0, 'Sim', 80, 32),
(581, 173, 'Bacalhau', 6.00, 0, 'Sim', 81, 31),
(582, 173, 'Bacon', 6.00, 0, 'Sim', 81, 1),
(583, 173, 'Camarão', 6.00, 0, 'Sim', 81, 30),
(584, 173, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 81, 25),
(585, 173, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 81, 26),
(586, 173, 'Carneiro', 6.00, 0, 'Sim', 81, 29),
(587, 173, 'Presunto', 2.00, 0, 'Sim', 81, 28),
(588, 173, 'Queijo', 2.00, 0, 'Sim', 81, 27),
(589, 173, 'Outros', 5.00, 0, 'Sim', 81, 32),
(590, 174, 'Bacalhau', 6.00, 0, 'Sim', 82, 31),
(591, 174, 'Bacon', 6.00, 0, 'Sim', 82, 1),
(592, 174, 'Camarão', 6.00, 0, 'Sim', 82, 30),
(593, 174, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 82, 25),
(594, 174, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 82, 26),
(595, 174, 'Carneiro', 6.00, 0, 'Sim', 82, 29),
(596, 174, 'Presunto', 2.00, 0, 'Sim', 82, 28),
(597, 174, 'Queijo', 2.00, 0, 'Sim', 82, 27),
(598, 174, 'Outros', 5.00, 0, 'Sim', 82, 32),
(599, 175, 'Bacalhau', 6.00, 0, 'Sim', 83, 31),
(600, 175, 'Bacon', 6.00, 0, 'Sim', 83, 1),
(601, 175, 'Camarão', 6.00, 0, 'Sim', 83, 30),
(602, 175, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 83, 25),
(603, 175, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 83, 26),
(604, 175, 'Carneiro', 6.00, 0, 'Sim', 83, 29),
(605, 175, 'Presunto', 2.00, 0, 'Sim', 83, 28),
(606, 175, 'Queijo', 2.00, 0, 'Sim', 83, 27),
(607, 175, 'Outros', 5.00, 0, 'Sim', 83, 32),
(608, 176, 'Bacalhau', 6.00, 0, 'Sim', 84, 31),
(609, 176, 'Bacon', 6.00, 0, 'Sim', 84, 1),
(610, 176, 'Camarão', 6.00, 0, 'Sim', 84, 30),
(611, 176, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 84, 25),
(612, 176, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 84, 26),
(613, 176, 'Carneiro', 6.00, 0, 'Sim', 84, 29),
(614, 176, 'Presunto', 2.00, 0, 'Sim', 84, 28),
(615, 176, 'Queijo', 2.00, 0, 'Sim', 84, 27),
(616, 176, 'Outros', 5.00, 0, 'Sim', 84, 32),
(617, 177, 'Bacalhau', 6.00, 0, 'Sim', 85, 31),
(618, 177, 'Bacon', 6.00, 0, 'Sim', 85, 1),
(619, 177, 'Camarão', 6.00, 0, 'Sim', 85, 30),
(620, 177, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 85, 25),
(621, 177, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 85, 26),
(622, 177, 'Carneiro', 6.00, 0, 'Sim', 85, 29),
(623, 177, 'Presunto', 2.00, 0, 'Sim', 85, 28),
(624, 177, 'Queijo', 2.00, 0, 'Sim', 85, 27),
(625, 177, 'Outros', 5.00, 0, 'Sim', 85, 32),
(626, 178, 'Bacalhau', 6.00, 0, 'Sim', 86, 31),
(627, 178, 'Bacon', 6.00, 0, 'Sim', 86, 1),
(628, 178, 'Camarão', 6.00, 0, 'Sim', 86, 30),
(629, 178, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 86, 25),
(630, 178, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 86, 26),
(631, 178, 'Carneiro', 6.00, 0, 'Sim', 86, 29),
(632, 178, 'Presunto', 2.00, 0, 'Sim', 86, 28),
(633, 178, 'Queijo', 2.00, 0, 'Sim', 86, 27),
(634, 178, 'Outros', 5.00, 0, 'Sim', 86, 32),
(635, 179, 'Bacalhau', 6.00, 0, 'Sim', 87, 31),
(636, 179, 'Bacon', 6.00, 0, 'Sim', 87, 1),
(637, 179, 'Camarão', 6.00, 0, 'Sim', 87, 30),
(638, 179, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 87, 25),
(639, 179, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 87, 26),
(640, 179, 'Carneiro', 6.00, 0, 'Sim', 87, 29),
(641, 179, 'Presunto', 2.00, 0, 'Sim', 87, 28),
(642, 179, 'Queijo', 2.00, 0, 'Sim', 87, 27),
(643, 179, 'Outros', 5.00, 0, 'Sim', 87, 32),
(644, 180, 'Bacalhau', 6.00, 0, 'Sim', 88, 31),
(645, 180, 'Bacon', 6.00, 0, 'Sim', 88, 1),
(646, 180, 'Camarão', 6.00, 0, 'Sim', 88, 30),
(647, 180, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 88, 25),
(648, 180, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 88, 26),
(649, 180, 'Carneiro', 6.00, 0, 'Sim', 88, 29),
(650, 180, 'Presunto', 2.00, 0, 'Sim', 88, 28),
(651, 180, 'Queijo', 2.00, 0, 'Sim', 88, 27),
(652, 180, 'Outros', 5.00, 0, 'Sim', 88, 32),
(653, 181, 'Bacalhau', 6.00, 0, 'Sim', 89, 31),
(654, 181, 'Bacon', 6.00, 0, 'Sim', 89, 1),
(655, 181, 'Camarão', 6.00, 0, 'Sim', 89, 30),
(656, 181, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 89, 25),
(657, 181, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 89, 26),
(658, 181, 'Carneiro', 6.00, 0, 'Sim', 89, 29),
(659, 181, 'Presunto', 2.00, 0, 'Sim', 89, 28),
(660, 181, 'Queijo', 2.00, 0, 'Sim', 89, 27),
(661, 181, 'Outros', 5.00, 0, 'Sim', 89, 32),
(662, 182, 'Bacalhau', 6.00, 0, 'Sim', 90, 31),
(663, 182, 'Bacon', 6.00, 0, 'Sim', 90, 1),
(664, 182, 'Camarão', 6.00, 0, 'Sim', 90, 30),
(665, 182, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 90, 25),
(666, 182, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 90, 26),
(667, 182, 'Carneiro', 6.00, 0, 'Sim', 90, 29),
(668, 182, 'Presunto', 2.00, 0, 'Sim', 90, 28),
(669, 182, 'Queijo', 2.00, 0, 'Sim', 90, 27),
(670, 182, 'Outros', 5.00, 0, 'Sim', 90, 32),
(671, 183, 'Bacalhau', 6.00, 0, 'Sim', 91, 31),
(672, 183, 'Bacon', 6.00, 0, 'Sim', 91, 1),
(673, 183, 'Camarão', 6.00, 0, 'Sim', 91, 30),
(674, 183, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 91, 25),
(675, 183, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 91, 26),
(676, 183, 'Carneiro', 6.00, 0, 'Sim', 91, 29),
(677, 183, 'Presunto', 2.00, 0, 'Sim', 91, 28),
(678, 183, 'Queijo', 2.00, 0, 'Sim', 91, 27),
(679, 183, 'Outros', 5.00, 0, 'Sim', 91, 32),
(680, 184, 'Bacalhau', 6.00, 0, 'Sim', 92, 31),
(681, 184, 'Bacon', 6.00, 0, 'Sim', 92, 1),
(682, 184, 'Camarão', 6.00, 0, 'Sim', 92, 30),
(683, 184, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 92, 25),
(684, 184, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 92, 26),
(685, 184, 'Carneiro', 6.00, 0, 'Sim', 92, 29),
(686, 184, 'Presunto', 2.00, 0, 'Sim', 92, 28),
(687, 184, 'Queijo', 2.00, 0, 'Sim', 92, 27),
(688, 184, 'Outros', 5.00, 0, 'Sim', 92, 32),
(689, 185, 'Bacalhau', 6.00, 0, 'Sim', 93, 31),
(690, 185, 'Bacon', 6.00, 0, 'Sim', 93, 1),
(691, 185, 'Camarão', 6.00, 0, 'Sim', 93, 30),
(692, 185, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 93, 25),
(693, 185, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 93, 26),
(694, 185, 'Carneiro', 6.00, 0, 'Sim', 93, 29),
(695, 185, 'Presunto', 2.00, 0, 'Sim', 93, 28),
(696, 185, 'Queijo', 2.00, 0, 'Sim', 93, 27),
(697, 185, 'Outros', 5.00, 0, 'Sim', 93, 32),
(698, 186, 'Bacalhau', 6.00, 0, 'Sim', 94, 31),
(699, 186, 'Bacon', 6.00, 0, 'Sim', 94, 1),
(700, 186, 'Camarão', 6.00, 0, 'Sim', 94, 30),
(701, 186, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 94, 25),
(702, 186, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 94, 26),
(703, 186, 'Carneiro', 6.00, 0, 'Sim', 94, 29),
(704, 186, 'Presunto', 2.00, 0, 'Sim', 94, 28),
(705, 186, 'Queijo', 2.00, 0, 'Sim', 94, 27),
(706, 186, 'Outros', 5.00, 0, 'Sim', 94, 32),
(707, 188, 'Bacalhau', 6.00, 0, 'Sim', 95, 31),
(708, 188, 'Bacon', 6.00, 0, 'Sim', 95, 1),
(709, 188, 'Camarão', 6.00, 0, 'Sim', 95, 30),
(710, 188, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 95, 25),
(711, 188, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 95, 26),
(712, 188, 'Carneiro', 6.00, 0, 'Sim', 95, 29),
(713, 188, 'Presunto', 2.00, 0, 'Sim', 95, 28),
(714, 188, 'Queijo', 2.00, 0, 'Sim', 95, 27),
(715, 188, 'Outros', 5.00, 0, 'Sim', 95, 32),
(716, 189, 'Bacalhau', 6.00, 0, 'Sim', 96, 31),
(717, 189, 'Bacon', 6.00, 0, 'Sim', 96, 1),
(718, 189, 'Camarão', 6.00, 0, 'Sim', 96, 30),
(719, 189, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 96, 25),
(720, 189, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 96, 26),
(721, 189, 'Carneiro', 6.00, 0, 'Sim', 96, 29),
(722, 189, 'Presunto', 2.00, 0, 'Sim', 96, 28),
(723, 189, 'Queijo', 2.00, 0, 'Sim', 96, 27),
(724, 189, 'Outros', 5.00, 0, 'Sim', 96, 32),
(725, 190, 'Bacalhau', 6.00, 0, 'Sim', 97, 31),
(726, 190, 'Bacon', 6.00, 0, 'Sim', 97, 1),
(727, 190, 'Camarão', 6.00, 0, 'Sim', 97, 30),
(728, 190, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 97, 25),
(729, 190, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 97, 26),
(730, 190, 'Carneiro', 6.00, 0, 'Sim', 97, 29),
(731, 190, 'Presunto', 2.00, 0, 'Sim', 97, 28),
(732, 190, 'Queijo', 2.00, 0, 'Sim', 97, 27),
(733, 190, 'Outros', 5.00, 0, 'Sim', 97, 32),
(734, 191, 'Bacalhau', 6.00, 0, 'Sim', 98, 31),
(735, 191, 'Bacon', 6.00, 0, 'Sim', 98, 1),
(736, 191, 'Camarão', 6.00, 0, 'Sim', 98, 30),
(737, 191, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 98, 25),
(738, 191, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 98, 26),
(739, 191, 'Carneiro', 6.00, 0, 'Sim', 98, 29),
(740, 191, 'Presunto', 2.00, 0, 'Sim', 98, 28),
(741, 191, 'Queijo', 2.00, 0, 'Sim', 98, 27),
(742, 191, 'Outros', 5.00, 0, 'Sim', 98, 32),
(743, 194, 'Bacalhau', 6.00, 0, 'Sim', 99, 31),
(744, 194, 'Bacon', 6.00, 0, 'Sim', 99, 1),
(745, 194, 'Camarão', 6.00, 0, 'Sim', 99, 30),
(746, 194, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 99, 25),
(747, 194, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 99, 26),
(748, 194, 'Carneiro', 6.00, 0, 'Sim', 99, 29),
(749, 194, 'Presunto', 2.00, 0, 'Sim', 99, 28),
(750, 194, 'Queijo', 2.00, 0, 'Sim', 99, 27),
(751, 194, 'Outros', 5.00, 0, 'Sim', 99, 32),
(752, 195, 'Bacalhau', 6.00, 0, 'Sim', 100, 31),
(753, 195, 'Bacon', 6.00, 0, 'Sim', 100, 1),
(754, 195, 'Camarão', 6.00, 0, 'Sim', 100, 30),
(755, 195, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 100, 25),
(756, 195, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 100, 26),
(757, 195, 'Carneiro', 6.00, 0, 'Sim', 100, 29),
(758, 195, 'Presunto', 2.00, 0, 'Sim', 100, 28),
(759, 195, 'Queijo', 2.00, 0, 'Sim', 100, 27),
(760, 195, 'Outros', 5.00, 0, 'Sim', 100, 32),
(761, 214, 'Bacalhau', 6.00, 0, 'Sim', 101, 31),
(762, 214, 'Bacon', 6.00, 0, 'Sim', 101, 1),
(763, 214, 'Camarão', 6.00, 0, 'Sim', 101, 30),
(764, 214, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 101, 25),
(765, 214, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 101, 26),
(766, 214, 'Carneiro', 6.00, 0, 'Sim', 101, 29),
(767, 214, 'Presunto', 2.00, 0, 'Sim', 101, 28),
(768, 214, 'Queijo', 2.00, 0, 'Sim', 101, 27),
(769, 214, 'Outros', 5.00, 0, 'Sim', 101, 32),
(770, 215, 'Bacalhau', 6.00, 0, 'Sim', 102, 31),
(771, 215, 'Bacon', 6.00, 0, 'Sim', 102, 1),
(772, 215, 'Camarão', 6.00, 0, 'Sim', 102, 30),
(773, 215, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 102, 25),
(774, 215, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 102, 26),
(775, 215, 'Carneiro', 6.00, 0, 'Sim', 102, 29),
(776, 215, 'Presunto', 2.00, 0, 'Sim', 102, 28),
(777, 215, 'Queijo', 2.00, 0, 'Sim', 102, 27),
(778, 215, 'Outros', 5.00, 0, 'Sim', 102, 32),
(779, 98, 'Bacalhau', 6.00, 0, 'Sim', 103, 31),
(780, 98, 'Bacon', 6.00, 0, 'Sim', 103, 1),
(781, 98, 'Camarão', 6.00, 0, 'Sim', 103, 30),
(782, 98, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 103, 25),
(783, 98, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 103, 26),
(784, 98, 'Carneiro', 6.00, 0, 'Sim', 103, 29),
(785, 98, 'Presunto', 2.00, 0, 'Sim', 103, 28),
(786, 98, 'Queijo', 2.00, 0, 'Sim', 103, 27),
(787, 98, 'Outros', 5.00, 0, 'Sim', 103, 32),
(788, 99, 'Bacalhau', 6.00, 0, 'Sim', 104, 31),
(789, 99, 'Bacon', 6.00, 0, 'Sim', 104, 1),
(790, 99, 'Camarão', 6.00, 0, 'Sim', 104, 30),
(791, 99, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 104, 25),
(792, 99, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 104, 26),
(793, 99, 'Carneiro', 6.00, 0, 'Sim', 104, 29),
(794, 99, 'Presunto', 2.00, 0, 'Sim', 104, 28),
(795, 99, 'Queijo', 2.00, 0, 'Sim', 104, 27),
(796, 99, 'Outros', 5.00, 0, 'Sim', 104, 32),
(797, 100, 'Bacalhau', 6.00, 0, 'Sim', 105, 31),
(798, 100, 'Bacon', 6.00, 0, 'Sim', 105, 1),
(799, 100, 'Camarão', 6.00, 0, 'Sim', 105, 30),
(800, 100, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 105, 25),
(801, 100, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 105, 26),
(802, 100, 'Carneiro', 6.00, 0, 'Sim', 105, 29),
(803, 100, 'Presunto', 2.00, 0, 'Sim', 105, 28),
(804, 100, 'Queijo', 2.00, 0, 'Sim', 105, 27),
(805, 100, 'Outros', 5.00, 0, 'Sim', 105, 32),
(806, 101, 'Bacalhau', 6.00, 0, 'Sim', 106, 31),
(807, 101, 'Bacon', 6.00, 0, 'Sim', 106, 1),
(808, 101, 'Camarão', 6.00, 0, 'Sim', 106, 30),
(809, 101, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 106, 25),
(810, 101, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 106, 26),
(811, 101, 'Carneiro', 6.00, 0, 'Sim', 106, 29),
(812, 101, 'Presunto', 2.00, 0, 'Sim', 106, 28),
(813, 101, 'Queijo', 2.00, 0, 'Sim', 106, 27),
(814, 101, 'Outros', 5.00, 0, 'Sim', 106, 32),
(815, 102, 'Bacalhau', 6.00, 0, 'Sim', 107, 31),
(816, 102, 'Bacon', 6.00, 0, 'Sim', 107, 1),
(817, 102, 'Camarão', 6.00, 0, 'Sim', 107, 30),
(818, 102, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 107, 25),
(819, 102, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 107, 26),
(820, 102, 'Carneiro', 6.00, 0, 'Sim', 107, 29),
(821, 102, 'Presunto', 2.00, 0, 'Sim', 107, 28),
(822, 102, 'Queijo', 2.00, 0, 'Sim', 107, 27),
(823, 102, 'Outros', 5.00, 0, 'Sim', 107, 32),
(824, 103, 'Bacalhau', 6.00, 0, 'Sim', 108, 31),
(825, 103, 'Bacon', 6.00, 0, 'Sim', 108, 1),
(826, 103, 'Camarão', 6.00, 0, 'Sim', 108, 30),
(827, 103, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 108, 25),
(828, 103, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 108, 26),
(829, 103, 'Carneiro', 6.00, 0, 'Sim', 108, 29),
(830, 103, 'Presunto', 2.00, 0, 'Sim', 108, 28),
(831, 103, 'Queijo', 2.00, 0, 'Sim', 108, 27),
(832, 103, 'Outros', 5.00, 0, 'Sim', 108, 32),
(833, 104, 'Bacalhau', 6.00, 0, 'Sim', 109, 31),
(834, 104, 'Bacon', 6.00, 0, 'Sim', 109, 1),
(835, 104, 'Camarão', 6.00, 0, 'Sim', 109, 30),
(836, 104, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 109, 25),
(837, 104, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 109, 26),
(838, 104, 'Carneiro', 6.00, 0, 'Sim', 109, 29),
(839, 104, 'Presunto', 2.00, 0, 'Sim', 109, 28),
(840, 104, 'Queijo', 2.00, 0, 'Sim', 109, 27),
(841, 104, 'Outros', 5.00, 0, 'Sim', 109, 32),
(842, 105, 'Bacalhau', 6.00, 0, 'Sim', 110, 31),
(843, 105, 'Bacon', 6.00, 0, 'Sim', 110, 1),
(844, 105, 'Camarão', 6.00, 0, 'Sim', 110, 30),
(845, 105, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 110, 25),
(846, 105, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 110, 26),
(847, 105, 'Carneiro', 6.00, 0, 'Sim', 110, 29),
(848, 105, 'Presunto', 2.00, 0, 'Sim', 110, 28),
(849, 105, 'Queijo', 2.00, 0, 'Sim', 110, 27),
(850, 105, 'Outros', 5.00, 0, 'Sim', 110, 32),
(851, 106, 'Bacalhau', 6.00, 0, 'Sim', 111, 31),
(852, 106, 'Bacon', 6.00, 0, 'Sim', 111, 1),
(853, 106, 'Camarão', 6.00, 0, 'Sim', 111, 30),
(854, 106, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 111, 25),
(855, 106, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 111, 26),
(856, 106, 'Carneiro', 6.00, 0, 'Sim', 111, 29),
(857, 106, 'Presunto', 2.00, 0, 'Sim', 111, 28),
(858, 106, 'Queijo', 2.00, 0, 'Sim', 111, 27),
(859, 106, 'Outros', 5.00, 0, 'Sim', 111, 32),
(860, 107, 'Bacalhau', 6.00, 0, 'Sim', 112, 31),
(861, 107, 'Bacon', 6.00, 0, 'Sim', 112, 1),
(862, 107, 'Camarão', 6.00, 0, 'Sim', 112, 30),
(863, 107, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 112, 25),
(864, 107, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 112, 26),
(865, 107, 'Carneiro', 6.00, 0, 'Sim', 112, 29),
(866, 107, 'Presunto', 2.00, 0, 'Sim', 112, 28),
(867, 107, 'Queijo', 2.00, 0, 'Sim', 112, 27),
(868, 107, 'Outros', 5.00, 0, 'Sim', 112, 32),
(869, 108, 'Bacalhau', 6.00, 0, 'Sim', 113, 31),
(870, 108, 'Bacon', 6.00, 0, 'Sim', 113, 1),
(871, 108, 'Camarão', 6.00, 0, 'Sim', 113, 30),
(872, 108, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 113, 25),
(873, 108, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 113, 26),
(874, 108, 'Carneiro', 6.00, 0, 'Sim', 113, 29),
(875, 108, 'Presunto', 2.00, 0, 'Sim', 113, 28),
(876, 108, 'Queijo', 2.00, 0, 'Sim', 113, 27),
(877, 108, 'Outros', 5.00, 0, 'Sim', 113, 32),
(878, 109, 'Bacalhau', 6.00, 0, 'Sim', 114, 31),
(879, 109, 'Bacon', 6.00, 0, 'Sim', 114, 1),
(880, 109, 'Camarão', 6.00, 0, 'Sim', 114, 30),
(881, 109, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 114, 25),
(882, 109, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 114, 26),
(883, 109, 'Carneiro', 6.00, 0, 'Sim', 114, 29),
(884, 109, 'Presunto', 2.00, 0, 'Sim', 114, 28),
(885, 109, 'Queijo', 2.00, 0, 'Sim', 114, 27),
(886, 109, 'Outros', 5.00, 0, 'Sim', 114, 32),
(887, 110, 'Bacalhau', 6.00, 0, 'Sim', 115, 31),
(888, 110, 'Bacon', 6.00, 0, 'Sim', 115, 1),
(889, 110, 'Camarão', 6.00, 0, 'Sim', 115, 30),
(890, 110, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 115, 25),
(891, 110, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 115, 26),
(892, 110, 'Carneiro', 6.00, 0, 'Sim', 115, 29),
(893, 110, 'Presunto', 2.00, 0, 'Sim', 115, 28),
(894, 110, 'Queijo', 2.00, 0, 'Sim', 115, 27),
(895, 110, 'Outros', 5.00, 0, 'Sim', 115, 32),
(896, 111, 'Bacalhau', 6.00, 0, 'Sim', 116, 31),
(897, 111, 'Bacon', 6.00, 0, 'Sim', 116, 1),
(898, 111, 'Camarão', 6.00, 0, 'Sim', 116, 30),
(899, 111, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 116, 25),
(900, 111, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 116, 26),
(901, 111, 'Carneiro', 6.00, 0, 'Sim', 116, 29),
(902, 111, 'Presunto', 2.00, 0, 'Sim', 116, 28),
(903, 111, 'Queijo', 2.00, 0, 'Sim', 116, 27),
(904, 111, 'Outros', 5.00, 0, 'Sim', 116, 32),
(905, 112, 'Bacalhau', 6.00, 0, 'Sim', 117, 31),
(906, 112, 'Bacon', 6.00, 0, 'Sim', 117, 1),
(907, 112, 'Camarão', 6.00, 0, 'Sim', 117, 30),
(908, 112, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 117, 25),
(909, 112, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 117, 26),
(910, 112, 'Carneiro', 6.00, 0, 'Sim', 117, 29),
(911, 112, 'Presunto', 2.00, 0, 'Sim', 117, 28),
(912, 112, 'Queijo', 2.00, 0, 'Sim', 117, 27),
(913, 112, 'Outros', 5.00, 0, 'Sim', 117, 32),
(914, 113, 'Bacalhau', 6.00, 0, 'Sim', 118, 31),
(915, 113, 'Bacon', 6.00, 0, 'Sim', 118, 1),
(916, 113, 'Camarão', 6.00, 0, 'Sim', 118, 30),
(917, 113, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 118, 25),
(918, 113, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 118, 26),
(919, 113, 'Carneiro', 6.00, 0, 'Sim', 118, 29),
(920, 113, 'Presunto', 2.00, 0, 'Sim', 118, 28),
(921, 113, 'Queijo', 2.00, 0, 'Sim', 118, 27),
(922, 113, 'Outros', 5.00, 0, 'Sim', 118, 32),
(923, 114, 'Bacalhau', 6.00, 0, 'Sim', 119, 31),
(924, 114, 'Bacon', 6.00, 0, 'Sim', 119, 1),
(925, 114, 'Camarão', 6.00, 0, 'Sim', 119, 30),
(926, 114, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 119, 25),
(927, 114, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 119, 26),
(928, 114, 'Carneiro', 6.00, 0, 'Sim', 119, 29),
(929, 114, 'Presunto', 2.00, 0, 'Sim', 119, 28),
(930, 114, 'Queijo', 2.00, 0, 'Sim', 119, 27),
(931, 114, 'Outros', 5.00, 0, 'Sim', 119, 32),
(932, 115, 'Bacalhau', 6.00, 0, 'Sim', 120, 31),
(933, 115, 'Bacon', 6.00, 0, 'Sim', 120, 1),
(934, 115, 'Camarão', 6.00, 0, 'Sim', 120, 30),
(935, 115, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 120, 25),
(936, 115, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 120, 26),
(937, 115, 'Carneiro', 6.00, 0, 'Sim', 120, 29),
(938, 115, 'Presunto', 2.00, 0, 'Sim', 120, 28),
(939, 115, 'Queijo', 2.00, 0, 'Sim', 120, 27),
(940, 115, 'Outros', 5.00, 0, 'Sim', 120, 32),
(941, 116, 'Bacalhau', 6.00, 0, 'Sim', 121, 31),
(942, 116, 'Bacon', 6.00, 0, 'Sim', 121, 1),
(943, 116, 'Camarão', 6.00, 0, 'Sim', 121, 30),
(944, 116, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 121, 25),
(945, 116, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 121, 26),
(946, 116, 'Carneiro', 6.00, 0, 'Sim', 121, 29),
(947, 116, 'Presunto', 2.00, 0, 'Sim', 121, 28),
(948, 116, 'Queijo', 2.00, 0, 'Sim', 121, 27),
(949, 116, 'Outros', 5.00, 0, 'Sim', 121, 32),
(950, 117, 'Bacalhau', 6.00, 0, 'Sim', 122, 31),
(951, 117, 'Bacon', 6.00, 0, 'Sim', 122, 1),
(952, 117, 'Camarão', 6.00, 0, 'Sim', 122, 30),
(953, 117, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 122, 25),
(954, 117, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 122, 26),
(955, 117, 'Carneiro', 6.00, 0, 'Sim', 122, 29),
(956, 117, 'Presunto', 2.00, 0, 'Sim', 122, 28),
(957, 117, 'Queijo', 2.00, 0, 'Sim', 122, 27),
(958, 117, 'Outros', 5.00, 0, 'Sim', 122, 32),
(959, 118, 'Bacalhau', 6.00, 0, 'Sim', 123, 31),
(960, 118, 'Bacon', 6.00, 0, 'Sim', 123, 1),
(961, 118, 'Camarão', 6.00, 0, 'Sim', 123, 30),
(962, 118, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 123, 25),
(963, 118, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 123, 26),
(964, 118, 'Carneiro', 6.00, 0, 'Sim', 123, 29),
(965, 118, 'Presunto', 2.00, 0, 'Sim', 123, 28),
(966, 118, 'Queijo', 2.00, 0, 'Sim', 123, 27),
(967, 118, 'Outros', 5.00, 0, 'Sim', 123, 32),
(968, 119, 'Bacalhau', 6.00, 0, 'Sim', 124, 31),
(969, 119, 'Bacon', 6.00, 0, 'Sim', 124, 1),
(970, 119, 'Camarão', 6.00, 0, 'Sim', 124, 30),
(971, 119, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 124, 25),
(972, 119, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 124, 26),
(973, 119, 'Carneiro', 6.00, 0, 'Sim', 124, 29),
(974, 119, 'Presunto', 2.00, 0, 'Sim', 124, 28),
(975, 119, 'Queijo', 2.00, 0, 'Sim', 124, 27),
(976, 119, 'Outros', 5.00, 0, 'Sim', 124, 32),
(977, 46, 'Bacalhau', 6.00, 0, 'Sim', 125, 31),
(978, 46, 'Bacon', 6.00, 0, 'Sim', 125, 1),
(979, 46, 'Camarão', 6.00, 0, 'Sim', 125, 30),
(980, 46, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 125, 25),
(981, 46, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 125, 26),
(982, 46, 'Carneiro', 6.00, 0, 'Sim', 125, 29),
(983, 142, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 128, 26),
(984, 46, 'Presunto', 2.00, 0, 'Sim', 125, 28),
(985, 46, 'Queijo', 2.00, 0, 'Sim', 125, 27),
(986, 46, 'Outros', 5.00, 0, 'Sim', 125, 32),
(987, 158, 'Bacalhau', 6.00, 0, 'Sim', 126, 31),
(988, 158, 'Camarão', 6.00, 0, 'Sim', 126, 30),
(989, 158, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 126, 25),
(990, 158, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 126, 26),
(991, 158, 'Carneiro', 6.00, 0, 'Sim', 126, 29),
(992, 158, 'Presunto', 2.00, 0, 'Sim', 126, 28),
(993, 158, 'Queijo', 2.00, 0, 'Sim', 126, 27),
(994, 158, 'Bacon', 6.00, 0, 'Sim', 126, 1),
(995, 158, 'Outros', 5.00, 0, 'Sim', 126, 32),
(996, 44, 'Bacalhau', 6.00, 0, 'Sim', 127, 31),
(997, 44, 'Bacon', 6.00, 0, 'Sim', 127, 1),
(998, 44, 'Camarão', 6.00, 0, 'Sim', 127, 30),
(999, 44, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 127, 25),
(1000, 44, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 127, 26),
(1001, 44, 'Presunto', 2.00, 0, 'Sim', 127, 28),
(1002, 144, 'Carneiro', 6.00, 0, 'Sim', 130, 29),
(1003, 144, 'Presunto', 2.00, 0, 'Sim', 130, 28),
(1004, 44, 'Queijo', 2.00, 0, 'Sim', 127, 27),
(1005, 44, 'Carneiro', 6.00, 0, 'Sim', 127, 29),
(1006, 44, 'Outros', 5.00, 0, 'Sim', 127, 32),
(1007, 145, 'Bacon', 6.00, 0, 'Sim', 131, 1),
(1008, 145, 'Camarão', 6.00, 0, 'Sim', 131, 30),
(1009, 145, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 131, 25),
(1010, 145, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 131, 26),
(1011, 145, 'Carneiro', 6.00, 0, 'Sim', 131, 29),
(1012, 145, 'Presunto', 2.00, 0, 'Sim', 131, 28),
(1013, 145, 'Queijo', 2.00, 0, 'Sim', 131, 27),
(1014, 145, 'Outros', 5.00, 0, 'Sim', 131, 32),
(1015, 146, 'Bacalhau', 6.00, 0, 'Sim', 132, 31),
(1016, 146, 'Bacon', 6.00, 0, 'Sim', 132, 1),
(1017, 146, 'Camarão', 6.00, 0, 'Sim', 132, 30),
(1018, 146, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 132, 25),
(1019, 146, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 132, 26),
(1020, 146, 'Carneiro', 6.00, 0, 'Sim', 132, 29),
(1021, 146, 'Presunto', 2.00, 0, 'Sim', 132, 28),
(1022, 146, 'Queijo', 2.00, 0, 'Sim', 132, 27),
(1023, 146, 'Outros', 5.00, 0, 'Sim', 132, 32),
(1024, 147, 'Bacalhau', 6.00, 0, 'Sim', 133, 31),
(1025, 147, 'Bacon', 6.00, 0, 'Sim', 133, 1),
(1026, 147, 'Camarão', 6.00, 0, 'Sim', 133, 30),
(1027, 147, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 133, 25),
(1028, 147, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 133, 26),
(1029, 147, 'Carneiro', 6.00, 0, 'Sim', 133, 29),
(1030, 142, 'Bacalhau', 6.00, 0, 'Sim', 128, 31),
(1031, 142, 'Bacon', 6.00, 0, 'Sim', 128, 1),
(1032, 142, 'Camarão', 6.00, 0, 'Sim', 128, 30),
(1033, 142, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 128, 25),
(1034, 142, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 128, 26),
(1035, 142, 'Carneiro', 6.00, 0, 'Sim', 128, 29),
(1036, 142, 'Presunto', 2.00, 0, 'Sim', 128, 28),
(1037, 142, 'Queijo', 2.00, 0, 'Sim', 128, 27),
(1038, 142, 'Outros', 5.00, 0, 'Sim', 128, 32),
(1039, 143, 'Bacalhau', 6.00, 0, 'Sim', 129, 31),
(1040, 143, 'Bacon', 6.00, 0, 'Sim', 129, 1),
(1041, 143, 'Camarão', 6.00, 0, 'Sim', 129, 30),
(1042, 143, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 129, 25),
(1043, 143, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 129, 26),
(1044, 143, 'Carneiro', 6.00, 0, 'Sim', 129, 29),
(1045, 143, 'Presunto', 2.00, 0, 'Sim', 129, 28),
(1046, 143, 'Queijo', 2.00, 0, 'Sim', 129, 27),
(1047, 143, 'Outros', 5.00, 0, 'Sim', 129, 32),
(1048, 144, 'Bacalhau', 6.00, 0, 'Sim', 130, 31),
(1049, 144, 'Bacon', 6.00, 0, 'Sim', 130, 1),
(1050, 144, 'Camarão', 6.00, 0, 'Sim', 130, 30),
(1051, 144, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 130, 25),
(1052, 144, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 130, 26),
(1053, 144, 'Carneiro', 6.00, 0, 'Sim', 130, 29),
(1054, 144, 'Presunto', 2.00, 0, 'Sim', 130, 28),
(1055, 144, 'Queijo', 2.00, 0, 'Sim', 130, 27),
(1056, 144, 'Outros', 5.00, 0, 'Sim', 130, 32),
(1057, 145, 'Bacalhau', 6.00, 0, 'Sim', 131, 31),
(1058, 145, 'Bacon', 6.00, 0, 'Sim', 131, 1),
(1059, 145, 'Camarão', 6.00, 0, 'Sim', 131, 30),
(1060, 145, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 131, 25),
(1061, 145, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 131, 26),
(1062, 145, 'Carneiro', 6.00, 0, 'Sim', 131, 29),
(1063, 145, 'Presunto', 2.00, 0, 'Sim', 131, 28),
(1064, 145, 'Queijo', 2.00, 0, 'Sim', 131, 27),
(1065, 145, 'Outros', 5.00, 0, 'Sim', 131, 32),
(1066, 146, 'Bacalhau', 6.00, 0, 'Sim', 132, 31),
(1067, 146, 'Bacon', 6.00, 0, 'Sim', 132, 1),
(1068, 146, 'Camarão', 6.00, 0, 'Sim', 132, 30),
(1069, 146, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 132, 25),
(1070, 146, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 132, 26),
(1071, 146, 'Carneiro', 6.00, 0, 'Sim', 132, 29),
(1072, 146, 'Presunto', 2.00, 0, 'Sim', 132, 28),
(1073, 146, 'Queijo', 2.00, 0, 'Sim', 132, 27),
(1074, 146, 'Outros', 5.00, 0, 'Sim', 132, 32),
(1075, 147, 'Bacalhau', 6.00, 0, 'Sim', 133, 31),
(1076, 147, 'Bacon', 6.00, 0, 'Sim', 133, 1),
(1077, 147, 'Camarão', 6.00, 0, 'Sim', 133, 30),
(1078, 147, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 133, 25),
(1079, 147, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 133, 26),
(1080, 147, 'Carneiro', 6.00, 0, 'Sim', 133, 29),
(1081, 147, 'Presunto', 2.00, 0, 'Sim', 133, 28),
(1082, 147, 'Queijo', 2.00, 0, 'Sim', 133, 27),
(1083, 147, 'Outros', 5.00, 0, 'Sim', 133, 32),
(1084, 148, 'Bacalhau', 6.00, 0, 'Sim', 134, 31),
(1085, 148, 'Bacon', 6.00, 0, 'Sim', 134, 1),
(1086, 148, 'Camarão', 6.00, 0, 'Sim', 134, 30),
(1087, 148, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 134, 25),
(1088, 148, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 134, 26),
(1089, 148, 'Carneiro', 6.00, 0, 'Sim', 134, 29),
(1090, 148, 'Presunto', 2.00, 0, 'Sim', 134, 28),
(1091, 148, 'Queijo', 2.00, 0, 'Sim', 134, 27),
(1092, 148, 'Outros', 5.00, 0, 'Sim', 134, 32),
(1093, 149, 'Bacalhau', 6.00, 0, 'Sim', 135, 31),
(1094, 149, 'Bacon', 6.00, 0, 'Sim', 135, 1),
(1095, 149, 'Camarão', 6.00, 0, 'Sim', 135, 30),
(1096, 149, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 135, 25);
INSERT INTO `itens_grade` (`id`, `produto`, `texto`, `valor`, `limite`, `ativo`, `grade`, `adicional`) VALUES
(1097, 149, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 135, 26),
(1098, 149, 'Carneiro', 6.00, 0, 'Sim', 135, 29),
(1099, 149, 'Presunto', 2.00, 0, 'Sim', 135, 28),
(1100, 149, 'Queijo', 2.00, 0, 'Sim', 135, 27),
(1101, 149, 'Outros', 5.00, 0, 'Sim', 135, 32),
(1102, 150, 'Bacalhau', 6.00, 0, 'Sim', 136, 31),
(1103, 150, 'Bacon', 6.00, 0, 'Sim', 136, 1),
(1104, 150, 'Camarão', 6.00, 0, 'Sim', 136, 30),
(1105, 150, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 136, 25),
(1106, 150, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 136, 26),
(1107, 150, 'Carneiro', 6.00, 0, 'Sim', 136, 29),
(1108, 150, 'Presunto', 2.00, 0, 'Sim', 136, 28),
(1109, 150, 'Queijo', 2.00, 0, 'Sim', 136, 27),
(1110, 150, 'Outros', 5.00, 0, 'Sim', 136, 32),
(1111, 151, 'Bacalhau', 6.00, 0, 'Sim', 137, 31),
(1112, 151, 'Bacon', 6.00, 0, 'Sim', 137, 1),
(1113, 151, 'Camarão', 6.00, 0, 'Sim', 137, 30),
(1114, 151, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 137, 25),
(1115, 151, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 137, 26),
(1116, 151, 'Carneiro', 6.00, 0, 'Sim', 137, 29),
(1117, 151, 'Presunto', 2.00, 0, 'Sim', 137, 28),
(1118, 151, 'Queijo', 2.00, 0, 'Sim', 137, 27),
(1119, 151, 'Outros', 5.00, 0, 'Sim', 137, 32),
(1120, 152, 'Bacalhau', 6.00, 0, 'Sim', 138, 31),
(1121, 152, 'Bacon', 6.00, 0, 'Sim', 138, 1),
(1122, 152, 'Camarão', 6.00, 0, 'Sim', 138, 30),
(1123, 152, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 138, 25),
(1124, 152, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 138, 26),
(1125, 152, 'Carneiro', 6.00, 0, 'Sim', 138, 29),
(1126, 152, 'Presunto', 2.00, 0, 'Sim', 138, 28),
(1127, 152, 'Queijo', 2.00, 0, 'Sim', 138, 27),
(1128, 152, 'Outros', 5.00, 0, 'Sim', 138, 32),
(1129, 153, 'Bacalhau', 6.00, 0, 'Sim', 139, 31),
(1130, 153, 'Bacon', 6.00, 0, 'Sim', 139, 1),
(1131, 153, 'Camarão', 6.00, 0, 'Sim', 139, 30),
(1132, 153, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 139, 25),
(1133, 153, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 139, 26),
(1134, 153, 'Carneiro', 6.00, 0, 'Sim', 139, 29),
(1135, 153, 'Presunto', 2.00, 0, 'Sim', 139, 28),
(1136, 153, 'Queijo', 2.00, 0, 'Sim', 139, 27),
(1137, 153, 'Outros', 5.00, 0, 'Sim', 139, 32),
(1138, 154, 'Bacalhau', 6.00, 0, 'Sim', 140, 31),
(1139, 154, 'Bacon', 6.00, 0, 'Sim', 140, 1),
(1140, 154, 'Camarão', 6.00, 0, 'Sim', 140, 30),
(1141, 154, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 140, 25),
(1142, 154, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 140, 26),
(1143, 154, 'Carneiro', 6.00, 0, 'Sim', 140, 29),
(1144, 154, 'Presunto', 2.00, 0, 'Sim', 140, 28),
(1145, 154, 'Queijo', 2.00, 0, 'Sim', 140, 27),
(1146, 154, 'Outros', 5.00, 0, 'Sim', 140, 32),
(1147, 155, 'Bacalhau', 6.00, 0, 'Sim', 141, 31),
(1148, 155, 'Bacon', 6.00, 0, 'Sim', 141, 1),
(1149, 155, 'Camarão', 6.00, 0, 'Sim', 141, 30),
(1150, 155, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 141, 25),
(1151, 155, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 141, 26),
(1152, 155, 'Carneiro', 6.00, 0, 'Sim', 141, 29),
(1153, 155, 'Presunto', 2.00, 0, 'Sim', 141, 28),
(1154, 155, 'Queijo', 2.00, 0, 'Sim', 141, 27),
(1155, 155, 'Outros', 5.00, 0, 'Sim', 141, 32),
(1156, 156, 'Bacalhau', 6.00, 0, 'Sim', 142, 31),
(1157, 156, 'Bacon', 6.00, 0, 'Sim', 142, 1),
(1158, 156, 'Camarão', 6.00, 0, 'Sim', 142, 30),
(1159, 156, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 142, 25),
(1160, 156, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 142, 26),
(1161, 156, 'Carneiro', 6.00, 0, 'Sim', 142, 29),
(1162, 156, 'Presunto', 2.00, 0, 'Sim', 142, 28),
(1163, 156, 'Queijo', 2.00, 0, 'Sim', 142, 27),
(1164, 156, 'Outros', 5.00, 0, 'Sim', 142, 32),
(1165, 157, 'Bacalhau', 6.00, 0, 'Sim', 143, 31),
(1166, 157, 'Bacon', 6.00, 0, 'Sim', 143, 1),
(1167, 157, 'Camarão', 6.00, 0, 'Sim', 143, 30),
(1168, 157, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 143, 25),
(1169, 157, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 143, 26),
(1170, 157, 'Carneiro', 6.00, 0, 'Sim', 143, 29),
(1171, 157, 'Presunto', 2.00, 0, 'Sim', 143, 28),
(1172, 157, 'Queijo', 2.00, 0, 'Sim', 143, 27),
(1173, 157, 'Outros', 5.00, 0, 'Sim', 143, 32),
(1174, 158, 'Bacalhau', 6.00, 0, 'Sim', 144, 31),
(1175, 158, 'Bacon', 6.00, 0, 'Sim', 144, 1),
(1176, 158, 'Camarão', 6.00, 0, 'Sim', 144, 30),
(1177, 158, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 144, 25),
(1178, 158, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 144, 26),
(1179, 158, 'Carneiro', 6.00, 0, 'Sim', 144, 29),
(1180, 158, 'Presunto', 2.00, 0, 'Sim', 144, 28),
(1181, 158, 'Queijo', 2.00, 0, 'Sim', 144, 27),
(1182, 158, 'Outros', 5.00, 0, 'Sim', 144, 32),
(1183, 159, 'Bacalhau', 6.00, 0, 'Sim', 145, 31),
(1184, 159, 'Bacon', 6.00, 0, 'Sim', 145, 1),
(1185, 159, 'Camarão', 6.00, 0, 'Sim', 145, 30),
(1186, 159, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 145, 25),
(1187, 159, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 145, 26),
(1188, 159, 'Carneiro', 6.00, 0, 'Sim', 145, 29),
(1189, 159, 'Presunto', 2.00, 0, 'Sim', 145, 28),
(1190, 159, 'Queijo', 2.00, 0, 'Sim', 145, 27),
(1191, 159, 'Outros', 5.00, 0, 'Sim', 145, 32),
(1192, 160, 'Bacalhau', 6.00, 0, 'Sim', 146, 31),
(1193, 160, 'Bacon', 6.00, 0, 'Sim', 146, 1),
(1194, 160, 'Camarão', 6.00, 0, 'Sim', 146, 30),
(1195, 160, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 146, 25),
(1196, 160, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 146, 26),
(1197, 160, 'Carneiro', 6.00, 0, 'Sim', 146, 29),
(1198, 160, 'Presunto', 2.00, 0, 'Sim', 146, 28),
(1199, 160, 'Queijo', 2.00, 0, 'Sim', 146, 27),
(1200, 160, 'Outros', 5.00, 0, 'Sim', 146, 32),
(1201, 161, 'Bacalhau', 6.00, 0, 'Sim', 147, 31),
(1202, 161, 'Bacon', 6.00, 0, 'Sim', 147, 1),
(1203, 161, 'Camarão', 6.00, 0, 'Sim', 147, 30),
(1204, 161, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 147, 25),
(1205, 161, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 147, 26),
(1206, 161, 'Carneiro', 6.00, 0, 'Sim', 147, 29),
(1207, 161, 'Presunto', 2.00, 0, 'Sim', 147, 28),
(1208, 161, 'Queijo', 2.00, 0, 'Sim', 147, 27),
(1209, 161, 'Outros', 5.00, 0, 'Sim', 147, 32),
(1210, 162, 'Bacalhau', 6.00, 0, 'Sim', 148, 31),
(1211, 162, 'Bacon', 6.00, 0, 'Sim', 148, 1),
(1212, 162, 'Camarão', 6.00, 0, 'Sim', 148, 30),
(1213, 162, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 148, 25),
(1214, 162, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 148, 26),
(1215, 162, 'Carneiro', 6.00, 0, 'Sim', 148, 29),
(1216, 162, 'Presunto', 2.00, 0, 'Sim', 148, 28),
(1217, 162, 'Queijo', 2.00, 0, 'Sim', 148, 27),
(1218, 162, 'Outros', 5.00, 0, 'Sim', 148, 32),
(1219, 163, 'Bacalhau', 6.00, 0, 'Sim', 149, 31),
(1220, 163, 'Bacon', 6.00, 0, 'Sim', 149, 1),
(1221, 163, 'Camarão', 6.00, 0, 'Sim', 149, 30),
(1222, 163, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 149, 25),
(1223, 163, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 149, 26),
(1224, 163, 'Carneiro', 6.00, 0, 'Sim', 149, 29),
(1225, 163, 'Presunto', 2.00, 0, 'Sim', 149, 28),
(1226, 163, 'Queijo', 2.00, 0, 'Sim', 149, 27),
(1227, 163, 'Outros', 5.00, 0, 'Sim', 149, 32),
(1228, 120, 'Bacalhau', 6.00, 0, 'Sim', 150, 31),
(1229, 120, 'Bacon', 6.00, 0, 'Sim', 150, 1),
(1230, 120, 'Camarão', 6.00, 0, 'Sim', 150, 30),
(1231, 120, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 150, 0),
(1232, 120, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 150, 26),
(1233, 120, 'Carneiro', 6.00, 0, 'Sim', 150, 29),
(1234, 120, 'Presunto', 2.00, 0, 'Sim', 150, 28),
(1235, 120, 'Queijo', 2.00, 0, 'Sim', 150, 27),
(1236, 120, 'Outros', 5.00, 0, 'Sim', 150, 32),
(1237, 121, 'Bacalhau', 6.00, 0, 'Sim', 151, 31),
(1238, 121, 'Bacon', 6.00, 0, 'Sim', 151, 1),
(1239, 121, 'Camarão', 6.00, 0, 'Sim', 151, 30),
(1240, 121, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 151, 0),
(1241, 121, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 151, 26),
(1242, 121, 'Carneiro', 6.00, 0, 'Sim', 151, 29),
(1243, 121, 'Presunto', 2.00, 0, 'Sim', 151, 28),
(1244, 121, 'Queijo', 2.00, 0, 'Sim', 151, 27),
(1245, 121, 'Outros', 5.00, 0, 'Sim', 151, 32),
(1246, 122, 'Bacalhau', 6.00, 0, 'Sim', 152, 31),
(1247, 122, 'Bacon', 6.00, 0, 'Sim', 152, 1),
(1248, 122, 'Camarão', 6.00, 0, 'Sim', 152, 30),
(1249, 122, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 152, 0),
(1250, 122, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 152, 26),
(1251, 122, 'Carneiro', 6.00, 0, 'Sim', 152, 29),
(1252, 122, 'Presunto', 2.00, 0, 'Sim', 152, 28),
(1253, 122, 'Queijo', 2.00, 0, 'Sim', 152, 27),
(1254, 122, 'Outros', 5.00, 0, 'Sim', 152, 32),
(1255, 123, 'Bacalhau', 6.00, 0, 'Sim', 153, 31),
(1256, 123, 'Bacon', 6.00, 0, 'Sim', 153, 1),
(1257, 123, 'Camarão', 6.00, 0, 'Sim', 153, 30),
(1258, 123, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 153, 0),
(1259, 123, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 153, 26),
(1260, 123, 'Carneiro', 6.00, 0, 'Sim', 153, 29),
(1261, 123, 'Presunto', 2.00, 0, 'Sim', 153, 28),
(1262, 123, 'Queijo', 2.00, 0, 'Sim', 153, 27),
(1263, 123, 'Outros', 5.00, 0, 'Sim', 153, 32),
(1264, 124, 'Bacalhau', 6.00, 0, 'Sim', 154, 31),
(1265, 124, 'Bacon', 6.00, 0, 'Sim', 154, 1),
(1266, 124, 'Camarão', 6.00, 0, 'Sim', 154, 30),
(1267, 124, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 154, 0),
(1268, 124, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 154, 26),
(1269, 124, 'Carneiro', 6.00, 0, 'Sim', 154, 29),
(1270, 124, 'Presunto', 2.00, 0, 'Sim', 154, 28),
(1271, 124, 'Queijo', 2.00, 0, 'Sim', 154, 27),
(1272, 124, 'Outros', 5.00, 0, 'Sim', 154, 32),
(1273, 125, 'Bacalhau', 6.00, 0, 'Sim', 155, 31),
(1274, 125, 'Bacon', 6.00, 0, 'Sim', 155, 1),
(1275, 125, 'Camarão', 6.00, 0, 'Sim', 155, 30),
(1276, 125, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 155, 0),
(1277, 125, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 155, 26),
(1278, 125, 'Carneiro', 6.00, 0, 'Sim', 155, 29),
(1279, 125, 'Presunto', 2.00, 0, 'Sim', 155, 28),
(1280, 125, 'Queijo', 2.00, 0, 'Sim', 155, 27),
(1281, 125, 'Outros', 5.00, 0, 'Sim', 155, 32),
(1282, 126, 'Bacalhau', 6.00, 0, 'Sim', 156, 31),
(1283, 126, 'Bacon', 6.00, 0, 'Sim', 156, 1),
(1284, 126, 'Camarão', 6.00, 0, 'Sim', 156, 30),
(1285, 126, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 156, 0),
(1286, 126, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 156, 26),
(1287, 126, 'Carneiro', 6.00, 0, 'Sim', 156, 29),
(1288, 126, 'Presunto', 2.00, 0, 'Sim', 156, 28),
(1289, 126, 'Queijo', 2.00, 0, 'Sim', 156, 27),
(1290, 126, 'Outros', 5.00, 0, 'Sim', 156, 32),
(1291, 127, 'Bacalhau', 6.00, 0, 'Sim', 157, 31),
(1292, 127, 'Bacon', 6.00, 0, 'Sim', 157, 1),
(1293, 127, 'Camarão', 6.00, 0, 'Sim', 157, 30),
(1294, 127, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 157, 0),
(1295, 127, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 157, 26),
(1296, 127, 'Carneiro', 6.00, 0, 'Sim', 157, 29),
(1297, 127, 'Presunto', 2.00, 0, 'Sim', 157, 28),
(1298, 127, 'Queijo', 2.00, 0, 'Sim', 157, 27),
(1299, 127, 'Outros', 5.00, 0, 'Sim', 157, 32),
(1300, 128, 'Bacalhau', 6.00, 0, 'Sim', 158, 31),
(1301, 128, 'Bacon', 6.00, 0, 'Sim', 158, 1),
(1302, 128, 'Camarão', 6.00, 0, 'Sim', 158, 30),
(1303, 128, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 158, 0),
(1304, 128, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 158, 26),
(1305, 128, 'Carneiro', 6.00, 0, 'Sim', 158, 29),
(1306, 128, 'Presunto', 2.00, 0, 'Sim', 158, 28),
(1307, 128, 'Queijo', 2.00, 0, 'Sim', 158, 27),
(1308, 128, 'Outros', 5.00, 0, 'Sim', 158, 32),
(1309, 129, 'Bacalhau', 6.00, 0, 'Sim', 159, 31),
(1310, 129, 'Bacon', 6.00, 0, 'Sim', 159, 1),
(1311, 129, 'Camarão', 6.00, 0, 'Sim', 159, 30),
(1312, 129, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 159, 0),
(1313, 129, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 159, 26),
(1314, 129, 'Carneiro', 6.00, 0, 'Sim', 159, 29),
(1315, 129, 'Presunto', 2.00, 0, 'Sim', 159, 28),
(1316, 129, 'Queijo', 2.00, 0, 'Sim', 159, 27),
(1317, 129, 'Outros', 5.00, 0, 'Sim', 159, 32),
(1318, 130, 'Bacalhau', 6.00, 0, 'Sim', 160, 31),
(1319, 130, 'Bacon', 6.00, 0, 'Sim', 160, 1),
(1320, 130, 'Camarão', 6.00, 0, 'Sim', 160, 30),
(1321, 130, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 160, 0),
(1322, 130, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 160, 26),
(1323, 130, 'Carneiro', 6.00, 0, 'Sim', 160, 29),
(1324, 130, 'Presunto', 2.00, 0, 'Sim', 160, 28),
(1325, 130, 'Queijo', 2.00, 0, 'Sim', 160, 27),
(1326, 130, 'Outros', 5.00, 0, 'Sim', 160, 32),
(1327, 131, 'Bacalhau', 6.00, 0, 'Sim', 161, 31),
(1328, 131, 'Bacon', 6.00, 0, 'Sim', 161, 1),
(1329, 131, 'Camarão', 6.00, 0, 'Sim', 161, 30),
(1330, 131, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 161, 0),
(1331, 131, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 161, 26),
(1332, 131, 'Carneiro', 6.00, 0, 'Sim', 161, 29),
(1333, 131, 'Presunto', 2.00, 0, 'Sim', 161, 28),
(1334, 131, 'Queijo', 2.00, 0, 'Sim', 161, 27),
(1335, 131, 'Outros', 5.00, 0, 'Sim', 161, 32),
(1336, 132, 'Bacalhau', 6.00, 0, 'Sim', 162, 31),
(1337, 132, 'Bacon', 6.00, 0, 'Sim', 162, 1),
(1338, 132, 'Camarão', 6.00, 0, 'Sim', 162, 30),
(1339, 132, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 162, 0),
(1340, 132, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 162, 26),
(1341, 132, 'Carneiro', 6.00, 0, 'Sim', 162, 29),
(1342, 132, 'Presunto', 2.00, 0, 'Sim', 162, 28),
(1343, 132, 'Queijo', 2.00, 0, 'Sim', 162, 27),
(1344, 132, 'Outros', 5.00, 0, 'Sim', 162, 32),
(1345, 133, 'Bacalhau', 6.00, 0, 'Sim', 163, 31),
(1346, 133, 'Bacon', 6.00, 0, 'Sim', 163, 1),
(1347, 133, 'Camarão', 6.00, 0, 'Sim', 163, 30),
(1348, 133, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 163, 0),
(1349, 133, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 163, 26),
(1350, 133, 'Carneiro', 6.00, 0, 'Sim', 163, 29),
(1351, 133, 'Presunto', 2.00, 0, 'Sim', 163, 28),
(1352, 133, 'Queijo', 2.00, 0, 'Sim', 163, 27),
(1353, 133, 'Outros', 5.00, 0, 'Sim', 163, 32),
(1354, 134, 'Bacalhau', 6.00, 0, 'Sim', 164, 31),
(1355, 134, 'Bacon', 6.00, 0, 'Sim', 164, 1),
(1356, 134, 'Camarão', 6.00, 0, 'Sim', 164, 30),
(1357, 134, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 164, 0),
(1358, 134, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 164, 26),
(1359, 134, 'Carneiro', 6.00, 0, 'Sim', 164, 29),
(1360, 134, 'Presunto', 2.00, 0, 'Sim', 164, 28),
(1361, 134, 'Queijo', 2.00, 0, 'Sim', 164, 27),
(1362, 134, 'Outros', 5.00, 0, 'Sim', 164, 32),
(1363, 135, 'Bacalhau', 6.00, 0, 'Sim', 165, 31),
(1364, 135, 'Bacon', 6.00, 0, 'Sim', 165, 1),
(1365, 135, 'Camarão', 6.00, 0, 'Sim', 165, 30),
(1366, 135, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 165, 0),
(1367, 135, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 165, 26),
(1368, 135, 'Carneiro', 6.00, 0, 'Sim', 165, 29),
(1369, 135, 'Presunto', 2.00, 0, 'Sim', 165, 28),
(1370, 135, 'Queijo', 2.00, 0, 'Sim', 165, 27),
(1371, 135, 'Outros', 5.00, 0, 'Sim', 165, 32),
(1372, 136, 'Bacalhau', 6.00, 0, 'Sim', 166, 31),
(1373, 136, 'Bacon', 6.00, 0, 'Sim', 166, 1),
(1374, 136, 'Camarão', 6.00, 0, 'Sim', 166, 30),
(1375, 136, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 166, 0),
(1376, 136, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 166, 26),
(1377, 136, 'Carneiro', 6.00, 0, 'Sim', 166, 29),
(1378, 136, 'Presunto', 2.00, 0, 'Sim', 166, 28),
(1379, 136, 'Queijo', 2.00, 0, 'Sim', 166, 27),
(1380, 136, 'Outros', 5.00, 0, 'Sim', 166, 32),
(1381, 137, 'Bacalhau', 6.00, 0, 'Sim', 167, 31),
(1382, 137, 'Bacon', 6.00, 0, 'Sim', 167, 1),
(1383, 137, 'Camarão', 6.00, 0, 'Sim', 167, 30),
(1384, 137, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 167, 0),
(1385, 137, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 167, 26),
(1386, 137, 'Carneiro', 6.00, 0, 'Sim', 167, 29),
(1387, 137, 'Presunto', 2.00, 0, 'Sim', 167, 28),
(1388, 137, 'Queijo', 2.00, 0, 'Sim', 167, 27),
(1389, 137, 'Outros', 5.00, 0, 'Sim', 167, 32),
(1390, 138, 'Bacalhau', 6.00, 0, 'Sim', 168, 31),
(1391, 138, 'Bacon', 6.00, 0, 'Sim', 168, 1),
(1392, 138, 'Camarão', 6.00, 0, 'Sim', 168, 30),
(1393, 138, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 168, 0),
(1394, 138, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 168, 26),
(1395, 138, 'Carneiro', 6.00, 0, 'Sim', 168, 29),
(1396, 138, 'Presunto', 2.00, 0, 'Sim', 168, 28),
(1397, 138, 'Queijo', 2.00, 0, 'Sim', 168, 27),
(1398, 138, 'Outros', 5.00, 0, 'Sim', 168, 32),
(1399, 139, 'Bacalhau', 6.00, 0, 'Sim', 169, 31),
(1400, 139, 'Bacon', 6.00, 0, 'Sim', 169, 1),
(1401, 139, 'Camarão', 6.00, 0, 'Sim', 169, 30),
(1402, 139, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 169, 0),
(1403, 139, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 169, 26),
(1404, 139, 'Carneiro', 6.00, 0, 'Sim', 169, 29),
(1405, 139, 'Presunto', 2.00, 0, 'Sim', 169, 28),
(1406, 139, 'Queijo', 2.00, 0, 'Sim', 169, 27),
(1407, 139, 'Outros', 5.00, 0, 'Sim', 169, 32),
(1408, 140, 'Bacalhau', 6.00, 0, 'Sim', 170, 31),
(1409, 140, 'Bacon', 6.00, 0, 'Sim', 170, 1),
(1410, 140, 'Camarão', 6.00, 0, 'Sim', 170, 30),
(1411, 140, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 170, 0),
(1412, 140, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 170, 26),
(1413, 140, 'Carneiro', 6.00, 0, 'Sim', 170, 29),
(1414, 140, 'Presunto', 2.00, 0, 'Sim', 170, 28),
(1415, 140, 'Queijo', 2.00, 0, 'Sim', 170, 27),
(1416, 140, 'Outros', 5.00, 0, 'Sim', 170, 32),
(1417, 141, 'Bacalhau', 6.00, 0, 'Sim', 170, 31),
(1418, 141, 'Bacon', 6.00, 0, 'Sim', 170, 1),
(1419, 141, 'Camarão', 6.00, 0, 'Sim', 170, 30),
(1420, 141, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 170, 0),
(1421, 141, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 170, 26),
(1422, 141, 'Carneiro', 6.00, 0, 'Sim', 170, 29),
(1423, 141, 'Presunto', 2.00, 0, 'Sim', 170, 28),
(1424, 141, 'Queijo', 2.00, 0, 'Sim', 170, 27),
(1425, 141, 'Outros', 5.00, 0, 'Sim', 170, 32),
(1426, 197, 'Bacalhau', 6.00, 0, 'Sim', 172, 31),
(1427, 197, 'Bacon', 6.00, 0, 'Sim', 172, 1),
(1428, 197, 'Camarão', 6.00, 0, 'Sim', 172, 30),
(1429, 197, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 172, 25),
(1430, 197, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 172, 26),
(1431, 197, 'Carneiro', 6.00, 0, 'Sim', 172, 29),
(1432, 197, 'Presunto', 2.00, 0, 'Sim', 172, 28),
(1433, 197, 'Queijo', 2.00, 0, 'Sim', 172, 27),
(1434, 197, 'Outros', 5.00, 0, 'Sim', 172, 32),
(1435, 196, 'Bacalhau', 6.00, 0, 'Sim', 173, 31),
(1436, 196, 'Bacon', 6.00, 0, 'Sim', 173, 1),
(1437, 196, 'Camarão', 6.00, 0, 'Sim', 173, 30),
(1438, 196, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 173, 25),
(1439, 196, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 173, 26),
(1440, 196, 'Carneiro', 6.00, 0, 'Sim', 173, 29),
(1441, 196, 'Presunto', 2.00, 0, 'Sim', 173, 28),
(1442, 196, 'Queijo', 2.00, 0, 'Sim', 173, 27),
(1443, 196, 'Outros', 5.00, 0, 'Sim', 173, 32),
(1444, 193, 'Bacalhau', 6.00, 0, 'Sim', 174, 31),
(1445, 193, 'Bacon', 6.00, 0, 'Sim', 174, 1),
(1446, 193, 'Camarão', 6.00, 0, 'Sim', 174, 30),
(1447, 193, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 174, 25),
(1448, 193, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 174, 26),
(1449, 193, 'Carneiro', 6.00, 0, 'Sim', 174, 29),
(1450, 193, 'Presunto', 2.00, 0, 'Sim', 174, 28),
(1451, 193, 'Queijo', 2.00, 0, 'Sim', 174, 27),
(1452, 193, 'Outros', 5.00, 0, 'Sim', 174, 32),
(1453, 192, 'Bacalhau', 6.00, 0, 'Sim', 175, 31),
(1454, 192, 'Bacon', 6.00, 0, 'Sim', 175, 1),
(1455, 192, 'Camarão', 6.00, 0, 'Sim', 175, 30),
(1456, 192, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 175, 25),
(1457, 192, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 175, 26),
(1458, 192, 'Carneiro', 6.00, 0, 'Sim', 175, 29),
(1459, 192, 'Presunto', 2.00, 0, 'Sim', 175, 28),
(1460, 192, 'Queijo', 2.00, 0, 'Sim', 175, 27),
(1461, 192, 'Outros', 5.00, 0, 'Sim', 175, 32),
(1462, 187, 'Bacalhau', 6.00, 0, 'Sim', 176, 31),
(1463, 187, 'Bacon', 6.00, 0, 'Sim', 176, 1),
(1464, 187, 'Camarão', 6.00, 0, 'Sim', 176, 30),
(1465, 187, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 176, 25),
(1466, 187, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 176, 26),
(1467, 187, 'Carneiro', 6.00, 0, 'Sim', 176, 29),
(1468, 187, 'Presunto', 2.00, 0, 'Sim', 176, 28),
(1469, 187, 'Queijo', 2.00, 0, 'Sim', 176, 27),
(1470, 187, 'Outros', 5.00, 0, 'Sim', 176, 32),
(1471, 169, 'Bacalhau', 6.00, 0, 'Sim', 177, 31),
(1472, 169, 'Bacon', 6.00, 0, 'Sim', 177, 1),
(1473, 169, 'Camarão', 6.00, 0, 'Sim', 177, 30),
(1474, 169, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 177, 25),
(1475, 169, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 177, 26),
(1476, 169, 'Carneiro', 6.00, 0, 'Sim', 177, 29),
(1477, 169, 'Presunto', 2.00, 0, 'Sim', 177, 28),
(1478, 169, 'Queijo', 2.00, 0, 'Sim', 177, 27),
(1479, 169, 'Outros', 5.00, 0, 'Sim', 177, 32),
(1480, 79, 'Bacalhau', 6.00, 0, 'Sim', 178, 31),
(1481, 79, 'Bacon', 6.00, 0, 'Sim', 178, 1),
(1482, 79, 'Camarão', 6.00, 0, 'Sim', 178, 30),
(1483, 79, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 178, 25),
(1484, 79, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 178, 26),
(1485, 79, 'Carneiro', 6.00, 0, 'Sim', 178, 29),
(1486, 79, 'Presunto', 2.00, 0, 'Sim', 178, 28),
(1487, 79, 'Queijo', 2.00, 0, 'Sim', 178, 27),
(1488, 79, 'Outros', 5.00, 0, 'Sim', 178, 32),
(1489, 78, 'Bacalhau', 6.00, 0, 'Sim', 179, 31),
(1490, 78, 'Bacon', 6.00, 0, 'Sim', 179, 1),
(1491, 78, 'Camarão', 6.00, 0, 'Sim', 179, 30),
(1492, 78, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 179, 25),
(1493, 78, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 179, 26),
(1494, 78, 'Carneiro', 6.00, 0, 'Sim', 179, 29),
(1495, 78, 'Presunto', 2.00, 0, 'Sim', 179, 28),
(1496, 78, 'Queijo', 2.00, 0, 'Sim', 179, 27),
(1497, 78, 'Outros', 5.00, 0, 'Sim', 179, 32),
(1498, 77, 'Bacalhau', 6.00, 0, 'Sim', 180, 31),
(1499, 77, 'Bacon', 6.00, 0, 'Sim', 180, 1),
(1500, 77, 'Camarão', 6.00, 0, 'Sim', 180, 30),
(1501, 77, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 180, 25),
(1502, 77, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 180, 26),
(1503, 77, 'Carneiro', 6.00, 0, 'Sim', 180, 29),
(1504, 77, 'Presunto', 2.00, 0, 'Sim', 180, 28),
(1505, 77, 'Queijo', 2.00, 0, 'Sim', 180, 27),
(1506, 77, 'Outros', 5.00, 0, 'Sim', 180, 32),
(1507, 76, 'Bacalhau', 6.00, 0, 'Sim', 181, 31),
(1508, 76, 'Bacon', 6.00, 0, 'Sim', 181, 1),
(1509, 76, 'Camarão', 6.00, 0, 'Sim', 181, 30),
(1510, 76, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 181, 25),
(1511, 76, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 181, 26),
(1512, 76, 'Carneiro', 6.00, 0, 'Sim', 181, 29),
(1513, 76, 'Presunto', 2.00, 0, 'Sim', 181, 28),
(1514, 76, 'Queijo', 2.00, 0, 'Sim', 181, 27),
(1515, 76, 'Outros', 5.00, 0, 'Sim', 181, 32),
(1516, 229, 'Bacalhau', 6.00, 0, 'Sim', 182, 31),
(1517, 229, 'Bacon', 6.00, 0, 'Sim', 182, 1),
(1518, 229, 'Camarão', 6.00, 0, 'Sim', 182, 30),
(1519, 229, 'Carne de Hambúrguer', 4.00, 0, 'Sim', 182, 25),
(1520, 229, 'Carne de Hambúrguer Picanha', 5.00, 0, 'Sim', 182, 26),
(1521, 229, 'Carneiro', 6.00, 0, 'Sim', 182, 29),
(1522, 229, 'Presunto', 2.00, 0, 'Sim', 182, 28),
(1523, 229, 'Queijo', 2.00, 0, 'Sim', 182, 27),
(1524, 229, 'Outros', 5.00, 0, 'Sim', 182, 32),
(1525, 244, 'Lata 350ml', 5.00, 0, 'Sim', 183, 0),
(1526, 244, '1 litro', 8.00, 0, 'Sim', 183, 0),
(1527, 244, '2 litros', 14.00, 0, 'Sim', 183, 0),
(1528, 244, 'Goob 230ml', 2.00, 0, 'Sim', 183, 0),
(1529, 222, 'Sem gás ', 2.00, 0, 'Sim', 186, 0),
(1530, 222, 'Com gás ', 3.00, 0, 'Sim', 186, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `marketing`
--

CREATE TABLE `marketing` (
  `id` int(11) NOT NULL,
  `data` date NOT NULL,
  `data_envio` date DEFAULT NULL,
  `envios` int(11) DEFAULT NULL,
  `titulo` varchar(100) DEFAULT NULL,
  `mensagem` varchar(500) DEFAULT NULL,
  `item1` varchar(100) DEFAULT NULL,
  `item2` varchar(100) DEFAULT NULL,
  `item3` varchar(100) DEFAULT NULL,
  `item4` varchar(100) DEFAULT NULL,
  `item5` varchar(100) DEFAULT NULL,
  `item6` varchar(100) DEFAULT NULL,
  `item7` varchar(100) DEFAULT NULL,
  `item8` varchar(100) DEFAULT NULL,
  `item9` varchar(100) DEFAULT NULL,
  `item10` varchar(100) DEFAULT NULL,
  `item11` varchar(100) DEFAULT NULL,
  `item12` varchar(100) DEFAULT NULL,
  `item13` varchar(100) DEFAULT NULL,
  `item14` varchar(100) DEFAULT NULL,
  `item15` varchar(100) DEFAULT NULL,
  `item16` varchar(100) DEFAULT NULL,
  `item17` varchar(100) DEFAULT NULL,
  `item18` varchar(100) DEFAULT NULL,
  `item19` varchar(100) DEFAULT NULL,
  `item20` varchar(100) DEFAULT NULL,
  `conclusao` varchar(500) DEFAULT NULL,
  `arquivo` varchar(100) DEFAULT NULL,
  `audio` varchar(100) DEFAULT NULL,
  `forma_envio` varchar(50) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `video` varchar(255) DEFAULT NULL,
  `conclusao2` varchar(500) DEFAULT NULL,
  `conclusao3` varchar(500) DEFAULT NULL,
  `conclusao4` varchar(500) DEFAULT NULL,
  `link2` varchar(255) DEFAULT NULL,
  `conclusao5` varchar(500) DEFAULT NULL,
  `documento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `marketing`
--

INSERT INTO `marketing` (`id`, `data`, `data_envio`, `envios`, `titulo`, `mensagem`, `item1`, `item2`, `item3`, `item4`, `item5`, `item6`, `item7`, `item8`, `item9`, `item10`, `item11`, `item12`, `item13`, `item14`, `item15`, `item16`, `item17`, `item18`, `item19`, `item20`, `conclusao`, `arquivo`, `audio`, `forma_envio`, `link`, `video`, `conclusao2`, `conclusao3`, `conclusao4`, `link2`, `conclusao5`, `documento`) VALUES
(1, '2025-02-26', NULL, NULL, 'Teste aa', 'Teste mensagem', '1', '2', '3', '4', '5', '6', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'mensagem acima link 1', '26-02-2025-12-36-29-08-08-2023-22-46-38-arte-whats-eu.png', '26-02-2025-12-36-29-13-07-2023-18-52-36-WhatsApp-Ptt-2023-07-13-at-18.34.03.ogg', NULL, 'link 1', 'link 2', 'mensagem abaixo link 1', 'mensagem conc 1', 'mensagem conc 2', 'link 2', 'mensagem acima link 2', '26-02-2025-12-36-29-16-08-2023-14-36-51-09-11-2021-14-59-23-pdfteste.pdf'),
(3, '2025-02-26', NULL, NULL, 'Aproveite nossas promoções', 'Ofertas em diversos produtos', 'Sanduíches', 'Pizzas', 'Açaí', 'Sorvetes', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', 'Acesse nosso site agora mesmo', '26-02-2025-18-17-19-prom.png', '26-02-2025-18-17-19-13-07-2023-18-52-36-WhatsApp-Ptt-2023-07-13-at-18.34.03.ogg', NULL, 'https://deliveryinterativo.sistemashugo.com.br', '', '', 'Ganhe um cartão fidelidade a cada compra', '', '', '', 'sem-foto.jpg');

-- --------------------------------------------------------

--
-- Estrutura da tabela `mesas`
--

CREATE TABLE `mesas` (
  `id` int(11) NOT NULL,
  `nome` varchar(25) NOT NULL,
  `ativo` varchar(5) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `mesas`
--

INSERT INTO `mesas` (`id`, `nome`, `ativo`, `status`) VALUES
(21, '01', 'Sim', 'Aberta'),
(22, '02', 'Sim', 'Fechada'),
(24, '04', 'Não', 'Fechada'),
(25, '05', 'Sim', 'Fechada'),
(26, '06', 'Não', 'Fechada'),
(27, '07', 'Sim', 'Fechada'),
(33, '08', 'Sim', 'Fechada'),
(34, '03', 'Sim', 'Fechada');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pagar`
--

CREATE TABLE `pagar` (
  `id` int(11) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `fornecedor` int(11) DEFAULT NULL,
  `funcionario` int(11) DEFAULT NULL,
  `valor` decimal(8,2) DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `data_pgto` date DEFAULT NULL,
  `data_lanc` date DEFAULT NULL,
  `forma_pgto` varchar(50) DEFAULT NULL,
  `frequencia` int(11) DEFAULT NULL,
  `obs` varchar(100) DEFAULT NULL,
  `arquivo` varchar(100) DEFAULT NULL,
  `referencia` varchar(30) DEFAULT NULL,
  `id_ref` int(11) DEFAULT NULL,
  `multa` decimal(8,2) DEFAULT NULL,
  `juros` decimal(8,2) DEFAULT NULL,
  `desconto` decimal(8,2) DEFAULT NULL,
  `taxa` decimal(8,2) DEFAULT NULL,
  `subtotal` decimal(8,2) DEFAULT NULL,
  `usuario_lanc` int(11) DEFAULT NULL,
  `usuario_pgto` int(11) DEFAULT NULL,
  `pago` varchar(5) DEFAULT NULL,
  `residuo` varchar(5) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `hash` varchar(100) DEFAULT NULL,
  `caixa` int(11) DEFAULT NULL,
  `produto` int(11) DEFAULT NULL,
  `pessoa` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `cliente` int(11) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `tipo` varchar(20) DEFAULT NULL,
  `comissao` varchar(35) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `pagar`
--

INSERT INTO `pagar` (`id`, `descricao`, `fornecedor`, `funcionario`, `valor`, `vencimento`, `data_pgto`, `data_lanc`, `forma_pgto`, `frequencia`, `obs`, `arquivo`, `referencia`, `id_ref`, `multa`, `juros`, `desconto`, `taxa`, `subtotal`, `usuario_lanc`, `usuario_pgto`, `pago`, `residuo`, `hora`, `hash`, `caixa`, `produto`, `pessoa`, `quantidade`, `cliente`, `foto`, `tipo`, `comissao`) VALUES
(1, 'Conta de Luz', 0, 0, 40.00, '2025-02-08', '2025-02-08', '2025-02-08', '2', 0, '', 'sem-foto.png', 'Conta', NULL, 0.00, 0.00, 0.00, NULL, 40.00, 1, 1, 'Sim', NULL, '09:53:04', '1368200', 1, NULL, NULL, NULL, NULL, 'sem-foto.png', NULL, NULL),
(2, 'Comissão Garçon', NULL, 18, 3.00, '2025-02-25', '2025-03-07', '2025-02-25', NULL, NULL, NULL, 'sem-foto.jpg', 'Comissão', 1, NULL, NULL, NULL, NULL, NULL, 1, 1, 'Sim', NULL, '17:04:58', NULL, 0, NULL, 0, NULL, NULL, 'sem-foto.png', 'Comissão', 'Garçon'),
(3, 'Comissão Garçon', NULL, 18, 2.40, '2025-02-25', '2025-03-07', '2025-02-25', NULL, NULL, NULL, 'sem-foto.jpg', 'Comissão', 2, NULL, NULL, NULL, NULL, NULL, 1, 1, 'Sim', NULL, '17:04:58', NULL, 0, NULL, 0, NULL, NULL, 'sem-foto.png', 'Comissão', 'Garçon'),
(4, 'Comissão Garçon', NULL, 18, 2.30, '2025-02-25', '2025-03-07', '2025-02-25', '2', NULL, NULL, 'sem-foto.jpg', 'Comissão', 3, 15.00, 0.12, 0.00, NULL, 17.42, 1, 1, 'Sim', NULL, '17:04:44', NULL, 0, NULL, 0, NULL, NULL, 'sem-foto.png', 'Comissão', 'Garçon'),
(5, 'Comissão Garçon', NULL, 18, 0.00, '2025-04-13', NULL, '2025-04-13', NULL, NULL, NULL, 'sem-foto.jpg', 'Comissão', 4, NULL, NULL, NULL, NULL, NULL, 1, NULL, 'Não', NULL, NULL, NULL, 0, NULL, 0, NULL, NULL, 'sem-foto.png', 'Comissão', 'Garçon');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

CREATE TABLE `produtos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` varchar(1000) DEFAULT NULL,
  `categoria` int(11) NOT NULL,
  `valor_compra` decimal(8,2) NOT NULL,
  `valor_venda` decimal(8,2) NOT NULL,
  `estoque` int(11) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `nivel_estoque` int(11) NOT NULL,
  `tem_estoque` varchar(5) NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `url` varchar(100) NOT NULL,
  `guarnicoes` int(11) DEFAULT NULL,
  `promocao` varchar(5) DEFAULT NULL,
  `combo` varchar(5) DEFAULT NULL,
  `delivery` varchar(5) DEFAULT NULL,
  `preparado` varchar(5) DEFAULT NULL,
  `val_promocional` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `descricao`, `categoria`, `valor_compra`, `valor_venda`, `estoque`, `foto`, `nivel_estoque`, `tem_estoque`, `ativo`, `url`, `guarnicoes`, `promocao`, `combo`, `delivery`, `preparado`, `val_promocional`) VALUES
(3, 'Taça de Açaí', 'Taça de Açaí', 8, 0.00, 0.00, 9, '17-11-2024-15-37-55-337827-original.jpg', 0, 'Não', 'Sim', 'taca-de-acai', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(14, 'DRAGÃO PICANHA', '2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, SALADA E MILHO VERDE', 1, 0.00, 20.00, 0, '24-12-2023-14-23-40-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(16, 'MIX DRAGÃO', 'CARNE DE HAMBÚRGUER, CARNE DO SOL, LOMBO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 1, 0.00, 18.00, 0, '24-12-2023-14-22-47-ESPECIAL.jpg', 0, 'Não', 'Sim', 'mix-dragao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(17, 'DRAGÃO BACON', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, BACON, SALADA E MILHO VERDE', 1, 0.00, 20.00, 0, '24-12-2023-14-22-10-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(28, 'MISTO QUENTE', 'QUEIJO E PRESUNTO', 10, 0.00, 4.00, 0, '23-12-2023-22-47-41-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'misto-quente', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(29, 'AMERICANO', 'OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 10, 0.00, 5.00, 0, '23-12-2023-22-48-39-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'americano', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(30, 'HAMBÚRGUER', 'CARNE DE HAMBÚRGUER, SALADA E MILHO VERDE', 10, 0.00, 5.00, 0, '23-12-2023-22-49-20-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'hamburguer', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(31, 'HAMB. DA CASA BACON', '2 CARNES DE HAMBÚRGUER, FATIA DE BACON, MAIONESE, SALADA E MILHO VERDE', 10, 0.00, 12.00, 0, '23-12-2023-22-49-43-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'hamb.-da-casa-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(32, 'HAMB. DA CASA CALABRESA', '2 CARNES DE HAMBÚRGUER, CALABRESA , MAIONESE, SALADA E MILHO VERDE', 10, 0.00, 12.00, 0, '23-12-2023-22-50-01-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'hamb.-da-casa-calabresa', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(33, 'HAMB. DA CASA LOMBO', '2 CARNES DE HAMBÚRGUER, LOMBO, MAIONESE, SALADA E MILHO VERDE', 10, 0.00, 13.00, 0, '23-12-2023-22-50-29-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'hamb.-da-casa-lombo', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(34, 'X-BURGUER', 'CARNE DE HAMBÚRGUER, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 10, 0.00, 8.00, 0, '23-12-2023-22-51-24-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'x-burguer', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(35, 'EGGS-BURGUER', 'CARNE DE HAMBÚRGUER, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 10, 0.00, 10.00, 0, '23-12-2023-22-51-43-TRADICIONAIS.jpg', 0, 'Não', 'Sim', 'eggs-burguer', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(36, 'X-FRANGO', 'CARNE DE HAMBÚRGUER, FRANGO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 9, 12.00, 12.00, 0, '23-12-2023-22-52-08-FRANGO.jpg', 0, 'Não', 'Sim', 'x-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(37, 'X-FRANGO PICANHA', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 9, 0.00, 18.00, 0, '23-12-2023-22-52-24-FRANGO.jpg', 0, 'Não', 'Sim', 'x-frango-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(38, 'EGGS-FRANGO', 'CARNE DE HAMBÚRGUER, FRANGO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 9, 14.00, 14.00, 0, '23-12-2023-22-52-42-FRANGO.jpg', 0, 'Não', 'Sim', 'eggs-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(39, 'EGGS-FRANGO PICANHA', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 9, 0.00, 19.00, 0, '23-12-2023-22-53-01-FRANGO.jpg', 0, 'Não', 'Sim', 'eggs-frango-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(40, 'EGGS-FRANGO COM BACON', 'CARNE DE HAMBÚRGUER, FRANGO, OVO, PRESUNTO, BACON, QUEIJO, SALADA E MILHO VERDE', 9, 0.00, 16.00, 0, '23-12-2023-22-53-17-FRANGO.jpg', 0, 'Não', 'Sim', 'eggs-frango-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(41, 'X-FILÉ DE FRANGO', 'CARNE DE HAMBÚRGUER, FILÉ DE FRANGO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 9, 0.00, 19.00, 0, '23-12-2023-22-53-40-FRANGO.jpg', 0, 'Não', 'Sim', 'x-file-de-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(42, 'EGGS-FILÉ DE FRANGO', 'CARNE DE HAMBÚRGUER, FILÉ DE FRANGO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 9, 0.00, 21.00, 0, '23-12-2023-22-53-55-FRANGO.jpg', 0, 'Não', 'Sim', 'eggs-file-de-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(43, 'X-CORAÇÃO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO, QUEIJO, PRESUNTO, SALADA E MILHO VERDE', 7, 0.00, 14.00, 0, '23-12-2023-22-55-58-CORAÇÃO.jpg', 0, 'Não', 'Sim', 'x-coracao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(44, 'X-CORAÇÃO DE PICANHA', 'CARNE DE HAMBÚRGUERR(PICANHA), CORAÇÃO, QUEIJO, PRESUNTO, SALADA E MILHO VERDE', 7, 0.00, 19.00, 0, '23-12-2023-22-56-25-CORAÇÃO.jpg', 0, 'Não', 'Sim', 'x-coracao-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(45, 'EGGS-CORAÇÃO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO, OVO, QUEIJO, PRESUNTO, SALADA E MILHO VERDE', 7, 0.00, 16.00, 0, '23-12-2023-22-56-47-CORAÇÃO.jpg', 0, 'Não', 'Sim', 'eggs-coracao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(46, 'EGGS-CORAÇÃO DE PICANHA', 'CARNE DE HAMBÚRGUERR(PICANHA), CORAÇÃO, OVO, QUEIJO, PRESUNTO, SALADA E MILHO VERDE', 7, 0.00, 19.00, 0, '23-12-2023-22-57-07-CORAÇÃO.jpg', 0, 'Não', 'Sim', 'eggs-coracao-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(47, 'X-CALABRESA', 'CARNE DE HAMBÚRGUER, CALABRESA, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 20, 12.00, 12.00, 0, '23-12-2023-22-57-41-CALABRESA.jpg', 0, 'Não', 'Sim', 'x-calabresa', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(48, 'X-CALABRESA DE PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), CALABRESA, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 20, 0.00, 18.00, 0, '23-12-2023-22-58-06-CALABRESA.jpg', 0, 'Não', 'Sim', 'x-calabresa-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(49, 'EGGS-CALABRESA', 'CARNE DE HAMBÚRGUER, CALABRESA, OVO, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 20, 14.00, 14.00, 0, '23-12-2023-22-58-30-CALABRESA.jpg', 0, 'Não', 'Sim', 'eggs-calabresa', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(50, 'EGGS-CALABRESA DE PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), CALABRESA, OVO, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 20, 0.00, 19.00, 0, '23-12-2023-22-58-48-CALABRESA.jpg', 0, 'Não', 'Sim', 'eggs-calabresa-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(51, 'X-BURGUER DE TOSCANA', 'CARNE DE HAMBÚRGUER, TOSCANA, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 22, 0.00, 12.00, 0, '23-12-2023-23-04-01-TOSCANA.jpg', 0, 'Não', 'Sim', 'x-burguer-de-toscana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(52, 'X-BURGUER DE TOSCANA COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), TOSCANA, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 22, 0.00, 17.00, 0, '23-12-2023-23-04-27-TOSCANA.jpg', 0, 'Não', 'Sim', 'x-burguer-de-toscana-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(53, 'EGGS-BURGUER DE TOSCANA', 'CARNE DE HAMBÚRGUER, TOSCANA, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 22, 0.00, 14.00, 0, '23-12-2023-23-04-44-TOSCANA.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-toscana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(54, 'EGGS-BURGUER DE TOSCANA COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), TOSCANA, OVO, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 22, 0.00, 19.00, 0, '23-12-2023-23-05-01-TOSCANA.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-toscana-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(55, 'X-BACON', 'CARNE DE HAMBÚRGUER, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 19, 12.00, 12.00, 0, '24-12-2023-13-49-57-BACON.jpg', 0, 'Não', 'Sim', 'x-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(56, 'X-BACON DE PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), BACON, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 19, 0.00, 17.00, 0, '24-12-2023-13-50-26-BACON.jpg', 0, 'Não', 'Sim', 'x-bacon-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(57, 'EGGS-BACON', 'CARNE DE HAMBÚRGUER, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 19, 14.00, 14.00, 0, '24-12-2023-13-50-49-BACON.jpg', 0, 'Não', 'Sim', 'eggs-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(58, 'EGGS-BACON DE PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 19, 0.00, 18.00, 0, '24-12-2023-13-51-08-BACON.jpg', 0, 'Não', 'Sim', 'eggs-bacon-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(59, 'X-BURGUER DE LOMBO', 'CARNE DE HAMBÚRGUER, LOMBO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 15, 0.00, 13.00, 0, '24-12-2023-13-51-34-LOMBO.jpg', 0, 'Não', 'Sim', 'x-burguer-de-lombo', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(60, 'X-BURGUER DE LOMBO COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), LOMBO, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 15, 0.00, 18.00, 0, '24-12-2023-13-52-38-LOMBO.jpg', 0, 'Não', 'Sim', 'x-burguer-de-lombo-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(61, 'EGGS-BURGUER DE LOMBO', 'CARNE DE HAMBÚRGUER, LOMBO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 15, 0.00, 14.00, 0, '24-12-2023-13-53-01-LOMBO.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-lombo', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(62, 'EGGS-BURGUER DE LOMBO COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), LOMBO, OVO, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 15, 0.00, 19.00, 0, '24-12-2023-13-53-23-LOMBO.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-lombo-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(63, 'X-BURGUER DE CARNE DO SOL', 'CARNE DE HAMBÚRGUER, CARNE DO SOL, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 21, 14.00, 14.00, 0, '24-12-2023-13-54-06-CARNE-DO-SOL.jpg', 0, 'Não', 'Sim', 'x-burguer-de-carne-do-sol', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(64, 'X-BURGUER DE CARNE DO SOL COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), CARNE DO SOL, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 21, 0.00, 17.00, 0, '24-12-2023-13-55-28-CARNE-DO-SOL.jpg', 0, 'Não', 'Sim', 'x-burguer-de-carne-do-sol-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(65, 'EGGS-BURGUER DE CARNE DO SOL ', 'CARNE DE HAMBÚRGUER, CARNE DO SOL, OVO, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 21, 16.00, 16.00, 0, '24-12-2023-13-55-51-CARNE-DO-SOL.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-carne-do-sol', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(66, 'EGGS-BURGUER DE CARNE DO SOL COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), CARNE DO SOL, OVO, PRESUNTO, QUEIJO, SALADA  E MILHO VERDE', 21, 0.00, 20.00, 0, '24-12-2023-13-56-14-CARNE-DO-SOL.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-carne-do-sol-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(67, 'X-BURGUER DE CHARQUE', 'CARNE DE HAMBÚRGUER, CHARQUE, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 17, 0.00, 14.00, 0, '24-12-2023-13-56-44-CHARQUE.jpg', 0, 'Não', 'Sim', 'x-burguer-de-charque', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(68, 'X-BURGUER DE CHARQUE COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), CHARQUE, PRESUNTO, QUEIJO, SALADA E MILHO  VERDE', 17, 0.00, 19.00, 0, '24-12-2023-13-57-31-CHARQUE.jpg', 0, 'Não', 'Sim', 'x-burguer-de-charque-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(69, 'EGGS-BURGUER DE CHARQUE ', 'CARNE DE HAMBÚRGUER, CHARQUE, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 17, 0.00, 16.00, 0, '24-12-2023-13-57-55-CHARQUE.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-charque', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(70, 'EGGS-BURGUER DE CHARQUE COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), CHARQUE, OVO, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 17, 0.00, 22.00, 0, '24-12-2023-13-59-23-CHARQUE.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-charque-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(71, 'X-BURGUER DE FILÉ', 'CARNE DE HAMBÚRGUER, FILÉ, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 12, 0.00, 15.00, 0, '24-12-2023-13-59-54-FILE.jpg', 0, 'Não', 'Sim', 'x-burguer-de-file', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(72, 'X-BURGUER DE FILÉ COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), FILÉ, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 12, 0.00, 20.00, 0, '24-12-2023-14-00-21-FILE.jpg', 0, 'Não', 'Sim', 'x-burguer-de-file-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(73, 'EGGS-BURGUER DE FILÉ', 'CARNE DE HAMBÚRGUER, FILÉ, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 12, 0.00, 18.00, 0, '24-12-2023-14-00-43-FILE.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-file', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(74, 'EGGS-BURGUER DE FILÉ COM PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), FILÉ, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 12, 0.00, 23.00, 0, '24-12-2023-14-01-01-FILE.jpg', 0, 'Não', 'Sim', 'eggs-burguer-de-file-com-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(75, 'HAMBÚRGUERR DE PICANHA', 'CARNE DE HAMBÚRGUERR(PICANHA), SALADA E MILHO VERDE', 14, 0.00, 11.00, 0, '24-12-2023-14-01-28-PICANHA.jpg', 0, 'Não', 'Sim', 'hamburguerr-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(76, 'X-BURGER DE PICANHA', 'CARNE DE HAMBÚRGUERR(PICANHA), QUEIJO, PRESUNTO, SALADA E MILHO VERDE', 14, 0.00, 13.00, 0, '24-12-2023-14-02-02-PICANHA.jpg', 0, 'Não', 'Sim', 'x-burger-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(77, 'X-BURGER DE PICANHA COM TOSCANA', 'CARNE DE HAMBÚRGUERR(PICANHA), OVO, TOSCANA, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 14, 0.00, 15.50, 0, '24-12-2023-14-03-58-PICANHA.jpg', 0, 'Não', 'Sim', 'x-burger-de-picanha-com-toscana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(78, 'EGGS-BURGER DE PICANHA', 'CARNE DE HAMBÚRGUERR(PICANHA), OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 14, 0.00, 14.00, 0, '24-12-2023-14-07-27-PICANHA.jpg', 0, 'Não', 'Sim', 'eggs-burger-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(79, 'EGGS-BURGER DE PICANHA COM TOSCANA', 'CARNE DE HAMBÚRGUERR(PICANHA), OVO, TOSCANA, PRESUNTO, QUEIJO, SALADA E  MILHO VERDE', 14, 0.00, 17.00, 0, '24-12-2023-14-07-54-PICANHA.jpg', 0, 'Não', 'Sim', 'eggs-burger-de-picanha-com-toscana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(80, 'MIX DRAGÃO 2', 'CARNE DE HAMBÚRGUER, CHARQUE, OVO, FRANGO DESFIADO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 1, 0.00, 21.00, 0, '24-12-2023-14-08-55-ESPECIAL.jpg', 0, 'Não', 'Sim', 'mix-dragao-2', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(81, 'MIX DRAGÃO 3', 'CARNE DE HAMBÚRGUER, CHARQUE, OVO, CALABRESA, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 1, 0.00, 20.00, 0, '24-12-2023-14-09-20-ESPECIAL.jpg', 0, 'Não', 'Sim', 'mix-dragao-3', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(82, 'MIX DRAGÃO 4', 'CARNE DE HAMBÚRGUER, CARNE DO SOL, OVO, CORAÇÃO DE GALINHA, PRESUNTO, QUEIJO,  SALADA E MILHO VERDE', 1, 0.00, 25.00, 0, '24-12-2023-14-09-43-ESPECIAL.jpg', 0, 'Não', 'Sim', 'mix-dragao-4', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(84, 'DRAGÃO', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, SALADA E MILHO VERDE', 1, 15.00, 15.00, 0, '24-12-2023-14-19-43-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(85, 'DRAGÃO CALABRESA', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, CALABRESA, SALADA E MILHO  VERDE', 1, 0.00, 20.00, 0, '24-12-2023-14-20-41-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-calabresa', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(86, 'DRAGÃO CORAÇÃO DE GALINHA', '2 CARNES DE HAMBÚRGUER, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, CORAÇÃO DE GALINHA, SALADA E  MILHO VERDE', 1, 0.00, 22.00, 0, '24-12-2023-14-24-47-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-coracao-de-galinha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(87, 'DRAGÃO CHARQUE', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, CHARQUE, SALADA E MILHO VERDE', 1, 0.00, 22.00, 0, '24-12-2023-14-25-15-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-charque', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(88, 'DRAGÃO CARNE DO SOL', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, CARNE DO SOL, SALADA E MILHO  VERDE', 1, 0.00, 23.00, 0, '24-12-2023-14-25-40-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-carne-do-sol', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(89, 'DRAGÃO FRANGO', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, FRANGO, SALADA E MILHO VERDE', 1, 0.00, 21.00, 0, '24-12-2023-14-26-07-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(90, 'DRAGÃO FILÉ', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, FILÉ, SALADA E MILHO VERDE', 1, 0.00, 20.00, 0, '24-12-2023-14-26-27-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-file', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(91, 'DRAGÃO TOSCANA', '2 CARNES DE HAMBÚRGUERR, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, TOSCANA, SALADA E MILHO VERDE', 1, 0.00, 21.00, 0, '24-12-2023-14-27-10-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-toscana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(92, 'DRAGÃO PICANHA COM BACON', 'DRAGÃO PICANHA COM BACON 2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, BACON, SALADA E  MILHO VERDE', 1, 25.00, 25.00, 0, '24-12-2023-14-29-34-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(93, 'DRAGÃO PICANHA COM CALABRESA', '2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, CALABRESA, SALADA E  MILHO VERDE', 1, 0.00, 28.00, 0, '24-12-2023-14-29-58-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha-com-calabresa', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(94, 'DRAGÃO PICANHA COM CORAÇÃO DE GALINHA', '2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, CORAÇÃO DE  GALINHA, SALADA E MILHO VERDE', 1, 0.00, 31.00, 0, '24-12-2023-14-30-25-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha-com-coracao-de-galinha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(95, 'DRAGÃO PICANHA COM FRANGO', '2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, FRANGO, SALADA E  MILHO VERDE', 1, 0.00, 28.00, 0, '24-12-2023-14-30-47-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha-com-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(96, 'DRAGÃO PICANHA COM FILÉ', '2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, FILÉ, SALADA E MILHO  VERDE', 1, 0.00, 32.00, 0, '24-12-2023-14-31-21-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha-com-file', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(97, 'DRAGÃO PICANHA COM TOSCANA', '2 CARNES DE HAMBÚRGUERR DE PICANHA, 2 OVOS, 2 PRESUNTOS, 2 QUEIJOS, TOSCANA, SALADA E  MILHO VERDE', 1, 0.00, 30.00, 0, '24-12-2023-14-31-45-ESPECIAL.jpg', 0, 'Não', 'Sim', 'dragao-picanha-com-toscana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(98, 'HAMBÚRGUER DE CARNEIRO', 'CARNE DE HAMBÚRGUERR, CARNEIRO, SALADA E MILHO VERDE', 2, 0.00, 14.00, 0, '15-01-2024-09-38-57-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'hamburguer-de-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(99, 'X-BURGUER DE CARNEIRO', 'CARNE DE HAMBÚRGUERR, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 15.00, 0, '15-01-2024-09-41-19-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-burguer-de-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(100, 'EGGS-BURGUER DE CARNEIRO', 'CARNE DE HAMBÚRGUERR, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 18.00, 0, '15-01-2024-09-42-12-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(101, 'X-BACON COM CARNEIRO', 'CARNE DE HAMBÚRGUERR, CARNEIRO, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 20.00, 0, '15-01-2024-09-42-39-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-bacon-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(102, 'EGGS-BACON COM CARNEIRO', 'CARNE DE HAMBÚRGUERR, CARNEIRO, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 22.00, 0, '15-01-2024-09-43-19-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-bacon-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(103, 'HAMBÚRGUERR DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CARNEIRO, SALADA E MILHO VERDE', 2, 0.00, 15.00, 0, '15-01-2024-09-45-02-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'hamburguerr-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(104, 'X-BURGUER DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 22.00, 0, '15-01-2024-09-45-33-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-burguer-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(105, 'EGGS-BURGUER DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 25.00, 0, '15-01-2024-09-46-01-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(106, 'X-BACON DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CARNEIRO, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 24.00, 0, '15-01-2024-09-46-34-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-bacon-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(107, 'EGGS-BACON DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CARNEIRO, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 26.00, 0, '15-01-2024-09-47-06-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-bacon-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(108, 'X-FRANGO COM CARNEIRO', 'CARNE DE HAMBÚRGUER, FRANGO, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 20.00, 0, '15-01-2024-09-47-35-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-frango-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(109, 'EGGS-FRANGO COM CARNEIRO', 'CARNE DE HAMBÚRGUER, FRANGO, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 22.00, 0, '15-01-2024-09-48-09-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-frango-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(110, 'X-FRANGO PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 25.00, 0, '15-01-2024-09-50-30-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-frango-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(111, 'EGGS-FRANGO PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 28.00, 0, '15-01-2024-09-50-56-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-frango-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(112, 'X-CORAÇÃO COM CARNEIRO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 20.00, 0, '15-01-2024-09-51-23-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-coracao-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(113, 'EGGS-CORAÇÃO COM CARNEIRO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 22.00, 0, '15-01-2024-09-51-47-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-coracao-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(114, 'X-CORAÇÃO DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 25.00, 0, '15-01-2024-09-52-11-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-coracao-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(115, 'EGGS-CORAÇÃO DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, CARNEIRO, OVO PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 28.00, 0, '15-01-2024-09-52-34-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-coracao-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(116, 'X-CALABRESA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR, CALABRESA, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 20.00, 0, '15-01-2024-09-53-22-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-calabresa-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(117, 'EGGS-CALABRESA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR, CALABRESA, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 22.00, 0, '15-01-2024-09-53-52-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(118, 'X-CALABRESA DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CALABRESA, CARNEIRO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 25.00, 0, '15-01-2024-09-54-19-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'x-calabresa-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(119, 'EGGS-CALABRESA DE PICANHA COM CARNEIRO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CALABRESA, CARNEIRO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 2, 0.00, 28.00, 0, '15-01-2024-09-54-47-WhatsApp-Image-2023-12-25-at-19.16.05-(5).jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-de-picanha-com-carneiro', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(120, 'HAMBÚRGUERR DE CAMARÃO', 'CARNE DE HAMBÚRGUERR, CAMARÃO, SALADA E MILHO VERDE .............', 16, 0.00, 12.00, 0, '15-01-2024-09-56-06-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'hamburguerr-de-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(121, 'X-BURGUER DE CAMARÃO', 'CARNE DE HAMBÚRGUERR, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 15.00, 0, '15-01-2024-09-56-31-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-burguer-de-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(122, 'EGGS-BURGUER DE CAMARÃO', 'CARNE DE HAMBÚRGUERR, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 18.00, 0, '15-01-2024-09-57-38-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(123, 'X-BACON COM CAMARÃO', 'CARNE DE HAMBÚRGUERR, CAMARÃO, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 21.00, 0, '15-01-2024-09-58-09-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-bacon-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(124, 'EGGS-BACON COM CAMARÃO', 'CARNE DE HAMBÚRGUERR, CAMARÃO, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 23.00, 0, '15-01-2024-09-58-41-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-bacon-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(125, 'HAMBÚRGUER DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CAMARÃO, SALADA E MILHO VERDE', 16, 0.00, 16.00, 0, '15-01-2024-09-59-13-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'hamburguer-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(126, 'X-BURGUER DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 18.00, 0, '15-01-2024-09-59-44-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-burguer-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(127, 'EGGS-BURGUER DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 25.00, 0, '15-01-2024-10-00-12-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(128, 'X-BACON DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CAMARÃO, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 20.00, 0, '15-01-2024-10-00-38-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-bacon-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(129, 'EGGS-BACON DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CAMARÃO, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 22.00, 0, '15-01-2024-10-01-08-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-bacon-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(130, 'X-FRANGO COM CAMARÃO', 'CARNE DE HAMBÚRGUER, FRANGO, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 20.00, 0, '15-01-2024-10-01-33-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-frango-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(131, 'EGGS-FRANGO COM CAMARÃO', 'CARNE DE HAMBÚRGUER, FRANGO, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 22.00, 0, '15-01-2024-10-01-56-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-frango-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(132, 'X-FRANGO PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 23.00, 0, '15-01-2024-10-02-46-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-frango-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(133, 'EGGS-FRANGO PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 26.00, 0, '15-01-2024-10-05-08-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-frango-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(134, 'X-CORAÇÃO COM CAMARÃO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 21.00, 0, '15-01-2024-10-05-50-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-coracao-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(135, 'EGGS-CORAÇÃO COM CAMARÃO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 23.00, 0, '15-01-2024-10-06-37-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-coracao-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(136, 'X-CORAÇÃO DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 25.00, 0, '15-01-2024-10-07-22-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-coracao-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(137, 'EGGS-CORAÇÃO DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, CAMARÃO, OVO PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 28.00, 0, '15-01-2024-10-07-47-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-coracao-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(138, 'X-CALABRESA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR, CALABRESA, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 20.00, 0, '15-01-2024-10-08-12-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-calabresa-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(139, 'EGGS-CALABRESA COM CAMARÃO', 'CARNE DE HAMBÚRGUER, CALABRESA, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 22.00, 0, '15-01-2024-10-09-43-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(140, 'X-CALABRESA DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CALABRESA, CAMARÃO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 22.00, 0, '15-01-2024-10-10-11-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'x-calabresa-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(141, 'EGGS-CALABRESA DE PICANHA COM CAMARÃO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CALABRESA, CAMARÃO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 16, 0.00, 25.00, 0, '15-01-2024-10-10-42-WhatsApp-Image-2023-12-25-at-19.16.05-(3).jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-de-picanha-com-camarao', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(142, 'HAMBÚRGUERR DE PORCO', 'CARNE DE HAMBÚRGUERR, PORCO, SALADA E MILHO VERDE', 13, 0.00, 10.00, 0, '15-01-2024-10-13-52-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'hamburguerr-de-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(143, 'X-BURGUER DE PORCO', 'CARNE DE HAMBÚRGUERR, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 12.00, 0, '15-01-2024-10-14-23-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-burguer-de-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(144, 'EGGS-BURGUER DE PORCO', 'CARNE DE HAMBÚRGUERR, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 13.00, 0, '15-01-2024-10-14-40-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(145, 'X-BACON COM PORCO', 'X-BACON COM PORCO CARNE DE HAMBÚRGUERR, PORCO, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 16.00, 0, '15-01-2024-10-15-07-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-bacon-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(146, 'EGGS-BACON COM PORCO', 'CARNE DE HAMBÚRGUERR, PORCO, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE ', 13, 0.00, 17.00, 0, '15-01-2024-10-15-31-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-bacon-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(147, 'HAMBÚRGUERR DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, PORCO, SALADA E MILHO VERDE', 13, 0.00, 16.00, 0, '15-01-2024-10-16-00-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'hamburguerr-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(148, 'X-BURGUER DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 17.00, 0, '15-01-2024-10-18-47-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-burguer-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(149, 'EGGS-BURGUER DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 19.00, 0, '15-01-2024-10-19-33-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(150, 'X-BACON DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, PORCO, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 20.00, 0, '15-01-2024-10-19-58-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-bacon-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(151, 'EGGS-BACON DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, PORCO, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 21.00, 0, '15-01-2024-10-20-35-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-bacon-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(152, 'X-FRANGO COM PORCO', 'CARNE DE HAMBÚRGUER, FRANGO, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 15.00, 0, '15-01-2024-10-21-30-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-frango-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(153, 'EGGS-FRANGO COM PORCO', 'CARNE DE HAMBÚRGUER, FRANGO, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 16.00, 0, '15-01-2024-10-21-55-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-frango-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(154, 'X-FRANGO PICANHA COM PORCO', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 19.00, 0, '15-01-2024-10-22-24-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-frango-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(155, 'EGGS-FRANGO PICANHA COM PORCO', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 21.00, 0, '15-01-2024-10-22-49-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-frango-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(156, 'X-CORAÇÃO COM PORCO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 17.00, 0, '15-01-2024-10-23-10-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-coracao-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(157, 'EGGS-CORAÇÃO COM PORCO', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 19.00, 0, '15-01-2024-10-23-39-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-coracao-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(158, 'X-CORAÇÃO DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 22.00, 0, '15-01-2024-10-24-02-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-coracao-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(159, 'EGGS-CORAÇÃO DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, PORCO, OVO PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 24.00, 0, '15-01-2024-10-24-25-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-coracao-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(160, 'X-CALABRESA COM PORCO', 'CARNE DE HAMBÚRGUERR, CALABRESA, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 14.00, 0, '15-01-2024-10-24-50-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-calabresa-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(161, 'EGGS-CALABRESA COM PORCO', 'CARNE DE HAMBÚRGUERR, CALABRESA, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 15.00, 0, '15-01-2024-10-25-15-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(162, 'X-CALABRESA DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUER DE PICANHA, CALABRESA, PORCO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 18.00, 0, '15-01-2024-10-25-41-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'x-calabresa-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(163, 'EGGS-CALABRESA DE PICANHA COM PORCO', 'CARNE DE HAMBÚRGUERR DE PICANHA, CALABRESA, PORCO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 13, 0.00, 19.00, 0, '15-01-2024-10-26-52-WhatsApp-Image-2023-12-25-at-19.16.06-(3).jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-de-picanha-com-porco', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(164, 'HAMBÚRGUERR DE BACALHAU', 'CARNE DE HAMBÚRGUER, BACALHAU, SALADA E MILHO VERDE', 18, 0.00, 15.00, 0, '15-01-2024-10-28-46-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'hamburguerr-de-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(165, 'X-BURGUER DE BACALHAU', 'CARNE DE HAMBÚRGUERR, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 20.00, 0, '15-01-2024-10-29-22-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-burguer-de-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(166, 'EGGS-BURGUER DE BACALHAU', 'CARNE DE HAMBÚRGUERR, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 22.00, 0, '15-01-2024-10-29-58-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(167, 'X-BACON COM BACALHAU', 'CARNE DE HAMBÚRGUERR, BACALHAU, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 23.00, 0, '15-01-2024-10-30-15-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-bacon-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(168, 'EGGS-BACON COM BACALHAU', 'CARNE DE HAMBÚRGUERR, BACALHAU, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 26.00, 0, '15-01-2024-10-30-37-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-bacon-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(169, 'HAMBÚRGUERR DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, BACALHAU, SALADA E MILHO VERDE', 18, 0.00, 16.00, 0, '15-01-2024-10-30-59-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'hamburguerr-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(170, 'X-BURGUER DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 22.00, 0, '15-01-2024-10-31-31-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-burguer-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(171, 'EGGS-BURGUER DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 26.00, 0, '15-01-2024-10-31-53-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-burguer-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(172, 'X-BACON DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, BACALHAU, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 28.00, 0, '15-01-2024-10-33-01-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-bacon-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(173, 'EGGS-BACON DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, BACALHAU, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 30.00, 0, '15-01-2024-10-33-25-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-bacon-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(174, 'X-FRANGO COM BACALHAU', 'CARNE DE HAMBÚRGUER, FRANGO, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 20.00, 0, '15-01-2024-10-33-45-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-frango-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(175, 'EGGS-FRANGO COM BACALHAU', 'CARNE DE HAMBÚRGUER, FRANGO, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 22.00, 0, '15-01-2024-10-34-21-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-frango-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(176, 'X-FRANGO PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 31.00, 0, '15-01-2024-10-34-43-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-frango-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(177, 'EGGS-FRANGO PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUER DE PICANHA, FRANGO, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 26.00, 0, '15-01-2024-10-35-10-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-frango-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(178, 'X-CORAÇÃO COM BACALHAU', 'CARNE DE HAMBÚRGUER, CORAÇÃO DE GALINHA, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 22.00, 0, '15-01-2024-10-35-39-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-coracao-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(179, 'EGGS-CORAÇÃO COM BACALHAU', 'CARNE DE HAMBÚRGUERR, CORAÇÃO DE GALINHA, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 26.00, 0, '15-01-2024-10-38-12-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-coracao-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(180, 'X-CORAÇÃO DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 26.00, 0, '15-01-2024-10-38-39-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-coracao-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(181, 'EGGS-CORAÇÃO DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, CORAÇÃO DE GALINHA, BACALHAU, OVO PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 30.00, 0, '15-01-2024-10-39-07-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-coracao-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(182, 'X-CALABRESA COM BACALHAU', 'CARNE DE HAMBÚRGUERR, CALABRESA, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 21.00, 0, '15-01-2024-10-39-35-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-calabresa-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(183, 'EGGS-CALABRESA COM BACALHAU', 'CARNE DE HAMBÚRGUERR, CALABRESA, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 24.00, 0, '15-01-2024-10-40-02-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(184, 'X-CALABRESA DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUER DE PICANHA, CALABRESA, BACALHAU, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 25.00, 0, '15-01-2024-10-43-09-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'x-calabresa-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(185, 'EGGS-CALABRESA DE PICANHA COM BACALHAU', 'CARNE DE HAMBÚRGUERR DE PICANHA, CALABRESA, BACALHAU, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 18, 0.00, 28.00, 0, '15-01-2024-10-43-34-WhatsApp-Image-2023-12-25-at-19.16.05.jpeg', 0, 'Não', 'Sim', 'eggs-calabresa-de-picanha-com-bacalhau', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(186, 'X-SALSICHA', 'CARNE DE HAMBÚRGUER, SALSICHA, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 10.00, 0, '15-01-2024-12-01-27-SALSICHA.jpg', 0, 'Não', 'Sim', 'x-salsicha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(187, 'X-SALSICHA DE PICANHA', 'CARNE DE HAMBÚRGUER(PICANHA), SALSICHA, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 15.00, 0, '15-01-2024-12-01-59-SALSICHA.jpg', 0, 'Não', 'Sim', 'x-salsicha-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(188, 'EGGS-SALSICHA', 'CARNE DE HAMBÚRGUER, SALSICHA, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 13.00, 0, '15-01-2024-12-05-51-SALSICHA.jpg', 0, 'Não', 'Sim', 'eggs-salsicha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(189, 'EGGS-SALSICHA DE PICANHA', 'CARNE DE HAMBÚRGUER, SALSICHA, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 18.00, 0, '15-01-2024-12-06-16-SALSICHA.jpg', 0, 'Não', 'Sim', 'eggs-salsicha-de-picanha', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(190, 'X-SALSICHA COM FRANGO', 'CARNE DE HAMBÚRGUER, SALSICHA, FRANGO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 17.00, 0, '15-01-2024-12-06-43-SALSICHA.jpg', 0, 'Não', 'Sim', 'x-salsicha-com-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(191, 'EGGS-SALSICHA COM FRANGO', 'CARNE DE HAMBÚRGUER, SALSICHA, FRANGO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 18.00, 0, '15-01-2024-12-07-05-SALSICHA.jpg', 0, 'Não', 'Sim', 'eggs-salsicha-com-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(192, 'X-SALSICHA PICANHA COM FRANGO', 'CARNE DE HAMBÚRGUER(PICANHA), SALSICHA, FRANGO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 18.00, 0, '15-01-2024-12-07-29-SALSICHA.jpg', 0, 'Não', 'Sim', 'x-salsicha-picanha-com-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(193, 'EGGS-SALSICHA PICANHA COM FRANGO', 'CARNE DE HAMBÚRGUER(PICANHA), SALSICHA, FRANGO, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 19.00, 0, '15-01-2024-12-08-01-SALSICHA.jpg', 0, 'Não', 'Sim', 'eggs-salsicha-picanha-com-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(194, 'X-SALSICHA COM BACON', 'CARNE DE HAMBÚRGUER, SALSICHA, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 15.00, 0, '15-01-2024-12-08-22-SALSICHA.jpg', 0, 'Não', 'Sim', 'x-salsicha-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(195, 'EGGS-SALSICHA COM BACON', 'CARNE DE HAMBÚRGUER, SALSICHA, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 17.00, 0, '15-01-2024-12-09-03-SALSICHA.jpg', 0, 'Não', 'Sim', 'eggs-salsicha-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(196, 'X-SALSICHA PICANHA COM BACON', 'CARNE DE HAMBÚRGUER(PICANHA), SALSICHA, BACON, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 18.00, 0, '15-01-2024-12-09-36-SALSICHA.jpg', 0, 'Não', 'Sim', 'x-salsicha-picanha-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(197, 'EGGS-SALSICHA PICANHA COM BACON', 'CARNE DE HAMBÚRGUER(PICANHA), SALSICHA, BACON, OVO, PRESUNTO, QUEIJO, SALADA E MILHO VERDE', 23, 0.00, 19.00, 0, '15-01-2024-12-09-53-SALSICHA.jpg', 0, 'Não', 'Sim', 'eggs-salsicha-picanha-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(198, 'CACHORRO QUENTE DE CAMARÃO E FRANGO', 'MOLHO DE CAMARÃO, MOLHO DE FRANGO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 22.00, 0, '15-01-2024-13-17-20-WhatsApp-Image-2024-01-02-at-12.20.08.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-camarao-e-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(199, 'CACHORRO QUENTE DE CARNE DOBRADO', 'MOLHO DE CARNE, 2 SALSICHAS, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 17.00, 0, '15-01-2024-13-19-47-e151853d5743663c8d268f022273246b.jpg', 0, 'Não', 'Sim', 'cachorro-quente-de-carne-dobrado', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(200, 'CACHORRO QUENTE DE FRANGO DOBRADO', 'MOLHO DE FRANGO, 2 SALSICHAS, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 16.00, 0, '15-01-2024-13-20-24-WhatsApp-Image-2024-01-02-at-12.20.08.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-frango-dobrado', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(201, 'CACHORRO QUENTE DE CAMARÃO DOBRADO', 'MOLHO DE CAMARÃO, 2 SALSICHAS, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 28.00, 0, '15-01-2024-13-21-32-WhatsApp-Image-2024-01-02-at-12.20.17.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-camarao-dobrado', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(203, 'CACHORRO QUENTE DE CAMARÃO E CARNE', 'MOLHO DE CAMARÃO, MOLHO DE CARNE, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 20.00, 0, '15-01-2024-13-23-02-WhatsApp-Image-2024-01-02-at-12.20.17.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-camarao-e-carne', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(204, 'CACHORRO QUENTE DE CAMARÃO G', 'MOLHO DE CAMARÃO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 20.00, 0, '15-01-2024-13-23-32-WhatsApp-Image-2024-01-02-at-12.20.17.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-camarao-g', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(205, 'CACHORRO QUENTE DE CAMARÃO P', 'MOLHO DE CAMARÃO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 15.00, 0, '15-01-2024-13-24-08-WhatsApp-Image-2024-01-02-at-12.20.17.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-camarao-p', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(206, 'CACHORRO QUENTE TRADICIONAL P', 'SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 5.00, 0, '15-01-2024-13-34-21-cachorro_quente_zona_sul_gastronomia_carioca.jpg', 0, 'Não', 'Sim', 'cachorro-quente-tradicional-p', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(207, 'CACHORRO QUENTE TRADICIONAL G', 'SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 8.00, 8.00, 0, '15-01-2024-13-35-29-cachorro_quente_zona_sul_gastronomia_carioca.jpg', 0, 'Não', 'Sim', 'cachorro-quente-tradicional-g', 5, 'Não', 'Não', 'Sim', 'Não', 0.00);
INSERT INTO `produtos` (`id`, `nome`, `descricao`, `categoria`, `valor_compra`, `valor_venda`, `estoque`, `foto`, `nivel_estoque`, `tem_estoque`, `ativo`, `url`, `guarnicoes`, `promocao`, `combo`, `delivery`, `preparado`, `val_promocional`) VALUES
(208, 'CACHORRO QUENTE DE FRANGO P', 'MOLHO DE FRANGO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 8.00, 0, '15-01-2024-13-42-38-58d35df0a2812615168a92abb1f4ec2d.png', 0, 'Não', 'Sim', 'cachorro-quente-de-frango-p', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(209, 'CACHORRO QUENTE DE FRANGO G', 'MOLHO DE FRANGO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 10.00, 0, '15-01-2024-13-46-22-58d35df0a2812615168a92abb1f4ec2d.png', 0, 'Não', 'Sim', 'cachorro-quente-de-frango-g', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(210, 'CACHORRO QUENTE DE CARNE P', 'MOLHO DE CARNE, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 8.00, 0, '15-01-2024-13-50-57-maxresdefault.jpg', 0, 'Não', 'Sim', 'cachorro-quente-de-carne-p', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(211, 'CACHORRO QUENTE DE CARNE G', 'MOLHO DE CARNE, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 10.00, 0, '15-01-2024-13-51-22-maxresdefault.jpg', 0, 'Não', 'Sim', 'cachorro-quente-de-carne-g', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(212, 'CACHORRO QUENTE DE CARNE E FRANGO P', 'MOLHO DE CARNE, MOLHO DE FRANGO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 10.00, 0, '15-01-2024-13-52-03-WhatsApp-Image-2024-01-02-at-12.20.08.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-carne-e-frango-p', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(213, 'CACHORRO QUENTE DE CARNE E FRANGO G', 'MOLHO DE CARNE, MOLHO DE FRANGO, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 15.00, 0, '15-01-2024-13-52-49-WhatsApp-Image-2024-01-02-at-12.20.08.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-de-carne-e-frango-g', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(214, 'CACHORRO QUENTE 4 QUEIJOS TRADICIONAL P', 'QUEIJO, SALSICHA, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 11.00, 0, '15-01-2024-13-53-10-WhatsApp-Image-2024-01-02-at-12.20.11.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-4-queijos-tradicional-p', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(215, 'CACHORRO QUENTE 4 QUEIJOS TRADICIONAL G', 'QUEIJO, SALSICHA, SALSICHA, ALFACE, BATATINHA, BATATA PALHA E MILHO VERDE', 6, 0.00, 13.00, 0, '15-01-2024-13-53-33-WhatsApp-Image-2024-01-02-at-12.20.11.jpeg', 0, 'Não', 'Sim', 'cachorro-quente-4-queijos-tradicional-g', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(216, 'ALASANHADO', 'CARNE DE HAMBÚRGUERR, OVO, QUEIJO, PRESUNTO, FRANGO, BACON, MOLHO DE CEBOLA, SALADA E MILHO VERDE', 1, 0.00, 18.00, 0, '15-01-2024-13-53-57-WhatsApp-Image-2024-01-02-at-12.20.06.jpeg', 0, 'Não', 'Sim', 'alasanhado', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(220, 'SUCO DA POLPA 400ml', '', 4, 0.00, 5.00, 0, '17-01-2024-17-59-19-sucos.jpg', 0, 'Não', 'Sim', 'suco-da-polpa-400ml', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(221, 'SUCO DE LARANJA 400ml', '', 4, 0.00, 7.00, 0, '17-01-2024-17-59-39-sucos.jpg', 0, 'Não', 'Sim', 'suco-de-laranja-400ml', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(222, 'ÁGUA MINERAL (500ml)', 'Com Gás - Sem Gás', 4, 0.00, 0.00, 0, '17-01-2024-18-02-38-56437d020e21637da60606afthinksto.jpg', 0, 'Não', 'Sim', 'agua-mineral-(500ml)', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(224, 'GUARA MIX', '', 4, 0.00, 2.00, 0, '17-01-2024-18-07-07-7898216250059.jpg', 0, 'Não', 'Sim', 'guara-mix', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(225, 'BOMBA BAIANA', '', 4, 0.00, 6.00, 0, '17-01-2024-18-09-27-sucSo.jpg', 0, 'Não', 'Sim', 'bomba-baiana', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(226, 'SUCO DETOX', '', 4, 0.00, 6.00, 0, '17-01-2024-18-10-50-suco-verde-suco-detox-1477687972.jpg', 0, 'Não', 'Sim', 'suco-detox', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(227, 'AÇAÍ', 'ATENÇÃO: ESCOLHA SOMENTE A QUANTIDADE DE ACOMPANHAMENTO CONFORME A DESCRIÇÃO', 24, 0.00, 0.00, 0, '18-01-2024-16-01-37-ACAIMEDIO.jpg', 0, 'Não', 'Sim', 'acai', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(228, 'AÇAÍ PEQUENO', 'AÇAÍ COM DIREITO A UM ACOMPANHAMENTO E UMA CALDA', 24, 0.00, 5.00, 0, '18-01-2024-15-59-43-Untitled.jpg', 0, 'Não', 'Sim', 'acai-pequeno', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(229, 'HAMB. DA CASA FRANGO', '2 CARNES DE HAMBÚRGUER, FRANGO DESFIADO, MAIONESE, SALADA E MILHO VERDE', 10, 0.00, 13.00, 0, '19-01-2024-19-15-43-FRANGO-DRAGAO.jpg', 0, 'Não', 'Sim', 'hamb.-da-casa-frango', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(231, 'Batata Frita', 'Porção de batata frita', 25, 0.00, 10.00, 0, '18-12-2024-20-31-57-batatinha.jpg', 0, 'Não', 'Sim', 'batata-frita', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(233, 'Batata Frita Recheada com Bacon', 'Batata Frita Recheada com Bacon', 25, 0.00, 18.00, 0, '11-01-2025-20-45-12-Big-batata-frita-2.jpg', 0, 'Não', 'Sim', 'batata-frita-recheada-com-bacon', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(234, 'Batata Frita Recheada com Calabresa', 'Batata Frita Recheada com Calabresa', 25, 0.00, 18.00, 0, '11-01-2025-20-55-47-Batata-Frita-e1578413517798.png.jpg', 0, 'Não', 'Sim', 'batata-frita-recheada-com-calabresa', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(235, 'Batata Recheada com Carne do Sol', 'Batata Frita Recheada com Carne do Sol desfiada', 25, 0.00, 20.00, 0, '11-01-2025-21-01-09-fritas-rústicas-scaled-e16551451.jpg', 0, 'Não', 'Sim', 'batata-recheada-com-carne-do-sol', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(236, 'Batata Recheada com Charque', 'Batata Frita Recheada com Charque', 25, 0.00, 20.00, 0, '11-01-2025-21-03-53-241747941_1942180362623879_66912.jpg', 0, 'Não', 'Sim', 'batata-recheada-com-charque', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(237, 'pudim', '', 26, 0.00, 5.00, 0, '12-02-2025-00-17-53-pud.jpeg', 500, 'Não', 'Sim', 'pudim', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(238, 'mousse de maracuja com ganache', '', 26, 0.00, 5.00, 0, '12-02-2025-00-19-31-mousse.jpeg', 0, 'Não', 'Sim', 'mousse-de-maracuja-com-ganache', 5, 'Não', 'Não', 'Sim', 'Não', 0.00),
(241, 'Combo Mega Satisfação', 'Uma bata frita recheada de bacon + um copo de açai com dois acompanhamentos + refrigerante 350ml', 27, 0.00, 30.00, 0, '13-04-2025-08-31-54-2.jpg', 0, 'Não', 'Sim', 'combo-mega-satisfacao', NULL, 'Sim', 'Sim', 'Sim', 'Não', 27.00),
(242, 'Combo Trio Delícia', 'Batata frita recheada + eggs burguer + refrigerante 350ml', 27, 0.00, 33.00, 0, '13-04-2025-08-35-21-4.jpg', 0, 'Não', 'Sim', 'combo-trio-delicia', NULL, 'Sim', 'Sim', 'Sim', 'Sim', 31.00),
(244, 'REFRIGERANTE', 'Escolha aqui seu Refrigerante ', 4, 0.00, 0.00, 0, '13-04-2025-16-34-14-IMG_2986.jpeg', 0, 'Não', 'Sim', 'refrigerante', NULL, 'Não', 'Não', 'Sim', 'Não', 0.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `receber`
--

CREATE TABLE `receber` (
  `id` int(11) NOT NULL,
  `descricao` varchar(100) DEFAULT NULL,
  `cliente` int(11) DEFAULT NULL,
  `valor` decimal(8,2) DEFAULT NULL,
  `vencimento` date DEFAULT NULL,
  `data_pgto` date DEFAULT NULL,
  `data_lanc` date DEFAULT NULL,
  `forma_pgto` varchar(50) DEFAULT NULL,
  `frequencia` int(11) DEFAULT NULL,
  `obs` varchar(100) DEFAULT NULL,
  `arquivo` varchar(100) DEFAULT NULL,
  `referencia` varchar(30) DEFAULT NULL,
  `id_ref` int(11) DEFAULT NULL,
  `multa` decimal(8,2) DEFAULT NULL,
  `juros` decimal(8,2) DEFAULT NULL,
  `desconto` decimal(8,2) DEFAULT NULL,
  `taxa` decimal(8,2) DEFAULT NULL,
  `subtotal` decimal(8,2) DEFAULT NULL,
  `usuario_lanc` int(11) DEFAULT NULL,
  `usuario_pgto` int(11) DEFAULT NULL,
  `pago` varchar(5) DEFAULT NULL,
  `residuo` varchar(5) DEFAULT NULL,
  `hora` time DEFAULT NULL,
  `hash` varchar(100) DEFAULT NULL,
  `caixa` int(11) DEFAULT NULL,
  `tipo` varchar(30) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `pessoa` int(11) DEFAULT NULL,
  `produto` int(11) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `funcionario` int(11) DEFAULT NULL,
  `adiantamento` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `receber`
--

INSERT INTO `receber` (`id`, `descricao`, `cliente`, `valor`, `vencimento`, `data_pgto`, `data_lanc`, `forma_pgto`, `frequencia`, `obs`, `arquivo`, `referencia`, `id_ref`, `multa`, `juros`, `desconto`, `taxa`, `subtotal`, `usuario_lanc`, `usuario_pgto`, `pago`, `residuo`, `hora`, `hash`, `caixa`, `tipo`, `foto`, `pessoa`, `produto`, `quantidade`, `funcionario`, `adiantamento`) VALUES
(1, 'Consumir Local', 6, 30.00, '2025-02-15', '2025-02-15', '2025-02-15', '2', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 30.00, NULL, 1, 'Sim', NULL, '13:35:21', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(2, 'Consumir Local', 6, 23.99, '2025-02-18', '2025-02-18', '2025-02-18', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 23.99, NULL, 1, 'Sim', NULL, '10:10:30', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(3, 'Consumir Local', 6, 30.00, '2025-02-18', '2025-02-18', '2025-02-18', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 30.00, NULL, 1, 'Sim', NULL, '10:11:41', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(4, 'Consumir Local', 6, 23.99, '2025-02-18', '2025-02-18', '2025-02-18', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 23.99, NULL, 1, 'Sim', NULL, '10:11:46', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(5, 'Consumir Local', 6, 23.99, '2025-02-25', '2025-02-25', '2025-02-25', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 23.99, NULL, 1, 'Sim', NULL, '18:33:45', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(6, 'Consumir Local', 6, 20.00, '2025-02-25', '2025-02-25', '2025-02-25', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 20.00, NULL, 1, 'Sim', NULL, '18:33:50', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(7, 'Consumir Local', 0, 30.00, '2025-02-25', '2025-02-25', '2025-02-25', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 30.00, NULL, 1, 'Sim', NULL, '18:34:39', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(8, 'Venda Mesa', NULL, 38.99, '2025-02-25', '2025-02-25', '2025-02-25', '1', NULL, NULL, 'sem-foto.jpg', 'Venda', 1, NULL, NULL, NULL, NULL, 38.99, 1, 1, 'Sim', NULL, NULL, NULL, 0, 'Venda', 'sem-foto.png', 0, NULL, NULL, NULL, NULL),
(9, 'Venda Mesa', NULL, 38.39, '2025-02-25', '2025-02-25', '2025-02-25', '1', NULL, NULL, 'sem-foto.jpg', 'Venda', 2, NULL, NULL, NULL, NULL, 38.39, 1, 1, 'Sim', NULL, NULL, NULL, 0, 'Venda', 'sem-foto.png', 0, NULL, NULL, NULL, NULL),
(10, 'Venda Mesa', NULL, 31.30, '2025-02-25', '2025-02-25', '2025-02-25', '12', NULL, NULL, 'sem-foto.jpg', 'Venda', 3, NULL, NULL, NULL, NULL, 31.30, 1, 1, 'Sim', NULL, NULL, NULL, 0, 'Venda', 'sem-foto.png', 0, NULL, NULL, NULL, NULL),
(11, 'Consumir Local', 0, 23.99, '2025-02-25', '2025-02-25', '2025-02-25', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 23.99, NULL, 1, 'Sim', NULL, '19:52:03', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(12, 'Retirar', 11, 30.00, '2025-03-07', '2025-03-07', '2025-03-07', '3', NULL, NULL, 'sem-foto.png', 'Retirar', NULL, NULL, NULL, NULL, NULL, 30.00, NULL, 1, 'Sim', NULL, '17:07:07', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(13, 'Retirar', 11, 31.00, '2025-04-13', '2025-04-13', '2025-04-13', '3', NULL, NULL, 'sem-foto.png', 'Retirar', NULL, NULL, NULL, NULL, NULL, 31.00, NULL, 1, 'Sim', NULL, '18:43:38', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(14, 'Adiantamento Mesa', NULL, 10.00, '2025-04-13', '2025-04-13', '2025-04-13', '1', NULL, NULL, 'sem-foto.jpg', 'Adiantamento Mesa', 4, NULL, NULL, NULL, NULL, NULL, 1, 1, 'Sim', NULL, NULL, NULL, 0, 'Abertura', 'sem-foto.jpg', 0, NULL, NULL, NULL, 1),
(15, 'Adiantamento Mesa', NULL, 45.00, '2025-04-13', '2025-04-13', '2025-04-13', '1', NULL, NULL, 'sem-foto.jpg', 'Adiantamento Mesa', 4, NULL, NULL, NULL, NULL, NULL, 1, 1, 'Sim', NULL, NULL, NULL, 0, 'Abertura', 'sem-foto.jpg', 0, NULL, NULL, NULL, 2),
(16, 'Venda Mesa', NULL, -5.00, '2025-04-13', '2025-04-13', '2025-04-13', '2', NULL, NULL, 'sem-foto.jpg', 'Venda', 4, NULL, NULL, NULL, NULL, -5.00, 1, 1, 'Sim', NULL, NULL, NULL, 0, 'Venda', 'sem-foto.png', 0, NULL, NULL, NULL, NULL),
(17, 'Retirar', 11, 2.00, '2025-04-16', '2025-04-16', '2025-04-16', '2', NULL, NULL, 'sem-foto.png', 'Retirar', NULL, NULL, NULL, NULL, NULL, 2.00, NULL, 0, 'Sim', NULL, '09:29:32', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(18, 'Consumir Local', 11, 34.65, '2025-05-18', '2025-05-18', '2025-05-18', '3', NULL, NULL, 'sem-foto.png', 'Consumir Local', NULL, NULL, NULL, NULL, NULL, 34.65, NULL, 1, 'Sim', NULL, '10:55:27', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(19, 'Retirar', 11, 2.00, '2025-06-05', '2025-06-05', '2025-06-05', '2', NULL, NULL, 'sem-foto.png', 'Retirar', NULL, NULL, NULL, NULL, NULL, 2.00, NULL, 0, 'Sim', NULL, '22:59:16', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL),
(20, 'Retirar', 11, 2.00, '2025-06-05', '2025-06-05', '2025-06-05', '2', NULL, NULL, 'sem-foto.png', 'Retirar', NULL, NULL, NULL, NULL, NULL, 2.00, NULL, 0, 'Sim', NULL, '23:02:47', NULL, 0, NULL, 'sem-foto.png', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura da tabela `saidas`
--

CREATE TABLE `saidas` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `motivo` varchar(50) NOT NULL,
  `usuario` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `saidas`
--

INSERT INTO `saidas` (`id`, `produto`, `quantidade`, `motivo`, `usuario`, `data`) VALUES
(1, 45, 2, 'Danificada', 1, '2024-11-17');

-- --------------------------------------------------------

--
-- Estrutura da tabela `sangrias`
--

CREATE TABLE `sangrias` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `caixa` int(11) NOT NULL,
  `feito_por` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura da tabela `tarefas`
--

CREATE TABLE `tarefas` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `usuario_lanc` int(11) NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `hora_mensagem` time DEFAULT NULL,
  `descricao` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `hash` varchar(100) DEFAULT NULL,
  `prioridade` varchar(25) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `tarefas`
--

INSERT INTO `tarefas` (`id`, `usuario`, `usuario_lanc`, `data`, `hora`, `hora_mensagem`, `descricao`, `status`, `hash`, `prioridade`) VALUES
(8, 1, 1, '2024-03-12', '10:10:00', '00:00:00', '', 'Concluída', NULL, NULL),
(9, 1, 1, '2024-03-18', '12:00:00', '00:00:00', '', 'Concluída', NULL, NULL),
(17, 1, 1, '2024-03-19', '17:00:00', '16:50:00', 'Reunião com Marcelo', 'Concluída', '56625', NULL),
(18, 1, 1, '2024-03-20', '16:00:00', '14:00:00', 'teste', 'Concluída', '56629', NULL),
(20, 1, 1, '2024-03-19', '18:00:00', '17:00:00', '', 'Agendada', '56865', NULL),
(22, 3, 1, '2024-03-19', '21:00:00', '20:00:00', 'Teste', 'Agendada', '56918', NULL),
(23, 3, 1, '2024-03-22', '14:00:00', '11:00:00', '', 'Agendada', '56919', NULL),
(25, 1, 1, '2024-03-22', '14:00:00', '13:00:00', 'fda fadsfsaf sadfas f asdfafdsx d d fad df afdsaf ffa fdaf afdas ', 'Concluída', '56979', NULL),
(26, 1, 1, '2024-03-19', '20:00:00', '19:53:00', '', 'Agendada', '56981', NULL),
(40, 1, 1, '2024-03-20', '19:09:00', '16:00:00', 'aaaaaaaaa', 'Agendada', '', 'Baixa'),
(41, 1, 1, '2024-03-20', '20:01:00', '19:41:00', '', 'Agendada', '', 'Baixa'),
(44, 1, 1, '2024-03-20', '21:00:00', '20:00:00', 'dsadsa dsadsadfsa dfsdsd sadsada', 'Concluída', '57635', 'Alta'),
(49, 1, 1, '2024-11-17', '18:00:00', '17:55:00', 'Teste', 'Agendada', '1013681', 'Média');

-- --------------------------------------------------------

--
-- Estrutura da tabela `temp`
--

CREATE TABLE `temp` (
  `id` int(11) NOT NULL,
  `sessao` varchar(35) NOT NULL,
  `tabela` varchar(25) NOT NULL,
  `id_item` int(11) NOT NULL,
  `carrinho` int(11) NOT NULL,
  `data` date DEFAULT NULL,
  `categoria` varchar(5) DEFAULT NULL,
  `grade` int(11) DEFAULT NULL,
  `valor_item` decimal(8,2) DEFAULT NULL,
  `quantidade` int(11) DEFAULT NULL,
  `tipagem` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `temp`
--

INSERT INTO `temp` (`id`, `sessao`, `tabela`, `id_item`, `carrinho`, `data`, `categoria`, `grade`, `valor_item`, `quantidade`, `tipagem`) VALUES
(13, '2025-04-12-20:18:59-6', 'Múltiplo', 86, 18, '2025-04-12', NULL, 26, 6.00, 1, 'Agregado'),
(15, '2025-04-12-20:18:59-6', 'Múltiplo', 92, 18, '2025-04-12', NULL, 26, 2.00, 2, 'Agregado'),
(21, '2025-04-13-16:08:39-570', 'Múltiplo', 1525, 21, '2025-04-13', NULL, 183, 5.00, 1, 'Único'),
(22, '2025-04-13-16:08:39-570', 'Múltiplo', 1526, 21, '2025-04-13', NULL, 183, 8.00, 2, 'Único'),
(23, '2025-04-13-16:08:39-570', 'Múltiplo', 1527, 21, '2025-04-13', NULL, 183, 14.00, 1, 'Único'),
(34, '2025-04-13-16:08:39-570', 'Múltiplo', 1529, 22, '2025-04-13', NULL, 186, 2.00, 1, 'Único'),
(35, '2025-04-13-16:08:39-570', 'Múltiplo', 1530, 22, '2025-04-13', NULL, 186, 3.00, 1, 'Único'),
(40, '2025-04-13-18:47:52-999', 'Múltiplo', 104, 24, '2025-04-13', NULL, 28, 6.00, 1, 'Agregado'),
(42, '2025-04-13-18:47:52-999', 'Múltiplo', 105, 24, '2025-04-13', NULL, 28, 6.00, 2, 'Agregado'),
(43, '2025-04-13-18:47:52-999', 'Múltiplo', 1527, 25, '2025-04-13', NULL, 183, 14.00, 1, 'Único'),
(44, '2025-04-16-09:25:25-1108', 'Múltiplo', 1529, 26, '2025-04-16', NULL, 186, 2.00, 1, 'Único'),
(45, '2025-05-04-10:09:45-19', 'Múltiplo', 788, 37, '2025-05-04', NULL, 104, 6.00, 1, 'Agregado'),
(46, '2025-05-04-10:45:41-1158', 'Múltiplo', 104, 38, '2025-05-04', NULL, 28, 6.00, 1, 'Agregado'),
(47, '2025-05-04-10:45:41-1158', 'Múltiplo', 105, 38, '2025-05-04', NULL, 28, 6.00, 1, 'Agregado'),
(48, '2025-05-18-10:53:32-880', 'Múltiplo', 109, 76, '2025-05-18', NULL, 28, 6.00, 1, 'Agregado'),
(49, '2025-05-18-10:53:32-880', 'Múltiplo', 108, 76, '2025-05-18', NULL, 28, 5.00, 1, 'Agregado'),
(50, '2025-05-18-10:53:32-880', 'Múltiplo', 107, 76, '2025-05-18', NULL, 28, 4.00, 1, 'Agregado'),
(51, '2025-05-31-22:57:55-568', 'Múltiplo', 779, 78, '2025-05-31', NULL, 103, 6.00, 1, 'Agregado'),
(52, '2025-06-07-12:21:10-444', 'Múltiplo', 1529, 81, '2025-06-07', NULL, 186, 2.00, 1, 'Único'),
(54, '2025-06-08-21:23:53-258', 'Múltiplo', 805, 114, '2025-06-09', NULL, 105, 5.00, 2, 'Agregado'),
(56, '2025-06-08-21:23:53-258', 'Múltiplo', 802, 114, '2025-06-09', NULL, 105, 6.00, 2, 'Agregado'),
(58, '2025-06-08-21:23:53-258', 'Múltiplo', 801, 114, '2025-06-09', NULL, 105, 5.00, 2, 'Agregado'),
(60, '2025-06-08-21:23:53-258', 'Múltiplo', 799, 114, '2025-06-09', NULL, 105, 6.00, 2, 'Agregado'),
(63, '2025-06-08-21:23:53-258', 'Múltiplo', 797, 114, '2025-06-09', NULL, 105, 6.00, 3, 'Agregado');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `senha` varchar(50) DEFAULT NULL,
  `senha_crip` varchar(130) NOT NULL,
  `nivel` varchar(25) NOT NULL,
  `ativo` varchar(5) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `endereco` varchar(150) DEFAULT NULL,
  `foto` varchar(100) DEFAULT NULL,
  `data` date NOT NULL,
  `comissao` int(11) DEFAULT NULL,
  `id_ref` int(11) NOT NULL,
  `pix` varchar(100) DEFAULT NULL,
  `token` varchar(150) DEFAULT NULL,
  `data_nasc` date DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `bairro` varchar(50) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `estado` varchar(50) DEFAULT NULL,
  `cep` varchar(20) DEFAULT NULL,
  `acessar_painel` varchar(5) DEFAULT NULL,
  `cpf` varchar(20) DEFAULT NULL,
  `mostrar_registros` varchar(5) DEFAULT NULL,
  `tipo_chave` varchar(50) NOT NULL,
  `complemento` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `usuarios`
--

INSERT INTO `usuarios` (`id`, `nome`, `email`, `senha`, `senha_crip`, `nivel`, `ativo`, `telefone`, `endereco`, `foto`, `data`, `comissao`, `id_ref`, `pix`, `token`, `data_nasc`, `numero`, `bairro`, `cidade`, `estado`, `cep`, `acessar_painel`, `cpf`, `mostrar_registros`, `tipo_chave`, `complemento`) VALUES
(1, 'Wesley Mendes', 'agcreativebr@gmail.com', '', '$2y$10$Gvjp3sWRj8s0w.ObnUuk/.P.nZuLSfxck88FQZ/qVGoWXdkYwR49O', 'Administrador', 'Sim', '(79) 98121-0784', '', '07-03-2025-17-13-48-29-06-2022-18-17-05-PACOTE-DELIVERY-INTERATIVO.jpg', '2024-04-09', NULL, 0, 'agcreativebr@gmail.com', '', '1989-02-21', '', 'wddw', '', '', '', 'Sim', '', 'Sim', 'Email', ''),
(9, 'Faixineiro', 'faxineiro@gmail.com', '', '$2y$10$pTair9DkMuuxOaL2ppSnGeDgBvY.ClB3lI2kqQ7Tb6OQl0iU/QU3S', 'Faxineiro', 'Sim', '(12) 55555-5555', 'Cocal', 'sem-foto.jpg', '2024-07-27', NULL, 0, 'faxineiro@gmail.com', NULL, '1980-10-25', '150', 'Cocal', 'Seabra', 'BA', '46900-000', 'Não', '', 'Não', 'Email', 'Casa 5'),
(11, 'Gerente', 'gerente@gmail.com', '', '$2y$10$NJ.nnu/Jxp3Zkt6avzDZ3ucslMTCKyvjnza.yf0gfSiVuBYtOjpk6', 'Gerente', 'Sim', '(12) 22222-2222', 'Rua Estância Velha', 'sem-foto.jpg', '2024-07-27', NULL, 0, '035482156897', NULL, '1980-10-25', '150', 'Jardim Lider', 'São Paulo', 'SP', '02983-130', 'Sim', NULL, NULL, 'CPF', 'Casa 2'),
(13, 'Entregador 01', 'entregador01@gmail.com', '', '$2y$10$GB/xG2cbihpSVkNWBrVMkOXmAVAObaBIBl2oXiq2WESSfV.v9PBSC', 'Entregador', 'Sim', '(11) 11111-1111', '', 'sem-foto.jpg', '2024-07-29', NULL, 0, '', NULL, NULL, '', '', '', '', '', 'Sim', NULL, NULL, '', ''),
(16, 'Garçon 01', 'garcom2@gmail.com', '', '$2y$10$k0nyz3jAMoJWYVVX16nPm.Jr425hloK1RykyhLoPkM2R02b0xgZUq', 'Garçon', 'Sim', '(25) 88888-8888', '', 'sem-foto.jpg', '2024-08-06', NULL, 0, '', NULL, NULL, '', '', '', '', '', 'Sim', '', 'Sim', 'Email', ''),
(18, 'Atendente', 'atedente01@gmail.com', '', '$2y$10$XUXvjxZ0yit7ePqaTZ0LSeNLHvTUhpxVb.k9O5goQMqS2NvSpgpou', 'Atendente', 'Sim', '(00) 08888-8888', '', 'sem-foto.jpg', '2024-08-07', NULL, 0, '254.555.555-55', NULL, '1980-10-25', '', '', '', '', '', 'Não', '', 'Não', 'CPF', 'Casa 2'),
(29, 'Motobpy', 'motoboy@gmial.com', '', '$2y$10$TK2gybbn1pMKYZlIB4fYfeX7wbOah3ZwCgEtoFcL.Qu7FmdJBT0n6', 'Entregador', 'Sim', '(31) 99534-8118', '', 'sem-foto.jpg', '2024-11-13', NULL, 0, '', NULL, NULL, '', '', '', '', '', 'Sim', NULL, NULL, '', '');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuarios_permissoes`
--

CREATE TABLE `usuarios_permissoes` (
  `id` int(11) NOT NULL,
  `usuario` int(11) NOT NULL,
  `permissao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `usuarios_permissoes`
--

INSERT INTO `usuarios_permissoes` (`id`, `usuario`, `permissao`) VALUES
(1, 2, 1),
(2, 2, 2),
(3, 2, 3),
(4, 2, 4),
(5, 2, 5),
(6, 2, 8),
(7, 2, 9),
(8, 2, 10),
(9, 2, 11),
(10, 2, 12),
(11, 2, 13),
(12, 2, 14),
(13, 2, 15),
(14, 2, 16),
(15, 2, 17),
(16, 2, 18),
(17, 2, 19),
(20, 2, 25),
(21, 2, 26),
(22, 2, 27),
(30, 15, 1),
(31, 15, 2),
(32, 15, 3),
(33, 15, 4),
(34, 15, 5),
(35, 15, 8),
(36, 15, 9),
(37, 15, 10),
(38, 15, 11),
(39, 15, 12),
(40, 15, 13),
(41, 15, 14),
(42, 15, 15),
(43, 15, 23),
(44, 15, 25),
(45, 15, 26),
(46, 15, 28),
(47, 15, 29),
(48, 15, 30),
(49, 15, 31),
(50, 15, 32),
(51, 15, 33),
(52, 15, 34),
(53, 15, 35),
(54, 15, 36),
(55, 15, 37),
(56, 15, 38),
(57, 15, 39),
(58, 15, 40),
(59, 15, 41),
(60, 15, 42),
(61, 15, 43),
(62, 15, 44),
(63, 15, 45),
(64, 15, 46),
(65, 15, 47),
(66, 15, 48),
(67, 15, 49),
(68, 15, 50),
(69, 15, 51),
(70, 15, 52),
(71, 18, 1),
(72, 18, 2),
(73, 18, 3),
(74, 18, 4),
(75, 18, 5),
(76, 18, 8),
(77, 18, 9),
(78, 18, 10),
(79, 18, 11),
(80, 18, 12),
(81, 18, 13),
(82, 18, 14),
(83, 18, 15),
(84, 18, 23),
(85, 18, 25),
(86, 18, 26),
(87, 18, 28),
(88, 18, 29),
(89, 18, 30),
(90, 18, 31),
(91, 18, 32),
(92, 18, 33),
(93, 18, 34),
(94, 18, 35),
(95, 18, 36),
(96, 18, 37),
(97, 18, 38),
(98, 18, 39),
(99, 18, 40),
(100, 18, 41),
(101, 18, 42),
(102, 18, 43),
(103, 18, 44),
(104, 18, 45),
(105, 18, 46),
(106, 18, 47),
(107, 18, 48),
(108, 18, 49),
(109, 18, 50),
(110, 18, 51),
(111, 18, 52),
(635, 16, 1),
(636, 16, 2),
(637, 16, 3),
(638, 16, 4),
(639, 16, 5),
(640, 16, 8),
(641, 16, 9),
(642, 16, 10),
(643, 16, 11),
(644, 16, 12),
(645, 16, 13),
(646, 16, 14),
(647, 16, 15),
(648, 16, 23),
(649, 16, 25),
(650, 16, 26),
(651, 16, 28),
(652, 16, 29),
(653, 16, 30),
(654, 16, 31),
(655, 16, 32),
(656, 16, 33),
(657, 16, 34),
(658, 16, 35),
(659, 16, 36),
(660, 16, 37),
(661, 16, 38),
(662, 16, 39),
(663, 16, 40),
(664, 16, 41),
(665, 16, 42),
(666, 16, 43),
(667, 16, 44),
(668, 16, 45),
(669, 16, 46),
(670, 16, 47),
(671, 16, 48),
(672, 16, 49),
(673, 16, 50),
(674, 16, 51),
(675, 16, 52),
(676, 16, 53),
(677, 16, 54),
(678, 16, 55),
(723, 30, 23),
(724, 30, 51),
(726, 30, 25),
(727, 30, 49),
(728, 30, 50),
(729, 30, 55),
(731, 13, 1),
(732, 13, 2),
(733, 13, 3),
(734, 13, 4),
(735, 13, 5),
(736, 13, 8),
(737, 13, 9),
(738, 13, 10),
(739, 13, 11),
(740, 13, 12),
(741, 13, 13),
(742, 13, 14),
(743, 13, 15),
(744, 13, 23),
(745, 13, 25),
(746, 13, 26),
(747, 13, 28),
(748, 13, 29),
(749, 13, 30),
(750, 13, 31),
(751, 13, 32),
(752, 13, 33),
(753, 13, 34),
(754, 13, 35),
(755, 13, 36),
(756, 13, 37),
(757, 13, 38),
(758, 13, 39),
(759, 13, 40),
(760, 13, 41),
(761, 13, 42),
(762, 13, 43),
(763, 13, 44),
(764, 13, 45),
(765, 13, 46),
(766, 13, 47),
(767, 13, 48),
(768, 13, 49),
(769, 13, 50),
(770, 13, 51),
(771, 13, 52),
(772, 13, 53),
(773, 13, 54),
(774, 13, 55),
(775, 13, 56),
(776, 11, 1),
(777, 11, 2),
(778, 11, 3),
(779, 11, 4),
(780, 11, 5),
(781, 11, 8),
(782, 11, 9),
(783, 11, 10),
(784, 11, 11),
(785, 11, 12),
(786, 11, 13),
(787, 11, 14),
(788, 11, 15),
(789, 11, 23),
(790, 11, 25),
(791, 11, 26),
(792, 11, 28),
(793, 11, 29),
(794, 11, 30),
(795, 11, 31),
(796, 11, 32),
(797, 11, 33),
(798, 11, 34),
(799, 11, 35),
(800, 11, 36),
(801, 11, 37),
(802, 11, 38),
(803, 11, 39),
(804, 11, 40),
(805, 11, 41),
(806, 11, 42),
(807, 11, 43),
(808, 11, 44),
(809, 11, 45),
(810, 11, 46),
(811, 11, 47),
(812, 11, 48),
(813, 11, 49),
(814, 11, 50),
(815, 11, 51),
(816, 11, 52),
(817, 11, 53),
(818, 11, 54),
(819, 11, 55),
(820, 11, 56),
(821, 11, 57);

-- --------------------------------------------------------

--
-- Estrutura da tabela `valor_adiantamento`
--

CREATE TABLE `valor_adiantamento` (
  `id` int(11) NOT NULL,
  `abertura` int(11) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `nome` varchar(50) DEFAULT NULL,
  `forma_pgto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `valor_adiantamento`
--

INSERT INTO `valor_adiantamento` (`id`, `abertura`, `valor`, `nome`, `forma_pgto`) VALUES
(1, 4, 10.00, 'carla', 1),
(2, 4, 45.00, 'Shaolin', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `variacoes`
--

CREATE TABLE `variacoes` (
  `id` int(11) NOT NULL,
  `produto` int(11) NOT NULL,
  `sigla` varchar(5) NOT NULL,
  `nome` varchar(35) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `valor` decimal(8,2) NOT NULL,
  `ativo` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `variacoes`
--

INSERT INTO `variacoes` (`id`, `produto`, `sigla`, `nome`, `descricao`, `valor`, `ativo`) VALUES
(2, 4, 'M', 'Médio', '25CM', 35.00, 'Sim'),
(3, 0, 'f', 'f', 'f', 50.00, 'Sim'),
(4, 0, 'M', 'Média', '6 Fatias', 30.00, 'Sim'),
(12, 3, '300ML', 'Pequeno', 'Pote de 300 ML', 15.00, 'Sim'),
(13, 3, '500ML', 'Médio', 'Pote de 500 ML', 20.00, 'Sim'),
(14, 3, '700ML', 'Grande', 'Pote de 500 ML', 25.00, 'Sim'),
(15, 1, '300ML', 'Pequena', 'Vitamina 300 ML', 10.00, 'Sim'),
(16, 1, '500ML', 'Média', 'Vitamina de 500 ML', 18.00, 'Sim'),
(20, 14, 'P', 'Pequena', '4 Fatias', 25.00, 'Sim'),
(21, 14, 'M', 'Média', '6 Fatias', 30.00, 'Sim'),
(22, 14, 'G', 'Grande', '8 Fatias', 35.00, 'Sim'),
(26, 25, 'P', '300 ML', 'Pote Pequeno', 25.00, 'Sim'),
(27, 25, 'M', '500 ML', '', 35.00, 'Sim'),
(29, 31, 'P', 'Pequena', '4 Fatias', 25.00, 'Sim'),
(30, 31, 'M', 'Média', '6 Fatias', 30.00, 'Sim'),
(31, 31, 'G', 'Grande', '8 Fatias', 35.00, 'Sim'),
(32, 31, 'GG', 'Gigante', '10 Fatias', 40.00, 'Sim'),
(33, 17, 'P', 'Pequena', '4 Fatias', 28.00, 'Sim'),
(34, 17, 'M', 'Média', '6 Fatias', 32.00, 'Sim'),
(35, 17, 'G', 'Grande', '8 Fatias', 37.00, 'Sim'),
(38, 16, 'P', 'Pequena', '4 Fatias', 22.00, 'Sim'),
(39, 16, 'M', 'Média', '6 Fatias', 25.00, 'Sim'),
(40, 16, 'G', 'Grande', '8 Fatias', 30.00, 'Sim'),
(41, 16, 'GG', 'Gigante', '10 Fatias', 35.00, 'Sim'),
(42, 14, 'GG', 'Gigante', '10 Fatias', 42.00, 'Sim'),
(43, 32, 'P', 'Pequena', '4 Fatias', 10.00, 'Sim'),
(44, 17, 'GG', 'Gigante', '10 Fatias', 50.00, 'Sim'),
(45, 36, 'P', 'Pequena', '4 Fatias', 30.00, 'Sim'),
(46, 36, 'M', 'Média', '6 Fatias', 50.00, 'Sim'),
(47, 36, 'G', 'Grande', '8 Fatias', 80.00, 'Sim'),
(48, 36, 'GG', 'Gigante', '10 Fatias', 90.00, 'Sim'),
(49, 37, 'P', 'Pequena', '4 Fatias', 35.00, 'Sim'),
(50, 37, 'M', 'Média', '6 Fatias', 45.00, 'Sim'),
(51, 37, 'G', 'Grande', '8 Fatias', 55.00, 'Sim'),
(52, 37, 'GG', 'Gigante', '10 Fatias', 65.00, 'Sim'),
(53, 38, 'P', 'Pequena', '4 Fatias', 35.00, 'Sim'),
(54, 38, 'M', 'Média', '6 Fatias', 45.00, 'Sim'),
(55, 38, 'G', 'Grande', '8 Fatias', 55.00, 'Sim'),
(56, 38, 'GG', 'Gigante', '10 Fatias', 65.00, 'Sim'),
(57, 47, 'P', 'Pequena', '4 Fatias', 35.00, 'Sim'),
(58, 47, 'M', 'Média', '8 Fatias', 45.00, 'Sim'),
(59, 47, 'G', 'Grande', '8 Fatias', 55.00, 'Sim'),
(60, 47, 'GG', 'Gigante', '10 Fatias', 65.00, 'Sim'),
(61, 48, 'P', 'Pequena', '4 Fatias', 35.00, 'Sim'),
(62, 48, 'M', 'Média', '6 Pedaços', 48.00, 'Sim'),
(63, 48, 'G', 'Grande', '8 Fatias', 58.00, 'Sim'),
(64, 48, 'GG', 'Gigante', '10 Fatias', 70.00, 'Sim'),
(65, 50, 'P', 'Pequena', '4 Fatias', 38.00, 'Sim'),
(66, 50, 'M', 'Média', '6 Pedaços', 48.00, 'Sim'),
(67, 50, 'G', 'Grande', '8 Fatias', 58.00, 'Sim'),
(69, 50, 'GG', 'Gigante', '10 Fatias', 65.00, 'Sim');

-- --------------------------------------------------------

--
-- Estrutura da tabela `variacoes_cat`
--

CREATE TABLE `variacoes_cat` (
  `id` int(11) NOT NULL,
  `categoria` int(11) NOT NULL,
  `sigla` varchar(15) NOT NULL,
  `nome` varchar(35) DEFAULT NULL,
  `descricao` varchar(50) DEFAULT NULL,
  `sabores` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `variacoes_cat`
--

INSERT INTO `variacoes_cat` (`id`, `categoria`, `sigla`, `nome`, `descricao`, `sabores`) VALUES
(9, 1, 'P', 'Pequena', '4 Fatias', 2),
(10, 1, 'M', 'Média', '6 Fatias', 2),
(11, 1, 'G', 'Grande', '8 Fatias', 4),
(12, 1, 'GG', 'Gigante', '10 Fatias', 6),
(13, 8, 'P', 'Pequeno', '300 ML', 0),
(14, 8, 'M', 'Médio', '500 ML', 0),
(15, 8, 'G', 'Grande', '700 ML', 0),
(16, 17, 'P', 'Pequena', '4 Fatias', 3),
(17, 17, 'M', 'Média', '8 Fatias', 3),
(18, 17, 'G', 'Grande', '12 Fatias', 3),
(28, 23, 'P', 'Pequena', '4 Fatias', 1),
(29, 23, 'M', 'Média', '8 Fatias', 2),
(30, 23, 'G', 'Grande', '8 Fatias', 3),
(31, 23, 'GG', 'Gigante', '10 Fatias', 4),
(33, 24, 'P', 'Pequena', '4 Fatias', 1),
(34, 24, 'M', 'Média', '6 Pedaços', 2),
(35, 24, 'G', 'Grande', '8 Fatias', 3),
(36, 24, 'GG', 'Gigante', '10 Fatias', 4);

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendas`
--

CREATE TABLE `vendas` (
  `id` int(11) NOT NULL,
  `cliente` int(11) NOT NULL,
  `valor` decimal(8,2) NOT NULL,
  `total_pago` decimal(8,2) NOT NULL,
  `troco` decimal(8,2) NOT NULL,
  `data` date NOT NULL,
  `hora` time NOT NULL,
  `status` varchar(25) NOT NULL,
  `pago` varchar(5) NOT NULL,
  `obs` varchar(100) DEFAULT NULL,
  `taxa_entrega` decimal(8,2) NOT NULL,
  `tipo_pgto` varchar(25) NOT NULL,
  `usuario_baixa` int(11) NOT NULL,
  `entrega` varchar(25) NOT NULL,
  `mesa` varchar(15) DEFAULT NULL,
  `nome_cliente` varchar(50) DEFAULT NULL,
  `cupom` decimal(8,2) DEFAULT NULL,
  `entregador` int(11) DEFAULT NULL,
  `pago_entregador` varchar(5) DEFAULT NULL,
  `pedido` int(11) DEFAULT NULL,
  `impressao` varchar(5) DEFAULT NULL,
  `ref_api` varchar(50) DEFAULT NULL,
  `mp_payment_id` varchar(255) DEFAULT NULL COMMENT 'ID do Pagamento no Mercado Pago (para PIX, etc.)',
  `caixa` int(11) DEFAULT NULL,
  `tipo_pedido` varchar(35) DEFAULT NULL,
  `taxa_cartao` decimal(10,2) NOT NULL DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Extraindo dados da tabela `vendas`
--

INSERT INTO `vendas` (`id`, `cliente`, `valor`, `total_pago`, `troco`, `data`, `hora`, `status`, `pago`, `obs`, `taxa_entrega`, `tipo_pgto`, `usuario_baixa`, `entrega`, `mesa`, `nome_cliente`, `cupom`, `entregador`, `pago_entregador`, `pedido`, `impressao`, `ref_api`, `mp_payment_id`, `caixa`, `tipo_pedido`, `taxa_cartao`) VALUES
(1, 6, 30.00, 30.00, 0.00, '2025-02-15', '11:18:10', 'Finalizado', 'Sim', '', 0.00, 'Pix', 1, 'Consumir Local', '', 'Hugo Test', 0.00, NULL, 'Não', 1, 'Sim', '', NULL, NULL, '', 0.00),
(2, 6, 23.99, 23.99, 0.00, '2025-02-18', '10:07:27', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', 'Hugo Test', 0.00, NULL, 'Não', 1, 'Sim', '', NULL, NULL, '', 0.00),
(3, 6, 30.00, 30.00, 0.00, '2025-02-18', '10:10:59', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', 'Hugo Test', 0.00, NULL, 'Não', 2, 'Sim', '', NULL, NULL, '', 0.00),
(4, 6, 23.99, 23.99, 0.00, '2025-02-18', '10:11:30', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', 'Hugo Test', 0.00, NULL, 'Não', 3, 'Sim', '102326523321', NULL, NULL, '', 0.00),
(5, 6, 23.99, 23.99, 0.00, '2025-02-25', '18:33:01', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', 'Hugo Test', 0.00, NULL, 'Não', 1, 'Sim', '103447173006', NULL, NULL, '', 0.00),
(6, 6, 20.00, 20.00, 0.00, '2025-02-25', '18:33:30', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', 'Hugo Test', 0.00, NULL, 'Não', 2, 'Sim', '', NULL, NULL, '', 0.00),
(7, 0, 30.00, 30.00, 0.00, '2025-02-25', '18:34:30', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', '', 0.00, NULL, 'Não', 3, 'Sim', '', NULL, NULL, 'Balcão', 0.00),
(8, 0, 38.39, 38.39, 0.00, '2025-02-25', '18:48:35', 'Finalizado', 'Sim', NULL, 0.00, '1', 1, 'Pedido Mesa', '25', 'Pedido Mesa', 0.00, NULL, 'Não', 0, NULL, '', NULL, NULL, 'Mesa', 0.00),
(9, 0, 31.30, 31.30, 0.00, '2025-02-26', '01:04:48', 'Finalizado', 'Sim', NULL, 0.00, 'Pix (Banco NuBank)', 1, 'Pedido Mesa', '25', 'João Mesa 5', 0.00, NULL, 'Não', 0, NULL, '', NULL, NULL, 'Mesa', 0.00),
(10, 0, 23.99, 23.99, 0.00, '2025-02-26', '18:51:54', 'Finalizado', 'Sim', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', '', 0.00, NULL, 'Não', 1, 'Sim', '', NULL, NULL, 'Balcão', 0.00),
(11, 11, 30.00, 60.00, 0.00, '2025-03-07', '16:33:24', 'Finalizado', 'Não', '', 0.00, 'Cartão de Crédito', 1, 'Retirar', '', 'Wesley', 0.00, NULL, 'Não', 1, NULL, '', NULL, NULL, '', 0.00),
(12, 11, 31.00, 31.00, 0.00, '2025-04-13', '18:41:45', 'Finalizado', 'Não', '', 0.00, 'Cartão de Crédito', 1, 'Retirar', '', 'Wesley', 0.00, NULL, 'Não', 1, NULL, '', NULL, NULL, '', 0.00),
(13, 0, -5.00, -5.00, 0.00, '2025-04-13', '18:52:44', 'Finalizado', 'Sim', NULL, 0.00, 'Pix', 1, 'Pedido Mesa', '22', 'carla', 0.00, NULL, 'Não', 0, NULL, '', NULL, NULL, 'Mesa', 0.00),
(14, 11, 2.00, 2.00, 0.00, '2025-04-16', '09:29:31', 'Finalizado', 'Sim', '', 0.00, 'Pix', 1, 'Retirar', '', 'Wesley', 0.00, NULL, 'Não', 1, NULL, '108590147110', NULL, NULL, '', 0.00),
(60, 11, 34.65, 34.65, 0.00, '2025-05-18', '10:54:06', 'Finalizado', 'Não', '', 0.00, 'Cartão de Crédito', 1, 'Consumir Local', '', 'Leo', 0.00, NULL, 'Não', 1, NULL, '', NULL, NULL, '', 0.00),
(62, 11, 2.00, 2.00, 0.00, '2025-06-05', '22:59:16', 'Finalizado', 'Sim', '', 0.00, 'Pix', 1, 'Retirar', '', 'WESLEY DOS SANTOS MENDES', 0.00, NULL, 'Não', 1, NULL, '113604528679', NULL, NULL, '', 0.00),
(63, 11, 2.00, 2.00, 0.00, '2025-06-05', '23:02:47', 'Finalizado', 'Sim', '', 0.00, 'Pix', 1, 'Retirar', '', 'WESLEY DOS SANTOS MENDES', 0.00, NULL, 'Não', 2, NULL, '113603967783', NULL, NULL, '', 0.00),
(74, 11, 34.00, 34.00, 0.00, '2025-06-08', '21:23:24', 'Iniciado', 'Não', '', 4.00, 'Cartão de Crédito', 0, 'Delivery', '', 'Wesley', 0.00, NULL, 'Não', 1, NULL, '114422165626', NULL, NULL, '', 0.00),
(75, 11, 124.00, 124.00, 0.00, '2025-06-09', '06:13:34', 'Iniciado', 'Não', '', 4.00, 'Cartão de Crédito', 0, 'Delivery', '', 'Wesley', 0.00, NULL, 'Não', 1, NULL, '113964125431', NULL, NULL, '', 0.00);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `abertura_mesa`
--
ALTER TABLE `abertura_mesa`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `acessos`
--
ALTER TABLE `acessos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `adicionais`
--
ALTER TABLE `adicionais`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `adicionais_cat`
--
ALTER TABLE `adicionais_cat`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `anotacoes`
--
ALTER TABLE `anotacoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `arquivos`
--
ALTER TABLE `arquivos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `bairros`
--
ALTER TABLE `bairros`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `banner_rotativo`
--
ALTER TABLE `banner_rotativo`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `bordas`
--
ALTER TABLE `bordas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `caixas`
--
ALTER TABLE `caixas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cargos`
--
ALTER TABLE `cargos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `carrinho`
--
ALTER TABLE `carrinho`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `config`
--
ALTER TABLE `config`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `cupons`
--
ALTER TABLE `cupons`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `dias`
--
ALTER TABLE `dias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `disparos`
--
ALTER TABLE `disparos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `dispositivos`
--
ALTER TABLE `dispositivos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `formas_pgto`
--
ALTER TABLE `formas_pgto`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `frequencias`
--
ALTER TABLE `frequencias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `grades`
--
ALTER TABLE `grades`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `grupo_acessos`
--
ALTER TABLE `grupo_acessos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `itens_grade`
--
ALTER TABLE `itens_grade`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `marketing`
--
ALTER TABLE `marketing`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `mesas`
--
ALTER TABLE `mesas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `pagar`
--
ALTER TABLE `pagar`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `receber`
--
ALTER TABLE `receber`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `saidas`
--
ALTER TABLE `saidas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `sangrias`
--
ALTER TABLE `sangrias`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `tarefas`
--
ALTER TABLE `tarefas`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `temp`
--
ALTER TABLE `temp`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `valor_adiantamento`
--
ALTER TABLE `valor_adiantamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `variacoes`
--
ALTER TABLE `variacoes`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `variacoes_cat`
--
ALTER TABLE `variacoes_cat`
  ADD PRIMARY KEY (`id`);

--
-- Índices para tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `abertura_mesa`
--
ALTER TABLE `abertura_mesa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `acessos`
--
ALTER TABLE `acessos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de tabela `adicionais`
--
ALTER TABLE `adicionais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de tabela `adicionais_cat`
--
ALTER TABLE `adicionais_cat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `anotacoes`
--
ALTER TABLE `anotacoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de tabela `arquivos`
--
ALTER TABLE `arquivos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de tabela `bairros`
--
ALTER TABLE `bairros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT de tabela `banner_rotativo`
--
ALTER TABLE `banner_rotativo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `bordas`
--
ALTER TABLE `bordas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `caixas`
--
ALTER TABLE `caixas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `cargos`
--
ALTER TABLE `cargos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `carrinho`
--
ALTER TABLE `carrinho`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=115;

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT de tabela `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de tabela `config`
--
ALTER TABLE `config`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `cupons`
--
ALTER TABLE `cupons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `dias`
--
ALTER TABLE `dias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `disparos`
--
ALTER TABLE `disparos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `dispositivos`
--
ALTER TABLE `dispositivos`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de tabela `entradas`
--
ALTER TABLE `entradas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `formas_pgto`
--
ALTER TABLE `formas_pgto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de tabela `fornecedores`
--
ALTER TABLE `fornecedores`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de tabela `frequencias`
--
ALTER TABLE `frequencias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de tabela `grades`
--
ALTER TABLE `grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=187;

--
-- AUTO_INCREMENT de tabela `grupo_acessos`
--
ALTER TABLE `grupo_acessos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de tabela `itens_grade`
--
ALTER TABLE `itens_grade`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1531;

--
-- AUTO_INCREMENT de tabela `marketing`
--
ALTER TABLE `marketing`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `mesas`
--
ALTER TABLE `mesas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT de tabela `pagar`
--
ALTER TABLE `pagar`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;

--
-- AUTO_INCREMENT de tabela `receber`
--
ALTER TABLE `receber`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de tabela `saidas`
--
ALTER TABLE `saidas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `sangrias`
--
ALTER TABLE `sangrias`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tarefas`
--
ALTER TABLE `tarefas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT de tabela `temp`
--
ALTER TABLE `temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT de tabela `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `usuarios_permissoes`
--
ALTER TABLE `usuarios_permissoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=822;

--
-- AUTO_INCREMENT de tabela `valor_adiantamento`
--
ALTER TABLE `valor_adiantamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `variacoes`
--
ALTER TABLE `variacoes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT de tabela `variacoes_cat`
--
ALTER TABLE `variacoes_cat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de tabela `vendas`
--
ALTER TABLE `vendas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
