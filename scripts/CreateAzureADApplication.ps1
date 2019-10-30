[CmdletBinding()]
param (
    # App display name
    [Parameter(Mandatory = $true)]
    [string]
    $DisplayName,
    # Application uri
    [Parameter(Mandatory = $true)]
    [string]
    $ApplicationUri
)

# Create basic AzureAD application
New-AzADApplication `
    -DisplayName $DisplayName `
    -IdentifierUris $ApplicationUri