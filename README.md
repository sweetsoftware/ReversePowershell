# ReversePowershell

__install.bat__ downloads the __client.ps1__ script (hosted at a location of your choice) and executes it, thus installing a persistent PowerShell backdoor.

The attacker runs __server.ps1__ and gets a reverse PowerShell prompt to the victim.

## Usage

* Host client.ps1 somewhere
* Replace the IP and port with your own in the client.ps1 script
* Replace scriptURL with the one where you host client.ps1 in client.ps1 and install.bat
