<# 

.DESCRIPTION 
    Connect to PSA Api

#>
function Connect-ToPsaApi {
    param 
    (
        [parameter(Mandatory = $true, Position = 0)]
        [string]$Key,

        [parameter(Mandatory = $true, Position = 1)]
        [string]$PW
    )
    begin {
        if (!$PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.GetVariableValue('VerbosePreference')
        }
        # Erroraction preference
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = "stop"

        # Import Autotask Module
        write-verbose "Importing Autotask Module..."
        if (Get-Module -ListAvailable -Name Autotask) {
            Import-Module Autotask
        } 
        else {
            write-host "Installing Autotask Module"
            Install-Module Autotask -Confirm $false
            Import-Module Autotask
        }
        write-verbose "Autotask imported.."

        # - Ignore SSL Errors
        [System.Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
        $OutputEncoding = [System.Text.Encoding]::Unicode
    
        # - Only Use TLSv1.1 and TLS1.2
        $AllProtocols = [System.Net.SecurityProtocolType]'Tls11,Tls12'
        [System.Net.ServicePointManager]::SecurityProtocol = $AllProtocols
        
        # Create Credential
        $APIPw = ConvertTo-SecureString -String $PW -AsPlainText -Force
        $Credential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $Key, $APIPw
    }            
    process {
        write-verbose "Connecting to Autotask Web Api.."
        try {
            Connect-AutotaskWebAPI -Credential $Credential
            write-verbose "Connected."
        }
        catch {
            Write-Verbose "Fehler beim Verbindungsaufbau mit WebAPI (Autotask)"
            Write-Error $_.Exception.Message
            $Errorstate = $true
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        write-verbose "Vorgang abgeschlossen"
        if ($Errorstate) {
            return $false
        }
        return $true
    }
}