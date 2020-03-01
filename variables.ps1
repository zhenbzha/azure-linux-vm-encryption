$templateFile = "template.json"
$templateParameterFile = "template.parameters.json"
$location = "North Europe"

$kvResourceGroupName = 'zhenzh-databricks-demo';
$VMName = 'vm1';
$keyVaultName = 'zhenzh-databricks-kv';
$keyVault = Get-AzKeyVault -VaultName $keyVaultName -ResourceGroupName $kvResourceGroupName;
$diskEncryptionKeyVaultUrl = $keyVault.VaultUri;
$keyVaultResourceId = $keyVault.ResourceId;