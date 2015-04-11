$port=8000

# Create server
$endpoint = New-Object System.Net.IPEndPoint([System.Net.IpAddress]::Any, $port)
$listener = New-Object System.Net.Sockets.TcpListener($endpoint)
$listener.Start()
Write-Host 'Listening on port'$port'...'

# Wait for connection
$client = $listener.AcceptTcpClient()
$stream = $client.GetStream()
$reader = New-Object System.IO.StreamReader($stream)
$writer = New-Object System.IO.StreamWriter($stream)
Write-Host [ -NoNewline;Write-Host * -Fore Green -NoNewline;Write-Host ] Connection established !

# Interact with the client
while($true) {
    $cmd = Read-Host
    if ($cmd -eq 'exit') {
        $writer.WriteLine('bye')
        $writer.Flush()
        break
    }
    $writer.WriteLine($cmd)
    $writer.Flush()
    $output = $reader.ReadLine()
    echo $output
    ""
}

# Cleanup
$reader.Close()
$writer.Close()
$client.Close()
$listener.Stop()
