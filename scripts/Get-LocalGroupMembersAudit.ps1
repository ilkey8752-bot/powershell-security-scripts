#Requires -Version 5.1
<#+
.SYNOPSIS
Liste les membres des groupes locaux ou d'un groupe précis.
#>
[CmdletBinding()]
param([string]$GroupName, [string]$OutputPath)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

try {
    $groups = if ($GroupName) { @(Get-LocalGroup -Name $GroupName) } else { Get-LocalGroup }
    $result = foreach ($group in $groups) {
        try {
            foreach ($member in Get-LocalGroupMember -Group $group.Name) {
                [pscustomobject]@{ Group = $group.Name; Member = $member.Name; ObjectClass = $member.ObjectClass; PrincipalSource = $member.PrincipalSource; SID = $member.SID }
            }
        } catch {
            Write-Warning "Groupe non lisible : $($group.Name)"
        }
    }
    if ($OutputPath) {
        $parent = Split-Path -Parent $OutputPath
        if ($parent -and -not (Test-Path -LiteralPath $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        $result | Export-Csv -LiteralPath $OutputPath -NoTypeInformation -Encoding UTF8
    }
    $result
} catch {
    Write-Error "Lecture des groupes locaux impossible : $($_.Exception.Message)"
}


