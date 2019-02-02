$ErrorActionPreference = "Stop"
Set-ExecutionPolicy Bypass -force
Write-Output "Start at: $(Get-Date)"
try
{
  # Set start time
  $start_time = Get-Date

  # Set download URLs
  $7zip_download_url = "http://downloads.sourceforge.net/sevenzip/7za465.zip"

  # Create Software folder
  $software_folder = "$env:SystemDrive\software"
  mkdir -force $software_folder

  # Create temp folder
  $temp_folder  = "$env:userprofile\temp\install"
  if (test-path("$temp_folder")) {ri -r -force "$temp_folder"}
  mkdir -force $temp_folder
  cd $temp_folder

  # Download 7zip
  Write-Output "Downloading 7zip from $7zip_download_url"
  $wc = new-object System.Net.WebClient
  $wc.DownloadFile($7zip_download_url,"$temp_folder\" + $7zip_download_url.Split("/")[-1])

  # Install 7-zip (just unzipping file to a 7zip folder)
  Write-Output "Installing 7zip in $software_folder\7zip"
  if (test-path("$software_folder\7zip")) {ri -r -force "$software_folder\7zip"}
  mkdir "$software_folder\7zip"
  $shell_app=new-object -com shell.application
  $zip_file = $shell_app.namespace("$temp_folder\7za465.zip")
  $destination = $shell_app.namespace("$software_folder\7zip")
  $destination.Copyhere($zip_file.items())

  # Add 7zip to path
  Write-Output "Adding 7zip to the PATH"
  [Environment]::SetEnvironmentVariable("PATH","$env:path;$software_folder\7zip","MACHINE")
  $env:path = "$env:path;$software_folder\7zip"

  # Remove temp folder
  Write-Output "Cleaning up"
  cd c:\
  ri -r -force "$temp_folder"
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
