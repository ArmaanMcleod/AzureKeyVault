[CmdletBinding()]
param (
    # Storage account name
    [Parameter(Mandatory = $true)]
    [string]
    $StorageAccountName,
    # Resource group name
    [Parameter(Mandatory = $true)]
    [string]
    $ResourceGroupName,
    # Location
    [Parameter(Mandatory = $true)]
    [string]
    $Location
)

# Create resource group
New-AzResourceGroup `
    -Location $Location `
    -Name $ResourceGroupName

# Create storage account
New-AzStorageAccount `
    -ResourceGroupName $ResourceGroupName `
    -Name $StorageAccountName `
    -Location $Location `
    -Kind StorageV2 `
    -AccessTier Hot `
    -SkuName Standard_GRS