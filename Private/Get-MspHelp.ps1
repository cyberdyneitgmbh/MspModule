<# 

.DESCRIPTION 
 MspModule-Function Help

#> 

function Get-MspHelp {
    [CmdletBinding()]
    param (
        [parameter(Mandatory = $true, Position=0)]
        [string]$FunctionName,

        [parameter(Mandatory = $true, Position=1)]
        [Object]$Parameters
    )
    $Type = $FunctionName.Substring($FunctionName.IndexOf("-")+1)
    $Verb = $FunctionName.SubString(0,$FunctionName.IndexOf("-"))

    Switch ($Verb) {

        'Get' { 
            $Synopsis = 'Über diese Methode kann ein Objekt des Typs {0} über das "MspModule" abgerufen werden. Alle benötigten Parameter werden markiert als benötigte Parameter um dich beim Programmieren zu unterstützen.' -F $Type
            $Description = 'Das Objekt {0} stellt verschiedene Parameter bereit, allerdings sind nicht alle nötig um ein neues Objekt zu erzeugen. Für mehr Informationen nutze Get-{0} | Format-List, um eine Liste der möglichen Parameter zu erhalten' -F $Type
            $Example = "Beispiel: {0}-{1} " -f $Verb, $Type
            $First = $Parameters | Select-Object -first 1
            foreach ($Parameter in $Parameters) {
                $Example += "<-$Parameter [Wert]> "
            }
            $Example += " Erhält ein neues {0}. Es wurden alle (möglichen) Parameter angegeben. Der Parameter {1} muss angegeben werden." -f $Type, $First

        }
        'New' { 
            $Synopsis = 'Diese Funktion erstellt eine neue {0} über das "MspModule". Alle benötigten Parameter werden markiert als benötigte Parameter um dich beim Programmieren zu unterstützen.' -F $Type
            $Description = 'Das Objekt {0} stellt verschiedene Parameter bereit, allerdings sind nicht alle nötig um ein neues Objekt zu erzeugen. Für mehr Informationen nutze Get-{0} | Format-List, um eine Liste der möglichen Parameter zu erhalten' -F $Type
            $Example = "Beispiel: {0}-{1} " -f $Verb, $Type
            $First = $Parameters | Select-Object -first 1
            foreach ($Parameter in $Parameters) {
                $Example += "<-$Parameter [Wert]> "
            }
            $Example += " erzeugt ein neues {0}. Es wurden alle Parameter angegeben. Der Parameter {1} muss angegeben werden." -f $Type, $First
        }
        'Set' { 
            $First = $Parameters | Select-Object -first 1
            $Synopsis = 'Diese Funktion setzt einen oder mehrere Werte eines {0} über das "MspModule". Alle angebenen Parameter werden bei einem bestimmten Objekt ersetzt. Der [Wert] {1} wird benötigt um das Objekt zu identifizieren. Alle benögtigen Parameter werden makiert, um dich beim Programmieren zu unterstützen.' -F $Type, $First
            $Description = 'Das Objekt {0} stellt verschiedene Parameter bereit, jeder dieser Parameter kann ersetzt werden. Bitte achte darauf, dass der [Wert] für {1} einmalig sein muss.' -F $Type, $First
            $Example = "Beispiel: {0}-{1} " -f $Verb, $Type
            foreach ($Parameter in $Parameters) {
                $Example += "<-$Parameter [Wert]> "
            }
            $Example += " setzt die Parameter für das eindeutige Objekt {0}. Es wurden alle Parameter angegeben. Mit dem Parameter {1} wird das Object identifiziert." -f $Type, $First
        }
    }
    return "<#

.SYNOPSIS
$Synopsis

.DESCRIPTION
$Description

.EXAMPLE
$Example

.NOTES
.Dieses Skript befindet sich noch in der Entwicklung

.LINK
https://github.com/cyberdyneitgmbh/MspModule

#>"

}

Get-MspHelp New-Test @('Name', 'Alter', 'Geschlecht')