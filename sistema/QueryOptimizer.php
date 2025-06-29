<?php
class QueryOptimizer
{
    private $pdo;
    private static $cache = [];
    private static $cacheEnabled = true;
    private static $cacheTTL = 900; // 15 minutos por padrão

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    /**
     * Otimiza consultas N+1 usando JOINs
     */
    public function optimizeQuery($table, $joins = [], $conditions = [], $fields = '*', $groupBy = '', $orderBy = '', $limit = '')
    {
        try {
            // Gera chave única para cache
            $cacheKey = $this->generateCacheKey(func_get_args());

            // Verifica cache
            if (self::$cacheEnabled && isset(self::$cache[$cacheKey]) && self::$cache[$cacheKey]['expires'] > time()) {
                return self::$cache[$cacheKey]['data'];
            }

            // Constrói a query
            $sql = "SELECT $fields FROM $table";

            // Adiciona JOINs
            foreach ($joins as $join) {
                $sql .= " " . $join['type'] . " JOIN " . $join['table'] . " ON " . $join['condition'];
            }

            // Adiciona condições WHERE
            if (!empty($conditions)) {
                $sql .= " WHERE " . implode(' AND ', array_keys($conditions));
            }

            // Adiciona GROUP BY
            if (!empty($groupBy)) {
                $sql .= " GROUP BY $groupBy";
            }

            // Adiciona ORDER BY
            if (!empty($orderBy)) {
                $sql .= " ORDER BY $orderBy";
            }

            // Adiciona LIMIT
            if (!empty($limit)) {
                $sql .= " LIMIT $limit";
            }

            // Prepara e executa a query
            $stmt = $this->pdo->prepare($sql);
            if (!empty($conditions)) {
                $stmt->execute(array_values($conditions));
            } else {
                $stmt->execute();
            }

            $result = $stmt->fetchAll(PDO::FETCH_ASSOC);

            // Salva no cache
            if (self::$cacheEnabled) {
                self::$cache[$cacheKey] = [
                    'data' => $result,
                    'expires' => time() + self::$cacheTTL
                ];
            }

            return $result;
        } catch (PDOException $e) {
            // Log do erro
            error_log("Erro na query otimizada: " . $e->getMessage());
            throw $e;
        }
    }

    /**
     * Exemplo de uso para listagem de pedidos com informações relacionadas
     */
    public function listarPedidosOtimizado($status = null, $limit = null)
    {
        $joins = [
            [
                'type' => 'LEFT',
                'table' => 'clientes c',
                'condition' => 'v.cliente = c.id'
            ],
            [
                'type' => 'LEFT',
                'table' => 'usuarios u',
                'condition' => 'v.usuario_baixa = u.id'
            ]
        ];

        $fields = "
            v.id, v.valor, v.status, v.data, v.hora,
            v.total_pago, v.troco, v.tipo_pgto, v.entrega,
            COALESCE(c.nome, v.nome_cliente) as nome_cliente,
            c.telefone as telefone_cliente,
            u.nome as nome_usuario_baixa
        ";

        $conditions = [];
        if ($status) {
            $conditions["v.status = ?"] = $status;
        }

        return $this->optimizeQuery(
            'vendas v',
            $joins,
            $conditions,
            $fields,
            '',
            'v.data DESC, v.hora DESC',
            $limit
        );
    }

    /**
     * Exemplo de uso para produtos com suas variações
     */
    public function listarProdutosComVariacoes($categoria = null)
    {
        $joins = [
            [
                'type' => 'LEFT',
                'table' => 'variacoes v',
                'condition' => 'p.id = v.produto'
            ],
            [
                'type' => 'LEFT',
                'table' => 'categorias c',
                'condition' => 'p.categoria = c.id'
            ]
        ];

        $fields = "
            p.*, 
            c.nome as categoria_nome,
            GROUP_CONCAT(DISTINCT v.nome) as variacoes,
            GROUP_CONCAT(DISTINCT v.valor) as valores_variacoes
        ";

        $conditions = [];
        if ($categoria) {
            $conditions["p.categoria = ?"] = $categoria;
        }

        return $this->optimizeQuery(
            'produtos p',
            $joins,
            $conditions,
            $fields,
            'p.id',
            'p.nome ASC'
        );
    }

    /**
     * Controle de cache
     */
    public static function enableCache($ttl = 900)
    {
        self::$cacheEnabled = true;
        self::$cacheTTL = $ttl;
    }

    public static function disableCache()
    {
        self::$cacheEnabled = false;
    }

    public static function clearCache()
    {
        self::$cache = [];
    }

    /**
     * Gera chave única para cache
     */
    private function generateCacheKey($args)
    {
        return md5(serialize($args));
    }

    /**
     * Invalida cache específico
     */
    public static function invalidateCache($table)
    {
        foreach (self::$cache as $key => $value) {
            if (strpos($key, $table) !== false) {
                unset(self::$cache[$key]);
            }
        }
    }
}
