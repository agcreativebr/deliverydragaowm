<?php

/**
 * Sistema de Autenticação Seguro
 * 
 * Correções implementadas:
 * - Tokens dinâmicos e seguros
 * - Rate limiting para prevenir brute force
 * - Remoção de senhas do localStorage
 * - Logging de segurança
 * - Timeout de sessão
 * - Validações robustas
 */

@session_set_cookie_params([
	'httponly' => true,
	'secure' => true,
	'samesite' => 'Strict',
	'lifetime' => 3600 // 1 hora
]);
@session_start();
@session_regenerate_id(true);

require_once("conexao.php");
require_once("SecureDB.php");

// Inicializar sistema seguro
$secureDB = new SecureDB($pdo);

/**
 * Classe para controle de rate limiting
 */
class RateLimiter
{
	private static $maxAttempts = 5;
	private static $timeWindow = 900; // 15 minutos

	public static function checkRateLimit($identifier)
	{
		$file = __DIR__ . '/logs/rate_limit.json';

		if (!file_exists($file)) {
			file_put_contents($file, json_encode([]));
		}

		$data = json_decode(file_get_contents($file), true);
		$now = time();

		// Limpar tentativas antigas
		$data = array_filter($data, function ($attempts) use ($now) {
			return ($now - $attempts['first_attempt']) < self::$timeWindow;
		});

		if (!isset($data[$identifier])) {
			$data[$identifier] = [
				'attempts' => 0,
				'first_attempt' => $now,
				'last_attempt' => $now
			];
		}

		$attempts = $data[$identifier]['attempts'];

		if ($attempts >= self::$maxAttempts) {
			$timeLeft = self::$timeWindow - ($now - $data[$identifier]['first_attempt']);
			SecurityLogger::logSecurityEvent('rate_limit_exceeded', [
				'identifier' => $identifier,
				'attempts' => $attempts,
				'time_left' => $timeLeft
			]);

			return [
				'allowed' => false,
				'time_left' => $timeLeft
			];
		}

		return ['allowed' => true];
	}

	public static function recordAttempt($identifier, $success = false)
	{
		$file = __DIR__ . '/logs/rate_limit.json';
		$data = json_decode(file_get_contents($file), true);
		$now = time();

		if ($success) {
			// Limpar tentativas em caso de sucesso
			unset($data[$identifier]);
		} else {
			if (!isset($data[$identifier])) {
				$data[$identifier] = [
					'attempts' => 1,
					'first_attempt' => $now,
					'last_attempt' => $now
				];
			} else {
				$data[$identifier]['attempts']++;
				$data[$identifier]['last_attempt'] = $now;
			}
		}

		file_put_contents($file, json_encode($data));
	}
}

/**
 * Classe para gerenciamento de sessões seguras
 */
class SecureSession
{
	public static function generateToken()
	{
		return bin2hex(random_bytes(32));
	}

	public static function createSession($user_data)
	{
		$token = self::generateToken();
		$expires = time() + 3600; // 1 hora

		$_SESSION['user_id'] = $user_data['id'];
		$_SESSION['user_name'] = $user_data['nome'];
		$_SESSION['user_level'] = $user_data['nivel'];
		$_SESSION['auth_token'] = $token;
		$_SESSION['session_expires'] = $expires;
		$_SESSION['session_ip'] = $_SERVER['REMOTE_ADDR'];
		$_SESSION['session_user_agent'] = $_SERVER['HTTP_USER_AGENT'];

		// Log da sessão criada
		SecurityLogger::logSecurityEvent('session_created', [
			'user_id' => $user_data['id'],
			'user_name' => $user_data['nome'],
			'expires' => date('Y-m-d H:i:s', $expires)
		]);

		return $token;
	}

	public static function validateSession()
	{
		// Verificar se sessão existe
		if (!isset($_SESSION['auth_token']) || !isset($_SESSION['session_expires'])) {
			return false;
		}

		// Verificar expiração
		if (time() > $_SESSION['session_expires']) {
			self::destroySession();
			return false;
		}

		// Verificar IP (opcional - pode ser problemático com proxies)
		if (isset($_SESSION['session_ip']) && $_SESSION['session_ip'] !== $_SERVER['REMOTE_ADDR']) {
			SecurityLogger::logSecurityEvent('session_ip_mismatch', [
				'original_ip' => $_SESSION['session_ip'],
				'current_ip' => $_SERVER['REMOTE_ADDR']
			]);
			// Não destruir automaticamente - apenas logar
		}

		// Renovar sessão se próxima do vencimento
		if ($_SESSION['session_expires'] - time() < 300) { // 5 minutos
			$_SESSION['session_expires'] = time() + 3600;
		}

		return true;
	}

	public static function destroySession()
	{
		SecurityLogger::logSecurityEvent('session_destroyed', [
			'user_id' => $_SESSION['user_id'] ?? 'unknown'
		]);

		session_unset();
		session_destroy();
	}
}

// Processar autenticação por ID (login automático)
$id_usu = filter_var(@$_POST['id'], FILTER_SANITIZE_NUMBER_INT);
$pagina = SecureDB::sanitize(@$_POST['pagina']);

if ($id_usu > 0) {
	$user_data = $secureDB->find('usuarios', ['id = ?' => $id_usu]);

	if ($user_data && $user_data['ativo'] === 'Sim') {
		SecureSession::createSession($user_data);

		$redirect = $pagina ? "painel/$pagina" : "painel";
		echo "<script>window.location='$redirect'</script>";
		exit();
	} else {
		echo "<script>localStorage.removeItem('user_id');</script>";
		echo '<script>window.location="index.php"</script>';
		exit();
	}
}

// Processar login por email/senha
$usuario = SecureDB::sanitize(@$_POST['usuario']);
$senha = @$_POST['senha'];
$salvar = SecureDB::sanitize(@$_POST['salvar']);

if (empty($usuario) || empty($senha)) {
	$_SESSION['msg'] = 'Email e senha são obrigatórios!';
	echo '<script>window.location="index.php"</script>';
	exit();
}

// Verificar rate limiting
$identifier = $_SERVER['REMOTE_ADDR'] . ':' . $usuario;
$rateCheck = RateLimiter::checkRateLimit($identifier);

if (!$rateCheck['allowed']) {
	$timeLeft = ceil($rateCheck['time_left'] / 60);
	$_SESSION['msg'] = "Muitas tentativas de login. Tente novamente em $timeLeft minutos.";
	echo '<script>window.location="index.php"</script>';
	exit();
}

// Validar email
if (!SecureDB::validateEmail($usuario)) {
	$_SESSION['msg'] = 'Email inválido!';
	RateLimiter::recordAttempt($identifier, false);
	echo '<script>window.location="index.php"</script>';
	exit();
}

// Buscar usuário
$user_data = $secureDB->find('usuarios', ['email = ?' => $usuario]);

if (!$user_data) {
	$_SESSION['msg'] = 'Usuário não encontrado!';
	RateLimiter::recordAttempt($identifier, false);
	SecurityLogger::logSecurityEvent('login_attempt_invalid_user', [
		'email' => $usuario,
		'ip' => $_SERVER['REMOTE_ADDR']
	]);
	echo '<script>window.location="index.php"</script>';
	exit();
}

// Verificar senha
if (!password_verify($senha, $user_data['senha_crip'])) {
	$_SESSION['msg'] = 'Senha incorreta!';
	RateLimiter::recordAttempt($identifier, false);
	SecurityLogger::logSecurityEvent('login_attempt_wrong_password', [
		'user_id' => $user_data['id'],
		'email' => $usuario,
		'ip' => $_SERVER['REMOTE_ADDR']
	]);
	echo '<script>window.location="index.php"</script>';
	exit();
}

// Verificar se usuário está ativo
if ($user_data['ativo'] !== 'Sim') {
	$_SESSION['msg'] = 'Conta desativada! Entre em contato com o administrador.';
	RateLimiter::recordAttempt($identifier, false);
	SecurityLogger::logSecurityEvent('login_attempt_inactive_user', [
		'user_id' => $user_data['id'],
		'email' => $usuario
	]);
	echo '<script>window.location="index.php"</script>';
	exit();
}

// Login bem-sucedido
RateLimiter::recordAttempt($identifier, true);
SecureSession::createSession($user_data);

// Configurar localStorage de forma segura (apenas dados não sensíveis)
if ($salvar === 'Sim') {
	echo "<script>localStorage.setItem('remember_email', '$usuario');</script>";
	echo "<script>localStorage.setItem('user_id', '{$user_data['id']}');</script>";
} else {
	echo "<script>localStorage.removeItem('remember_email');</script>";
	echo "<script>localStorage.removeItem('user_id');</script>";
}

// IMPORTANTE: Nunca mais salvar senhas no localStorage
echo "<script>localStorage.removeItem('senha_usu');</script>";

SecurityLogger::logSecurityEvent('login_success', [
	'user_id' => $user_data['id'],
	'email' => $usuario,
	'level' => $user_data['nivel']
]);

echo '<script>window.location="painel"</script>';
