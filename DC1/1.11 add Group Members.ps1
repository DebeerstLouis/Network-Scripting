$groups = Import-Csv -Path 'C:\Users\Administrator\Documents\GroupMembers.csv' -Delimiter(';')
$Secure_String_Pwd = ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force

foreach($item in $groups)
{
    $name = $item.Member
    Add-ADGroupMember -Members $item.Member -Identity $item.Identity
    Write-Host "$name was added"
}