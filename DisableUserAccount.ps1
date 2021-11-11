#This script provides a reusable prompt to disable user accounts through AD. Created to speed up processing of account disablement lists for work.

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
  $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
  Start-Process -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
  Exit
}
}


#Prompts for current ticket number to insert in description in below section

$TicketNumber = Read-Host -Prompt "Enter the currently worked ticket number"


#Prompts for user input for User Account to Disable

while($true){

$UserAccount = Read-Host -Prompt "Enter the user account to be disabled"


#Disables AD account and leaves note in description pointing to currently worked ticket number

Disable-ADAccount $UserAccount

Set-ADUser $UserAccount -Description "Disabled for 30-day non-use per $TicketNumber"

Write-Host "Account Disabled"
