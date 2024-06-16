# Imports
Import-Module -Name Terminal-Icons
Import-Module -Name PSReadLine

$CurrentDirectory = Split-Path -Parent $Profile
$AliasesPath = Join-Path $CurrentDirectory "aliases.ps1"
$ThemePath = Join-Path $CurrentDirectory "theme.ps1"

# Settings
$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -EditMode Windows

# Dot source
. $AliasesPath
. $ThemePath

