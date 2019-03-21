<# 

.DESCRIPTION 
    Create an MspEventLog

#>

function New-MspEventLog {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false, Position = 0)]
        [string]$Logname,

        [parameter(Mandatory = $false, Position = 1)]
        [string[]]$Source
    )   
    begin {
        
        # Verbose parameter
        if ($PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.GetVariableValue('VerbosePreference')
        }
        
        # Erroraction preference
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference= 'silentlycontinue'
        
        # Errorflag
        $Errorstate = $false
        
        # Standard Sources
        $SSources = @("RMM", "RMM-Job", "RMM-Monitor")
        
        # Check for mspEventLog Accountvariable - if NOT exist: Set to TESTvar "MspEventLog"
        if (!($Logname)) {
            $Logname = "MspEventLog"
            Write-Verbose "Es ist kein Logname angegeben worden. Logname wird auf 'MspEventlog' gesetzt"
        }
        if (!$Source) {
            $Source = $SSources
        } else {
            foreach ($SSource in $SSources) {
                if (!($Source -match $SSource)) {
                    Write-Verbose "Standardquelle $SSource wird zu $Logname hinzugefügt"
                    $Source += $SSource
                }
            }
        }
        $FixedSources = New-Object "System.Collections.ArrayList"
        $Source | ForEach-Object {
            if ([System.Diagnostics.EventLog]::SourceExists($Source)) {
                Write-Verbose "Die Quelle $_ existiert bereits und wird aus $Logname entfernt"
            } else {
                $FixedSources.Add($_) | Out-Null
            }
        }
        $Source = $FixedSources
    }            
    process {
        Write-Verbose "Erstelle neues MspEventlog..."
        if ([System.Diagnostics.EventLog]::Exists($Logname)) {
            Write-Verbose "Es existiert bereits das Eventlog $Logname."
        } else {
            try {
                New-EventLog -LogName $Logname -Source $Source -ErrorAction "stop"
                Write-Verbose "Eventlog $Logname wurde erstellt"
                Limit-EventLog -LogName $Logname -MaximumSize 200MB
                Write-Verbose "Eventlog $Logname wurde auf 200MB vergrößert"
            }
            catch {
                Write-Verbose "ERROR: Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
                Write-Verbose "ERROR: $($_.Exception.Message)"
                $Errorstate = $true
            }
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        Write-Verbose "Abgeschlossen"
        if ($Errorstate) {
            return "Beim Erstellen des Eventlogs ist ein Fehler aufgetreten. Nutzen Sie den Parameter '-Verbose' für mehr Informationen"
        }
        return "Das Eventlog $Logname ist nun Verfügbar"
    }
}