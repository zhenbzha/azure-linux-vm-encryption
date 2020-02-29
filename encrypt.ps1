. .\variables.ps1

Set-AzVMDiskEncryptionExtension `
    -ResourceGroupName $VMResourceGroupName `
    -VMName $VMName `
    -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl `
    -DiskEncryptionKeyVaultId $keyVaultResourceId `
    -SkipVmBackup -VolumeType All -EncryptFormatAll `
    -Force

$start = Get-Date

$prevText = ""
DO
{
    $text = Get-AzVmDiskEncryptionStatus -VMName $VMName -ResourceGroupName $VMResourceGroupName | Out-String
    $finished = $text.Contains("Encryption succeeded for all volumes")
    if($prevText -ne $text) {
        Write-Output $text 
        $prevText = $text
    }    
} while (-Not $finished)

$end= Get-Date
$diff= New-TimeSpan -Start $start -End $end
Write-Output "Total encryption time: $diff"
