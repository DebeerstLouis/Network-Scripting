$PC_Name = "DC2"

#Connecting to Remote on DC2
$s = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

Invoke-Command -Session $s -ScriptBlock  {
    $Domain = "intranet.mijnschool.be"

    Write-Host "Adding machine to domain $Domain"
    Add-Computer -DomainName $Domain -Restart
}