[CmdletBinding()]
param (
    # Resource group Name
    [Parameter(Mandatory=$true)]
    [string]
    $ResourceGroupName,
    # Key vault name
    [Parameter(Mandatory=$true)]
    [string]
    $KeyVaultName,
    # Location
    [Parameter(Mandatory=$true)]
    [string]
    $Location
)

# Register Microsoft.KeyVault resource provider
Register-AzResourceProvider -ProviderNamespace "Microsoft.KeyVault"

# Create resource group
New-AzResourceGroup `
    -Location $Location `
    -Name $ResourceGroupName

# Create Key vault with disk encryption
New-AzKeyVault `
    -Location $Location `
    -ResourceGroupName $ResourceGroupName `
    -VaultName $KeyVaultName `
    -EnabledForDiskEncryption