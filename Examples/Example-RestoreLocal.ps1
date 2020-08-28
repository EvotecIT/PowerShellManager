Import-Module $PSScriptRoot\..\PowerShellRestore.psd1 -Force

Restore-PowerShellScript -Type WindowsPowerShell -Path $PSScriptRoot\Scripts -Verbose