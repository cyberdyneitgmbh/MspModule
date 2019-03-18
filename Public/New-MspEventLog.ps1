<# 

.DESCRIPTION 
    Create an MspEventLog

#>

function New-MspEventLog {
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
        # Check for mspEventLog Accountvariable - if NOT exist: Set to TESTvar "MspEventLog"
        if (!($Logname)) {
            $Logname = "MspEventLog"
            Write-Verbose "Es ist keine Accountvariable für das MspEventlog angelegt"
        }
    }            
    process {
        Write-Verbose "+ Erstelle neues MspEventlog"
        try {
            New-EventLog -LogName $Logname
            Write-Verbose "+ Eventlog $Logname wurde erstellt"
        }
        catch {
            Write-Verbose "ERROR: Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
            Write-Verbose "ERROR: $($_.Exception.Message)"
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        Write-Verbose "+ Beende Funktion New-MspEventLog"
    }
}