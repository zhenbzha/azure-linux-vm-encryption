function DeployAndEncrypt($ResourceGroupName) {
    Deploy $ResourceGroupName
    
    Write-Output "Wait for 1 min for VM provisioning to finish ..."
    Start-Sleep -s 60

    Encrypt $ResourceGroupName
}

function Deploy($ResourceGroupName) {
    New-AzResourceGroup `
        -Name $ResourceGroupName `
        -Location $location `
        -Force

    #Test-AzResourceGroupDeployment `
    New-AzResourceGroupDeployment `
        -ResourceGroupName $ResourceGroupName `
        -TemplateUri $templateUri `
        -TemplateParameterUri $templateParameterUri
}

function Encrypt($ResourceGroupName) {
    Set-AzVMDiskEncryptionExtension `
        -ResourceGroupName $ResourceGroupName `
        -VMName $VMName `
        -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl `
        -DiskEncryptionKeyVaultId $keyVaultResourceId `
        -SkipVmBackup `
        -VolumeType All `
        -EncryptFormatAll `
        -Force

    $start = Get-Date

    $prevText = ""
    DO
    {
        $text = Get-AzVmDiskEncryptionStatus -VMName $VMName -ResourceGroupName $ResourceGroupName | Out-String
        $finished = $text.Contains("Encryption succeeded for all volumes")
        if($prevText -ne $text) {
            Write-Output $text 
            $prevText = $text
        }    
    } while (-Not $finished)

    $end= Get-Date
    $diff= New-TimeSpan -Start $start -End $end
    Write-Output "Total encryption time: $diff"
}

function RemoveRG($ResourceGroupName) {
    Remove-AzResourceGroup `
        -Name $ResourceGroupName `
        -Force
}