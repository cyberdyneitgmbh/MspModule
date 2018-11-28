<#PSScriptInfo

.VERSION 0.0

.GUID 1888c68a-d20f-4f84-9826-0c0b63a38d61

.AUTHOR durry@cyberdyne.de

.COMPANYNAME CYBERDYNE IT GmbH

.RELEASENOTES

#>

<# 

.DESCRIPTION 
 MspModule-Help Text

#> 

Function Get-MspHelp {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]$CalledFunction
    )
    Begin { 
        write-host "Starting"
    }
    Process { 
        write-host "processing" $_ for $CalledFunction
    }
    End {
        write-host "Ending"
    }

}
