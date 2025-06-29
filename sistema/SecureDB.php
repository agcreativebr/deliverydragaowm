<?php

/**
 * Classe SecureDB - Sistema de Consultas Seguras
 * 
 * Esta classe substitui as consultas SQL vulneráveis por prepared statements
 * mantendo total compatibilidade com o código existente.
 * 
 * Criado para corrigir vulnerabilidades críticas de SQL Injection
 * CVSS Score: 9.8/10 - CRÍTICO
 */

class SecureDB
{
    private $pdo;

    public function __construct($pdo)
    {
        $this->pdo = $pdo;
    }

    /**
     * Executa SELECT com prepared statement
     * @param string $table Nome da tabela
     * @param array $conditions Condições WHERE ['campo = ?' => 'valor'] ou ['campo' => 'valor']
     * @param string $fields Campos a selecionar
     * @param string $orderBy Ordenação
     * @param string $limit Limite
     * @return array Resultado da consulta
     */
    public function select($table, $conditions = [], $fields = '*', $orderBy = '', $limit = '')
    {
        $sql = "SELECT $fields FROM $table";
        $params = [];

        if (!empty($conditions)) {
            $whereClause = [];
            $whereCounter = 0;

            foreach ($conditions as $condition => $value) {
                // Se a condição já contém um operador, usar como está
                if (
                    strpos($condition, '=') !== false || strpos($condition, '>') !== false ||
                    strpos($condition, '<') !== false || strpos($condition, 'LIKE') !== false
                ) {

                    // Se já tem parâmetro nomeado (:param), usar como está
                    if (strpos($condition, ':') !== false) {
                        $whereClause[] = $condition;
                        // Extrair nome do parâmetro
                        preg_match('/:(\w+)/', $condition, $matches);
                        if (isset($matches[1])) {
                            $params[$matches[1]] = $value;
                        }
                    } else {
                        // Substituir ? por parâmetro nomeado
                        $paramName = "param_$whereCounter";
                        $whereClause[] = str_replace('?', ":$paramName", $condition);
                        $params[$paramName] = $value;
                        $whereCounter++;
                    }
                } else {
                    // Condição simples: campo => valor
                    $paramName = "param_$whereCounter";
                    $whereClause[] = "$condition = :$paramName";
                    $params[$paramName] = $value;
                    $whereCounter++;
                }
            }
            $sql .= " WHERE " . implode(' AND ', $whereClause);
        }

        if ($orderBy) {
            $sql .= " ORDER BY $orderBy";
        }

        if ($limit) {
            $sql .= " LIMIT $limit";
        }

        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt->fetchAll(PDO::FETCH_ASSOC);
    }

    /**
     * Executa INSERT com prepared statement
     * @param string $table Nome da tabela
     * @param array $data Dados para inserir ['campo' => 'valor']
     * @return int ID do registro inserido
     */
    public function insert($table, $data)
    {
        $fields = implode(', ', array_keys($data));
        $placeholders = ':' . implode(', :', array_keys($data));

        $sql = "INSERT INTO $table ($fields) VALUES ($placeholders)";

        $stmt = $this->pdo->prepare($sql);

        foreach ($data as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }

        $stmt->execute();
        return $this->pdo->lastInsertId();
    }

    /**
     * Executa UPDATE com prepared statement
     * @param string $table Nome da tabela
     * @param array $data Dados para atualizar ['campo' => 'valor']
     * @param array $conditions Condições WHERE ['campo' => 'valor'] ou ['campo = :param' => 'valor']
     * @return bool Sucesso da operação
     */
    public function update($table, $data, $conditions)
    {
        $setClause = [];
        $params = [];

        // Preparar SET clause com parâmetros nomeados
        foreach ($data as $key => $value) {
            $paramName = "set_$key";
            $setClause[] = "$key = :$paramName";
            $params[$paramName] = $value;
        }

        $sql = "UPDATE $table SET " . implode(', ', $setClause);

        // Preparar WHERE clause
        if (!empty($conditions)) {
            $whereClause = [];
            $whereCounter = 0;

            foreach ($conditions as $condition => $value) {
                // Se a condição já contém um operador, usar como está
                if (
                    strpos($condition, '=') !== false || strpos($condition, '>') !== false ||
                    strpos($condition, '<') !== false || strpos($condition, 'LIKE') !== false
                ) {

                    // Se já tem parâmetro nomeado (:param), usar como está
                    if (strpos($condition, ':') !== false) {
                        $whereClause[] = $condition;
                        // Extrair nome do parâmetro
                        preg_match('/:(\w+)/', $condition, $matches);
                        if (isset($matches[1])) {
                            $params[$matches[1]] = $value;
                        }
                    } else {
                        // Substituir ? por parâmetro nomeado
                        $paramName = "where_$whereCounter";
                        $whereClause[] = str_replace('?', ":$paramName", $condition);
                        $params[$paramName] = $value;
                        $whereCounter++;
                    }
                } else {
                    // Condição simples: campo => valor
                    $paramName = "where_$whereCounter";
                    $whereClause[] = "$condition = :$paramName";
                    $params[$paramName] = $value;
                    $whereCounter++;
                }
            }
            $sql .= " WHERE " . implode(' AND ', $whereClause);
        }

        $stmt = $this->pdo->prepare($sql);

        foreach ($params as $key => $value) {
            $stmt->bindValue(":$key", $value);
        }

        return $stmt->execute();
    }

    /**
     * Executa DELETE com prepared statement
     * @param string $table Nome da tabela
     * @param array $conditions Condições WHERE ['campo = ?' => 'valor'] ou ['campo' => 'valor']
     * @return bool Sucesso da operação
     */
    public function delete($table, $conditions)
    {
        $sql = "DELETE FROM $table";
        $params = [];

        if (!empty($conditions)) {
            $whereClause = [];
            $whereCounter = 0;
            
            foreach ($conditions as $condition => $value) {
                // Se a condição já contém um operador, usar como está
                if (strpos($condition, '=') !== false || strpos($condition, '>') !== false || 
                    strpos($condition, '<') !== false || strpos($condition, 'LIKE') !== false) {
                    
                    // Se já tem parâmetro nomeado (:param), usar como está
                    if (strpos($condition, ':') !== false) {
                        $whereClause[] = $condition;
                        // Extrair nome do parâmetro
                        preg_match('/:(\w+)/', $condition, $matches);
                        if (isset($matches[1])) {
                            $params[$matches[1]] = $value;
                        }
                    } else {
                        // Substituir ? por parâmetro nomeado
                        $paramName = "param_$whereCounter";
                        $whereClause[] = str_replace('?', ":$paramName", $condition);
                        $params[$paramName] = $value;
                        $whereCounter++;
                    }
                } else {
                    // Condição simples: campo => valor
                    $paramName = "param_$whereCounter";
                    $whereClause[] = "$condition = :$paramName";
                    $params[$paramName] = $value;
                    $whereCounter++;
                }
            }
            $sql .= " WHERE " . implode(' AND ', $whereClause);
        }

        $stmt = $this->pdo->prepare($sql);
        return $stmt->execute($params);
    }

    /**
     * Método para queries customizadas (compatibilidade)
     * @param string $sql Query SQL com placeholders
     * @param array $params Parâmetros para bind
     * @return PDOStatement
     */
    public function query($sql, $params = [])
    {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    /**
     * Método para buscar um único registro
     * @param string $table Nome da tabela
     * @param array $conditions Condições WHERE
     * @param string $fields Campos a selecionar
     * @return array|false Registro encontrado ou false
     */
    public function find($table, $conditions, $fields = '*')
    {
        $result = $this->select($table, $conditions, $fields, '', '1');
        return !empty($result) ? $result[0] : false;
    }

    /**
     * Conta registros com prepared statement
     * @param string $table Nome da tabela
     * @param array $conditions Condições WHERE
     * @return int Número de registros
     */
    public function count($table, $conditions = [])
    {
        $result = $this->select($table, $conditions, 'COUNT(*) as total');
        return (int) $result[0]['total'];
    }

    /**
     * Verifica se registro existe
     * @param string $table Nome da tabela
     * @param array $conditions Condições WHERE
     * @return bool Existe ou não
     */
    public function exists($table, $conditions)
    {
        return $this->count($table, $conditions) > 0;
    }

    /**
     * Sanitiza entrada para prevenir XSS
     * @param mixed $data Dados para sanitizar
     * @return mixed Dados sanitizados
     */
    public static function sanitize($data)
    {
        if (is_array($data)) {
            return array_map([self::class, 'sanitize'], $data);
        }

        return htmlspecialchars(trim($data), ENT_QUOTES, 'UTF-8');
    }

    /**
     * Valida email
     * @param string $email Email para validar
     * @return bool Válido ou não
     */
    public static function validateEmail($email)
    {
        return filter_var($email, FILTER_VALIDATE_EMAIL) !== false;
    }

    /**
     * Gera token seguro
     * @param int $length Tamanho do token
     * @return string Token gerado
     */
    public static function generateToken($length = 32)
    {
        return bin2hex(random_bytes($length / 2));
    }
}

/**
 * Função de compatibilidade para substituir pdo->query() vulnerável
 * @param PDO $pdo Conexão PDO
 * @return SecureDB Instância da classe segura
 */
function getSecureDB($pdo)
{
    return new SecureDB($pdo);
}

/**
 * Classe para logging de segurança
 */
class SecurityLogger
{
    public static function logSecurityEvent($event, $details = [])
    {
        $logEntry = [
            'timestamp' => date('Y-m-d H:i:s'),
            'ip' => $_SERVER['REMOTE_ADDR'] ?? 'unknown',
            'user_agent' => $_SERVER['HTTP_USER_AGENT'] ?? 'unknown',
            'event' => $event,
            'details' => $details,
            'user_id' => $_SESSION['id'] ?? 'anonymous'
        ];

        // Log para arquivo de segurança
        $logFile = __DIR__ . '/logs/security.log';
        if (!file_exists(dirname($logFile))) {
            mkdir(dirname($logFile), 0755, true);
        }

        file_put_contents(
            $logFile,
            json_encode($logEntry) . "\n",
            FILE_APPEND | LOCK_EX
        );
    }

    public static function logSQLInjectionAttempt($query, $params = [])
    {
        self::logSecurityEvent('sql_injection_attempt', [
            'query' => $query,
            'params' => $params,
            'severity' => 'CRITICAL'
        ]);
    }
}

/**
 * WAF Simples para bloquear ataques básicos
 */
class SimpleWAF
{
    private static $sqlPatterns = [
        '/union\s+select/i',
        '/drop\s+table/i',
        '/insert\s+into/i',
        '/delete\s+from/i',
        '/update\s+.*set/i',
        '/or\s+1\s*=\s*1/i',
        '/and\s+1\s*=\s*1/i',
        '/\'\s*or\s*\'/i',
        '/\'\s*;\s*drop/i',
        '/\/\*.*\*\//i'
    ];

    private static $xssPatterns = [
        '/<script[\s\S]*?>[\s\S]*?<\/script>/i',
        '/javascript:/i',
        '/on\w+\s*=/i',
        '/<iframe/i',
        '/<object/i',
        '/<embed/i'
    ];

    public static function checkRequest()
    {
        $input = json_encode($_REQUEST);

        // Verificar SQL Injection
        foreach (self::$sqlPatterns as $pattern) {
            if (preg_match($pattern, $input)) {
                SecurityLogger::logSQLInjectionAttempt($input);
                self::blockRequest('SQL Injection attempt detected');
            }
        }

        // Verificar XSS
        foreach (self::$xssPatterns as $pattern) {
            if (preg_match($pattern, $input)) {
                SecurityLogger::logSecurityEvent('xss_attempt', ['input' => $input]);
                self::blockRequest('XSS attempt detected');
            }
        }
    }

    private static function blockRequest($reason)
    {
        http_response_code(403);
        header('Content-Type: application/json');
        echo json_encode([
            'error' => 'Request blocked for security reasons',
            'reason' => $reason,
            'timestamp' => date('Y-m-d H:i:s')
        ]);
        exit;
    }
}

// Ativar WAF em todas as requisições
SimpleWAF::checkRequest();
