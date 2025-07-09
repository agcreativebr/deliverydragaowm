<?php
require_once(__DIR__ . '/../sistema/RedisCache.php');

// Simula indisponibilidade do Redis forçando o fallback
$refClass = new ReflectionClass('RedisCache');
$instanceProp = $refClass->getProperty('instance');
$instanceProp->setAccessible(true);
$instanceProp->setValue(null, null); // Reseta singleton

$redisCache = RedisCache::getInstance();

// Força o uso do fallback
$useRedisProp = $refClass->getProperty('useRedis');
$useRedisProp->setAccessible(true);
$useRedisProp->setValue($redisCache, false);

// Testes básicos
$erros = 0;
echo "\n==== TESTE DE FALLBACK PARA CACHE EM MEMÓRIA ====";
echo "\nSimulando indisponibilidade do Redis...\n";

// Teste SET
$ok = $redisCache->set('teste_fallback', 'valor_memoria', 60);
if ($ok) {
    echo "✓ SET (memória) realizado com sucesso\n";
} else {
    echo "✗ Erro no SET (memória)\n";
    $erros++;
}

// Teste GET
$valor = $redisCache->get('teste_fallback');
if ($valor === 'valor_memoria') {
    echo "✓ GET (memória) funcionando corretamente\n";
} else {
    echo "✗ Erro no GET (memória)\n";
    $erros++;
}

// Teste DELETE
$redisCache->delete('teste_fallback');
if ($redisCache->get('teste_fallback') === null) {
    echo "✓ DELETE (memória) funcionando corretamente\n";
} else {
    echo "✗ Erro no DELETE (memória)\n";
    $erros++;
}

echo "\n==== RESULTADO DO TESTE ====";
if ($erros === 0) {
    echo "\nO fallback para cache em memória está funcionando perfeitamente!\n";
    echo "O sistema está seguro para rodar em ambientes sem Redis (ex: HostGator).\n";
} else {
    echo "\nForam encontrados $erros erro(s) no fallback. Revise a implementação antes de publicar.\n";
}

echo "\nDúvidas? Envie este resultado para o suporte técnico.\n";
