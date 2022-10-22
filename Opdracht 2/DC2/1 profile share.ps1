$Sesie_DC2 = New-PSSession -ComputerName "DC2" -Credential "INTRANET\Administrator"

Invoke-Command -Session $Sesie_DC2 -ScriptBlock {
    $Share_Name = "Profiles$"
    $Share_Path = "C:\Profiles"

    # dirictory maken die we willen
    mkdir $Share_Path

    # Full controll
    New-SmbShare -Name $Share_Name -path $Share_Path -FullAccess Everyone

    $acl = Get-ACL -Path $Share_Path

    # Disable inheritance
    $acl.SetAccessRuleProtection($True, $False)
    
    # Remove everyone from folder
    $acl.Access | %{$acl.RemoveAccessRule($_)}

    # Add administrators with full control
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)

    # Add system with full control
    $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM","FullControl","Allow")
    $acl.SetAccessRule($AccessRule)

    # Add Personeel Users and give them ReadAndExecute rights
    $AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Authenticated Users','modify','Allow')
    $acl.AddAccessRule($AccessRule)
    Set-Acl -Path $Share_Path -AclObject $acl
}