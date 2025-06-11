<?php
require_once ('../../sistema/conexao.php');
$tel = @$_POST['tel'];

// Inicializa todas as variáveis que serão retornadas
$nome = "";
$id_cliente = "";
$rua = "";
$numero = "";
$bairro = "";
$complemento = "";
$cep = "";
$cidade = "";
$taxa_entrega = "0"; // Valor padrão se não houver taxa específica
$taxa_entregaF = "0,00"; // Valor formatado padrão

if (!empty($tel)) {
    // Remove caracteres não numéricos do telefone para a busca
    $tel_limpo = preg_replace('/[^0-9]/', '', $tel);

    $query = $pdo->prepare("SELECT * FROM clientes where telefone = :telefone");
    $query->bindValue(":telefone", $tel_limpo); // Busca pelo telefone limpo
    $query->execute();
    $res_cliente = $query->fetchAll(PDO::FETCH_ASSOC);

    if (@count($res_cliente) > 0) {
        $nome = $res_cliente[0]['nome'];
        $id_cliente = $res_cliente[0]['id'];
        $rua = $res_cliente[0]['endereco'];
        $numero = $res_cliente[0]['numero'];
        $bairro = $res_cliente[0]['bairro'];
        $complemento = $res_cliente[0]['complemento'];
        $cep = $res_cliente[0]['cep'];
        $cidade = $res_cliente[0]['cidade'];

        // Se o bairro foi encontrado para o cliente, busca a taxa de entrega
        // Apenas se não estiver usando a API de distância do Google Maps
        if (!empty($bairro) && ($entrega_distancia != "Sim" || empty($chave_api_maps))) {
            $query_bairro = $pdo->prepare("SELECT valor FROM bairros where nome = :bairro");
            $query_bairro->bindValue(":bairro", $bairro);
            $query_bairro->execute();
            $res_bairro_taxa = $query_bairro->fetch(PDO::FETCH_ASSOC);

            if ($res_bairro_taxa && isset($res_bairro_taxa['valor'])) {
                $taxa_entrega = $res_bairro_taxa['valor'];
                $taxa_entregaF = number_format($taxa_entrega, 2, ',', '.');
            } else {
                // Se o bairro do cliente não tem taxa definida, reseta para 0
                $taxa_entrega = "0";
                $taxa_entregaF = "0,00";
            }
        } else if ($entrega_distancia == "Sim" && !empty($chave_api_maps)) {
            // Se usa API de distância, a taxa de entrega será calculada no frontend
            // e não deve ser retornada aqui, ou deve ser retornada como vazia/zero
            // para não sobrescrever o cálculo do frontend.
            $taxa_entrega = ""; // Ou 0, dependendo de como o frontend trata
            $taxa_entregaF = ""; // Ou 0,00
        }
    }
}

// Retorna os dados formatados para o AJAX
echo $nome . '**' . $rua . '**' . $numero . '**' . $bairro . '**' . $complemento . '**' . $taxa_entrega . '**' . $taxa_entregaF . '**' . $id_cliente . '**' . $cep . '**' . $cidade;

?>
