# Silent Install 7-Zip
# http://www.7-zip.org/download.html

$version = "1604"
$workdir = "c:\temp\"

# Check if work directory exists if not create it
if (Test-Path -Path $workdir -PathType Container) {
  Write-Host "$workdir already exists"
} else {
  New-Item -Path $workdir  -ItemType directory
}

# Download the installer
$source = "http://www.7-zip.org/a/7z$version-x64.msi"
$destination = "$workdir\7-Zip.msi"
Write-Host "INFO: Downloading 7-Zip $version msi from $source"
Invoke-WebRequest $source -OutFile $destination

Write-Host "INFO: Installing 7-Zip msi"
$MSIArguments = @(
  "/i"
  "$workdir\7-Zip.msi"
  "/qb"
)
Start-Process "msiexec.exe" -ArgumentList $MSIArguments -Wait -NoNewWindow

Write-Host "INFO: Install complete. Cleaning up"
rm -Force $workdir\7*

# Add 7zip to path
Write-Output "INFO: Adding command 7z to the path"
[Environment]::SetEnvironmentVariable("PATH","$env:path;$env:programfiles\7-Zip","MACHINE")
$env:path = "$env:path;$env:programfiles\7-Zip"

Write-Output "INFO: 7zip msi install complete"
