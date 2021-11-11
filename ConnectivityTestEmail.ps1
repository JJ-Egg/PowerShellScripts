#This script fills out an email from a template and sends it to the appropriate address with a click. Created for Network Connectivity Testing at work.

Add-Type -AssemblyName System.Windows.Forms

#navigates to ConnectivityTest directory
set-location \\...\ServiceDeskTools\ConnectivityTest

#Sets variable for current hour
$Time = get-date -Uformat %H

#-old code-$TicketNumber = Read-Host "Input today's ticket number"

#Sets TicketNumber variable to content of TicketNumber text file in above directory
$TicketNumber = get-content TicketNumber.txt

Write-Host -ForegroundColor Blue "Opening Test Email..."
Start-Sleep -s 1

#Opens Test Email Template
Start-process "\\...\ServiceDeskTools\ConnectivityTest\ConnectTest.oft"

sleep 8

#Writes to email subject line/sends
[System.Windows.Forms.SendKeys]::SendWait( $TicketNumber)
[System.Windows.Forms.SendKeys]::SendWait(' - ')
[System.Windows.Forms.SendKeys]::SendWait( $Time)
[System.Windows.Forms.SendKeys]::SendWait('00')
[System.Windows.Forms.SendKeys]::SendWait('%S') 
