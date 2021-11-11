#Created to test network connectivity at work; will clear the cache in IE and chrome, and open several webpages through them to test, closing after leaving the pages open a bit for the user to verify functionality.

Add-Type -AssemblyName System.Windows.Forms

#Deletes IE Cache
Remove-Item -path "C:\Users\$env:USERNAME\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue -Verbose
Remove-Item -path "C:\Users\$env:USERNAME\AppData\Local\Microsoft\Windows\INetCache\*" -Recurse -Force -EA SilentlyContinue -Verbose
Write-Host -ForegroundColor Green "IE Cache Cleared"
Start-Sleep -s 1

#Deletes Google Chrome Cache
Remove-Item -path "C:\Users\$env:USERNAME\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose
Write-Host -ForegroundColor Green "Chrome Cache Cleared"
Start-Sleep -s 1

Write-Host -ForegroundColor Blue "Starting Website Connectivity Test..."
Start-Sleep -s 1

#Starts IE - 2 webpages - displays and closes sequentially 
Start-Process iexplore "https://www.cnn.com/"
Start-Sleep -s 30
Get-Process iexplore | Stop-Process


Start-Process iexplore "https://www.justice.gov/jmd/learndoj"
Start-Sleep -s 15
Get-Process iexplore | Stop-Process


#Starts Google Chrome - 2 tabs with different websites - closes
Start-Process chrome "https://dojnet.doj.gov/" , "https://www.cnn.com/" 
Start-Sleep -s 30
Get-Process chrome | Stop-Process 
