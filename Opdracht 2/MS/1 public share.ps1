$Name_DC2 = "DC2"
$Name_MS = "MS"

$Sesie_DC2 = New-PSSession -ComputerName $DC2 -Credential "INTRANET\Administrator"

Invoke-Command -Session $Sesie_DC2 -ScriptBlock {
    $File_Path = "\\DC1\netlogon\logon.bat"
    $Text_script = "net use P: \\MS\Public"

    # Bestaat Login script?
    if (Test-Path $File_Path){
        Write-Host "File exists, continuing ..."
    } 
    else {
        # stop het script
        Write-Host "ERROR file not found"
        Write-Host "    ----> Stopping the script"
        exit 1
    }

    # Add text to logon.bat
    $SEL = Select-String -Path $File_Path -Pattern $Text_script

    if ($SEL -ne $null)
        {
            Write-Host "Login.bat contains '$Text_script'"
        }
    else
        {
            Write-Host "Adding '$Text_script' to login.bat ..."
            Add-Content $File_Path "`nnet use P: \\MS\Public"
        }
}


$Sesie_MS = New-PSSession -ComputerName $Name_MS -Credential "INTRANET\Administrator"

Invoke-Command -Session $Sesie_MS -ScriptBlock {
        $Share_Name = "Public"
        $Share_Path = "C:\$Share_Name"

        # dirictory maken die we willen 
        mkdir $Share_Path
    
        # Full control
        New-SmbShare -Name $Share_Name -path $Share_Path -FullAccess Everyone
    
        $acl = Get-ACL -Path $Share_Path
    
        # Disable inheritance
        $acl.SetAccessRuleProtection($True, $False)
        
        # Remove everyone from folder
        $acl.Access | %{$acl.RemoveAccessRule($_)}
    
        # Adding groups to share with ntfs permissions
    
        # administrators with full control
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("BUILTIN\Administrators","FullControl","Allow")
        $acl.SetAccessRule($AccessRule)
    
        # system with full control
        $AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("NT AUTHORITY\SYSTEM","FullControl","Allow")
        $acl.SetAccessRule($AccessRule)
    
        # Personeel Users and give them ReadAndExecute rights
        $AccessRule = new-object system.security.AccessControl.FileSystemAccessRule('Personeel','modify','Allow')
        $acl.AddAccessRule($AccessRule)
    
        Set-Acl -Path $Share_Path -AclObject $acl
}