#Created by Jonathan Eggleston
#This script automates start up processes and logins for applications used in a NOC environment

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Runtime

#Find's AppData folder path and stores in variable
$AppDataPath = Join-Path $env:AppData "PowerShellScripts"

# This if statement section determines if a folder exists for storing logins; if not, creates one and requests login info from user for first-time setup

if(!(Test-Path "$AppDataPath\StartUpScript")) {

Write-Host "Starting first-time setup."

New-Item -ItemType "directory" -Path "$AppDataPath\StartUpScript"

#SSO/LDAP Username and Password

Read-Host -Prompt "Enter your SSO/LDAP username" | Out-File -FilePath "$AppDataPath\StartUpScript\Username.txt"
Read-Host -Prompt "Enter your SSO/LDAP Password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\Password.xml"

#NFM-T Password
Read-Host -Prompt "Enter your NFM-T Password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\NFMTpassword.xml"

#BTI Password
Read-Host -Prompt "Enter your Juniper BTI Password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\BTIpassword.xml"

#Tera Term Username and Password
Read-Host -Prompt "Enter your Memphis Switch username" | Out-File -FilePath "$AppDataPath\StartUpScript\TTusername.txt"
Read-Host -Prompt "Enter your Memphis Switch password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\TTpassword.xml"
Read-Host -Prompt "Enter your Jackson Switch username" | Out-File -FilePath "$AppDataPath\StartUpScript\TTusername2.txt"
Read-Host -Prompt "Enter your Jackson Switch password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\TTpassword2.xml"

#Avaya passwords 
Read-Host -Prompt "Enter your 1st Avaya password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\AvayaPassword1.xml"
Read-Host -Prompt "Enter your 2nd Avaya password" -AsSecureString | Export-CliXml -Path "$AppDataPath\StartUpScript\AvayaPassword2.xml"
}


# Prompts user to choose which apps to load depending on whether they are working Transport, Wireless, or both
$SelectVersion = Read-Host -Prompt "Enter 1 for Transport, 2 for Wireless, or 3 for both"


#Next section declares variables and imports logins from files in StartUpScript folder

#SSO/LDAP Username and Password
$Username = Get-Content -Path "$AppDataPath\StartUpScript\Username.txt"
$ReadPassword = Import-Clixml -Path "$AppDataPath\StartUpScript\Password.xml"
$Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadPassword))


#NFM-T Password
$ReadNFMTPassword = Import-Clixml -Path "$AppDataPath\StartUpScript\NFMTPassword.xml"
$NFMTPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadNFMTPassword))

<#BTI Password - commented out for troubleshooting - this app interferes with PS window
$ReadBTIPassword = Import-Clixml -Path "$AppDataPath\StartUpScript\BTIPassword.xml"
$BTIPassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadBTIPassword))
#>

#Tera Term Username and Password
$TTusername = Get-Content -Path "$AppDataPath\StartUpScript\TTusername.txt"
$ReadTTpassword = Import-Clixml -Path "$AppDataPath\StartUpScript\TTpassword.xml"
$TTpassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadTTPassword))

$TTusername2 = Get-Content -Path "$AppDataPath\StartUpScript\TTusername2.txt"
$ReadTTpassword2 = Import-Clixml -Path "$AppDataPath\StartUpScript\TTpassword2.xml"
$TTpassword = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadTTPassword2))


#Avaya Passwords
$ReadAvayaPassword1 = Import-Clixml -Path "$AppDataPath\StartUpScript\AvayaPassword1.xml"
$AvayaPassword1 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadAvayaPassword1))

$ReadAvayaPassword2 = Import-Clixml -Path "$AppDataPath\StartUpScript\AvayaPassword2.xml"
$AvayaPassword2 = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($ReadAvayaPassword2))


#Next section begins login process

#Retrieves current username for finding user directory below
$CurrentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$CurrentUser = $CurrentUser.Trim("'CORP\'")
Write-Host $CurrentUser

#If Transport, this runs
if ($SelectVersion -eq 1) {

#TEOCO Cruiser
start-process -FilePath "C:\Users\$CurrentUser\Desktop\Cruiser.lnk"
sleep 5
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 5
[System.Windows.Forms.SendKeys]::SendWait($Username)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait($Password)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 20

# Starts Secure CRT
Start-Process "C:\Users\$CurrentUser\AppData\Local\VanDyke Software\Clients\SecureCRT.exe"
sleep 5

# Starts Fuji 
Start-Process "C:\Users\$CurrentUser\Desktop\Fuji Netsmart.exe"
sleep 10 
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 20


# Starts BTI
Start-Process "C:\Program Files\Juniper\PSM Client 7.8.0\bin\psmclient.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait($Username)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait($BTIpassword)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 5

Commented out for testing
Avaya login

Start-Process "C:\Users\Public\Desktop\Avaya one-X Agent.lnk"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($AvayaPassword1)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($AvayaPassword2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts Outlook
Start-Process Outlook.exe
sleep 1

}

#If Wireless, this runs
if ($SelectVersion -eq 2) {

# Starts window 1
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPmemphis)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts window 2
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPmemphis)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts window 3
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPjackson)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername2)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts window 4
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPjackson)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername2)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

#TEOCO Cruiser
start-process -FilePath "C:\Users\$CurrentUser\Desktop\Cruiser.lnk"
sleep 5
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 5
[System.Windows.Forms.SendKeys]::SendWait($Username)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait($Password)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 20

# Starts Outlook
Start-Process Outlook.exe
sleep 1

}

#If both, this runs
if ($SelectVersion -eq 3) {
# Starts window 1
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPmemphis)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts window 2
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPmemphis)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts window 3
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPjackson)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername2)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

# Starts window 4
Start-Process "C:\Program Files (x86)\teraterm\ttermpro.exe"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($IPjackson)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($TTusername2)
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
[System.Windows.Forms.SendKeys]::SendWait($TTpassword2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10

#TEOCO Cruiser
start-process -FilePath "C:\Users\$CurrentUser\Desktop\Cruiser.lnk"
sleep 5
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 5
[System.Windows.Forms.SendKeys]::SendWait($Username)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{TAB}')
sleep 1
[System.Windows.Forms.SendKeys]::SendWait($Password)
sleep 1
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 20

# Starts Secure CRT
Start-Process "C:\Users\$CurrentUser\AppData\Local\VanDyke Software\Clients\SecureCRT.exe"
sleep 5

Starts Fuji - commented out for testing
Start-Process "C:\Users\$CurrentUser\Desktop\Fuji Netsmart.exe"
sleep 10 
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 20





#Avaya login

Start-Process "C:\Users\Public\Desktop\Avaya one-X Agent.lnk"
sleep 10
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($AvayaPassword1)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10
[System.Windows.Forms.SendKeys]::SendWait($AvayaPassword2)
[System.Windows.Forms.SendKeys]::SendWait('{ENTER}')
sleep 10


# Starts Outlook
Start-Process Outlook.exe
sleep 1

}

#If user reports logins didn't complete successfully, clears the local login cache
$Reset = Read-Host "Did the logins complete successfully? If no, the script will reset to prepare for another first-time setup.(Y/N)"

if ($Reset -eq "N") {

Remove-Item -Path "C:\Users\$CurrentUser\AppData\Roaming\PowerShellScripts\StartUpScript" -Recurse -ErrorAction SilentlyContinue

}