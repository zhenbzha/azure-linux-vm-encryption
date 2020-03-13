$templateUri = "https://zhenzhupload.blob.core.windows.net/linux-vm-encryption/template.json?st=2020-03-13T13%3A19%3A42Z&se=2021-12-31T13%3A19%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=GEVIwKLy2SYAjuPcD7lWYnv8CkL8UoZ9oawMSWuwhls%3D"
$templateParameterUri = "https://zhenzhupload.blob.core.windows.net/linux-vm-encryption/template.parameters.json?st=2020-03-13T13%3A20%3A56Z&se=2021-12-31T13%3A20%3A00Z&sp=rl&sv=2018-03-28&sr=b&sig=difZABNlphSxSJiQeenxQXxPPBHcG9ffb6JggYyIFOw%3D"
$location = "North Europe"

$kvResourceGroupName = 'zhenzh-databricks-demo';
$VMName = 'vm1';
$keyVaultName = 'zhenzh-databricks-kv';
$keyVault = Get-AzKeyVault -VaultName $keyVaultName -ResourceGroupName $kvResourceGroupName;
$diskEncryptionKeyVaultUrl = $keyVault.VaultUri;
$keyVaultResourceId = $keyVault.ResourceId;