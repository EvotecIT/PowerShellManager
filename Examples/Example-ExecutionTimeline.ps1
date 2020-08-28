Import-Module $PSScriptRoot\..\PowerShellManager.psd1 -Force

$Output = Get-PowerShellScriptExecution -Type WindowsPowerShell -Verbose
$Output | Format-Table