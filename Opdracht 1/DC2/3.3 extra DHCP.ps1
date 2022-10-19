$PC_Name = "DC2"

#remote connection to DC2
$s = New-PSSession -ComputerName $PC_Name -Credential "INTRANET\Administrator" 

Invoke-Command -Session $s -ScriptBlock {
    # Variables
    $PrimaryDHCPServer = "DC1.intranet.mijnschool.be"
    $DNS_Name2 = "DC2.intranet.mijnschool.be"
    $Scope = "192.168.1.0"
    $Password = "P@ssw0rd"

    $IP_Type = "IPV4"
    $IP_Int_Alias = "Ethernet0"

    $IP_Address = (Get-NetIPAddress -AddressFamily $IP_Type -InterfaceAlias $IP_Int_Alias).IPAddress

    # Configuring the DHCP Server on Dc2
    Add-DhcpServerInDC -IPAddress $IP_Address -DnsName $DNS_Name2 

    # Creating a Failover to the DHCP Server on DC1
    Add-DhcpServerv4Failover -ComputerName $PrimaryDHCPServer -Name "SFO-SIN-Failover" -PartnerServer $DNS_Name2 -ScopeId $Scope -SharedSecret $Password
}