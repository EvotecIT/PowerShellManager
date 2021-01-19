Import-Module $PSScriptRoot\..\PowerShellManager.psd1 -Force

Restore-PowerShellScript -Path $PSScriptRoot\ScriptsLocal -EventLogPath $Env:UserProfile\Downloads\Test.evtx -Verbose -Format -AddMarkdown