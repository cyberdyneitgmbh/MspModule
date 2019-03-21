<# 

.DESCRIPTION 
    Accesstoken for RMM-Api connection (pinotage)

#>

function New-RmmApiAccessToken {
    [CmdletBinding()]
    param (
        [string]$apiUrl,
        [string]$apiKey,
        [string]$apiSecretKey,
        [string]$apiMethod,
        [string]$apiRequestBody
    )   
    begin {
        # Erroraction preference
        $LastErrorActionPreference = $ErrorActionPreference
        $ErrorActionPreference = 'stop'
                
        # Errorflag
        $Errorstate = $false 

        # Verbose parameter
        if ($PSBoundParameters.ContainsKey('Verbose')) {
            $VerbosePreference = $PSCmdlet.GetVariableValue('VerbosePreference')
        }
        
        # Specify security protocols
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'

        # Convert password to secure string
        $securePassword = ConvertTo-SecureString -String 'public' -AsPlainText -Force

        # Define parameters for Invoke-WebRequest cmdlet
        $params = @{
            Credential  =	New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList ('public-client', $securePassword)
            Uri         =	'{0}/auth/oauth/token' -f $apiUrl
            Method      =	'POST'
            ContentType = 'application/x-www-form-urlencoded'
            Body        = 'grant_type=password&username={0}&password={1}' -f $apiKey, $apiSecretKey
        }
    }            
    process {
        Write-Verbose "Empfange $AccessToken"
        try {
            $AccessToken = (Invoke-WebRequest @params -UseBasicParsing | ConvertFrom-Json).access_token
        }
        catch {
            write-Verbose "Fehler waehrend des WebRequests."
            Write-Error $_.Exception.Message
            $Errorstate = $true
        }
    }            
    end {
        $ErrorActionPreference = $LastErrorActionPreference
        if ($Errorstate) {
            return $null
        }
        return $AccessToken
    }
}

$RMMApiKey = "QBR97CVCTGSVH66CB64C0R3P3K3HFP82"
$RMMApiSecretKey = "M5V8E3S059EPGSPAF03AAKE92A1EKSLS"
$RMMApiUrl = "https://pinotage-api.centrastage.net"


$params = @{
    apiUrl         =	$RMMApiUrl
    apiKey         =	$RMMApiKey
    apiSecretKey   =	$RMMApiSecretKey
    apiMethod      =	'GET'
    apiRequestBody	=	$null
}
$AccessToken = New-RmmApiAccessToken @params -Verbose
$AccessToken