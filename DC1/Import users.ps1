$users = Import-Csv -Path 'C:\Users\Administrator\Documents\UserAccounts.csv' -Delimiter(';')
$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

foreach($item in $users)
{
    $name = $item.Name
    New-ADUser -Name $item.Name -SamAccountName $item.SamAccountName -GivenName $item.GivenName -Surname $item.Surname -DisplayName $item.DisplayName -AccountPassword $Secure_String_Pwd -HomeDrive $item.HomeDrive -HomeDirectory $item.HomeDirectory -ScriptPath $item.ScriptPath -Path $item.Path -PasswordNeverExpires $true -Enabled $true
    Write-Host "$name was added"
}