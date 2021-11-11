# This script uses PowerShell cmdlets to both restart and test the connection of a target PC through Active Directory management.

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
}
}


#Prompts for user input for PC ID #
$PCID = Read-Host -Prompt "Enter the PC's PIN/ID to restart"

#Restarts PC using variable set up above
Restart-Computer $PCID -force

#Waits for PC to restart, and runs a connection test/ping test
Write-Host "Restarting PC..."

sleep 60

Test-NetConnection $PCID

Read-Host -Prompt "Press Enter to Exit" 
