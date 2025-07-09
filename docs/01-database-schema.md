# 📊 DOCUMENTAÇÃO DA ESTRUTURA DO BANCO DE DADOS

**Sistema:** Dragão Lanches - Sistema de Delivery  
**Banco:** MySQL - `deliverydragao`  
**Criado em:** $(date)  
**Status:** Mapeamento baseado em análise de código-fonte

---

## 🔧 CONFIGURAÇÃO DE CONEXÃO

```php
// Configuração Local
$servidor = 'localhost';
$banco = 'deliverydragao';
$usuario = 'root';
$senha = '';
$charset = 'utf8';
```

---

## 📋 TABELAS PRINCIPAIS IDENTIFICADAS

### 1. **config** - Configurações do Sistema

**Função:** Armazena todas as configurações globais do sistema

**Campos Identificados:**

- `nome` - Nome do estabelecimento
- `email` - Email do sistema
- `telefone` - Telefone principal
- `endereco` - Endereço do estabelecimento
- `instagram` - Instagram do estabelecimento
- `logo` - Logo principal
- `logo_rel` - Logo para relatórios
- `icone` - Ícone do sistema
- `ativo` - Status do sistema (Sim/Não)
- `multa_atraso` - Valor da multa por atraso
- `juros_atraso` - Juros por atraso
- `marca_dagua` - Usar marca d'água (Sim/Não)
- `assinatura_recibo` - Incluir assinatura no recibo
- `impressao_automatica` - Impressão automática
- `cnpj` - CNPJ do estabelecimento
- `entrar_automatico` - Login automático
- `mostrar_preloader` - Exibir preloader
- `ocultar_mobile` - Ocultar no mobile
- `api_whatsapp` - Usar API WhatsApp
- `token_whatsapp` - Token da API WhatsApp
- `instancia_whatsapp` - Instância WhatsApp
- `dados_pagamento` - Dados para pagamento
- `telefone_fixo` - Telefone fixo
- `tipo_rel` - Tipo de relatório
- `tipo_miniatura` - Tipo de miniatura
- `previsao_entrega` - Tempo de entrega (minutos)
- `horario_abertura` - Horário de abertura
- `horario_fechamento` - Horário de fechamento
- `texto_fechamento_horario` - Mensagem quando fechado por horário
- `texto_fechamento` - Mensagem quando fechado
- `status_estabelecimento` - Status (Aberto/Fechado)
- `tempo_atualizar` - Tempo para atualizar tela
- `tipo_chave` - Tipo de chave PIX
- `dias_apagar` - Dias para apagar registros
- `banner_rotativo` - Banner rotativo ativo
- `pedido_minimo` - Valor mínimo do pedido
- `mostrar_aberto` - Mostrar status aberto
- `entrega_distancia` - Entrega por distância
- `chave_api_maps` - Chave API Google Maps
- `latitude_rest` - Latitude do restaurante
- `longitude_rest` - Longitude do restaurante
- `distancia_entrega_km` - Distância máxima entrega
- `valor_km` - Valor por km
- `mais_sabores` - Permitir mais sabores
- `abrir_comprovante` - Abrir comprovante automaticamente
- `fonte_comprovante` - Tamanho da fonte do comprovante
- `mensagem_auto` - Mensagem automática
- `data_cobranca` - Data de cobrança
- `api_merc` - API Mercado Pago
- `comissao_garcon` - Comissão do garçom
- `couvert` - Valor do couvert
- `mostrar_acessos` - Mostrar acessos
- `abertura_caixa` - Abertura de caixa obrigatória
- `dias_retorno` - Dias para retorno
- `link_retorno` - Link de retorno
- `mensagem_retorno` - Mensagem de retorno
- `total_cartoes` - Total de cartões
- `valor_cupom` - Valor do cupom
- `taxa_cartao` - Taxa do cartão

---

### 2. **vendas** - Tabela Principal de Pedidos

**Função:** Armazena todos os pedidos/vendas do sistema

**Campos Identificados:**

- `id` - ID único do pedido
- `cliente` - ID do cliente (FK para tabela clientes)
- `valor` - Valor total do pedido
- `total_pago` - Valor total pago
- `troco` - Valor do troco
- `data` - Data do pedido
- `hora` - Hora do pedido
- `status` - Status do pedido (Iniciado, Aceito, Preparando, Entrega, Finalizado, Cancelado)
- `pago` - Status do pagamento (Sim/Não)
- `obs` - Observações do pedido
- `taxa_entrega` - Taxa de entrega
- `tipo_pgto` - Tipo de pagamento
- `usuario_baixa` - Usuário que deu baixa
- `entrega` - Tipo de entrega (Delivery, Retirar, Mesa)
- `mesa` - Número da mesa (quando aplicável)
- `nome_cliente` - Nome do cliente (quando não cadastrado)
- `pedido` - Número do pedido
- `impressao` - Status de impressão
- `ref_api` - Referência da API (PIX, etc.)

**Status Possíveis:**

- `Iniciado` - Pedido recém-criado
- `Aceito` - Pedido aceito pelo estabelecimento
- `Preparando` - Pedido em preparação
- `Entrega` - Pedido saiu para entrega
- `Finalizado` - Pedido concluído
- `Cancelado` - Pedido cancelado

---

### 3. **produtos** - Catálogo de Produtos

**Função:** Armazena todos os produtos do cardápio

**Campos Identificados:**

- `id` - ID único do produto
- `nome` - Nome do produto
- `descricao` - Descrição do produto
- `categoria` - ID da categoria (FK para tabela categorias)
- `valor_compra` - Valor de compra
- `valor_venda` - Valor de venda
- `foto` - Foto do produto
- `estoque` - Quantidade em estoque
- `nivel_estoque` - Nível mínimo de estoque
- `tem_estoque` - Controla estoque (Sim/Não)
- `ativo` - Produto ativo (Sim/Não)
- `combo` - É um combo (Sim/Não)
- `promocao` - Em promoção (Sim/Não)
- `preparado` - Precisa ser preparado (Sim/Não)
- `delivery` - Disponível para delivery (Sim/Não)
- `val_promocional` - Valor promocional

---

### 4. **clientes** - Cadastro de Clientes

**Função:** Armazena informações dos clientes

**Campos Identificados:**

- `id` - ID único do cliente
- `nome` - Nome completo
- `telefone` - Telefone do cliente
- `email` - Email do cliente
- `endereco` - Endereço completo
- `cpf` - CPF do cliente
- `numero` - Número da residência
- `bairro` - Bairro
- `cidade` - Cidade
- `estado` - Estado
- `cep` - CEP
- `data_cad` - Data de cadastro
- `data_nasc` - Data de nascimento
- `complemento` - Complemento do endereço
- `marketing` - Aceita marketing (Sim/Não)
- `usuario` - Usuário que cadastrou

---

### 5. **carrinho** - Itens do Carrinho/Pedido

**Função:** Armazena os itens de cada pedido

**Campos Identificados:**

- `id` - ID único do item
- `sessao` - Sessão do usuário
- `cliente` - ID do cliente
- `produto` - ID do produto (FK para tabela produtos)
- `quantidade` - Quantidade do produto
- `total_item` - Valor total do item
- `obs` - Observações do item
- `pedido` - ID do pedido (FK para tabela vendas)
- `data` - Data do item
- `mesa` - Mesa (quando aplicável)
- `nome_cliente` - Nome do cliente
- `valor_unitario` - Valor unitário do produto
- `status` - Status do item (Aguardando, etc.)
- `hora` - Hora do item

### 6. **carrinho_adicionais** - Adicionais dos Itens do Carrinho

**Função:** Armazena os adicionais selecionados para cada item do carrinho

**Campos:**

- `id` - ID único do registro
- `carrinho_id` - ID do item no carrinho (FK para tabela carrinho)
- `adicional_id` - ID do adicional (FK para tabela adicionais)
- `quantidade` - Quantidade do adicional
- `valor_unitario` - Valor unitário do adicional
- `valor_total` - Valor total do adicional (quantidade \* valor_unitario)

**Relacionamentos:**

- FK com `carrinho.id`
- FK com `adicionais.id`

**Índices:**

- PRIMARY KEY (`id`)
- INDEX `idx_carrinho` (`carrinho_id`)
- INDEX `idx_adicional` (`adicional_id`)

---

### 7. **categorias** - Categorias de Produtos

**Função:** Organiza os produtos em categorias

**Campos Identificados:**

- `id` - ID único da categoria
- `nome` - Nome da categoria
- `mais_sabores` - Permite mais sabores (Sim/Não)

---

### 8. **usuarios** - Usuários do Sistema

**Função:** Controle de acesso ao sistema

**Campos Identificados:**

- `id` - ID único do usuário
- `nome` - Nome do usuário
- `email` - Email para login
- `senha` - Senha criptografada
- `nivel` - Nível de acesso
- `token` - Token para recuperação de senha

---

### 9. **mesas** - Controle de Mesas

**Função:** Gerenciamento de mesas do estabelecimento

**Campos Identificados:**

- `id` - ID único da mesa
- `numero` - Número da mesa
- `status` - Status da mesa

---

### 10. **dias** - Dias de Funcionamento

**Função:** Controla os dias que o estabelecimento funciona

**Campos Identificados:**

- `id` - ID único
- `dia` - Nome do dia da semana

---

### 11. **variacoes** - Variações de Produtos

**Função:** Armazena variações dos produtos (tamanhos, sabores, etc.)

**Campos Identificados:**

- `id` - ID único da variação
- `produto` - ID do produto (FK)
- `nome` - Nome da variação
- `valor` - Valor da variação

---

### 12. **temp** - Tabela Temporária

**Função:** Armazena dados temporários durante a montagem do pedido

**Campos Identificados:**

- `id` - ID único
- `sessao` - Sessão do usuário
- `carrinho` - ID do carrinho
- `tabela` - Tipo de item (Variação, adicionais, etc.)
- `grade` - ID da grade (quando aplicável)

---

### 13. **bordas** - Bordas de Pizza

**Função:** Opções de bordas para pizzas

**Campos Identificados:**

- `id` - ID único da borda
- `nome` - Nome da borda
- `valor` - Valor adicional da borda

---

### 14. **grades** - Grades de Produtos

**Função:** Sistema de grades para produtos complexos

**Campos Identificados:**

- `id` - ID único da grade
- `produto` - ID do produto (FK)
- `tipo_item` - Tipo do item da grade

---

### 15. **itens_grade** - Itens das Grades

**Função:** Itens específicos das grades

**Campos Identificados:**

- `id` - ID único do item
- `grade` - ID da grade (FK)
- `nome` - Nome do item
- `valor` - Valor do item

---

### 16. **abertura_mesa** - Abertura de Mesas

**Função:** Controla a abertura de mesas para atendimento

**Campos Identificados:**

- `id` - ID único da abertura
- `mesa` - ID da mesa (FK)
- `garcon` - ID do garçom (FK para usuarios)
- `data` - Data da abertura
- `hora` - Hora da abertura

---

### 17. **formas_pgto** - Formas de Pagamento

**Função:** Cadastro das formas de pagamento aceitas

**Campos Identificados:**

- `id` - ID único
- `nome` - Nome da forma de pagamento

---

### 18. **receber** - Contas a Receber

**Função:** Controle financeiro de recebimentos

**Campos Identificados:**

- `id` - ID único
- `cliente` - ID do cliente (FK)
- `valor` - Valor a receber
- `vencimento` - Data de vencimento
- `data_pgto` - Data do pagamento
- `pago` - Status (Sim/Não)
- `usuario_lanc` - Usuário que lançou
- `usuario_pgto` - Usuário que recebeu
- `forma_pgto` - Forma de pagamento
- `caixa` - ID do caixa

---

### 19. **pagar** - Contas a Pagar

**Função:** Controle financeiro de pagamentos

**Campos Identificados:**

- `id` - ID único
- `fornecedor` - ID do fornecedor
- `funcionario` - ID do funcionário
- `valor` - Valor a pagar
- `vencimento` - Data de vencimento
- `data_pgto` - Data do pagamento
- `pago` - Status (Sim/Não)
- `referencia` - Referência (Conta, Compra, etc.)
- `usuario_lanc` - Usuário que lançou
- `usuario_pgto` - Usuário que pagou
- `forma_pgto` - Forma de pagamento
- `caixa` - ID do caixa

---

### 20. **fornecedores** - Cadastro de Fornecedores

**Função:** Controle de fornecedores

**Campos Identificados:**

- `id` - ID único
- `nome` - Nome do fornecedor

---

### 21. **caixas** - Controle de Caixa

**Função:** Gerenciamento de caixas

**Campos Identificados:**

- `id` - ID único do caixa
- `operador` - ID do operador
- `data_abertura` - Data de abertura
- `usuario_abertura` - Usuário que abriu
- `usuario_fechamento` - Usuário que fechou

---

### 22. **sangrias** - Sangrias do Caixa

**Função:** Controle de retiradas do caixa

**Campos Identificados:**

- `id` - ID único
- `caixa` - ID do caixa (FK)
- `valor` - Valor da sangria
- `usuario` - Usuário que fez
- `feito_por` - Usuário responsável

---

### 23. **frequencias** - Frequências de Pagamento

**Função:** Controle de frequências para pagamentos recorrentes

**Campos Identificados:**

- `id` - ID único
- `dias` - Número de dias

---

### 24. **acessos** - Controle de Acessos

**Função:** Sistema de permissões

**Campos Identificados:**

- `id` - ID único
- `nome` - Nome do acesso

---

### 25. **usuarios_permissoes** - Permissões dos Usuários

**Função:** Relaciona usuários com suas permissões

**Campos Identificados:**

- `id` - ID único
- `usuario` - ID do usuário (FK)
- `permissao` - ID da permissão (FK)

---

## 🔗 RELACIONAMENTOS PRINCIPAIS

### Fluxo de Pedidos:

1. **vendas** (pedido principal)
2. **carrinho** (itens do pedido) → FK: `pedido`
3. **produtos** (dados do produto) → FK: `produto`
4. **clientes** (dados do cliente) → FK: `cliente`
5. **temp** (dados temporários) → FK: `carrinho`

### Sistema de Produtos:

1. **produtos** → FK: `categoria` (categorias)
2. **variacoes** → FK: `produto` (produtos)
3. **grades** → FK: `produto` (produtos)
4. **itens_grade** → FK: `grade` (grades)

### Sistema Financeiro:

1. **receber** → FK: `cliente` (clientes)
2. **pagar** → FK: `fornecedor` (fornecedores)
3. **vendas** → Gera entradas em **receber**

### Sistema de Mesas:

1. **abertura_mesa** → FK: `mesa` (mesas)
2. **abertura_mesa** → FK: `garcon` (usuarios)
3. **carrinho** → FK: `mesa` (abertura_mesa)

---

## ⚠️ OBSERVAÇÕES IMPORTANTES

### Performance:

- **CRÍTICO:** Muitas consultas usam `SELECT *` - otimizar para campos específicos
- **CRÍTICO:** Ausência de índices explícitos identificada
- **ATENÇÃO:** Consultas N+1 detectadas em listagens

### Segurança:

- **CRÍTICO:** Algumas consultas não usam prepared statements
- **ATENÇÃO:** Validação de entrada inconsistente

### Integridade:

- **CRÍTICO:** Relacionamentos não enforçados por Foreign Keys
- **ATENÇÃO:** Alguns campos podem aceitar valores inconsistentes

---

**Próximos Passos:**

1. Validar estrutura real via DESCRIBE das tabelas
2. Mapear índices existentes
3. Identificar consultas mais lentas
4. Propor otimizações específicas

---

_Documento gerado automaticamente via análise de código-fonte_
