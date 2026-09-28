#Requires -Version 5.1
<#+
.SYNOPSIS
Inventorie les services Windows sans modifier leur état.
#>
[CmdletBinding()]
param(
    [ValidateSet('All', 'Running', 'Stopped')]
    [string]$State = 'All',
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $services = Get-CimInstance -ClassName Win32_Service
    if ($State -ne 'All') { $services = $services | Where-Object State -EQ $State }
    $result = $services | Select-Object Name, DisplayName, State, StartMode, StartName, PathName
    if ($OutputPath) {
        $parent = Split-Path -Parent $OutputPath
        if ($parent -and -not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        $result | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8
    }
    $result
} catch {
    Write-Error "Inventaire des services impossible : $($_.Exception.Message)"
}


