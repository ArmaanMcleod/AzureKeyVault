[CmdletBinding()]
param (
    # Key vault name
    [Parameter(Mandatory = $true)]
    [string]
    $KeyVaultName,
    # Resource group name
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,
    # Virtual machine name
    [Parameter(Mandatory = $true)]
    [string]
    $VMName,
    # Key name
    [Parameter(Mandatory = $true)]
    [string]
    $KeyName
)

# Retrieve Key vault
$keyVault = Get-AzKeyVault `
    -VaultName $KeyVaultName `
    -ResourceGroupName $ResourceGroupName

# Store key vault uri
$diskEncryptionKeyVaultUrl = $keyVault.VaultUri

# Store key vault resource id
$keyVaultResourceId = $keyVault.ResourceId

# Get encryted key url
$keyEncryptionKeyUrl = (
    Get-AzKeyVaultKey `
        -VaultName $KeyVaultName `
        -Name $KeyName `
).Key.Kid

# Encrypt virtual machine
Set-AzVMDiskEncryptionExtension `
    -ResourceGroupName $ResourceGroupName `
    -VMName $VMName `
    -DiskEncryptionKeyVaultUrl $diskEncryptionKeyVaultUrl `
    -DiskEncryptionKeyVaultId $keyVaultResourceId `
    -KeyEncryptionKeyUrl $keyEncryptionKeyUrl `
    -KeyEncryptionKeyVaultId $keyVaultResourceId