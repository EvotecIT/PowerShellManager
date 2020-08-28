@{
    AliasesToExport      = ''
    Author               = 'Przemyslaw Klys'
    CompanyName          = 'Evotec'
    CompatiblePSEditions = 'Desktop', 'Core'
    Copyright            = '(c) 2011 - 2020 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Project that help restoring malware / run / deleted scripts straight from Event Logs for further analysis'
    FunctionsToExport    = 'Get-PowerShellScriptExecution', 'Restore-PowerShellScript'
    GUID                 = '759cffa8-9eae-4c4c-a047-e3516e482e4f'
    ModuleVersion        = '0.1.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = 'Windows', 'Restore', 'PowerShellScript', 'Malware', 'EventLog'
            ProjectUri = 'https://github.com/EvotecIT/PowerShellManager'
        }
    }
    RequiredModules      = @{
        ModuleVersion = '1.0.17'
        ModuleName    = 'PSEventViewer'
        GUID          = '5df72a79-cdf6-4add-b38d-bcacf26fb7bc'
    }, @{
        ModuleVersion = '1.19.1'
        ModuleName    = 'PSScriptAnalyzer'
        GUID          = 'd6245802-193d-4068-a631-8863a4342a18'
    }
    RootModule           = 'PowerShellManager.psm1'
}