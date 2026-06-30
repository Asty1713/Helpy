$InstallPath = "$env:LOCALAPPDATA\Helpy"
$ZipPath = "$env:TEMP\Helpy.zip"
$DownloadUrl = "https://github.com/Asty1713/Helpy/releases/download/v0.1.0-beta/Helpy.zip"

Write-Host "Installing Helpy..." -ForegroundColor Cyan

Remove-Item $InstallPath -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $InstallPath | Out-Null

Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipPath
Expand-Archive -Path $ZipPath -DestinationPath $InstallPath -Force

$ExePath = Get-ChildItem -Path $InstallPath -Filter "Helpy.exe" -Recurse | Select-Object -First 1

if (-not $ExePath) {
    Write-Host "ERROR: Helpy.exe was not found after extracting." -ForegroundColor Red
    pause
    exit
}

$DesktopPath = [Environment]::GetFolderPath("Desktop")
$ShortcutPath = Join-Path $DesktopPath "Helpy.lnk"

$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $ExePath.FullName
$Shortcut.WorkingDirectory = $ExePath.DirectoryName
$Shortcut.Save()

Write-Host "Helpy installed successfully!" -ForegroundColor Green
Write-Host "Shortcut created at: $ShortcutPath"

Start-Process $ExePath.FullName