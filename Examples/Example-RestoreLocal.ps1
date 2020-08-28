Import-Module $PSScriptRoot\..\PowerShellManager.psd1 -Force

Restore-PowerShellScript -Type WindowsPowerShell -Path $PSScriptRoot\ScriptsLocal -Verbose -Format -AddMarkdown