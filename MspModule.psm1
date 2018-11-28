<#
        Description
        Imports every public and private script 
#>
[CmdletBinding()]
$PublicFunction  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$PrivateFunction = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )

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