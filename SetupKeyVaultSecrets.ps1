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

# Fetch storage account keys
$storageAccountKey = Get-AzStorageAccountKey `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName

# Get primary and secondary key names and values
$primaryKeyName = $storageAccountKey.KeyName[0]
$primaryKeyValue = $storageAccountKey.Value[0]

$SecondaryKeyName = $storageAccountKey.KeyName[1]
$SecondaryKeyValue = $storageAccountKey.Value[1]

# Convert keys to secure strings
$primaryKeyValueSecret = ConvertTo-SecureString $primaryKeyValue -AsPlainText -Force
$secondaryKeyValueSecret = ConvertTo-SecureString $SecondaryKeyValue -AsPlainText -Force

# Insert primary and secondary secure keys into key vault
Set-AzKeyVaultSecret `
    -VaultName $KeyVaultName `
    -Name $primaryKeyName `
    -SecretValue $primaryKeyValueSecret

Set-AzKeyVaultSecret `
    -VaultName $KeyVaultName `
    -Name $secondaryKeyName `
    -SecretValue $secondaryKeyValueSecret
