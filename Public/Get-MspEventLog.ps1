<# 

.DESCRIPTION 
 MspModule-EventLog Get-Functions

#> 

function Get-MspEventLog {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [String]$Name
    )
    if ($Name -like "Msp-GetHelp") {
        write-host "Help"
    } else {
        write-host "no Help"
    }
    write-host "Get-MspEventLog wurde aufgerufen"
}
