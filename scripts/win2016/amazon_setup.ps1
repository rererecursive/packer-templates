$ErrorActionPreference = "Stop"
Set-ExecutionPolicy Bypass -force
Write-Output "Start at: $(Get-Date)"
try
{
  Write-Output "Set up the EC2-Launch file for Windows 2016 initialisation"
  $start_time = Get-Date
  $EC2SettingsFile="C:\ProgramData\Amazon\EC2-Windows\Launch\Config\LaunchConfig.json"
  $json = Get-Content $EC2SettingsFile | ConvertFrom-Json
  $json.setComputerName = "true"
  $json.setWallpaper = "true"
  $json.addDnsSuffixList = "true"
  $json.extendBootVolumeSize = "true"
  $json.adminPasswordType = "Random"
  $json | ConvertTo-Json  | set-content $EC2SettingsFile
  Write-Output "Time taken: $((Get-Date).Subtract($start_time))"
}
catch
{
  Write-Output "Caught an exception:"
  Write-Output "Exception Type: $($_.Exception.GetType().FullName)"
  Write-Output "Exception Message: $($_.Exception.Message)"
  exit 1
}

exit 0
