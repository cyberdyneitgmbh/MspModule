<# 

.DESCRIPTION 
 MspModule-Function Help

#> 

function Get-MspHelp {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $false, Position = 0)]
        [ValidateSet("About_Msp_EventLog")]
        [string]$Command
    )
    if (!($PSBoundParameters.ContainsKey('Command'))) {
        $ShortDescription = "Zeigt Hilfe zum Windows-PowerShell-Modul MspModule an."
        $LongDescription = "Wenn Sie wissen moechten, wie man am besten mit dem MspModule arbeitet, finden sie hier die passenden Lösungen. 
Durch angabe von bestimmten Parametern können Sie so die alles rund um die verschiedenen Methoden erfahren."
        $Examples = "Nutzen Sie die die Funktion Get-Help mit dem Parameter <-Command-> [string], um mehr über einen bestimmten Befehl zu erfahren:`n
Parameter für Command können sein:
About_Msp_Eventlog
Durch Eingabe von 'Get-Help About_Msp_Eventlog' finden sie alles rund um das Thema EventLogs mit RMM!"   
        return "<#

.THEMA:
GET-MSPHELP

.KURZBESCHREIBUNG
$ShortDescription

.DETAILBESCHREIBUNG
$LongDescription

.BEISPIELE
$Examples

.LINK
https://github.com/cyberdyneitgmbh/MspModule

#>"

    }
    Switch ($Command) {

        'About_Msp_EventLog' { 
            $ShortDescription = "Noch in Entwicklung."
            $LongDescription = "Noch in Entwicklung"
            $Examples = "Noch in Entwicklung"
        }
    }
    return "<#

.THEMA:
About_Msp_EventLog

.KURZBESCHREIBUNG
$ShortDescription

.DETAILBESCHREIBUNG
$LongDescription

.BEISPIELE
$Examples

.LINK
https://github.com/cyberdyneitgmbh/MspModule

#>"

}