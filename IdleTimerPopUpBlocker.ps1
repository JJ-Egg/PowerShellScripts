#Created by Jonathan Eggleston
#This script detects when a window with the name "Idle timer expired" appears and stops its process.
#Add-Type -AssemblyName System.Windows.Forms

$windowTitle = "Idle timer expired"

while ($true) {

if ($(Get-Process | Where-Object {$_.MainWindowTitle -like "*$windowTitle*"})) 

    {
    sleep 1

	Get-Process | Where-Object {$_.MainWindowTitle -like "*$windowTitle*"} | Stop-Process
	
    <#[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
    [System.Windows.Forms.SendKeys]::SendWait('{ENTER}')#>

    Write-Output "Idle pop-up blocked!"

    }
 
}