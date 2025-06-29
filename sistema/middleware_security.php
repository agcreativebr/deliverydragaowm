<?php

/**
 * Middleware de Segurança
 * 
 * Este arquivo deve ser incluído em todas as páginas do painel administrativo
 * para garantir que apenas usuários autenticados e autorizados tenham acesso.
 * 
 * Funcionalidades:
 * - Validação de sessão
 * - Verificação de tokens
 * - Controle de permissões
 * - Logging de acessos
 * - Proteção contra CSRF
 */

// Iniciar sessão se não estiver iniciada
if (session_status() === PHP_SESSION_NONE) {
    @session_set_cookie_params([
        'httponly' => true,
        'secure' => true,
        'samesite' => 'Strict',
        'lifetime' => 3600
    ]);
    @session_start();
}

require_once(__DIR__ . '/SecureDB.php');

class SecurityMiddleware
{
    private static $publicPages = [
        'index.php',
        'autenticar.php',
        'logout.php'
    ];

    private static $adminOnlyPages = [
        'usuarios',
        'config',
        'backup',
        'logs'
    ];

    /**
     * Verificar se usuário está autenticado
     */
    public static function checkAuthentication()
    {
        // Verificar se é página pública
        $currentPage = basename($_SERVER['PHP_SELF']);
        if (in_array($currentPage, self::$publicPages)) {
            return true;
        }

        // Verificar se sessão existe
        if (!isset($_SESSION['auth_token']) || !isset($_SESSION['user_id'])) {
            self::redirectToLogin('Sessão não encontrada');
            return false;
        }

        // Verificar se sessão não expirou
        if (isset($_SESSION['session_expires']) && time() > $_SESSION['session_expires']) {
            self::destroySession();
            self::redirectToLogin('Sessão expirada');
            return false;
        }

        // Verificar consistência da sessão
        if (!self::validateSessionIntegrity()) {
            self::destroySession();
            self::redirectToLogin('Sessão inválida');
            return false;
        }

        // Renovar sessão se próxima do vencimento
        if (
            isset($_SESSION['session_expires']) &&
            $_SESSION['session_expires'] - time() < 300
        ) { // 5 minutos
            $_SESSION['session_expires'] = time() + 3600;
            session_regenerate_id(true);
        }

        return true;
    }

    /**
     * Verificar permissões de acesso
     */
    public static function checkPermissions($requiredLevel = null)
    {
        if (!self::checkAuthentication()) {
            return false;
        }

        $userLevel = $_SESSION['user_level'] ?? '';
        $currentPage = self::getCurrentPage();

        // Verificar se é página restrita a admin
        if (in_array($currentPage, self::$adminOnlyPages) && $userLevel !== 'Administrador') {
            SecurityLogger::logSecurityEvent('unauthorized_access_attempt', [
                'user_id' => $_SESSION['user_id'],
                'user_level' => $userLevel,
                'attempted_page' => $currentPage,
                'required_level' => 'Administrador'
            ]);

            self::accessDenied('Acesso negado. Permissão insuficiente.');
            return false;
        }

        // Verificar nível específico se fornecido
        if ($requiredLevel && !self::hasPermission($requiredLevel)) {
            SecurityLogger::logSecurityEvent('insufficient_permissions', [
                'user_id' => $_SESSION['user_id'],
                'user_level' => $userLevel,
                'required_level' => $requiredLevel,
                'page' => $currentPage
            ]);

            self::accessDenied("Acesso negado. Nível '$requiredLevel' requerido.");
            return false;
        }

        return true;
    }

    /**
     * Verificar integridade da sessão
     */
    private static function validateSessionIntegrity()
    {
        // Verificar mudança de IP (opcional)
        if (
            isset($_SESSION['session_ip']) &&
            $_SESSION['session_ip'] !== $_SERVER['REMOTE_ADDR']
        ) {
            SecurityLogger::logSecurityEvent('session_ip_change', [
                'user_id' => $_SESSION['user_id'],
                'original_ip' => $_SESSION['session_ip'],
                'new_ip' => $_SERVER['REMOTE_ADDR']
            ]);
            // Não bloquear automaticamente - apenas logar
        }

        // Verificar mudança de User-Agent
        if (
            isset($_SESSION['session_user_agent']) &&
            $_SESSION['session_user_agent'] !== $_SERVER['HTTP_USER_AGENT']
        ) {
            SecurityLogger::logSecurityEvent('session_user_agent_change', [
                'user_id' => $_SESSION['user_id'],
                'original_ua' => $_SESSION['session_user_agent'],
                'new_ua' => $_SERVER['HTTP_USER_AGENT']
            ]);
            // Não bloquear automaticamente - apenas logar
        }

        return true;
    }

    /**
     * Verificar se usuário tem permissão específica
     */
    private static function hasPermission($requiredLevel)
    {
        $userLevel = $_SESSION['user_level'] ?? '';

        $hierarchy = [
            'Funcionario' => 1,
            'Gerente' => 2,
            'Administrador' => 3
        ];

        $userRank = $hierarchy[$userLevel] ?? 0;
        $requiredRank = $hierarchy[$requiredLevel] ?? 99;

        return $userRank >= $requiredRank;
    }

    /**
     * Obter página atual
     */
    private static function getCurrentPage()
    {
        $uri = $_SERVER['REQUEST_URI'];
        $path = parse_url($uri, PHP_URL_PATH);
        $segments = explode('/', trim($path, '/'));

        // Retornar último segmento ou 'dashboard' se vazio
        return end($segments) ?: 'dashboard';
    }

    /**
     * Redirecionar para login
     */
    private static function redirectToLogin($message = '')
    {
        if ($message) {
            $_SESSION['security_message'] = $message;
        }

        // Verificar se é requisição AJAX
        if (
            !empty($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest'
        ) {

            http_response_code(401);
            header('Content-Type: application/json');
            echo json_encode([
                'error' => 'Unauthorized',
                'message' => $message,
                'redirect' => '../index.php'
            ]);
            exit();
        }

        // Redirecionar para login
        $loginUrl = self::getLoginUrl();
        header("Location: $loginUrl");
        exit();
    }

    /**
     * Mostrar página de acesso negado
     */
    private static function accessDenied($message)
    {
        // Verificar se é requisição AJAX
        if (
            !empty($_SERVER['HTTP_X_REQUESTED_WITH']) &&
            strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) == 'xmlhttprequest'
        ) {

            http_response_code(403);
            header('Content-Type: application/json');
            echo json_encode([
                'error' => 'Forbidden',
                'message' => $message
            ]);
            exit();
        }

        // Mostrar página de erro
        http_response_code(403);
        echo "<!DOCTYPE html>
        <html>
        <head>
            <title>Acesso Negado</title>
            <style>
                body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
                .error { color: #d32f2f; }
                .btn { background: #1976d2; color: white; padding: 10px 20px; text-decoration: none; border-radius: 4px; }
            </style>
        </head>
        <body>
            <h1 class='error'>Acesso Negado</h1>
            <p>$message</p>
            <a href='javascript:history.back()' class='btn'>Voltar</a>
        </body>
        </html>";
        exit();
    }

    /**
     * Destruir sessão
     */
    private static function destroySession()
    {
        SecurityLogger::logSecurityEvent('session_destroyed', [
            'user_id' => $_SESSION['user_id'] ?? 'unknown',
            'reason' => 'security_middleware'
        ]);

        session_unset();
        session_destroy();
    }

    /**
     * Obter URL de login baseada na localização atual
     */
    private static function getLoginUrl()
    {
        $currentDir = dirname($_SERVER['PHP_SELF']);

        // Se estiver em subdiretório do painel, voltar para raiz
        if (strpos($currentDir, '/painel') !== false) {
            return '../index.php';
        }

        return 'index.php';
    }

    /**
     * Gerar token CSRF
     */
    public static function generateCSRFToken()
    {
        if (!isset($_SESSION['csrf_token'])) {
            $_SESSION['csrf_token'] = bin2hex(random_bytes(32));
        }
        return $_SESSION['csrf_token'];
    }

    /**
     * Verificar token CSRF
     */
    public static function validateCSRFToken($token)
    {
        if (!isset($_SESSION['csrf_token'])) {
            return false;
        }

        return hash_equals($_SESSION['csrf_token'], $token);
    }

    /**
     * Middleware principal - chamar em todas as páginas protegidas
     */
    public static function protect($requiredLevel = null)
    {
        // Verificar autenticação
        if (!self::checkAuthentication()) {
            return false;
        }

        // Verificar permissões
        if (!self::checkPermissions($requiredLevel)) {
            return false;
        }

        // Log de acesso autorizado
        SecurityLogger::logSecurityEvent('authorized_access', [
            'user_id' => $_SESSION['user_id'],
            'page' => self::getCurrentPage(),
            'user_level' => $_SESSION['user_level']
        ]);

        return true;
    }

    /**
     * Verificar se é admin
     */
    public static function isAdmin()
    {
        return isset($_SESSION['user_level']) && $_SESSION['user_level'] === 'Administrador';
    }

    /**
     * Obter informações do usuário atual
     */
    public static function getCurrentUser()
    {
        if (!self::checkAuthentication()) {
            return null;
        }

        return [
            'id' => $_SESSION['user_id'],
            'name' => $_SESSION['user_name'],
            'level' => $_SESSION['user_level']
        ];
    }
}

// Auto-proteção: executar middleware automaticamente se não for página pública
$currentPage = basename($_SERVER['PHP_SELF']);
if (!in_array($currentPage, ['index.php', 'autenticar.php', 'logout.php'])) {
    SecurityMiddleware::protect();
}

/**
 * Função helper para verificar se usuário está logado
 */
function isLoggedIn()
{
    return SecurityMiddleware::checkAuthentication();
}

/**
 * Função helper para verificar se é admin
 */
function isAdmin()
{
    return SecurityMiddleware::isAdmin();
}

/**
 * Função helper para obter usuário atual
 */
function getCurrentUser()
{
    return SecurityMiddleware::getCurrentUser();
}

/**
 * Função helper para gerar token CSRF
 */
function csrf_token()
{
    return SecurityMiddleware::generateCSRFToken();
}

/**
 * Função helper para campo CSRF hidden
 */
function csrf_field()
{
    $token = csrf_token();
    return "<input type='hidden' name='csrf_token' value='$token'>";
}
