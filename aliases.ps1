function GotoSource {
    Set-Location C:\Users\Jaron\source\repos\
}

function LoginToDingo {
    ssh jaron@192.168.0.45
}

function ActivateVenv() {
    if (Test-Path env:VIRTUAL_ENV) {
        Write-Debug "Deactivating virtual environment"
        deactivate
        return
    }
    Get-ChildItem activate.ps1 -Recurse -Depth 2 | ForEach-Object{$_.FullName} | Invoke-Expression
}

Set-Alias -Name src -Value GotoSource
Set-Alias -Name dingo -Value LoginToDingo
Set-Alias -Name venv -Value ActivateVenv
