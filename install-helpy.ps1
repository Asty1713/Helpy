$InstallPath = "$env:LOCALAPPDATA\Helpy"
$ZipPath = "$env:TEMP\Helpy.zip"

$DownloadUrl = "https://raw.githubusercontent.com/Asty1713/Helpy/main/Helpy.zip"

Write-Host "Installing Helpy..." -ForegroundColor Cyan

New-Item -ItemType Directory -Force -Path $InstallPath | Out-Null

Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipPath

Expand-Archive -Path $ZipPath -DestinationPath $InstallPath -Force

$ExePath = "$InstallPath\Helpy.exe"

$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut("$env:USERPROFILE\Desktop\Helpy.lnk")
$Shortcut.TargetPath = $ExePath
$Shortcut.WorkingDirectory = $InstallPath
$Shortcut.Save()

Write-Host "Helpy installed successfully!" -ForegroundColor Green
Write-Host "Desktop shortcut created."

Start-Process $ExePath