<# 

.DESCRIPTION 
    Create a new EventLog Source

#>

function New-MspEventLogSource {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true)]
        [string]$Source,

        [parameter(Mandatory = $false)]
        [string]$Logname
    )   
    begin {
        if (!$PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.GetVariableValue('VerbosePreference')
        }
        # Erroraction preference
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "stop"
        # Check Logname and Source
        if (!$Logname) {
            $Logname = "MspEventLog"
        }
    }            
    process {
        Write-Verbose "Erstelle Eventlog-Eintrag.."
        if ([System.Diagnostics.EventLog]::Exists($Logname)) {
            write-Verbose "$Logname existiert"
            if (!$PSBoundParameters.ContainsKey('Verbose')) {
                try {
                    New-EventLog -LogName $Logname -Source $Source -Verbose
                }
                catch {
                    Write-Verbose "Fehler beim Erstellen der Eventlog Quelle"
                    Write-Verbose $_.Exception.Message
                    $Errorstate = $true
                }
            }
            else {
                try {
                    New-EventLog -LogName $Logname -Source $Source
                }
                catch {
                    Write-Verbose "Fehler beim Erstellen der Eventlog Quelle"
                    Write-Verbose $_.Exception.Message
                    $Errorstate = $true
                }
            }
        }
        else {
            write-Verbose "$Logname existiert nicht"
            Write-Verbose "Es is ein Fehler aufgetreten"
            Write-Verbose $_.Exception.Message
            $Errorstate = $true
        }
    }            
    end {
        Write-Verbose "Vorgang abgeschlossen"
        $ErrorActionPreference = $LastErrorActionPreference
        if ($Errorstate) {
            write-Error "Beim Erstellen der Eventlog-Quelle ist ein Fehler aufgetreten. Nutzen Sie den Parameter '-Verbose' fuer mehr Informationen"
            return $False
        }
        write-Verbose "Quelle '$($Source)' wurde im Eventlog '$($Logname)' hinzugefuegt"
        return $True
    }
}
