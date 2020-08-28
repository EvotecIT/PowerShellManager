Import-Module $PSScriptRoot\..\PowerShellRestore.psd1 -Force

# Keep in mind AD1/AD2 will do it in parallel
Restore-PowerShellScript -Type WindowsPowerShell -Path $PSScriptRoot\Scripts -ComputerName AD1, AD2 -Verbose