<# 

.DESCRIPTION 
 MspModule-EventLog New-Functions (Create)

#> 

function New-MspEventLog {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $True, Position = 0)]
        [string]$Source,

        [parameter(Mandatory = $false)]
        [string]$ComputerName
    )

    begin {
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "stop"
        $Logname = "MspEvent"
    }

    process {
        if ([System.Diagnostics.EventLog]::Exists($Logname)) {
            Write-Verbose "+ $Logname vorhanden"
            Write-Verbose "+ Prüfe, ob Quelle $Source in $Logname vorhanden"
            if (!([System.Diagnostics.EventLog]::SourceExists($Source))) {
                try {
                    Write-Verbose "+ Erstelle neue Quelle $Source in $Logname"
                    New-EventLog -LogName $Logname -Source $Source
                    Write-Verbose "+ Eventlog $Logname wurde mit der Quelle $Source erstellt"
                }
                catch {
                    Write-Error "- Es ist ein Fehler bei der Erstellung des MspEventLogs aufgetreten"
                }
            }
            else {
                Write-Verbose "+ Quelle $Source in $Logname vorhanden"
            }
        }
        else {
            Write-Verbose "+ $Logname existiert nicht und wird mit der Quelle $Source neu erstellt."
            try {
                Write-Verbose "+ Erstelle neue Quelle $Source in $Logname"
                New-EventLog -LogName $Logname -Source $Source
                Write-Verbose "+ Eventlog $Logname wurde mit der Quelle $Source erstellt"
            }
            catch {
                Write-Error "- Es ist ein Fehler bei der Erstellung des MspEventLogs aufgetreten"
            }
        }
    }
        
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        Write-Verbose "+ Funktion New-MspEventLog beendet"
    }
    
}