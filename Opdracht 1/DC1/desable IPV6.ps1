#Disable an Network Component on an network interface
Get-NetAdapterBinding

$InterfaceAlias = Read-Host "Enter InterfaceAlias (Name)"
$componentID = Read-Host "Enter componentID"

Disable-NetAdapterBinding –InterfaceAlias $InterfaceAlias –ComponentID $componentID