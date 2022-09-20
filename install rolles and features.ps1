Install-WindowsFeature -Name AD-Domain-Services -ComputerName DC1 -Restart
Install-WindowsFeature -Name dns -ComputerName DC1 -Restart
Install-WindowsFeature -Name dhcp server -ComputerName DC1 -Restart
