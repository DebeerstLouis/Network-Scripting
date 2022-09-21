Install-WindowsFeature -Name AD-Domain-Services -ComputerName DC1 -IncludeManagementTools
Install-WindowsFeature -Name dns -ComputerName DC1 -IncludeManagementTools
Install-WindowsFeature -Name dhcp -ComputerName DC1 -IncludeManagementTools -Restart
