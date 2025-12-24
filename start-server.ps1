# Simple HTTP Server for game.html
$port = 8080
$url = "http://localhost:$port/"

# Check if port is already in use
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $port)
try {
    $listener.Start()
    $listener.Stop()
    Write-Host "Port $port is available"
} catch {
    Write-Host "Port $port is already in use. Trying to use existing server..."
    Start-Process $url
    exit
}

# Create HTTP listener
$httpListener = New-Object System.Net.HttpListener
$httpListener.Prefixes.Add($url)
$httpListener.Start()

Write-Host "Server started at $url"
Write-Host "Press Ctrl+C to stop"

# Open browser
Start-Process "${url}game.html"

try {
    while ($httpListener.IsListening) {
        $context = $httpListener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $localPath = $request.Url.LocalPath.TrimStart('/')
        if ($localPath -eq '' -or $localPath -eq 'game.html') {
            $localPath = 'game.html'
        }
        
        $filePath = Join-Path $PSScriptRoot $localPath
        
        if (Test-Path $filePath) {
            $content = [System.IO.File]::ReadAllBytes($filePath)
            $response.ContentType = if ($filePath.EndsWith('.html')) { 'text/html' } 
                                    elseif ($filePath.EndsWith('.js')) { 'application/javascript' }
                                    elseif ($filePath.EndsWith('.css')) { 'text/css' }
                                    else { 'text/plain' }
            $response.ContentLength64 = $content.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($content, 0, $content.Length)
        } else {
            $response.StatusCode = 404
            $bytes = [System.Text.Encoding]::UTF8.GetBytes("File not found")
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        }
        
        $response.Close()
    }
} finally {
    $httpListener.Stop()
}


