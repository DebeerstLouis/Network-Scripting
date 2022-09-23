# Create New DHCP Scope
Add-DhcpServerv4Scope -name "Scope1" -StartRange 192.168.1.1 -EndRange 192.168.1.254 -SubnetMask 255.255.255.0 -State Active
Add-DhcpServerv4ExclusionRange -ScopeID 192.168.1.0 -StartRange 192.168.1.2 -EndRange 192.168.1.10
Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.1.1 -ScopeID 192.168.1.0 -ComputerName DC1
Set-DhcpServerv4OptionValue -DnsDomain intranet.mijnschool.be -DnsServer 192.168.1.2
# DHCP reservation for Printer
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.100 -ClientId "b8-e9-37-3e-55-86" -Description "Reservation for Printer"