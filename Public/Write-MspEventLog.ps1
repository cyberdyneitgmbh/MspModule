<# 

.DESCRIPTION 
 MspModule-Registry Set-Functions, e.g. Write-MspEventLog "Komponentenname" 0

#>

function Write-MspEventLog {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $True, Position = 0)]
        [string]$Source,

        [parameter(Mandatory = $True, Position = 1)]
        [int32]$EventID,

        [parameter(Mandatory = $false)]
        [string]$Description,

        [parameter(Mandatory = $false)]
        [string]$EntryType,

        [parameter(Mandatory = $false)]
        [string]$ResourceFile
    )            
    begin {
        Write-Verbose "+ Prüfe, ob EventLog MspEvent existiert"
        if ([System.Diagnostics.EventLog]::Exists('MspEvent')) {
            Write-Verbose "+ MspEvent vorhanden"
            Write-Verbose "+ Prüfe, ob Quelle $Source in MspEvent vorhanden"
            if (!([System.Diagnostics.EventLog]::SourceExists($Source))) {
                try {
                    Write-Verbose "+ Erstelle neue Quelle $Source in MspEvent"
                    New-EventLog -Source $Source -LogName "MspEvent"
                }
                catch {
                    Write-Verbose "+ Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
                    Write-Verbose $_.Exception.Message
                    Write-Error "+ Fehler: "
                    Write-Error $_.Exception.Message
                }
            }
            else {
                Write-Verbose "+ Quelle $Source in MspEvent vorhanden"
            }
        }
        else {
            Write-Verbose "+ MspEvent existiert nicht und wird mit der Quelle $Source neu erstellt."
            try {
                New-EventLog -Source $Source -LogName "MspEvent"
            }
            catch {
                Write-Verbose "+ Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
                Write-Verbose $_.Exception.Message
                Write-Error "+ Fehler: "
                Write-Error $_.Exception.Message
            }
        }
        if (!([ValidateNotNullOrEmpty()]$Description)) {
            $Description = "Es wurde ein Event durch das Msp-Modul ausgelöst"
        }
        if (!([ValidateNotNullOrEmpty()]$EntryType)) {
            $EntryType = "Information"
        }
        if (!([ValidateNotNullOrEmpty()]$Message)) {
            $Message = "Es wurde ein Event durch das Msp-Modul ausgelöst"
        }
        if (!([ValidateNotNullOrEmpty()]$MessageResourceFile)) {
            $MessageResourceFile = "C:\Program Files\WindowsPowerShell\Modules\MspModule\Public\Write-MspEventLog.ps1"
        }
    }            
    process {
        Write-Verbose "+ Schreibe neuen MspEventLog Eintrag"
        try {
            Write-EventLog -Source $Source -LogName "MspEvent" -Message $Description -EventId 0 -EntryType $EntryType
        }
        catch {
            Write-Verbose "+ Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
            Write-Verbose $_.Exception.Message
            Write-Error "+ Fehler: "
            Write-Error $_.Exception.Message
        }
    }            
    end {
        Write-Verbose "+ Es wurde erfolgreich in das MspEventLog geschrieben"
    }
}
