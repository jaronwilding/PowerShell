enum Theme {
    Starship
    OhMyPosh
}

$CurrentTheme = [Theme]::OhMyPosh
$CurrentDirectory = Split-Path -Parent $Profile
$ThemeDirectory = Join-Path $CurrentDirectory "themes"

switch($CurrentTheme) {
    ([Theme]::Starship) {
        $env:STARSHIP_CONFIG = Join-Path $ThemeDirectory "panda.starship.toml"
        Invoke-Expression (& starship init powershell)
    }
    ([Theme]::OhMyPosh) {
        $ThemePath = Join-Path $ThemeDirectory "panda.omp.yaml"
        $env:POSH_GIT_ENABLED = $true
        oh-my-posh --init --shell pwsh --config $ThemePath | Invoke-Expression
    }
    default {
        Write-Host "Invalid theme selected"
    }
}
