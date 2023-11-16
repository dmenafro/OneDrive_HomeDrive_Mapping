<#
.SYNOPSIS

    The purpose of this script is to map a drive to a user's local OneDrive 'Documents' folder.
    This is to address instances where a specific drive letter mapping is required for a customers application to function.

.Description

    By default the drive letter to be mapped will be 'H'

    You can launch the script and pass a different drive letter if required
        
        Example: powershell.exe -file OneDrive_HomeDrive_Mapping.ps1 -DriveLetter Q

    The script will check if there is a drive already mapped under the desired drive letter
    If not, it will map the users local OneDrive path to the drive letter provided or 'H' by default

.OUTPUTS
    
    If using script via GPO check for Event 5018 under
    Microsoft-Windows-GroupPolicy/Operational

    Script will error if a drive letter passed is more than 1 character long or isn't a valid drive letter

.NOTES
  Version:        1.0
  Author:         Dan Menafro
  Creation Date:  11/16/2023
  Last Changed:   11/16/2023

  Purpose/Change:    

#>

Param([ValidateLength(0,1)][string]$DriveLetter = "H")

$HomeDrivePath = "\\localhost\"+($env:OneDriveCommercial).Replace(':','$')+"\Documents"


if(!(get-psdrive $driveLetter -ErrorAction SilentlyContinue)){

    New-PSDrive -name $DriveLetter -PSProvider "FileSystem" -Root $HomeDrivePath -Persist

} # End 
