<# 

.DESCRIPTION 
 MspModule-EventLog Get-Functions

#> 

function Get-MspEventLog {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false)]
        [string]$Logname,

        [parameter(Mandatory = $false)]
        [string[]]$Source,

        [parameter(Mandatory = $false)]
        [ValidateSet('Information', 'Error', 'Warning')]
        [string[]]$Type,

        [parameter(Mandatory = $false)]
        [int32[]]$ID
    )   
    begin {
        if (!$PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.GetVariableValue('VerbosePreference')
        }
        # Erroraction preference
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "stop"
        # LevelVariables
        $InformationLevel = 4
        $WarningLevel = 3
        $ErrorLevel = 2
        # Check Logname and Source - Prepare the Information for the request
        if (!$Logname) {
            $Logname = "MspEventLog"
        }
        if (!$Source) {
            $Source = @("RMM", "RMM-Job", "RMM-Monitor")
        }
        if (!$Type) {
            $Level = @($InformationLevel, $WarningLevel, $ErrorLevel)
        }
        else {
            Write-Verbose "Überprüfen der Typ-Variablen"
            $Level = @()
            $Type | ForEach-Object {
                switch ($_) {
                    "Information" { 
                        $Level += $InformationLevel   
                    }
                    "Warning" { 
                        $Level += $WarningLevel
                    }
                    "Error" { 
                        $Level += $ErrorLevel
                    }
                }
            }
        }
        # Add ID to String or not
        if (!$ID) {
            $FilterString = @{
                Logname         = $Logname
                ProviderName    = $Source
                Level           = $Level
            }
        } else {
            $FilterString = @{
                Logname         = $Logname
                ProviderName    = $Source
                Level           = $Level
                ID             = $ID
            }
        }
    }            
    process {
        Write-Verbose "Sammel Eventlog-Informationen.."
        if ([System.Diagnostics.EventLog]::Exists($Logname)) {
            write-Verbose "$Logname existiert"
            $EventLog = Get-WinEvent -FilterHashtable $FilterString
        }
        else {
            $Errorstate = $true
            if (!$PSBoundParameters.ContainsKey('Verbose')) {
                write-Verbose "$Logname existiert nicht"
                Write-Error "Das Eventlog ist nicht vorhanden"
            }
            else {
                Write-Error "Das Eventlog ist nicht vorhanden"
            }
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        Write-Verbose "Vorgang abgeschlossen"
        if ($Errorstate) {
            Write-Error "Beim Abrufen des Eventlogs ist ein Fehler aufgetreten. Nutzen Sie den Parameter '-Verbose' für mehr Informationen"
            return $null
        }
        return $EventLog
    }
}
