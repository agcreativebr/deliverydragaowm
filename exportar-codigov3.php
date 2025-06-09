<?php
date_default_timezone_set('America/Sao_Paulo');
/**
 * Script para exportar, analisar e documentar projetos de código.
 * Gera um arquivo Markdown detalhado para análise por IAs.
 * VERSÃO 3.0 - ANÁLISE CONTEXTUAL E DE RELAÇÕES
 */

class CodeExporter {
    private $projectPath;
    private $logFile;
    private $allowedExtensions;
    private $excludePaths;

    public function __construct($projectPath = './', $logFile = 'codigo-log.md') {
        $this->projectPath = rtrim(str_replace('\\', '/', realpath($projectPath)), '/') . '/';
        $this->logFile = $logFile;

        $this->allowedExtensions = [
            'php', 'js', 'css', 'html', 'htm', 'sql', 'json', 'xml',
            'htaccess', 'txt', 'md', 'yml', 'yaml', 'ini', 'env', 'example'
        ];

        $this->excludePaths = [
            'vendor/', 'node_modules/', '.git/', 'storage/', 'temp/', 'tmp/', 'backup/',
            'public/build/', '.env', 'composer.lock', 'package-lock.json', basename(__FILE__),
        ];
        $this->excludePaths[] = basename($this->logFile);
    }

    // ===============================================
    // MESTRE DE ORQUESTRAÇÃO
    // ===============================================
    public function exportAll() {
        echo "🔎 Escaneando arquivos do projeto..." . PHP_EOL;
        $files = $this->scanDirectory();
        if (empty($files)) {
            echo "⚠️ Nenhum arquivo encontrado para exportar." . PHP_EOL;
            return;
        }

        echo "🧠 Analisando relações e gerando contexto..." . PHP_EOL;
        // 1. Gera as seções de alto nível
        $header = $this->generateHeader();
        $projectOverview = $this->generateProjectOverview();
        $dependencies = $this->generateDependenciesSection();
        $routesTable = $this->generateRoutesTable();
        $sqlSearchIndex = $this->generateSqlSearchIndex($files);

        // 2. Processa todos os arquivos e armazena seus dados e markdown em memória
        $fileData = [];
        foreach ($files as $filePath) {
            $fileInfo = $this->getFileInfo($filePath);
            $content = file_get_contents($filePath);
            if ($content === false) continue;
            
            $fileData[$filePath] = [
                'info' => $fileInfo,
                'content' => $content,
                'markdown' => $this->formatMarkdown($fileInfo, $content),
            ];
        }

        // 3. Calcula as linhas e gera o índice navegável principal
        echo "📊 Calculando posições e montando o índice principal..." . PHP_EOL;
        $preContent = $header . $projectOverview . $dependencies . $routesTable;
        // O índice SQL é gerado, mas sua posição não afeta o cálculo das linhas de conteúdo, pois ele vem depois do índice principal.
        
        $draftNavIndex = $this->generateNavigableIndex($fileData, 0);
        $contentStartLine = substr_count($preContent, "\n") 
                          + substr_count($draftNavIndex, "\n")
                          + substr_count($sqlSearchIndex, "\n")
                          + 1;
        $navigableIndex = $this->generateNavigableIndex($fileData, $contentStartLine);

        // 4. Monta o conteúdo final
        $allFilesContent = '';
        foreach ($fileData as $data) {
            $allFilesContent .= $data['markdown'];
        }
        $footer = $this->generateFooter($files);

        // 5. Escreve o documento completo de uma só vez
        echo "✍️ Escrevendo o arquivo de documentação final: " . $this->logFile . PHP_EOL;
        $finalDocument = $preContent . $navigableIndex . $sqlSearchIndex . $allFilesContent . $footer;
        file_put_contents($this->logFile, $finalDocument);
    }

    // ===============================================
    // SEÇÕES DE CONTEXTO E ANÁLISE
    // ===============================================

    private function generateProjectOverview() {
        $overview = "\n## 🎯 Objetivo do Projeto\n\n";
        $overview .= "*(ROJETO: Controle de combustível
CONTEXTO: Será para órgão pulico, para manter o controle de combustível.
PROBLEMA: Atualmente temos um problema onde o controle de combustível é feito através de uma planinha e eventualmente ocorre problemas como não sincronizção dos dados, perda de dados, falta de anexos dos comprovantes e afins. Esse sistema seria de forma simples para controle de veiculos, motoristas e combustível principalmente, com dashboard com métricas e relatórios completos dos abastecimentos.)*\n\n";
        $overview .= "## 🏛️ Arquitetura Geral\n\n";
        $overview .= "*(🛠️ STACK TECNOLÓGICA CONFIRMADA
Backend
PHP 8.1+ Puro (sem frameworks)

MySQL 8.0+ como banco de dados

APIs RESTful para comunicação

PDO com prepared statements

Composer para autoload

Frontend
JavaScript Vanilla (zero dependências)

Chart.js para gráficos e dashboards

TailwindCSS para estilização

Interface minimalista e profissional

Temas claro e escuro

Infraestrutura
Nginx como servidor web

Host compartilhado (economia para órgão público)

Git para versionamento

📄 ESTRUTURA DE PÁGINAS DEFINIDAS
1. Autenticação
✅ Login (login.php)

✅ Recuperar senha (recuperar-senha.php)

2. Dashboard
✅ Dashboard principal (index.php)

3. Gestão de Veículos
✅ Lista (veiculos/index.php)

✅ Cadastro (veiculos/criar.php)

✅ Edição (veiculos/editar.php)

✅ Detalhes (veiculos/detalhes.php)

4. Gestão de Motoristas
✅ Lista (motoristas/index.php)

✅ Cadastro (motoristas/criar.php)

✅ Edição (motoristas/editar.php)

✅ Detalhes (motoristas/detalhes.php)

5. Controle de Abastecimentos ⭐ CORE
✅ Lista (abastecimentos/index.php)

✅ Novo (abastecimentos/criar.php)

✅ Edição (abastecimentos/editar.php)

✅ Detalhes (abastecimentos/detalhes.php)

6. Fornecedores/Postos
✅ Lista (postos/index.php)

✅ Cadastro (postos/criar.php)

✅ Edição (postos/editar.php)

7. Relatórios ⭐ CRÍTICO
✅ Central (relatorios/index.php)

✅ Consumo (relatorios/consumo.php)

✅ Custos (relatorios/custos.php)

✅ Eficiência (relatorios/eficiencia.php)

✅ Sintético (relatorios/sintetico.php)

8. Configurações
✅ Geral (configuracoes/geral.php)

✅ Usuários (configuracoes/usuarios.php)

✅ Combustíveis (configuracoes/combustiveis.php)

✅ Departamentos (configuracoes/departamentos.php)

9. Páginas de Apoio
✅ Perfil (perfil.php)

✅ Ajuda (ajuda.php)

✅ Sobre (sobre.php)

10. Páginas de Erro
✅ 404, 403, 500

)*\n\n";
        $overview .= "## ✨ Principais Funcionalidades\n\n";
        $overview .= "*(🔑 FUNCIONALIDADES PRINCIPAIS
Controle de Abastecimentos ⭐
Campo	Tipo	Formato	Validação
Nº Nota Fiscal	String	Livre	Obrigatório, único
Nº da Ordem	String	Livre	Obrigatório, 50 chars
Data Abastecimento	Date	DD/MM/AAAA	Não futuro, max 30 dias
Veículo	Select	Autocomplete	Ativo, existe
Motorista	Select	Autocomplete	CNH válida, autorizado
Posto	Select	Autocomplete	Ativo, conveniado
Combustível	Enum	Dropdown	Gasolina/Etanol/Diesel
Litros	Decimal	999,999	> 0, max tanque
Valor/Litro	Decimal	R$ 9,999	> 0, range válido
Valor Total	Calculated	R$ 99.999,99	Auto: litros × preço
Quilometragem	Integer	999.999	> anterior
Comprovante	File	PDF/PNG/JPG/XML	Obrigatório, max 5MB
Filtros Avançados
✅ Período (data início/fim)

✅ Veículo, Motorista, Posto

✅ Nota Fiscal, Número da Ordem

✅ Tipo de combustível

✅ Status (pendente/aprovado/rejeitado)

Relatórios Completos
✅ Consumo por veículo/período

✅ Custos por departamento

✅ Ranking de eficiência

✅ Relatório executivo

✅ Exportação PDF/Excel/CSV)*\n\n";
        $overview .= "---\n";
        return $overview;
    }
    
    private function generateDependenciesSection() {
        $deps = "\n## 📦 Dependências do Projeto\n\n";
        $found = false;

        // Composer
        $composerPath = $this->projectPath . 'composer.json';
        if (file_exists($composerPath)) {
            $found = true;
            $deps .= "<details>\n<summary>👁️‍🗨️ **Backend (composer.json)**</summary>\n\n";
            $deps .= "```json\n" . file_get_contents($composerPath) . "\n```\n\n";
            $deps .= "</details>\n\n";
        }
        
        // NPM
        $packageJsonPath = $this->projectPath . 'package.json';
        if (file_exists($packageJsonPath)) {
            $found = true;
            $deps .= "<details>\n<summary>👁️‍🗨️ **Frontend (package.json)**</summary>\n\n";
            $deps .= "```json\n" . file_get_contents($packageJsonPath) . "\n```\n\n";
            $deps .= "</details>\n\n";
        }
        
        if (!$found) {
            $deps .= "*Nenhum arquivo `composer.json` ou `package.json` encontrado na raiz do projeto.*\n\n";
        }
        
        return $deps . "---\n";
    }

    private function generateRoutesTable() {
        $routesContent = "\n## 🗺️ Mapa de Rotas (API Endpoints)\n\n";
        $routes = [];
        $routeFilesPath = $this->projectPath . 'routes/';

        if (!is_dir($routeFilesPath)) {
            return $routesContent . "*Diretório `routes/` não encontrado.*\n\n---\n";
        }

        $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($routeFilesPath));
        foreach ($files as $file) {
            if ($file->isDir()) continue;
            $content = file_get_contents($file->getPathname());
            // Regex para capturar rotas (simplificado para o padrão Laravel/Lumen)
            preg_match_all("/Route::(get|post|put|patch|delete|options|any)\s*\(\s*['\"]([^'\"]+)['\"]\s*,\s*\[\s*([^,]+)::class,\s*['\"]([^'\"]+)['\"]\s*\]\s*\);/m", $content, $matches, PREG_SET_ORDER);
            
            foreach ($matches as $match) {
                $controllerParts = explode('\\', $match[3]);
                $routes[] = [
                    'verb' => strtoupper($match[1]),
                    'uri' => $match[2],
                    'action' => end($controllerParts) . '@' . $match[4]
                ];
            }
        }

        if (empty($routes)) {
            return $routesContent . "*Nenhuma rota detectada automaticamente.*\n\n---\n";
        }

        $routesContent .= "| Verbo | URI | Ação (Controlador@Método) |\n";
        $routesContent .= "|---|---|---|\n";
        foreach ($routes as $route) {
            $routesContent .= "| `{$route['verb']}` | `{$route['uri']}` | `{$route['action']}` |\n";
        }

        return $routesContent . "\n---\n";
    }

    // ... (generateNavigableIndex e generateSqlSearchIndex aqui)
    private function generateNavigableIndex($fileData, $contentStartLine) {
        $index = "\n## 📋 Índice Navegável\n\n";
        
        $categories = [
            'sql' => ['icon' => '🗄️', 'title' => 'Banco de Dados (SQL)', 'files' => []],
            'php' => ['icon' => '🐘', 'title' => 'Backend (PHP)', 'files' => []],
            'js' => ['icon' => '⚡', 'title' => 'Frontend (JavaScript)', 'files' => []],
            'css' => ['icon' => '🎨', 'title' => 'Estilos (CSS)', 'files' => []],
            'html' => ['icon' => '📄', 'title' => 'Templates (HTML)', 'files' => []],
            'config' => ['icon' => '⚙️', 'title' => 'Configuração', 'files' => []]
        ];
        
        foreach ($fileData as $filePath => $data) {
            $info = $data['info'];
            $categoryKey = $this->categorizeFile($info['extension'], $info['name']);
            if (isset($categories[$categoryKey])) {
                $categories[$categoryKey]['files'][] = [
                    'name' => $info['name'],
                    'path' => $info['path'],
                    'anchor' => $this->createSafeAnchor($info['name']),
                    'markdown' => $data['markdown']
                ];
            }
        }
        
        $currentLine = $contentStartLine;

        foreach ($categories as $key => $category) {
            if (!empty($category['files'])) {
                $count = count($category['files']);
                $index .= "### {$category['icon']} {$category['title']} ({$count} arquivos)\n\n";
                
                foreach ($category['files'] as $file) {
                    $lineCount = substr_count($file['markdown'], "\n");
                    $endLine = $currentLine + $lineCount -1;
                    $lineInfo = ($contentStartLine > 0) ? " (Linhas: {$currentLine}-{$endLine})" : "";
                    $index .= "- **[{$file['name']}](#{$file['anchor']})** - `{$file['path']}`{$lineInfo}\n";
                    if($contentStartLine > 0) $currentLine = $endLine + 1;
                }
                $index .= "\n";
            }
        }
        
        return $index . "---\n\n";
    }

    private function generateSqlSearchIndex($files) {
        $sqlIndex = "\n## 🗄️ Busca Rápida SQL\n\n";
        $sqlKeywords = [];
        
        foreach ($files as $file) {
            if (pathinfo($file, PATHINFO_EXTENSION) !== 'sql') continue;
            
            $content = file_get_contents($file);
            $fileName = basename($file);
            $anchor = $this->createSafeAnchor($fileName);
            
            $patterns = [
                'CREATE TABLE' => '/CREATE\s+TABLE\s+`?(\w+)`?/i', 'INSERT INTO' => '/INSERT\s+INTO\s+`?(\w+)`?/i',
                'UPDATE' => '/UPDATE\s+`?(\w+)`?/i', 'SELECT FROM' => '/SELECT.*?FROM\s+`?(\w+)`?/i',
                'ALTER TABLE' => '/ALTER\s+TABLE\s+`?(\w+)`?/i', 'DROP TABLE' => '/DROP\s+TABLE\s+`?(\w+)`?/i',
                'FOREIGN KEY' => '/REFERENCES\s+`?(\w+)`?/i'
            ];
            
            foreach ($patterns as $operation => $pattern) {
                if (preg_match_all($pattern, $content, $matches)) {
                    foreach ($matches[1] as $table) {
                        $key = strtolower($table);
                        if (!isset($sqlKeywords[$key])) $sqlKeywords[$key] = [];
                        $sqlKeywords[$key][] = ['file' => $fileName, 'anchor' => $anchor, 'operation' => $operation];
                    }
                }
            }
        }
        
        if (!empty($sqlKeywords)) {
            ksort($sqlKeywords);
            $sqlIndex .= "### 📊 Por Tabela\n\n";
            foreach ($sqlKeywords as $table => $operations) {
                $sqlIndex .= "**Tabela `{$table}`:**\n";
                $uniqueFiles = [];
                foreach ($operations as $op) {
                    $key = $op['file'] . '|' . $op['operation'];
                    if (!isset($uniqueFiles[$key])) $uniqueFiles[$key] = $op;
                }
                foreach ($uniqueFiles as $op) {
                    $sqlIndex .= "- {$op['operation']}: [{$op['file']}](#{$op['anchor']})\n";
                }
                $sqlIndex .= "\n";
            }
        } else {
            $sqlIndex .= "*Nenhum arquivo SQL encontrado.*\n\n";
        }
        
        return $sqlIndex . "---\n\n";
    }
    // ===============================================
    // FORMATADOR E ANALISADOR DE ARQUIVOS
    // ===============================================

    private function formatMarkdown($fileInfo, $content) {
        $lang = $this->detectLanguage($fileInfo['extension']);
        
        $output = "\n\n### {$fileInfo['name']}\n\n";
        $output .= "<a id=\"" . $this->createSafeAnchor($fileInfo['name']) . "\"></a>\n";

        $output .= "| Propriedade | Valor |\n";
        $output .= "|---|---|\n";
        $output .= "| **Caminho** | `{$fileInfo['path']}` |\n";
        $output .= "| **Modificado** | {$fileInfo['date']} |\n";
        $output .= "| **Tamanho** | {$fileInfo['size']} |\n";
        
        $summary = $this->generateSmartSummary($content, $fileInfo['extension']);
        if ($summary) {
            $output .= "**Resumo da Análise** | {$summary}\n";
        }
        $output .= "\n";

        if ($fileInfo['lines'] > 1) { // Só mostra o bloco de código se houver conteúdo
            $output .= "<details>\n<summary>👁️ Ver código completo ({$fileInfo['lines']} linhas)</summary>\n\n";
            $output .= "```{$lang}\n" . rtrim($content) . "\n```\n\n";
            $output .= "</details>\n\n";
        }
        
        $output .= "[⬆️ Voltar ao Índice](#-índice-navegável) | [🗺️ Voltar às Rotas](#️-mapa-de-rotas-api-endpoints)\n\n";
        $output .= "---\n";
        
        return $output;
    }

    private function generateSmartSummary($content, $extension) {
        switch ($extension) {
            case 'sql': return $this->analyzeSqlFile($content);
            case 'php': return $this->analyzePhpFile($content);
            case 'js': return $this->analyzeJsFile($content);
            default: return null;
        }
    }

    private function analyzePhpFile($content) {
        $analysis = [];
        
        // Classe, Herança, Interfaces
        if (preg_match('/class\s+(\w+)\s*(?:extends\s+([^\s]+))?\s*(?:implements\s+([^{\s]+))?/', $content, $matches)) {
            $classInfo = "Classe: **{$matches[1]}**";
            if (!empty($matches[2])) $classInfo .= " | Herda de: `{$matches[2]}`";
            if (!empty($matches[3])) $classInfo .= " | Implementa: `{$matches[3]}`";
            $analysis[] = $classInfo;
        }

        // Mapeamento de Tabela (Model)
        if (preg_match('/protected\s+\$table\s*=\s*[\'"]([^\'"]+)[\'"];/', $content, $matches)) {
            $analysis[] = "Mapeia Tabela: `{$matches[1]}`";
        }

        // Dependências (use)
        if (preg_match_all('/^use\s+([^;]+);/m', $content, $matches)) {
            $deps = array_map(function($dep) {
                $parts = explode('\\', $dep);
                return end($parts);
            }, $matches[1]);
            $analysis[] = "Dependências: `" . implode('`, `', array_slice($deps, 0, 3)) . (count($deps) > 3 ? '...`' : '`');
        }
        
        return implode(' | ', $analysis);
    }
    
    private function analyzeJsFile($content) {
        $analysis = [];
        // Detecta chamadas a API (padrão fetch e axios)
        preg_match_all('/(?:fetch|axios\.(?:get|post|put|delete))\s*\(\s*[\'"`]([^\'"`]+)[\'"`]/', $content, $matches);
        if(!empty($matches[1])) {
            $endpoints = array_unique($matches[1]);
            $analysis[] = "Chamadas de API: `" . implode('`, `', $endpoints) . '`';
        }
        return implode(' | ', $analysis);
    }

    private function analyzeSqlFile($content) {
        $analysis = [];
        $operations = [
            'CREATE TABLE' => '/CREATE\s+TABLE/i', 'INSERT' => '/INSERT\s+INTO/i',
            'UPDATE' => '/UPDATE\s+\w+\s+SET/i', 'SELECT' => '/SELECT\s+.*\s+FROM/i',
        ];
        foreach ($operations as $op => $pattern) {
            $count = preg_match_all($pattern, $content);
            if ($count > 0) $analysis[] = "{$op}: {$count}";
        }
        return implode(' | ', $analysis);
    }

    // ===============================================
    // FUNÇÕES AUXILIARES (A MAIORIA SEM ALTERAÇÃO)
    // ===============================================

    private function getFileInfo($filePath) {
        $content = file_get_contents($filePath);
        return [
            'name' => basename($filePath),
            'path' => str_replace($this->projectPath, './', $filePath),
            'extension' => strtolower(pathinfo($filePath, PATHINFO_EXTENSION)),
            'size' => $this->formatFileSize(filesize($filePath)),
            'date' => date('d/m/Y H:i:s', filemtime($filePath)),
            'lines' => substr_count($content, "\n") + 1
        ];
    }
    
    // As funções abaixo não precisam de grandes alterações.
    private function categorizeFile($extension, $fileName) { if ($extension === 'sql') return 'sql'; if ($extension === 'php') return 'php'; if ($extension === 'js') return 'js'; if ($extension === 'css') return 'css'; if (in_array($extension, ['html', 'htm'])) return 'html'; if (in_array($extension, ['json', 'ini', 'env', 'example']) || in_array($fileName, ['.htaccess', 'composer.json', 'package.json'])) return 'config'; return 'config'; }
    private function createSafeAnchor($fileName) { $anchor = strtolower($fileName); $anchor = preg_replace('/[^a-z0-9\-_]/', '-', $anchor); return trim(preg_replace('/-+/', '-', $anchor), '-'); }
    private function generateHeader() { $header = "# 📁 Documentação Completa do Projeto\n\n"; $header .= "**Gerado em:** " . date('d/m/Y H:i:s') . "\n"; $header .= "**Projeto:** " . basename(rtrim($this->projectPath, '/')) . "\n\n"; $header .= "> Este documento foi gerado automaticamente para fornecer um contexto completo do projeto para análise e desenvolvimento assistido por IA. Use os índices e seções de contexto para navegar.\n\n"; $header .= "---\n"; return $header; }
    private function generateFooter($exportedFiles) { $totalSize = 0; foreach ($exportedFiles as $file) { $totalSize += filesize($file); } $footer = "\n\n---\n\n## 📊 Estatísticas\n\n"; $footer .= "- **Total de arquivos analisados:** " . count($exportedFiles) . "\n"; $footer .= "- **Tamanho total:** " . $this->formatFileSize($totalSize) . "\n"; return $footer; }
    private function formatFileSize($bytes) { if ($bytes >= 1048576) return number_format($bytes / 1048576, 1) . ' MB'; if ($bytes >= 1024) return number_format($bytes / 1024, 1) . ' KB'; return $bytes . ' bytes'; }
    private function detectLanguage($extension) { $map = ['php' => 'php', 'js' => 'javascript', 'css' => 'css', 'html' => 'html', 'sql' => 'sql', 'json' => 'json', 'xml' => 'xml', 'md' => 'markdown', 'yml' => 'yaml', 'ini' => 'ini', 'htaccess' => 'apache', 'env' => 'bash']; return $map[$extension] ?? 'text'; }
    private function scanDirectory() { $files = []; $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($this->projectPath, RecursiveDirectoryIterator::SKIP_DOTS), RecursiveIteratorIterator::SELF_FIRST); foreach ($iterator as $file) { $path = str_replace('\\', '/', $file->getPathname()); if ($file->isDir()) { if ($this->isPathExcluded($path . '/')) { $iterator->setFlags(RecursiveDirectoryIterator::SKIP_DOTS); } else { $iterator->setFlags(0); } continue; } if (!$this->isPathExcluded($path) && in_array(strtolower(pathinfo($path, PATHINFO_EXTENSION)), $this->allowedExtensions)) { $files[] = $path; } } sort($files); return $files; }
    private function isPathExcluded($filePath) { $relativePath = str_replace($this->projectPath, '', $filePath); foreach ($this->excludePaths as $pattern) { if (str_ends_with($pattern, '/')) { if (str_starts_with($relativePath, $pattern)) return true; } else { if ($relativePath === $pattern) return true; } } return false; }
}

// =====================================
// BLOCO DE EXECUÇÃO PRINCIPAL
// =====================================
$options = getopt('p:f:h', ['path:', 'file:', 'help']);

if (isset($options['h']) || isset($options['help'])) {
    echo "📖 Gerador de Documentação de Código para IA - v3.0\n\n";
    echo "Uso: php " . basename(__FILE__) . " -p <caminho_do_projeto> -f <arquivo_de_saida.md>\n";
    exit(0);
}

$projectPath = isset($options['p']) ? $options['p'] : './';
$logFile = isset($options['f']) ? $options['f'] : 'documentacao_projeto.md';

try {
    $exporter = new CodeExporter($projectPath, $logFile);
    echo "🚀 Iniciando análise completa do projeto em: " . realpath($projectPath) . PHP_EOL;
    $exporter->exportAll();
    echo PHP_EOL . "🎉 Documentação contextualizada gerada com sucesso!" . PHP_EOL;
    echo " Arquivo: " . $logFile . PHP_EOL;

} catch (Exception $e) {
    echo "❌ Erro inesperado: " . $e->getMessage() . PHP_EOL;
    exit(1);
}