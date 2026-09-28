Describe 'Scripts de sécurité défensifs' {
    $scriptFiles = Get-ChildItem -Path (Join-Path $PSScriptRoot '..\scripts') -Filter '*.ps1'

    It 'contient les scripts attendus' {
        $scriptFiles.Count | Should -BeGreaterOrEqual 6
    }

    foreach ($file in $scriptFiles) {
        It "$($file.Name) possède une syntaxe PowerShell valide" {
            $tokens = $null
            $errors = $null
            [void][System.Management.Automation.Language.Parser]::ParseFile($file.FullName, [ref]$tokens, [ref]$errors)
            $errors.Count | Should -Be 0
        }
    }
}


