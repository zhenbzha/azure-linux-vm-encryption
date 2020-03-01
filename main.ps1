invoke-expression -Command .\deploy.ps1


Write-Output "Wait for 5 min for VM provisioning to finish ..."
Start-Sleep -s 300

invoke-expression -Command .\encrypt.ps1