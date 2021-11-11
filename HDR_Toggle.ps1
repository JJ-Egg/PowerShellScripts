#Created to enable quick toggling of HDR in Windows Display Settings.

Add-Type -AssemblyName System.Windows.Forms

#Opens Windows Display Settings
Start-Process ms-settings:display

#Waits
Start-Sleep -s 2


#Tabs to HDR toggle switch
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')

#Toggles switch
[System.Windows.Forms.SendKeys]::SendWait('% ')

Start-Sleep -s 5

[System.Windows.Forms.SendKeys]::SendWait('%{F4}')