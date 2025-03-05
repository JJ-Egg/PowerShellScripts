Add-Type -AssemblyName System.Windows.Forms

#This script is useful for dealing with outages in NOC work. It opens a Teams meeting with a custom title; it also opens a service ticket and fills out a web form with details
#*Non-working templete; sensitive details removed

#Starts Teams meeting invite email
Start-process outlook 
sleep 3
[System.Windows.Forms.SendKeys]::SendWait("+^(Q)")
sleep 4
[System.Windows.Forms.SendKeys]::SendWait("<ST-XXXXXX> : LOB + Location + Service(s) Impacted + Severity")
sleep 3

#Starts ticket creation 
Start-process #URL for ticket creation
sleep 7
[System.Windows.Forms.SendKeys]::SendWait('{TAB 3}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1

#Timing seems inconsistent in below line ; may require changes
[System.Windows.Forms.SendKeys]::SendWait('{TAB 13}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 2
[System.Windows.Forms.SendKeys]::SendWait('{TAB 2}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("LOB + Location + Service(s) Impacted + Severity ")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 3}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Home")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 2}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Video TV 1 {(}Set top Box{)}")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 1}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Customer")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 1}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Service - Hard Down")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 2}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("All services went down at <equipment_name/ location>")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 2}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Business Name")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 2}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("NOC")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 7}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Business Name")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB 2}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait("Phone Call")
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')

