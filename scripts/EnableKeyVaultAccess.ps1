[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]
    $StorageAccountName,
    # Application Id
    [Parameter(Mandatory = $true)]
    [string]
    $ApplicationId,
    # Resource group name
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName
)

# Get storage account
$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName

New-AzRoleAssignment `
    -ApplicationId $ApplicationId `
    -RoleDefinitionName 'Storage Account Key Operator Service Role' `
    -Scope $storageAccount.Id