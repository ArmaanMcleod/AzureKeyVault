[CmdletBinding()]
param (
    # Key vault name
    [Parameter(Mandatory = $true)]
    [string]
    $KeyVaultName,
    # Storage account name
    [Parameter(Mandatory = $true)]
    [string]
    $StorageAccountName,
    # Resource group name
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,
    # Regeneration period in datys
    [Parameter(Mandatory = $true)]
    [double]
    $RegenerationPeriod
)

# Public used key vault
$keyVaultSpAppId = "cfa8b339-82a2-471a-a3c9-0fc0be7a4093"

# Storage access key name
$storageAccountKey = "key1"

# Get your User Id
$userId = (Get-AzContext).Account.Id

# Get a reference to your Azure storage account
$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -StorageAccountName $StorageAccountName

# Assign RBAC role "Storage Account Key Operator Service Role" to Key Vault, limiting the access scope to your storage account. For a classic storage account, use "Classic Storage Account Key Operator Service Role." 
New-AzRoleAssignment `
    -ApplicationId $KeyVaultSpAppId `
    -RoleDefinitionName 'Storage Account Key Operator Service Role' `
    -Scope $StorageAccount.Id

# Give your user principal access to all storage account permissions, on your Key Vault instance
Set-AzKeyVaultAccessPolicy `
    -VaultName $KeyVaultName `
    -UserPrincipalName $userId `
    -PermissionsToStorage get, list, delete, set, update, regeneratekey, getsas, listsas, deletesas, setsas, recover, backup, restore, purge

# Add your storage account to your Key Vault's managed storage accounts
$regenPeriod = [System.Timespan]::FromDays($RegenerationPeriod)
Add-AzKeyVaultManagedStorageAccount `
    -VaultName $KeyVaultName `
    -AccountName $StorageAccountName `
    -AccountResourceId $StorageAccount.Id `
    -ActiveKeyName $StorageAccountKey `
    -RegenerationPeriod $regenPeriod