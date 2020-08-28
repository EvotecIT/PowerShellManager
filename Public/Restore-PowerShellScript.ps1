function Restore-PowerShellScript {
    [cmdletBinding(DefaultParameterSetName = 'Request')]
    param(
        [Parameter(ParameterSetName = 'Request', Mandatory)][ValidateSet('PowerShell', 'WindowsPowerShell')][string] $Type,
        [Parameter(ParameterSetName = 'Request')][string[]] $ComputerName,
        [Parameter(ParameterSetName = 'Events')][Array] $Events,
        [Parameter(ParameterSetName = 'File')][string] $EventLogPath,
        [Parameter(Mandatory)][Alias('FolderPath')][string] $Path,

        [DateTime] $DateFrom,
        [DateTime] $DateTo,
        [switch] $AddMarkdown,
        [switch] $Format,
        [switch] $Unblock
    )
    if (-not $Events) {
        $getEventsSplat = [ordered] @{
            ID       = 4103, 4104
            DateFrom = $DateFrom
            DateTo   = $DateTo
        }
        if ($ComputerName) {
            $getEventsSplat.Computer = $ComputerName
        }
        if ($Type -eq 'WindowsPowerShell') {
            $getEventsSplat['LogName'] = 'Microsoft-Windows-PowerShell/Operational'
        } elseif ($Type -eq 'PowerShell') {
            $getEventsSplat['LogName'] = 'PowerShellCore/Operational'
        }
        if ($EventLogPath) {
            Path = $EventLogPath
        }
        $Events = Get-Events @getEventsSplat -Verbose:$VerbosePreference
    }
    $FormatterSettings = @{
        IncludeRules = @(
            'PSPlaceOpenBrace',
            'PSPlaceCloseBrace',
            'PSUseConsistentWhitespace',
            'PSUseConsistentIndentation',
            'PSAlignAssignmentStatement',
            'PSUseCorrectCasing'
        )
        Rules        = @{
            PSPlaceOpenBrace           = @{
                Enable             = $true
                OnSameLine         = $true
                NewLineAfter       = $true
                IgnoreOneLineBlock = $true
            }

            PSPlaceCloseBrace          = @{
                Enable             = $true
                NewLineAfter       = $false
                IgnoreOneLineBlock = $true
                NoEmptyLineBefore  = $false
            }

            PSUseConsistentIndentation = @{
                Enable              = $true
                Kind                = 'space'
                PipelineIndentation = 'IncreaseIndentationAfterEveryPipeline'
                IndentationSize     = 4
            }

            PSUseConsistentWhitespace  = @{
                Enable          = $true
                CheckInnerBrace = $true
                CheckOpenBrace  = $true
                CheckOpenParen  = $true
                CheckOperator   = $true
                CheckPipe       = $true
                CheckSeparator  = $true
            }

            PSAlignAssignmentStatement = @{
                Enable         = $true
                CheckHashtable = $true
            }

            PSUseCorrectCasing         = @{
                Enable = $true
            }
        }
    }
    $Cache = [ordered] @{}
    foreach ($U in $Events) {
        if ($null -eq $U.ScriptBlockText -or $U.ScriptBlockText -eq 0) {
            continue
        }
        if (-not $Cache[$U.ScriptBlockId]) {
            $Cache[$U.ScriptBlockId] = [ordered] @{}
        }
        $Cache[$U.ScriptBlockId]["0"] = $U
        $Cache[$U.ScriptBlockId]["$($U.MessageNumber)"] = $U.ScriptBlockText
    }
    if (-not (Test-Path -Path $Path)) {
        $null = New-Item -ItemType Directory -Path $Path
    }
    foreach ($ScriptBlockID in $Cache.Keys) {
        [int] $ScriptBlockCount = $Cache[$ScriptBlockID]['0'].MessageTotal
        [string] $Script = for ($i = 1; $i -le $ScriptBlockCount; $i++) {
            $Cache[$ScriptBlockID]["$i"]
        }
        if ($Format) {
            try {
                $Script = Invoke-Formatter -ScriptDefinition $Script -Settings $FormatterSettings -ErrorAction Stop
            } catch {
                Write-Warning "Restore-PowerShellScript - Formatter failed to format. Skipping formatting."
            }
        }
        $FileName = -join ($($Cache[$ScriptBlockID]['0'].MachineName), '_', "$($ScriptBlockID).ps1")
        $FilePath = [io.path]::Combine($Path, $FileName)
        if ($AddMarkdown) {
            @(
                '<#'
                "RecordID = $($Cache[$ScriptBlockID]['0'].RecordID)"
                "LogName = $($Cache[$ScriptBlockID]['0'].LogName)"

                "MessageTotal = $($Cache[$ScriptBlockID]['0'].MessageTotal)"
                "MachineName = $($Cache[$ScriptBlockID]['0'].MachineName)"
                "UserId = $($Cache[$ScriptBlockID]['0'].UserId)"
                "TimeCreated = $($Cache[$ScriptBlockID]['0'].TimeCreated)"
                "LevelDisplayName = $($Cache[$ScriptBlockID]['0'].LevelDisplayName)"
                '#>'
                $Script
            ) | Out-File -FilePath $FilePath
        } else {
            $Script | Out-File -FilePath $FilePath
        }
        if (-not $Unblock) {
            $data = [System.Text.StringBuilder]::new().AppendLine('[ZoneTransfer]').Append('ZoneId=3').ToString()
            Set-Content -Path $FilePath -Stream "Zone.Identifier" -Value $data
        }
    }
}