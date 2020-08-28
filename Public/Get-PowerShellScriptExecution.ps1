function Get-PowerShellScriptExecution {
    [cmdletBinding(DefaultParameterSetName = 'Request')]
    param(
        [Parameter(ParameterSetName = 'Request', Mandatory)][ValidateSet('PowerShell', 'WindowsPowerShell')][string] $Type,
        [Parameter(ParameterSetName = 'Request')][string[]] $ComputerName,
        [Parameter(ParameterSetName = 'Events')][Array] $Events,
        [DateTime] $DateFrom,
        [DateTime] $DateTo
    )
    if (-not $Events) {
        $getEventsSplat = [ordered] @{
            ID       = 4100
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

    foreach ($Event in $Events) {
        $ContextInfo = $Event.ContextInfo.Split([Environment]::NewLine)
        $EventEntry = [ordered] @{}
        foreach ($Entry in $ContextInfo) {
            if ($Entry.Trim()) {
                $Data = $Entry.Trim() -split '='
                $FieldName = "$($Data[0])".Replace(' ', '')
                $EventEntry[$FieldName] = if ($Data[1]) { $Data[1].Trim() } else { $null }
            }
        }
        [PSCustomObject] $EventEntry
    }
}