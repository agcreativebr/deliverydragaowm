-- Restaurar estrutura do banco de dados
-- Tabela carrinho_adicionais
CREATE TABLE IF NOT EXISTS `carrinho_adicionais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `carrinho_id` int(11) NOT NULL,
  `adicional_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL DEFAULT 1,
  `valor_unitario` decimal(8,2) NOT NULL,
  `valor_total` decimal(8,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_carrinho` (`carrinho_id`),
  KEY `idx_adicional` (`adicional_id`),
  CONSTRAINT `fk_carrinho_adicionais_carrinho` FOREIGN KEY (`carrinho_id`) REFERENCES `carrinho` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_carrinho_adicionais_adicional` FOREIGN KEY (`adicional_id`) REFERENCES `adicionais` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- Atualizar a tabela de produtos
ALTER TABLE `produtos` 
ADD COLUMN IF NOT EXISTS `valor_venda` decimal(8,2) NOT NULL DEFAULT 0.00,
ADD COLUMN IF NOT EXISTS `valor_compra` decimal(8,2) NOT NULL DEFAULT 0.00,
ADD COLUMN IF NOT EXISTS `estoque` int(11) NOT NULL DEFAULT 0,
ADD COLUMN IF NOT EXISTS `tem_estoque` varchar(5) NOT NULL DEFAULT 'Não',
ADD COLUMN IF NOT EXISTS `ativo` varchar(5) NOT NULL DEFAULT 'Sim',
ADD COLUMN IF NOT EXISTS `promocao` varchar(5) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `val_promocional` decimal(8,2) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `delivery` varchar(5) DEFAULT NULL;

-- Atualizar a tabela de carrinho
ALTER TABLE `carrinho`
ADD COLUMN IF NOT EXISTS `valor_unitario` decimal(8,2) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `total_item` decimal(8,2) NOT NULL DEFAULT 0.00,
ADD COLUMN IF NOT EXISTS `obs` varchar(255) DEFAULT NULL,
ADD COLUMN IF NOT EXISTS `variacao` int(11) DEFAULT NULL; 