<# 

.DESCRIPTION 
 MspModule-Function Help

#> 

function Get-MspHelp {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false, Position = 0)]
        [ValidateSet("About_Msp_EventLog", "About_Msp_RMM", "About_Msp_Registry")]
        [string]$Command
    )
    if (!($PSBoundParameters.ContainsKey('Command'))) {
        $ShortDescription = "Zeigt Hilfe zum Windows-PowerShell-Modul MspModule an."
        $LongDescription = "Wenn Sie wissen moechten, wie man am besten mit dem MspModule arbeitet, finden sie hier die passenden Lösungen. 
Durch angabe von bestimmten Parametern können Sie so die alles rund um die verschiedenen Methoden erfahren."
        $Examples = "Nutzen Sie die die Funktion Get-MspHelp <String> um mehr über einen bestimmten Befehl zu erfahren:
    
    Get-MspHelp 'About_Msp_RMM'
    Get-MspHelp 'About_Msp_Eventlog'
    Get-MspHelp 'About_Msp_Registry'"   
        $Usage = "Das Modul dient als funktionale Erweiterung zu Datto RMM. Um richtig damit arbeiten zu können, sollten bestimmte Dinge vorbereitet sein:

1. Setzen der Accountvariablen. Um Skripte untereinander Austauschen zu können, müssen bestimmte Werte Standardisiert werden, dazu gehören:

    a) mspEventLog (Gibt den Logname an)
    b) mspRegistryName (Gibt den Regkey Namen an unter HKLM:SOFTWARE\mspRegistryName)
    c) mspDirPath (Gibt den Pfad an, der Lokal erstellt wird, um Logfiles zu hinterlegen.)
    d) mspPSAAPI (Account mit PSA API Zugang)
    e) mspPSAAPIPW (Passwort zum Account mit PSA API Zugang)
    f) mspCompany (Name des MSP´s)"
        return "<#

.THEMA
GET-MSPHELP

.KURZBESCHREIBUNG
$ShortDescription

.DETAILBESCHREIBUNG
$LongDescription

.BEISPIELE
$Examples

.BENUTZUNG
$Usage

.LINK
https://github.com/cyberdyneitgmbh/MspModule

#>"

    }
    Switch ($Command) {

        'About_Msp_EventLog' { 
            $Theme = "About_Msp_EventLog"
            $ShortDescription = "Zeigt Hilfe zum Arbeiten mit Eventlogs in RMM an."
            $LongDescription = "Das nutzen von Eventlogs hat viele Vorteile beim arbeiten mit RMM. Verschiedene Informationen können so leichter erfasst und sind später Nachvollziehbar!
So kann einfach jeder Job vor abschließen einen Eintrag erstellen. Und so einen Fingerabdruck hinterlegen. Durch Verschiedene ID´s können diese im Nachhinein gefiltet und auffindbar gemacht werden."
            $Examples = "Die Nutzung dieser Methode ist einfach! Die Parameter [-Source] und [-EventID] müssen angegeben werden. Der Rest ist Optional und wird sonst mit Standardwerten befüllt.

    Write-MspEventLog [-Source] <string[]> [[-EventID] <int32>] [-Description] <string> [-EntryType] <string>

    - EntryType kann nur aus bestimmten Strings bestehen. Diese geben an, welchen Typ der Eintrag im EventLog hat.
    - Valide Eingaben sind: 'Error','FailureAudit','SuccessAudit','Warning','Information' [Standard bei nicht Angabe]"
            $Usage = "Es ist nicht viel Nötig um einen Eventlog Eintrag zu erstellen. Will man einfach die Information haben, dass ein Skript durchgelaufen ist, könnte die Nutzung wie folgt aussehen:

    Write-MspEventLog 'Name_Des_Jobs' 99 -> Dieser Befehl erstellt einen Eventlog Eintrag im definierten EventLogNamen (RMM-AccountVariable) des MSP vom Typ 'Information' und ID 99"
        }
        'About_Msp_RMM' {
            $Theme = "About_Msp_RMM"
            $ShortDescription = "Noch in Entwicklung"
            $LongDescription = "Noch in Entwicklung"
            $Examples = "Noch in Entwicklung"
        }
        'About_Msp_Registry' {
            $Theme = "About_Msp_Registry"
            $ShortDescription = "Noch in Entwicklung"
            $LongDescription = "Noch in Entwicklung"
            $Examples = "Noch in Entwicklung"
        }
    }
    return "<#

.THEMA:
$Theme

.KURZBESCHREIBUNG
$ShortDescription

.DETAILBESCHREIBUNG
$LongDescription

.BEISPIELE
$Examples

.BENUTZUNG
$Usage

.LINK
https://github.com/cyberdyneitgmbh/MspModule

#>"

}

Get-MspHelp About_Msp_EventLog