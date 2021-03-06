param
(    
    [string] $Option = "deploy",
    [Parameter(Mandatory)]
    [string] $RGName
)

. .\variables.ps1
. .\utility.ps1

function Execute {
    If($option -eq "deploy") {
        Write-Output "Deploy Linux VM $VMName to Resource Group $RGName"
        Deploy $RGName
    }
    ElseIf($option -eq "encrypt") {
        Write-Output "Encrypt Linux VM $VMName in Resource Group $RGName"
        Encrypt $RGName
    } 
    ElseIf($option -eq "deploy-encrypt") {
        Write-Output "Deploy and Encrypt Linux VM $VMName in Resource Group $RGName"
        DeployAndEncrypt $RGName
    }
    ElseIf($option -eq "remove") {
        Write-Output "Remove Resource Group $RGName"
        RemoveRG $RGName
    }
    Else {
        Write-Output "Not supported! Supported option(deploy, encrypt, deploy-encrypt)" 
    }     
}

Execute