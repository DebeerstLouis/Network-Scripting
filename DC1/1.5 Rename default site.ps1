# Change Default-First-Site-Name
Write-Host "Change Name of Default-First-Site"
$Sitename = read-host "Enter new site name to replace Default-First-Site"
$configNCDN = (Get-ADRootDSE).ConfigurationNamingContext
$siteContainerDN = ("CN=Sites," + $configNCDN)
$siteDN = "CN=Default-First-Site-Name," + $siteContainerDN
Get-ADObject -Identity $siteDN | Rename-ADObject -NewName:$sitename


#https://pixelrobots.co.uk/2016/11/step-by-step-guide-to-setting-up-an-active-directory-forest-and-adding-additional-dcs-on-windows-2016-with-powershell/