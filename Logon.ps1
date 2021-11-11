#This script can open webpages and login based on information entered below

Add-Type -AssemblyName System.Windows.Forms

Start-Process chrome #URL here
sleep 5
[System.Windows.Forms.SendKeys]::SendWait(#Password in '')
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')

sleep 3

Start-Process chrome #URL here
Sleep 6
[System.Windows.Forms.SendKeys]::SendWait(#Username)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait(#Password)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')