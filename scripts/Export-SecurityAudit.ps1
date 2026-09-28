#Requires -Version 5.1
<#+
.SYNOPSIS
Exécute les scripts d'audit du dépôt et produit plusieurs CSV locaux.
#>
[CmdletBinding()]
param([string]$OutputDirectory = (Join-Path $PSScriptRoot '..\output'))

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$resolvedOutput = [IO.Path]::GetFullPath($OutputDirectory)
if (-not (Test-Path -LiteralPath $resolvedOutput)) {
    New-Item -ItemType Directory -Path $resolvedOutput -Force | Out-Null
}

& (Join-Path $PSScriptRoot 'Get-SystemInventory.ps1') -OutputPath (Join-Path $resolvedOutput 'system.csv') | Out-Null
& (Join-Path $PSScriptRoot 'Get-LocalUsersAudit.ps1') -OutputPath (Join-Path $resolvedOutput 'local-users.csv') | Out-Null
& (Join-Path $PSScriptRoot 'Get-ServicesAudit.ps1') -OutputPath (Join-Path $resolvedOutput 'services.csv') | Out-Null
& (Join-Path $PSScriptRoot 'Get-LocalGroupMembersAudit.ps1') -OutputPath (Join-Path $resolvedOutput 'local-groups.csv') | Out-Null
& (Join-Path $PSScriptRoot 'Get-WindowsEventsAudit.ps1') -OutputPath (Join-Path $resolvedOutput 'system-events.csv') | Out-Null

Get-ChildItem -LiteralPath $resolvedOutput -Filter '*.csv' | Select-Object Name, Length, LastWriteTime


