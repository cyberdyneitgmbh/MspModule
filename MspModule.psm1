<#
        Description
#>
[CmdletBinding()]
$PublicFunction  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue ) # Public functions can be called by user after module import
$PrivateFunction = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue ) # Private functions can only be called internally in other functions in the module 

foreach ($Import in @($PublicFunction + $PrivateFunction))
{
    Write-Verbose "Importing $Import"
    try
    {
        . $Import.fullname
    }
    catch
    {
        throw "Could not import function $($Import.fullname): $_"
    }
}

Export-ModuleMember -Function $PublicFunction.Basename