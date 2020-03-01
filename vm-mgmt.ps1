param
(    
    [string] $Option = "deploy",
    [Parameter(Mandatory)]
    [string] $ResourceGroupName
)

. .\variables.ps1
. .\utility.ps1

function Execute {
    If($option -eq "deploy") {
        Write-Output "Deploy Linux VM $VMName to RG $ResourceGroupName"
        Deploy
    }
    ElseIf($option -eq "encrypt") {
        Write-Output "Encrypt Linux VM $VMName in RG $ResourceGroupName"
        Encrypt
    } 
    ElseIf($option -eq "deploy-encrypt") {
        Write-Output "Deploy and Encrypt Linux VM $VMName in RG $ResourceGroupName"
        DeployAndEncrypt
    }
    Else {
        Write-Output "Not supported! Supported option(deploy, encrypt, deploy-encrypt)" 
    }     
}

Execute