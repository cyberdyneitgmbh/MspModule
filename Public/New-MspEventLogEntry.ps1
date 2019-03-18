<# 

.DESCRIPTION 
    Create an MspEventLog

#>

function New-MspEventLogEntry {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false, Position = 0)]
        [string]$Logname
    )   
    begin {
        if ($PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.GetVariableValue('VerbosePreference')
        }
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "stop"
        
    }            
    process {
        
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        
    }
}