#Requires -Version 5.1
<#+
.SYNOPSIS
Liste les utilisateurs locaux et leurs principaux attributs de sécurité.
#>
[CmdletBinding()]
param([string]$OutputPath)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $result = Get-LocalUser | Select-Object Name, Enabled, LastLogon, PasswordRequired, PasswordExpires, UserMayChangePassword, SID
    if ($OutputPath) {
        $parent = Split-Path -Parent $OutputPath
        if ($parent -and -not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        $result | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8
    }
    $result
} catch {
    Write-Error "Lecture des utilisateurs locaux impossible : $($_.Exception.Message)"
}


