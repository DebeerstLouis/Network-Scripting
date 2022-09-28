#
# ADD 1 user 
#
New-ADUser -Name Rozemieke -AccountPassword (ConvertTo-SecureString "P@ssword" -AsplainText -Force) -DisplayName Rozemieke -GivenName Rozemieke -HomeDirectory \\ms\homedirs\%username% -HomeDrive H: -PasswordNeverExpires $true -Path "OU=Secretariaat,OU=Mijn school,DC=intranet,DC=mijnschool,DC=be" -SamAccountName Rozemieke -ScriptPath login.bat -Enabled $true
#
# parameters veranderen!
#