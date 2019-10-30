[CmdletBinding()]
param (
    # Key vault name
    [Parameter(Mandatory = $true)]
    [string]
    $KeyVaultName
)

# Current user email id
$userId = (Get-AzContext).Account.Id

# Allow key vault to update secrets
Set-AzKeyVaultAccessPolicy `
    -VaultName $KeyVaultName `
    -UserPrincipalName $userId `
    -PermissionsToSecrets set `
    -PermissionsToStorage regeneratekey