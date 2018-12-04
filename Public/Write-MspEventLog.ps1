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

        [parameter(Mandatory = $false, Position = 3)]
        [ValidateSet("Error","FailureAudit","SuccessAudit","Warning","Information")]
        [AllowEmptyString()]
        [AllowNull()] 
        [string]$EntryType,

        [parameter(Mandatory = $false)]
        [string]$Description,

        [parameter(Mandatory = $false)]
        [string]$ResourceFile

    )   
    begin {
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "stop"
        $Logname = "MspEvent" 
        if (!($Description)) {
            $Description = "Es wurde ein Event durch das Msp-Modul ausgelöst"
        }
        if (!($EntryType)) {
            $EntryType = "Information"
        }
        if (!($Message)) {
            $Message = "Es wurde ein Event durch das Msp-Modul ausgelöst"
        }
        if (!($MessageResourceFile)) {
            $MessageResourceFile = "C:\Program Files\WindowsPowerShell\Modules\MspModule\Public\Write-MspEventLog.ps1"
        }
        Write-Verbose "+ Prüfe, ob EventLog $Logname mit Quelle $Source existiert"
        New-MspEventLog -Source $Source
    }            
    process {
        Write-Verbose "+ Schreibe neuen MspEventLog Eintrag"
        try {
            Write-EventLog -LogName $Logname -Source $Source -Message $Description -EventId $EventID -EntryType $EntryType
            Write-Verbose "+ Es wurde ein neuer Eventlog Eintrag in $Logname mit Quelle $Source und ID $EventID erstellt"
        }
        catch {
            Write-Error "- Es ist ein Fehler bei der Erstellung eines MspEventLog-Eintrages aufgetreten"
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        Write-Verbose "+ Beende Funktion Write-MspEventLog"
    }
}