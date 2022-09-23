Write-Host "Create New Scope"
$ScopeName = Read-Host "New ScopeName"
$StartRange = Read-Host "Enter Start range"
$EndRange = Read-Host "Enter End range"
$SubnetMask = Read-Host "Enter SubnetMask"
Write-Host "Create ExclusionRange"
$ScopeID = Read-Host "Enter ScopeID"
$StartRangeEx = Read-Host "Enter Start range Exclude"
$StopRandeEX = Read-Host "Enter Ende range Exclude"

# Create New DHCP Scope
Add-DhcpServerv4Scope -name $ScopeName -StartRange $StartRange -EndRange $EndRange -SubnetMask $SubnetMask -State Active
Add-DhcpServerv4ExclusionRange -ScopeID $ScopeID -StartRange $StartRangeEx -EndRange $StopRandeEX
Set-DhcpServerv4OptionValue -OptionID 3 -Value 192.168.1.1 -ScopeID 192.168.1.0 -ComputerName DC1
Set-DhcpServerv4OptionValue -DnsDomain intranet.mijnschool.be -DnsServer 192.168.1.2
# DHCP reservation for Printer
Add-DhcpServerv4Reservation -ScopeId 192.168.1.0 -IPAddress 192.168.1.100 -ClientId "b8-e9-37-3e-55-86" -Description "Reservation for Printer"