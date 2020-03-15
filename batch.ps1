param
(
    [string] $Option = "batch-deploy",    
    [string][Parameter(mandatory=$true)] $NumOfRG
)

$RGs = 1..$NumOfRG | ForEach-Object {
    $RGBaseNaem = "linux-vm-encryption"
    "$RGBaseNaem-$_"    
}

function Execute {

    If($option -eq "batch-deploy") {
        Write-Output "Deploy Linux VM to $NumOfRG Resource Groups"
        
        $RGs | ForEach-Object -ThrottleLimit 3 -Parallel {
            $TimeStamp = (Get-Date).ToString("yyyy-MM-dd-HH-mm")
            $LogFile = ".\logs\$TimeStamp.$_.deploy.log"

            Invoke-Expression ".\vm-mgmt.ps1 -Option deploy-encrypt -RGName $_ > $LogFile"
        }
    }
    ElseIf($option -eq "batch-remove") {
        Write-Output "Clean all RG"
        $RGs | ForEach-Object -ThrottleLimit 3 -Parallel {
            $TimeStamp = (Get-Date).ToString("yyyy-MM-dd-HH-mm")
            $LogFile = ".\logs\$TimeStamp.$_.remove.log"    
            Invoke-Expression ".\vm-mgmt.ps1 -Option remove -RGName $_ > $LogFile"
        }        
    }
    ElseIf($option -eq "batch-test") {
        Write-Output "Create RG with VMs and remove afterwards"
        $RGs | ForEach-Object -ThrottleLimit 3 -Parallel {
            $TimeStamp = (Get-Date).ToString("yyyy-MM-dd-HH-mm")            
            $LogFile = ".\logs\$TimeStamp-" + $_ + ".test.log"

            Invoke-Expression ".\vm-mgmt.ps1 -Option deploy-encrypt -RGName $_ >> $LogFile"
            Invoke-Expression ".\vm-mgmt.ps1 -Option remove -RGName $_ >> $LogFile"
        }        
    }    
    Else {
        Write-Output "Not supported! Supported option(deploy, encrypt, deploy-encrypt)" 
    }
}

Execute