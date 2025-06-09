<?php
date_default_timezone_set('America/Sao_Paulo');
/**
 * Script para exportar arquivos, verificar e gerar árvore de projeto.
 * Sistema de Controle de Combustível
 * Data: 08/06/2025 - VERSÃO FINAL COMPLETA
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
    // MODO 1: EXPORTAR PARA MARKDOWN
    // ===============================================

    public function exportAll() {
        $this->writeHeader();
        $files = $this->scanDirectory();
        
        if(empty($files)) {
            echo "⚠️ Nenhum arquivo encontrado para exportar. Verifique suas configurações de extensão e exclusão." . PHP_EOL;
            return;
        }

        foreach ($files as $file) {
            $this->exportFile($file);
        }

        $this->writeFooter($files);
    }

    public function exportFile($filePath) {
        $fileInfo = $this->getFileInfo($filePath);
        $content = file_get_contents($filePath);
        if ($content === false) {
            echo "⚠️ Erro ao ler arquivo: " . $filePath . PHP_EOL;
            return;
        }

        $markdown = $this->formatMarkdown($fileInfo, $content);
        file_put_contents($this->logFile, $markdown, FILE_APPEND | LOCK_EX);
        echo "📄 Exportado: " . $fileInfo['path'] . PHP_EOL;
    }
    
    // ===============================================
    // MODO 2: GERAR ÁRVORE DE ARQUIVOS
    // ===============================================

    public function generateFileTree($outputFile) {
        echo "🌳 Gerando árvore de arquivos..." . PHP_EOL;
        $this->excludePaths[] = basename($outputFile);

        $treeString = "Árvore do Projeto: " . basename(rtrim($this->projectPath, '/')) . PHP_EOL;
        $treeString .= "Gerado em: " . date('d/m/Y H:i:s') . PHP_EOL;
        $treeString .= "------------------------------------------------" . PHP_EOL . PHP_EOL;

        $this->buildTreeRecursively($this->projectPath, $treeString);

        if (file_put_contents($outputFile, $treeString)) {
            echo "✅ Árvore de arquivos salva com sucesso em: " . $outputFile . PHP_EOL;
        } else {
            echo "❌ Erro ao salvar o arquivo da árvore." . PHP_EOL;
        }
    }

    private function buildTreeRecursively($dir, &$treeString, $prefix = '') {
        $items = array_diff(scandir($dir), ['.', '..']);
        $items = array_values($items);

        foreach ($items as $i => $item) {
            $isLast = ($i === count($items) - 1);
            $fullPath = $dir . $item;
            $connector = $isLast ? '└── ' : '├── ';
            $treeString .= $prefix . $connector . $item;

            if (is_dir($fullPath)) {
                $rule = $this->getExclusionRule($fullPath . '/');
                if ($rule) {
                    $treeString .= " [DIRETÓRIO EXCLUÍDO - Regra: $rule]" . PHP_EOL;
                } else {
                    $treeString .= PHP_EOL;
                    $newPrefix = $prefix . ($isLast ? '    ' : '│   ');
                    $this->buildTreeRecursively($fullPath . '/', $treeString, $newPrefix);
                }
            } else {
                $status = $this->getFileStatus($fullPath);
                $treeString .= " " . $status . PHP_EOL;
            }
        }
    }

    // ===============================================
    // MODO 3: VERIFICAR NO CONSOLE
    // ===============================================
    
    public function verifyExclusions() {
        echo "🔎  Iniciando verificação de arquivos (o que será exportado)..." . PHP_EOL;
        $files = $this->scanDirectory(true); // Get all files, including excluded ones for reporting
        
        $includedCount = 0;
        $excludedCount = 0;

        foreach ($files as $file) {
            $status = $this->getFileStatus($file);
            $relativePath = str_replace($this->projectPath, '', $file);
            if(str_contains($status, '[INCLUÍDO]')) {
                echo "✅ [INCLUÍDO] " . $relativePath . PHP_EOL;
                $includedCount++;
            } else {
                echo "❌ " . str_replace('[', '[EXCLUÍDO] ', $status) . " " . $relativePath . PHP_EOL;
                $excludedCount++;
            }
        }
        echo "------------------------------------------------" . PHP_EOL;
        echo "📊 Verificação concluída. " . $includedCount . " arquivos seriam incluídos, " . $excludedCount . " seriam excluídos/ignorados." . PHP_EOL;
    }

    // ===============================================
    // FUNÇÕES AUXILIARES (Completas e Corrigidas)
    // ===============================================

    private function scanDirectory($listAll = false) {
        $files = [];
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($this->projectPath, RecursiveDirectoryIterator::SKIP_DOTS),
            RecursiveIteratorIterator::SELF_FIRST
        );

        foreach ($iterator as $file) {
            $path = str_replace('\\', '/', $file->getPathname());
            
            // Se for diretório, verifica se deve ser pulado
            if ($file->isDir()) {
                if ($this->getExclusionRule($path . '/')) {
                    // Impede o iterador de entrar neste diretório
                    $iterator->setFlags(RecursiveDirectoryIterator::SKIP_DOTS);
                } else {
                    $iterator->setFlags(0);
                }
                continue;
            }
            
            // Se for arquivo, aplica as regras
            if ($listAll) { // Para o modo --verify
                $files[] = $path;
            } elseif (!$this->getExclusionRule($path) && $this->isAllowedExtension($path)) { // Para exportação
                $files[] = $path;
            }
        }
        sort($files);
        return $files;
    }

    private function getFileStatus($filePath) {
        $rule = $this->getExclusionRule($filePath);
        if ($rule) return "[EXCLUÍDO - Regra: $rule]";
        if ($this->isAllowedExtension($filePath)) return "[INCLUÍDO]";
        $ext = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));
        return "[IGNORADO - Extensão: .$ext]";
    }

    private function getExclusionRule($filePath) {
        $normalizedPath = str_replace('\\', '/', $filePath);
        $relativePath = str_replace($this->projectPath, '', $normalizedPath);
        foreach ($this->excludePaths as $pattern) {
            if (str_ends_with($pattern, '/')) {
                if (str_starts_with($relativePath, $pattern)) return $pattern;
            } else {
                if ($relativePath === $pattern) return $pattern;
            }
        }
        return null;
    }

    private function isAllowedExtension($filePath) {
        $extension = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));
        $filename = basename($filePath);
        if (in_array($filename, ['.htaccess', 'Dockerfile'])) return true;
        return in_array($extension, $this->allowedExtensions);
    }

    private function getFileInfo($filePath) {
        $relativePath = str_replace($this->projectPath, './', $filePath);
        $size = filesize($filePath);
        $lines = 0;
        $handle = fopen($filePath, 'r');
        if ($handle) {
            while (fgets($handle) !== false) { $lines++; }
            fclose($handle);
        }
        return [
            'name' => basename($filePath), 'path' => $relativePath,
            'extension' => strtolower(pathinfo($filePath, PATHINFO_EXTENSION)),
            'size' => $this->formatFileSize($size), 'date' => date('d/m/Y H:i:s', filemtime($filePath)),
            'lines' => $lines
        ];
    }

    private function formatFileSize($bytes) {
        if ($bytes >= 1048576) return number_format($bytes / 1048576, 1) . ' MB';
        if ($bytes >= 1024) return number_format($bytes / 1024, 1) . ' KB';
        return $bytes . ' bytes';
    }

    private function detectLanguage($extension) {
        $map = ['php' => 'php', 'js' => 'javascript', 'css' => 'css', 'html' => 'html', 'sql' => 'sql', 'json' => 'json', 'xml' => 'xml', 'md' => 'markdown', 'yml' => 'yaml', 'ini' => 'ini', 'htaccess' => 'apache', 'env' => 'bash'];
        return $map[$extension] ?? 'text';
    }

    private function formatMarkdown($fileInfo, $content) {
        $lang = $this->detectLanguage($fileInfo['extension']);
        $output = "\n\n## Arquivo: " . $fileInfo['name'] . "\n";
        $output .= "**Caminho:** `" . $fileInfo['path'] . "`\n";
        $output .= "**Detalhes:** " . $fileInfo['date'] . " | " . $fileInfo['size'] . " | " . $fileInfo['lines'] . " linhas\n\n";
        $output .= "```" . $lang . "\n";
        $output .= rtrim($content) . "\n";
        $output .= "```\n---";
        return $output;
    }

    private function writeHeader() {
        $header = "# 📁 Log de Programaçãodelivery\n\n";
        $header .= "**Gerado em:** " . date('d/m/Y H:i:s') . "\n";
        $header .= "**Projeto:** " . basename(rtrim($this->projectPath, '/')) . "\n---\n";
        file_put_contents($this->logFile, $header);
    }

    private function writeFooter($exportedFiles) {
        $totalSize = 0;
        foreach ($exportedFiles as $file) { $totalSize += filesize($file); }
        $footer = "\n\n---\n\n## 📊 Estatísticas\n\n";
        $footer .= "- **Total de arquivos exportados:** " . count($exportedFiles) . "\n";
        $footer .= "- **Tamanho total:** " . $this->formatFileSize($totalSize) . "\n";
        file_put_contents($this->logFile, $footer, FILE_APPEND);
    }
}

// =====================================
// BLOCO DE EXECUÇÃO PRINCIPAL
// =====================================

$options = getopt('p:f:h', ['path:', 'file:', 'help', 'verify', 'tree-file:']);

if (isset($options['h']) || isset($options['help'])) {
    echo "📖 Exportador de Código para Markdown\n\nUso: php " . basename(__FILE__) . " [opções]\n\n";
    echo "Opções:\n";
    echo "  (nenhuma)             Executa a exportação principal para o arquivo Markdown.\n";
    echo "  -p, --path <caminho>      Caminho do projeto a ser exportado (padrão: ./).\n";
    echo "  -f, --file <arquivo>      Arquivo de saída para a exportação (padrão: codigo-log.md).\n";
    echo "      --verify              Mostra no console o que seria incluído ou excluído, sem exportar.\n";
    echo "      --tree-file <arquivo> Gera um arquivo de texto com a árvore do projeto.\n";
    echo "  -h, --help                Mostra esta ajuda.\n";
    exit(0);
}

$projectPath = isset($options['p']) || isset($options['path']) ? ($options['p'] ?? $options['path']) : './';
$logFile = isset($options['f']) || isset($options['file']) ? ($options['f'] ?? $options['file']) : 'codigo-log.md';

try {
    $exporter = new CodeExporter($projectPath, $logFile);

    if (isset($options['tree-file'])) {
        $treeOutputFile = $options['tree-file'];
        if (empty($treeOutputFile) || !is_string($treeOutputFile)) die("❌ Erro: --tree-file requer um nome de arquivo.\n");
        $exporter->generateFileTree($treeOutputFile);

    } elseif (isset($options['verify'])) {
        $exporter->verifyExclusions();

    } else {
        // AÇÃO PADRÃO: EXPORTAR PARA MARKDOWN
        echo "🚀 Iniciando exportação para Markdown..." . PHP_EOL;
        echo "📂 Projeto: " . realpath($projectPath) . PHP_EOL;
        echo "📝 Arquivo de saída: " . $logFile . PHP_EOL . PHP_EOL;
        $exporter->exportAll();
        echo PHP_EOL . "🎉 Exportação concluída com sucesso!" . PHP_EOL;
    }

} catch (Exception $e) {
    echo "❌ Erro inesperado: " . $e->getMessage() . PHP_EOL;
    exit(1);
}