@{
    AliasesToExport      = ''
    Author               = 'Przemyslaw Klys'
    CompanyName          = 'Evotec'
    CompatiblePSEditions = 'Desktop', 'Core'
    Copyright            = '(c) 2011 - 2020 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'Project that help restoring malware / run / deleted scripts straight from Event Logs for further analysis'
    FunctionsToExport    = 'Restore-PowerShellScript'
    GUID                 = 'eb76426a-1992-40a5-82cd-6480f883ef4d'
    ModuleVersion        = '0.1.1'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags       = 'Windows', 'Restore', 'PowerShellScript', 'Malware', 'EventLog'
            ProjectUri = 'https://github.com/EvotecIT/PowerShellRestore'
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
    RootModule           = 'PowerShellRestore.psm1'
}