param
(    
    [string] $Option = "deploy",
    [string][Parameter(mandatory=$true)] $RGName,
    [string][Parameter(mandatory=$true)] $appId,
    [string][Parameter(mandatory=$true)] $secret,
    [string][Parameter(mandatory=$true)] $tenantId,
    [string][Parameter(mandatory=$true)] $subscriptionId,
    [string] $Environment = "AzureCloud"
)

$pscredential = New-Object System.Management.Automation.PSCredential($appId, (ConvertTo-SecureString $secret -AsPlainText -Force))

Connect-AzAccount -ServicePrincipal -Credential $pscredential -TenantId $tenantId -Subscription $subscriptionId -Environment $Environment -Verbose

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