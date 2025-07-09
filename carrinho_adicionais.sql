-- Criação da tabela carrinho_adicionais
CREATE TABLE `carrinho_adicionais` (
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