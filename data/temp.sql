-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09-Jul-2025 às 17:58
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
(48, '2025-05-18-10:53:32-880', 'Múltiplo', 109, 76, '2025-05-18', NULL, 28, 6.00, 1, 'Agregado'),
(49, '2025-05-18-10:53:32-880', 'Múltiplo', 108, 76, '2025-05-18', NULL, 28, 5.00, 1, 'Agregado'),
(50, '2025-05-18-10:53:32-880', 'Múltiplo', 107, 76, '2025-05-18', NULL, 28, 4.00, 1, 'Agregado'),
(51, '2025-05-31-22:57:55-568', 'Múltiplo', 779, 78, '2025-05-31', NULL, 103, 6.00, 1, 'Agregado'),
(52, '2025-06-07-12:21:10-444', 'Múltiplo', 1529, 81, '2025-06-07', NULL, 186, 2.00, 1, 'Único'),
(54, '2025-06-08-21:23:53-258', 'Múltiplo', 805, 114, '2025-06-09', NULL, 105, 5.00, 2, 'Agregado'),
(56, '2025-06-08-21:23:53-258', 'Múltiplo', 802, 114, '2025-06-09', NULL, 105, 6.00, 2, 'Agregado'),
(58, '2025-06-08-21:23:53-258', 'Múltiplo', 801, 114, '2025-06-09', NULL, 105, 5.00, 2, 'Agregado'),
(60, '2025-06-08-21:23:53-258', 'Múltiplo', 799, 114, '2025-06-09', NULL, 105, 6.00, 2, 'Agregado'),
(63, '2025-06-08-21:23:53-258', 'Múltiplo', 797, 114, '2025-06-09', NULL, 105, 6.00, 3, 'Agregado'),
(64, '2025-06-11-12:52:59-326', 'Múltiplo', 1528, 143, '2025-06-11', NULL, 183, 2.00, 1, 'Único'),
(65, '2025-06-11-12:52:59-326', 'Múltiplo', 1527, 143, '2025-06-11', NULL, 183, 14.00, 1, 'Único'),
(66, '2025-06-11-12:52:59-326', 'Múltiplo', 1526, 143, '2025-06-11', NULL, 183, 8.00, 1, 'Único'),
(67, '2025-06-11-12:52:59-326', 'Múltiplo', 1525, 143, '2025-06-11', NULL, 183, 5.00, 1, 'Único'),
(69, '2025-06-11-12:52:59-326', 'Múltiplo', 1527, 144, '2025-06-11', NULL, 183, 14.00, 2, 'Único'),
(70, '2025-06-13-17:03:15-1350', 'Múltiplo', 105, 157, '2025-06-13', NULL, 28, 6.00, 1, 'Agregado'),
(71, '2025-06-13-17:03:15-1350', 'Múltiplo', 107, 157, '2025-06-13', NULL, 28, 4.00, 1, 'Agregado'),
(72, '2025-06-13-17:03:15-1350', 'Múltiplo', 106, 157, '2025-06-13', NULL, 28, 6.00, 1, 'Agregado'),
(90, '2025-06-14-17:55:17-256', 'Múltiplo', 311, 171, '2025-06-14', NULL, 51, 6.00, 2, 'Agregado'),
(92, '2025-06-14-17:55:17-256', 'Múltiplo', 315, 171, '2025-06-14', NULL, 51, 5.00, 2, 'Agregado'),
(93, '2025-06-14-17:55:17-256', 'Múltiplo', 316, 171, '2025-06-14', NULL, 51, 6.00, 1, 'Agregado'),
(94, '2025-06-14-17:55:17-256', 'Múltiplo', 317, 171, '2025-06-14', NULL, 51, 2.00, 1, 'Agregado'),
(95, '2025-06-14-17:55:17-256', 'Múltiplo', 318, 171, '2025-06-14', NULL, 51, 2.00, 1, 'Agregado'),
(96, '2025-06-14-17:55:17-256', 'Múltiplo', 319, 171, '2025-06-14', NULL, 51, 5.00, 1, 'Agregado'),
(97, '2025-06-14-17:55:17-256', 'Múltiplo', 313, 171, '2025-06-14', NULL, 51, 6.00, 1, 'Agregado'),
(98, '2025-06-14-17:55:17-256', 'Múltiplo', 314, 171, '2025-06-14', NULL, 51, 4.00, 1, 'Agregado'),
(99, '2025-06-14-17:55:17-256', 'Múltiplo', 312, 171, '2025-06-14', NULL, 51, 6.00, 1, 'Agregado'),
(100, '2025-06-14-17:55:17-256', 'Múltiplo', 1527, 172, '2025-06-14', NULL, 183, 14.00, 1, 'Único'),
(103, '2025-06-14-17:57:55-1297', 'Múltiplo', 86, 173, '2025-06-14', NULL, 26, 6.00, 3, 'Agregado'),
(105, '2025-06-14-17:57:55-1297', 'Múltiplo', 221, 174, '2025-06-14', NULL, 41, 6.00, 2, 'Agregado'),
(107, '2025-06-14-17:57:55-1297', 'Múltiplo', 222, 174, '2025-06-14', NULL, 41, 6.00, 2, 'Agregado'),
(109, '2025-06-14-17:57:55-1297', 'Múltiplo', 1526, 175, '2025-06-14', NULL, 183, 8.00, 2, 'Único'),
(110, '2025-06-29-11:15:23-767', 'Múltiplo', 392, 190, '2025-06-29', NULL, 60, 6.00, 1, 'Agregado'),
(111, '2025-06-29-11:15:23-767', 'Múltiplo', 393, 190, '2025-06-29', NULL, 60, 6.00, 1, 'Agregado'),
(112, '2025-06-29-11:15:23-767', 'Múltiplo', 394, 190, '2025-06-29', NULL, 60, 6.00, 1, 'Agregado'),
(217, '2025-07-08-15:16:54-876', 'adicionais', 103, 297, NULL, NULL, NULL, NULL, 1, NULL),
(218, '2025-07-08-15:16:54-876', 'adicionais', 805, 298, NULL, NULL, NULL, NULL, 1, NULL),
(219, '2025-07-08-15:16:54-876', 'adicionais', 814, 299, NULL, NULL, NULL, NULL, 1, NULL),
(220, '2025-07-08-15:16:54-876', 'adicionais', 146, 300, NULL, NULL, NULL, NULL, 1, NULL),
(221, '2025-07-08-15:16:54-876', 'adicionais', 355, 301, NULL, NULL, NULL, NULL, 2, NULL),
(222, '2025-07-08-15:16:54-876', 'adicionais', 92, 302, NULL, NULL, NULL, NULL, 1, NULL),
(235, '2025-07-08-15:16:54-876', 'adicionais', 103, 310, NULL, NULL, NULL, NULL, 2, NULL),
(236, '2025-07-08-15:16:54-876', 'adicionais', 102, 310, NULL, NULL, NULL, NULL, 2, NULL),
(239, '2025-07-08-15:16:54-876', 'adicionais', 99, 310, NULL, NULL, NULL, NULL, 2, NULL),
(240, '2025-07-08-15:16:54-876', 'adicionais', 98, 310, NULL, NULL, NULL, NULL, 2, NULL),
(242, '2025-07-08-15:16:54-876', 'adicionais', 96, 310, NULL, NULL, NULL, NULL, 2, NULL),
(243, '2025-07-08-15:16:54-876', 'adicionais', 95, 310, NULL, NULL, NULL, NULL, 2, NULL),
(244, '2025-07-08-20:30:07-306', 'adicionais', 121, 311, NULL, NULL, NULL, NULL, 6, NULL),
(245, '2025-07-08-20:36:56-230', 'adicionais', 814, 312, NULL, NULL, NULL, NULL, 5, NULL),
(246, '2025-07-08-20:36:56-230', 'adicionais', 813, 312, NULL, NULL, NULL, NULL, 5, NULL),
(248, '2025-07-08-20:36:56-230', 'adicionais', 811, 312, NULL, NULL, NULL, NULL, 5, NULL),
(249, '2025-07-08-20:36:56-230', 'adicionais', 810, 312, NULL, NULL, NULL, NULL, 5, NULL),
(250, '2025-07-08-20:36:56-230', 'adicionais', 809, 312, NULL, NULL, NULL, NULL, 5, NULL),
(251, '2025-07-08-20:36:56-230', 'adicionais', 808, 312, NULL, NULL, NULL, NULL, 5, NULL),
(252, '2025-07-08-20:36:56-230', 'adicionais', 807, 312, NULL, NULL, NULL, NULL, 5, NULL),
(253, '2025-07-08-20:36:56-230', 'adicionais', 806, 312, NULL, NULL, NULL, NULL, 5, NULL),
(254, '2025-07-08-20:40:05-1273', 'adicionais', 814, 313, NULL, NULL, NULL, NULL, 1, NULL),
(255, '2025-07-08-20:52:26-1391', 'adicionais', 111, 314, NULL, NULL, NULL, NULL, 1, NULL),
(256, '2025-07-08-22:19:30-908', 'adicionais', 103, 315, NULL, NULL, NULL, NULL, 5, NULL),
(257, '2025-07-08-22:19:30-908', 'adicionais', 99, 315, NULL, NULL, NULL, NULL, 4, NULL),
(258, '2025-07-08-22:19:59-737', 'adicionais', 381, 316, NULL, NULL, NULL, NULL, 2, NULL),
(259, '2025-07-08-22:19:59-737', 'adicionais', 380, 316, NULL, NULL, NULL, NULL, 1, NULL),
(260, '2025-07-08-22:20:18-1178', 'adicionais', 797, 317, NULL, NULL, NULL, NULL, 2, NULL),
(261, '2025-07-08-23:37:59-461', 'adicionais', 112, 323, NULL, NULL, NULL, NULL, 3, NULL),
(262, '2025-07-09-01:52:29-193', 'adicionais', 337, 328, NULL, NULL, NULL, NULL, 1, NULL),
(263, '2025-07-09-09:13:47-225', 'adicionais', 832, 0, NULL, NULL, NULL, NULL, 1, NULL),
(264, '2025-07-09-09:13:47-225', 'adicionais', 828, 0, NULL, NULL, NULL, NULL, 1, NULL),
(265, '2025-07-09-09:55:46-1479', 'adicionais', 796, 330, NULL, NULL, NULL, NULL, 1, NULL),
(266, '2025-07-09-09:55:46-1479', 'adicionais', 795, 330, NULL, NULL, NULL, NULL, 1, NULL),
(267, '2025-07-09-09:55:46-1479', 'adicionais', 793, 330, NULL, NULL, NULL, NULL, 1, NULL),
(268, '2025-07-09-09:55:46-1479', 'adicionais', 792, 330, NULL, NULL, NULL, NULL, 1, NULL),
(269, '2025-07-09-10:17:35-857', 'adicionais', 803, 331, NULL, NULL, NULL, NULL, 1, NULL),
(270, '2025-07-09-10:17:35-857', 'adicionais', 802, 331, NULL, NULL, NULL, NULL, 1, NULL),
(271, '2025-07-09-10:17:35-857', 'adicionais', 800, 331, NULL, NULL, NULL, NULL, 1, NULL),
(272, '2025-07-09-10:47:16-1369', 'adicionais', 93, 332, NULL, NULL, NULL, NULL, 1, NULL),
(273, '2025-07-09-10:47:16-1369', 'adicionais', 87, 332, NULL, NULL, NULL, NULL, 1, NULL),
(274, '2025-07-09-10:47:16-1369', 'adicionais', 89, 332, NULL, NULL, NULL, NULL, 1, NULL),
(275, '2025-07-09-11:09:59-133', 'adicionais', 832, 333, NULL, NULL, NULL, NULL, 1, NULL),
(276, '2025-07-09-11:09:59-133', 'adicionais', 828, 333, NULL, NULL, NULL, NULL, 1, NULL),
(277, '2025-07-09-11:27:14-441', 'adicionais', 832, 334, NULL, NULL, NULL, NULL, 1, NULL),
(278, '2025-07-09-11:36:33-1436', 'adicionais', 804, 335, NULL, NULL, NULL, NULL, 1, NULL),
(279, '2025-07-09-11:36:33-1436', 'adicionais', 800, 335, NULL, NULL, NULL, NULL, 1, NULL),
(280, '2025-07-09-11:36:33-1436', 'adicionais', 798, 335, NULL, NULL, NULL, NULL, 1, NULL),
(281, '2025-07-09-11:52:43-1125', 'adicionais', 95, 336, NULL, NULL, NULL, NULL, 1, NULL),
(282, '2025-07-09-11:52:43-1125', 'adicionais', 96, 336, NULL, NULL, NULL, NULL, 1, NULL),
(283, '2025-07-09-11:52:43-1125', 'adicionais', 97, 336, NULL, NULL, NULL, NULL, 1, NULL),
(284, '2025-07-09-12:03:42-1096', 'adicionais', 803, 337, NULL, NULL, NULL, NULL, 1, NULL),
(285, '2025-07-09-12:03:42-1096', 'adicionais', 798, 337, NULL, NULL, NULL, NULL, 1, NULL),
(286, '2025-07-09-12:03:42-1096', 'adicionais', 800, 337, NULL, NULL, NULL, NULL, 1, NULL),
(287, '2025-07-09-12:42:10-1184', 'adicionais', 805, 338, NULL, NULL, NULL, NULL, 1, NULL),
(288, '2025-07-09-12:42:10-1184', 'adicionais', 804, 338, NULL, NULL, NULL, NULL, 1, NULL),
(289, '2025-07-09-12:45:05-1112', 'adicionais', 804, 339, NULL, NULL, NULL, NULL, 1, NULL),
(290, '2025-07-09-12:45:05-1112', 'adicionais', 801, 339, NULL, NULL, NULL, NULL, 1, NULL),
(291, '2025-07-09-12:45:05-1112', 'adicionais', 800, 339, NULL, NULL, NULL, NULL, 1, NULL);

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `temp`
--
ALTER TABLE `temp`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `temp`
--
ALTER TABLE `temp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=292;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
