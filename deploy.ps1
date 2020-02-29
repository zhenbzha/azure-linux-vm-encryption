. .\variables.ps1

New-AzResourceGroup `
    -Name $VMResourceGroupName `
    -Location $location `
    -Force

#Test-AzResourceGroupDeployment `
New-AzResourceGroupDeployment `
    -ResourceGroupName $VMResourceGroupName `
    -TemplateFile $templateFile `
    -TemplateParameterFile $templateParameterFile