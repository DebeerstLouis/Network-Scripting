Set-NetIPInterface -Dhcp Disabled -InterfaceIndex (Get-NetAdapter).InterfaceIndex
New-NetIPAddress -IPAddress 192.168.1.2 -DefaultGateway 192.168.1.1 -PrefixLength 24 -InterfaceIndex (Get-NetAdapter).InterfaceIndex

Set-DnsClientServerAddress -InterfaceAlias Ethernet0 -ServerAddresses ("172.20.4.140","172.20.4.141")