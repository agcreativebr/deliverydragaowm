<?php
date_default_timezone_set('America/Sao_Paulo');
/**
 * Script para exportar arquivos de programação em formato Markdown
 * Sistema de Controle de Combustível
 * Data: 07/06/2025 - VERSÃO CORRIGIDA
 */

class CodeExporter {
    private $logFile;
    private $projectPath;
    private $allowedExtensions;
    private $excludePaths;
    
    public function __construct($projectPath = './', $logFile = 'codigo-log.md') {
        $this->projectPath = rtrim($projectPath, '/') . '/';
        $this->logFile = $logFile;
        
        $this->allowedExtensions = [
            'php', 'js', 'css', 'html', 'htm', 'sql', 'json', 'xml', 
            'htaccess', 'txt', 'md', 'yml', 'yaml', 'ini', 'env'
        ];
        
        $this->excludePaths = [
    'vendor/',           // Exclui tudo da pasta vendor
    'vendor/composer/',  // Especificamente a subpasta composer
    'node_modules/',
    '.git/',
    'storage/logs/',
    'storage/cache/',
    'temp/',
    'tmp/',
    'backup/',
    '.env',
    'composer.lock',
    'package-lock.json'
];
    }
    
    public function exportAll() {
        $this->writeHeader();
        $files = $this->scanDirectory($this->projectPath);
        
        foreach ($files as $file) {
            $this->exportFile($file);
        }
        
        $this->writeFooter();
        echo "✅ Exportação concluída! Arquivo: " . $this->logFile . PHP_EOL;
    }
    
    public function exportFile($filePath) {
        if (!file_exists($filePath)) {
            echo "❌ Arquivo não encontrado: " . $filePath . PHP_EOL;
            return false;
        }
        
        if (!$this->isAllowedFile($filePath)) {
            return false;
        }
        
        $fileInfo = $this->getFileInfo($filePath);
        $content = file_get_contents($filePath);
        
        if ($content === false) {
            echo "⚠️ Erro ao ler arquivo: " . $filePath . PHP_EOL;
            return false;
        }
        
        $markdown = $this->formatMarkdown($fileInfo, $content);
        file_put_contents($this->logFile, $markdown, FILE_APPEND | LOCK_EX);
        
        echo "📄 Exportado: " . $fileInfo['name'] . PHP_EOL;
        return true;
    }
    
    private function scanDirectory($dir) {
        $files = [];
        
        if (!is_dir($dir)) {
            return $files;
        }
        
        $iterator = new RecursiveIteratorIterator(
            new RecursiveDirectoryIterator($dir, RecursiveDirectoryIterator::SKIP_DOTS)
        );
        
        foreach ($iterator as $file) {
            if ($file->isFile() && !$this->isExcluded($file->getPathname())) {
                $files[] = $file->getPathname();
            }
        }
        
        sort($files);
        return $files;
    }

   private function isExcluded($filePath) {
    // Converte separadores para / (compatível com Windows e Unix)
    $relativePath = str_replace('\\', '/', str_replace($this->projectPath, '', $filePath));

    foreach ($this->excludePaths as $excludePath) {
        // Verifica se o caminho contém a pasta excluída
        if (strpos($relativePath, $excludePath) !== false) {
            return true;
        }
    }

    return false;
}

    private function isAllowedFile($filePath) {
        $extension = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));
        $filename = basename($filePath);
        
        if (in_array($filename, ['.htaccess', '.env.example', 'Dockerfile'])) {
            return true;
        }
        
        return in_array($extension, $this->allowedExtensions);
    }
    
    private function getFileInfo($filePath) {
        $relativePath = str_replace('\\', '/', str_replace($this->projectPath, './', $filePath));
        $extension = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));
        $size = filesize($filePath);
        $modified = filemtime($filePath);
        
        $lines = 0;
        $handle = fopen($filePath, 'r');
        if ($handle) {
            while (fgets($handle) !== false) {
                $lines++;
            }
            fclose($handle);
        }
        
        return [
            'name' => basename($filePath),
            'path' => $relativePath,
            'extension' => $extension ?: 'config',
            'size' => $this->formatFileSize($size),
            'date' => date('d/m/Y H:i:s', $modified),
            'lines' => $lines
        ];
    }
    
    private function formatFileSize($bytes) {
        if ($bytes >= 1048576) {
            return number_format($bytes / 1048576, 1) . ' MB';
        } elseif ($bytes >= 1024) {
            return number_format($bytes / 1024, 1) . ' KB';
        } else {
            return $bytes . ' bytes';
        }
    }
    
    private function detectLanguage($extension) {
        $languages = [
            'php' => 'php',
            'js' => 'javascript',
            'css' => 'css',
            'html' => 'html',
            'htm' => 'html',
            'sql' => 'sql',
            'json' => 'json',
            'xml' => 'xml',
            'md' => 'markdown',
            'yml' => 'yaml',
            'yaml' => 'yaml',
            'ini' => 'ini',
            'htaccess' => 'apache',
            'env' => 'bash'
        ];
        
        return $languages[$extension] ?? 'text';
    }

    private function formatMarkdown($fileInfo, $content) {
        $language = $this->detectLanguage($fileInfo['extension']);
        
        $output = PHP_EOL . PHP_EOL . "## Arquivo: " . $fileInfo['name'] . PHP_EOL;
        $output .= "**Caminho:** `" . $fileInfo['path'] . "`" . PHP_EOL;
        $output .= "**Tipo:** " . $fileInfo['extension'] . PHP_EOL;
        $output .= "**Data:** " . $fileInfo['date'] . PHP_EOL;
        $output .= "**Tamanho:** " . $fileInfo['size'] . PHP_EOL;
        $output .= "**Linhas:** " . $fileInfo['lines'] . PHP_EOL . PHP_EOL;

        $lines = explode("\n", $content);
        if (count($lines) > 500) {
            $content = implode("\n", array_slice($lines, 0, 500));
            $output .= "⚠️ **Arquivo truncado - Mostrando primeiras 500 linhas**" . PHP_EOL . PHP_EOL;
        }

        $output .= "```" . $language . PHP_EOL;
        $output .= $content . PHP_EOL;
        $output .= "```" . PHP_EOL . "---" . PHP_EOL;

        return $output;
    }
    
    private function writeHeader() {
    $header = "# 📁 Log de Programação - Sistema delivery" . PHP_EOL . PHP_EOL;
    $header .= "**Gerado em:** " . date('d/m/Y H:i:s') . PHP_EOL;
    $header .= "**Projeto:** Sistema delivery" . PHP_EOL;
    $header .= "**Arquitetura:** PHP 8.1+ + MySQL + JavaScript Vanilla" . PHP_EOL . PHP_EOL;
    $header .= "---" . PHP_EOL;

    // ✅ Não faz backup, apenas sobrescreve diretamente
    file_put_contents($this->logFile, $header);
}
    
    private function writeFooter() {
        $footer = PHP_EOL . PHP_EOL . "---" . PHP_EOL . PHP_EOL;
        $footer .= "## 📊 Estatísticas" . PHP_EOL . PHP_EOL;
        $footer .= "- **Total de arquivos:** " . $this->countFiles() . PHP_EOL;
        $footer .= "- **Tamanho total:** " . $this->getTotalSize() . PHP_EOL;
        $footer .= "- **Última atualização:** " . date('d/m/Y H:i:s') . PHP_EOL . PHP_EOL;
        $footer .= "*Log gerado automaticamente pelo exportador de código*" . PHP_EOL;
        
        file_put_contents($this->logFile, $footer, FILE_APPEND | LOCK_EX);
    }
    
    private function countFiles() {
        $files = $this->scanDirectory($this->projectPath);
        $count = 0;
        foreach ($files as $file) {
            if ($this->isAllowedFile($file)) {
                $count++;
            }
        }
        return $count;
    }
    
    private function getTotalSize() {
        $files = $this->scanDirectory($this->projectPath);
        $totalSize = 0;
        
        foreach ($files as $file) {
            if ($this->isAllowedFile($file)) {
                $totalSize += filesize($file);
            }
        }
        
        return $this->formatFileSize($totalSize);
    }
}

// =====================================
// EXECUÇÃO DO SCRIPT
// =====================================

$projectPath = './';
$logFile = 'codigo-log.md';

$options = getopt('p:f:h', ['path:', 'file:', 'help']);

if (isset($options['h']) || isset($options['help'])) {
    echo "📖 Exportador de Código para Markdown" . PHP_EOL . PHP_EOL;
    echo "Uso: php export-code.php [opções]" . PHP_EOL . PHP_EOL;
    echo "Opções:" . PHP_EOL;
    echo "  -p, --path    Caminho do projeto (padrão: ./)" . PHP_EOL;
    echo "  -f, --file    Arquivo de saída (padrão: codigo-log.md)" . PHP_EOL;
    echo "  -h, --help    Mostra esta ajuda" . PHP_EOL;
    exit(0);
}

if (isset($options['p']) || isset($options['path'])) {
    $projectPath = $options['p'] ?? $options['path'];
}

if (isset($options['f']) || isset($options['file'])) {
    $logFile = $options['f'] ?? $options['file'];
}

try {
    echo "🚀 Iniciando exportação..." . PHP_EOL;
    echo "📂 Projeto: " . $projectPath . PHP_EOL;
    echo "📝 Log: " . $logFile . PHP_EOL . PHP_EOL;
    
    $exporter = new CodeExporter($projectPath, $logFile);
    $exporter->exportAll();
    
    echo PHP_EOL . "🎉 Exportação concluída com sucesso!" . PHP_EOL;
    echo "📋 Arquivo gerado: " . $logFile . PHP_EOL;
    
} catch (Exception $e) {
    echo "❌ Erro: " . $e->getMessage() . PHP_EOL;
    exit(1);
}
?>
