#Requires -Version 5.1
<#+
.SYNOPSIS
Collecte un inventaire système local en lecture seule.
.PARAMETER OutputPath
Chemin CSV facultatif. Aucun export n'est réalisé si le paramètre est omis.
#>
[CmdletBinding()]
param([string]$OutputPath)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $computer = Get-CimInstance -ClassName Win32_ComputerSystem
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $bios = Get-CimInstance -ClassName Win32_BIOS
    $result = [pscustomobject]@{
        ComputerName = $env:COMPUTERNAME
        Manufacturer = $computer.Manufacturer
        Model = $computer.Model
        OperatingSystem = $os.Caption
        OSVersion = $os.Version
        LastBootTime = $os.LastBootUpTime
        BiosVersion = ($bios.SMBIOSBIOSVersion -join ', ')
        CollectedAt = Get-Date
    }

    if ($OutputPath) {
        $parent = Split-Path -Parent $OutputPath
        if ($parent -and -not (Test-Path -LiteralPath $parent)) {
            New-Item -ItemType Directory -Path $parent -Force | Out-Null
        }
        $result | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8
    }
    $result
} catch {
    Write-Error "Inventaire impossible : $($_.Exception.Message)"
}


