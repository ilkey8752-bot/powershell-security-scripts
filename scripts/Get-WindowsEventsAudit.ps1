#Requires -Version 5.1
<#+
.SYNOPSIS
Lit un nombre limité d'événements Windows récents.
#>
[CmdletBinding()]
param(
    [ValidateSet('System', 'Application', 'Security')]
    [string]$LogName = 'System',
    [ValidateRange(1, 5000)]
    [int]$MaxEvents = 200,
    [ValidateRange(1, 30)]
    [int]$Days = 1,
    [string]$OutputPath
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $start = (Get-Date).AddDays(-$Days)
    $result = Get-WinEvent -FilterHashtable @{ LogName = $LogName; StartTime = $start } -MaxEvents $MaxEvents |
        Select-Object TimeCreated, Id, LevelDisplayName, ProviderName, MachineName, Message
    if ($OutputPath) {
        $parent = Split-Path -Parent $OutputPath
        if ($parent -and -not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        $result | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8
    }
    $result
} catch {
    Write-Error "Lecture du journal $LogName impossible : $($_.Exception.Message)"
}


