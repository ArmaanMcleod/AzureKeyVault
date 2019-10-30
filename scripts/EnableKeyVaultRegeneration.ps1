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
    [int]
    $RegenerationPeriod
)

# Get storage account
$storageAccount = Get-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName

# Get storage account keys
$storageAccountKey = Get-AzStorageAccountKey `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName

$regenPeriod = [System.Timespan]::FromDays($RegenerationPeriod)

# Add regeneration period of key
Add-AzKeyVaultManagedStorageAccount `
    -VaultName $KeyVaultName `
    -AccountName $StorageAccountName `
    -AccountResourceId $storageAccount.Id `
    -ActiveKeyName $storageAccountKey.KeyName[0] `
    -RegenerationPeriod $regenPeriod