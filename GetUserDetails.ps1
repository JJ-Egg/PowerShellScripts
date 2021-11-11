#Creates a reusable prompt which gets last logon date of AD accounts based on input. Created to speed up checking on AD account status for work.

while($true){
    $username = Read-Host -Prompt "Enter a username"

    get-ADUser $username -properties lastlogondate, description
} 
