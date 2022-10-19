Set-NetIPInterface -Dhcp Disabled -InterfaceIndex (Get-NetAdapter).InterfaceIndex
New-NetIPAddress -IPAddress 192.168.1.3 -DefaultGateway 192.168.1.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

Set-DnsClientServerAddress -InterfaceAlias Ethernet0 -ServerAddresses ("192.168.1.2","192.182.1.3")