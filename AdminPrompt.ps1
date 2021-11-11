﻿#A snippet I incorporated into several scripts at work which needed administrator privileges to run. It prompts for an admin login before running anything else in the script. 

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
    if([int]Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -FilePath Powershell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
    }
}