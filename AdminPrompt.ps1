﻿#A snippet I incorporated into several scripts at work which needed administrator privileges to run. It prompts for an admin login before running anything else in the script. 
 #Not created by me, yet I incorporated it into my own scripts
 #Originally sourced from: https://blog.expta.com/2017/03/how-to-self-elevate-powershell-script.html

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if([int]Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath Powershell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}
