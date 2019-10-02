[CmdletBinding()]
param (
    # Resource group Name
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName,
    # Storage account name
    [Parameter(Mandatory=$true)]
    [string]
    $StorageAccountName,
    # Key vault name
    [Parameter(Mandatory=$true)]
    [string]
    $KeyVaultName
)

# Get storage account
$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -AccountName $StorageAccountName

# Get key vault
$keyVault = Get-AzKeyVault -VaultName $KeyVaultName

# Enable auditing
Set-AzDiagnosticSetting `
    -ResourceId $keyVault.ResourceId `
    -StorageAccountId $storageAccount.Id `
    -Enabled $true `
    -Category AuditEvent