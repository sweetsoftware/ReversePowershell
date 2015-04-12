# ReversePowershell

__install.bat__ downloads the client.ps1 script (hosted at a location of your choice) and executes it, thus installing a persistent PowerShell backdoor.

The attacker runs server.ps1 and gets a reverse PowerShell prompt to the victim.

## Usage

* Host client.ps1 somew	here
* Replace the IP and port with your own in the client.ps1 script
* Replace scriptURL with the one where you host client.ps1 in client.ps1 and install.bat
