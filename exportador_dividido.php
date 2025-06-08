<?php
date_default_timezone_set('America/Sao_Paulo');

/**
 * Script para exportar arquivos de programação em formato Markdown, dividindo a saída
 * em múltiplos arquivos baseados em um limite de linhas.
 *
 * Sistema de Controle de Combustível
 * Data: 08/06/2025 - VERSÃO 2.1 (COMPLETA E CORRIGIDA)
 * @author IA Arquiteta de Software
 */
class CodeExporter
{
    private string $projectPath;
    private string $baseLogFile;
    private array $allowedExtensions;
    private array $excludePaths;

    // Propriedades para controle da divisão de arquivos
    private int $lineLimit;
    private int $currentLineCount = 0;
    private int $filePartNumber = 1;
    private $currentFileHandle;

    /**
     * Construtor da classe.
     *
     * @param string $projectPath Caminho do projeto a ser analisado.
     * @param string $logFile Nome base para os arquivos de log.
     * @param int $lineLimit Limite de linhas por arquivo de log.
     */
    public function __construct(string $projectPath = './', string $logFile = 'codigo-log.md', int $lineLimit = 10000)
    {
        $this->projectPath = rtrim($projectPath, '/') . '/';
        $this->baseLogFile = $logFile;
        $this->lineLimit = $lineLimit;

        $this->allowedExtensions = [
            'php', 'js', 'css', 'html', 'htm', 'sql', 'json', 'xml',
            'htaccess', 'txt', 'md', 'yml', 'yaml', 'ini', 'env', 'dockerfile'
        ];

        $this->excludePaths = [
            'vendor/',
            'node_modules/',
            '.git/',
            'storage/',
            'temp/',
            'tmp/',
            'backup/',
            'cache/',
            '.env',
            'composer.lock',
            'package-lock.json',
            basename(__FILE__) // Exclui o próprio script de exportação
        ];
    }

    /**
     * Inicia a exportação de todos os arquivos do projeto.
     */
    public function exportAll(): void
    {
        $this->startNewLogFile();
        $files = $this->scanDirectory($this->projectPath);

        foreach ($files as $file) {
            $this->exportFile($file);
        }

        $this->writeFooter();
        fclose($this->currentFileHandle);
        echo "✅ Exportação concluída! Arquivos gerados a partir de: " . $this->baseLogFile . PHP_EOL;
    }

    /**
     * Exporta um único arquivo para o log.
     *
     * @param string $filePath Caminho do arquivo a ser exportado.
     */
    private function exportFile(string $filePath): void
    {
        if (!file_exists($filePath) || !$this->isAllowedFile($filePath)) {
            return;
        }

        $content = file_get_contents($filePath);
        if ($content === false) {
            echo "⚠️ Erro ao ler arquivo: " . $filePath . PHP_EOL;
            return;
        }
        
        $fileInfo = $this->getFileInfo($filePath, $content);
        $markdownContent = $this->formatMarkdown($fileInfo, $content);
        $linesToAdd = substr_count($markdownContent, "\n") + 1;

        if (($this->currentLineCount + $linesToAdd) > $this->lineLimit && $this->currentLineCount > 0) {
            $this->writeFooter();
            fclose($this->currentFileHandle);
            $this->filePartNumber++;
            $this->startNewLogFile();
        }

        fwrite($this->currentFileHandle, $markdownContent);
        $this->currentLineCount += $linesToAdd;

        echo "📄 Exportado: " . $fileInfo['path'] . " para " . $this->getCurrentLogFilename() . PHP_EOL;
    }

    /**
     * Inicia um novo arquivo de log (parte).
     */
    private function startNewLogFile(): void
    {
        $this->currentLineCount = 0;
        $filename = $this->getCurrentLogFilename();
        $this->currentFileHandle = fopen($filename, 'w');
        if ($this->currentFileHandle === false) {
            throw new \RuntimeException("Não foi possível abrir o arquivo de log para escrita: " . $filename);
        }
        $header = $this->generateHeader();
        fwrite($this->currentFileHandle, $header);
        $this->currentLineCount += substr_count($header, "\n") + 1;
    }

    /**
     * Gera o nome do arquivo de log atual com base no número da parte.
     */
    private function getCurrentLogFilename(): string
    {
        $path_parts = pathinfo($this->baseLogFile);
        $filename = $path_parts['filename'];
        $extension = $path_parts['extension'] ?? 'md';
        return $filename . '-parte-' . $this->filePartNumber . '.' . $extension;
    }

    /**
     * Gera o conteúdo do cabeçalho para os arquivos de log.
     */
    private function generateHeader(): string
    {
        $header = "# 📁 Log de Programação - Sistema delivery (Parte " . $this->filePartNumber . ")" . PHP_EOL . PHP_EOL;
        $header .= "**Gerado em:** " . date('d/m/Y H:i:s') . PHP_EOL;
        $header .= "**Projeto:** Sistema delivery" . PHP_EOL;
        $header .= "**Arquitetura:** PHP 8.1+ + MySQL + JavaScript Vanilla" . PHP_EOL . PHP_EOL;
        $header .= "---" . PHP_EOL;
        return $header;
    }

    /**
     * Formata o conteúdo do arquivo em Markdown.
     */
    private function formatMarkdown(array $fileInfo, string $content): string
    {
        $language = $this->detectLanguage($fileInfo['extension']);

        $output = PHP_EOL . "## Arquivo: " . $fileInfo['name'] . PHP_EOL;
        $output .= "**Caminho:** `" . $fileInfo['path'] . "`" . PHP_EOL;
        $output .= "**Tipo:** " . $fileInfo['extension'] . PHP_EOL;
        $output .= "**Data:** " . $fileInfo['date'] . PHP_EOL;
        $output .= "**Tamanho:** " . $fileInfo['size'] . PHP_EOL;
        $output .= "**Linhas:** " . $fileInfo['lines'] . PHP_EOL . PHP_EOL;
        $output .= "```" . $language . PHP_EOL;
        $output .= rtrim($content) . PHP_EOL;
        $output .= "```" . PHP_EOL . "---" . PHP_EOL;

        return $output;
    }

    /**
     * Escreve o rodapé no arquivo de log atual.
     */
    private function writeFooter(): void
    {
        $footer = PHP_EOL . PHP_EOL . "---" . PHP_EOL . PHP_EOL;
        $footer .= "## 📊 Estatísticas (Fim da Parte " . $this->filePartNumber . ")" . PHP_EOL . PHP_EOL;
        $footer .= "- **Total de arquivos no projeto:** " . $this->countFiles() . PHP_EOL;
        $footer .= "- **Tamanho total do projeto:** " . $this->getTotalSize() . PHP_EOL;
        $footer .= "- **Última atualização:** " . date('d/m/Y H:i:s') . PHP_EOL . PHP_EOL;
        $footer .= "*Log gerado automaticamente pelo exportador de código*" . PHP_EOL;

        if ($this->currentFileHandle) {
            fwrite($this->currentFileHandle, $footer);
        }
    }

    /**
     * MÉTODOS AUXILIARES (AGORA INCLUÍDOS)
     */
    private function scanDirectory(string $dir): array
    {
        $files = [];
        if (!is_dir($dir)) return $files;
        $iterator = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($dir, RecursiveDirectoryIterator::SKIP_DOTS));
        foreach ($iterator as $file) {
            if ($file->isFile() && !$this->isExcluded($file->getPathname())) {
                $files[] = $file->getPathname();
            }
        }
        sort($files);
        return $files;
    }

    private function isExcluded(string $filePath): bool
    {
        $relativePath = str_replace('\\', '/', str_replace($this->projectPath, '', $filePath));
        foreach ($this->excludePaths as $excludePath) {
            if (str_starts_with($relativePath, $excludePath)) {
                return true;
            }
        }
        return false;
    }

    private function isAllowedFile(string $filePath): bool
    {
        $extension = strtolower(pathinfo($filePath, PATHINFO_EXTENSION));
        return in_array($extension, $this->allowedExtensions);
    }

    private function getFileInfo(string $filePath, string $content): array
    {
        return [
            'name' => basename($filePath),
            'path' => str_replace('\\', '/', str_replace($this->projectPath, './', $filePath)),
            'extension' => strtolower(pathinfo($filePath, PATHINFO_EXTENSION)),
            'size' => $this->formatFileSize(filesize($filePath)),
            'date' => date('d/m/Y H:i:s', filemtime($filePath)),
            'lines' => substr_count($content, "\n") + 1
        ];
    }

    private function formatFileSize(int $bytes): string
    {
        if ($bytes >= 1048576) return number_format($bytes / 1048576, 2) . ' MB';
        if ($bytes >= 1024) return number_format($bytes / 1024, 2) . ' KB';
        return $bytes . ' bytes';
    }

    private function detectLanguage(string $extension): string
    {
        $map = [
            'php' => 'php', 'js' => 'javascript', 'css' => 'css', 'html' => 'html', 
            'sql' => 'sql', 'json' => 'json', 'md' => 'markdown', 'yml' => 'yaml', 
            'ini' => 'ini', 'htaccess' => 'apache', 'env' => 'bash', 'dockerfile' => 'dockerfile'
        ];
        return $map[$extension] ?? 'text';
    }

    private function countFiles(): int
    {
        return count($this->scanDirectory($this->projectPath));
    }

    private function getTotalSize(): string
    {
        $totalSize = 0;
        $files = $this->scanDirectory($this->projectPath);
        foreach ($files as $file) {
            $totalSize += filesize($file);
        }
        return $this->formatFileSize($totalSize);
    }
} // Fim da classe CodeExporter

// =====================================
// EXECUÇÃO DO SCRIPT
// =====================================
$projectPath = './';
$logFile = 'codigo-log.md';
$lineLimit = 10000;

try {
    echo "🚀 Iniciando exportação com divisão de arquivos..." . PHP_EOL;
    echo "📂 Projeto: " . realpath($projectPath) . PHP_EOL;
    echo "📝 Arquivo base: " . $logFile . PHP_EOL;
    echo "📏 Limite por arquivo: " . $lineLimit . " linhas" . PHP_EOL . PHP_EOL;

    $exporter = new CodeExporter($projectPath, $logFile, $lineLimit);
    $exporter->exportAll();

} catch (Exception $e) {
    echo PHP_EOL . "❌ Erro fatal durante a exportação: " . $e->getMessage() . PHP_EOL;
    exit(1);
}

?>
