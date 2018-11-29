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
