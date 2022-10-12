$groups = Import-Csv -Path 'C:\Users\Administrator\Documents\Groups.csv' -Delimiter(';')
$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

foreach($item in $groups)
{
    $name = $item.Name
    New-ADGroup -Name $item.Name -GroupCategory $item.GroupCategory -GroupScope $item.GroupScope -DisplayName $item.DisplayName -Path $item.Path -Description $item.Description
    Write-Host "$name was added"
}