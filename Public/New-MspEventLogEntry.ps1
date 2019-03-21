<# 

.DESCRIPTION 
    Create an MspEventLog

#>

function New-MspEventLogEntry {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position = 0)]
        [int32]$ID,

        [parameter(Mandatory = $true, Position = 1)]
        [string]$Message,

        [parameter(Mandatory = $false)]
        [ValidateSet('Information','Error','Warning')]
        [string]$Type,

        [parameter(Mandatory = $false)]
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
        if (!$Source) {
            $Source = "RMM"
        }
        if (!$Logname) {
            $Logname = "MspEventLog"
        }
        if (!$Type) {
            $Type = "Information"
        }
    }            
    process {
        Write-Verbose "Erstelle Eventlog-Eintrag.."
        if ([System.Diagnostics.EventLog]::Exists($Logname)) {
            write-Verbose "$Logname existiert"
        } else {
            if (!$PSBoundParameters.ContainsKey('Verbose')) {
                New-MspEventLog $Logname $Source -Verbose | Out-Null
            } else {
                New-MspEventLog $Logname $Source | Out-Null
            }
        }
        try {
            Write-EventLog -LogName $Logname -Source $Source -EventId $ID -Message $Message -EntryType $Type -ErrorAction "stop"
            Write-Verbose "Eventlog-Eintrag wurde erstellt"
            $Entry = Get-WinEvent -FilterHashtable @{Logname = $Logname} -MaxEvents 1
        }
        catch {
            Write-Verbose "ERROR: Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
            Write-Verbose "ERROR: $($_.Exception.Message)"
            $Errorstate = $true
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        Write-Verbose "Abgeschlossen"
        if ($Errorstate) {
            Write-Error "Beim Erstellen des Eventlog-Eintrages ist ein Fehler aufgetreten. Nutzen Sie den Parameter '-Verbose' fuer mehr Informationen"
            return $null
        }
        return $Entry
    }
}

New-MspEventLogEntry -id 99 -Message "JD" -Source "RMM-Allgemein" -Verbose