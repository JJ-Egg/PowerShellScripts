#Created to fix issue I have occasionally on home PC with my TV's sound not being detected. Opening the Sound options from the control panel will detect the device, and this script automates that process.

#Add Assembly Type
Add-Type -AssemblyName System.Windows.Forms

#open Sound dialog
show-controlpanelitem -name "Sound"

#Waits a bit
Start-Sleep -s 2

#Close dialog by simulating Esc press
[System.Windows.Forms.SendKeys]::SendWait('{ESC}')
exit