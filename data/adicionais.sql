-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 08-Jul-2025 às 23:26
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

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `adicionais`
--
ALTER TABLE `adicionais`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `adicionais`
--
ALTER TABLE `adicionais`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
