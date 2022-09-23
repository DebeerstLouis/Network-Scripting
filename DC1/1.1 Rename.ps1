$new_hostname = Read-Host "New name"

Rename-Computer -NewName $new_hostname -Restart -Confirm:$false