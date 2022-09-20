$item=get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name "fDenyTsConnections" 
if ($item.fDenyTsconnections)
{
    write-host "Enable RDP "
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name  "fDenyTsConnections" -Value 0
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"
}
else
{
    write-host "Enable RDP "
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server" -Name  "fDenyTsConnections" -Value 1
    Disable-NetFirewallRule -DisplayGroup "Remote Desktop"
}