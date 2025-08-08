function Install-OhMyPosh {
    <#
    .SYNOPSIS
    Installs Oh My Posh for PowerShell.
    
    .DESCRIPTION
    This function installs Oh My Posh, a prompt theme engine for PowerShell.
    
    .EXAMPLE
    Install-OhMyPosh
    #>

    try {
        Get-Command "winget.exe" -ErrorAction Stop | Out-Null
        $winget_path = "winget.exe"
    } catch {
        # Fallback: try resolving from WindowsApps
        $resolved_path = Resolve-Path -Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe" -ErrorAction SilentlyContinue
        if ($resolved_path) {
            $winget_path = $resolved_path.Path
        } else {
            Write-Error "winget.exe not found in PATH or WindowsApps fallback. Cannot continue."
            return $false
        }
    }

    $app_name = "JanDeDobbeleer.OhMyPosh"
    $winget_install_args = "install $($app_name) --source winget --scope machine --accept-package-agreements --accept-source-agreements --force"
    $winget_update_args = "upgrade $($app_name) --source winget --scope machine --accept-package-agreements --accept-source-agreements --force"

    Start-Process -FilePath $winget_path -ArgumentList "source reset --force" -Wait -NoNewWindow
    Start-Process -FilePath $winget_path -ArgumentList "source update" -Wait -NoNewWindow

    if (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue) {
        Write-Output "Oh My Posh is already installed, upgrading..."
        try {
            Start-Process -FilePath $winget_path -ArgumentList $winget_update_args -Wait -NoNewWindow
            if ($LASTEXITCODE -ne 0) {
                Write-Error "Failed to upgrade Oh My Posh."
                return $false
            }
            Write-Output "Oh My Posh upgraded successfully."
            return $true
        } catch {
            Write-Error "Failed to upgrade Oh My Posh: $_"
            return $false
        }
    } else {
        Write-Output "Installing Oh My Posh..."
        try {
            Start-Process -FilePath $winget_path -ArgumentList $winget_install_args -Wait -NoNewWindow
            if ($LASTEXITCODE -ne 0) {
                Write-Error "Failed to install Oh My Posh."
                return $false
            }
            Write-Output "Oh My Posh installed successfully."
            return $true
        } catch {
            Write-Error "Failed to install Oh My Posh: $_"
            return $false
        }
    }
}

function Install-Fonts {
    <#
    .SYNOPSIS
    Installs the required fonts for Oh My Posh.
    
    .DESCRIPTION
    This function installs the Cascadia Code font, which is required for Oh My Posh themes.
    
    .EXAMPLE
    Install-Fonts
    #>

    if (-not (Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)) {
        Write-Error "Oh My Posh is not installed. Please install it first."
        return $false
    }
    Write-Output "Installing fonts: CascadiaCode"
    try {
        & "oh-my-posh" font install CascadiaCode
        Write-Output "Fonts installed successfully."
        return $true
    } catch {
        Write-Error "Failed to install fonts: $_"
        return $false
    }
}