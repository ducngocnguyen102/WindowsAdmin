<# 
.SYNOPSIS 

    Migrate Windows device to Intune
#> 

#Load Functions
Function Get-Uninstall {
    <#
    .SYNOPSIS
        Get Uninstall string and install location of an application
    .PARAMETER Name
        Match DisplayName of an application
    .EXAMPLE
        Get-uninstall -Name "Google Chrome"
    .NOTES
    
    #>
    
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory = $True)]
        [String]$Name
    )
    
    $UninstallKeys = @( 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
                        'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall',
                        'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall')
    
    $UninstallItems = Get-ChildItem $UninstallKeys
    
    Foreach ($Item in $UninstallItems.PSPath){
        $ItemProperty = Get-ItemProperty $Item
        #Match Regkey with string name.
        if ($ItemProperty.DisplayName -match "$Name"){
            #If QuietUninstallString switch is used then select QuietUninstallString. 
            $ItemProperty
                [PSCustomObject]@{
                    DisplayName = $ItemProperty.DisplayName
                    DisplayVersion = $ItemProperty.DisplayVersion
                    InstallLocation = $ItemProperty.InstallLocation
                    GUID = $ItemProperty.PSChildName
                    UninstallString = $ItemProperty.UninstallString
                    QuietUninstallString = $ItemProperty.QuietUninstallString
            }
        }
    }
}

# Declare Variables
# ================
$Date = get-date -Format "yyyy-MM-dd-hh-mm-ss"
$EntraJoinedFolder = "C:\CSOD\EntraJoined" 
$telemetrySampleSettings =  "C:\ProgramData\Microsoft\Diagnosis\DownloadedSettings\telemetry.ASM-WindowsDefault.json"  
$BinariesFolder = "C:\Windows\CSOD\Deploy-Application\Files"

Set-Location "C:\Windows\CSOD\Deploy-Application\Files"

# Create Folder to store binaries 
# ============================== 
$TestPath = Test-Path $EntraJoinedFolder 
$Hostname =  (Get-WmiObject -Class win32_bios).SerialNumber 
if (-not $TestPath){New-Item -Path C:\CSOD -Name EntraJoined -ItemType Directory -Force} 

Start-Transcript -Path "$EntraJoinedFolder\Logs\Migrate-$Date.txt" -Append -Force

# Check if Powershell script is elevated
# ======================================
if ((New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Output "PS is Elevated."
} else {
    Write-Output "PS is not elevated."
}

# Preventive Steps
# ================
Get-Service 'Avecto Defendpoint Service' | Stop-Service #Prevent Avecto to intervene with migration processes 
powercfg /change -monitor-timeout-ac 0 #set to never sleep while plugged in to AC power
REG ADD "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /V DontDisplayNetworkSelectionUI /T REG_DWORD /D 0 /F #require restart or sign-out

#Activate Windows
$activation_result = Get-CimInstance SoftwareLicensingProduct -Filter "Name like 'Windows%'" | where { $_.PartialProductKey } | select Description, LicenseStatus
if ($activation_result.LicenseStatus -ne '1'){slmgr.vbs //b -ipk 83JRV-DX6TQ-KYQGP-7K9H2-GF6PX /ato}



# Uninstall OneDrive
# =================
$OneDrive = Get-Uninstall -Name "OneDrive" 
$OneDrive | ForEach-Object {
    $UninstallString = $_.UninstallString
    $DisplayName = $_.DisplayName
    Write-Host "Uninstalling $DisplayName"
    Start-Process -FilePath "cmd.exe" -ArgumentList "/C $UninstallString" -Wait
    
}

# Registry Clean Up
# =================
Reg delete HKLM\SOFTWARE\Microsoft\Enrollments /f 

# Configure Sample Rate to ensure PPKG works without any issues 
# ============================================================ 
$Content = Get-Content $telemetrySampleSettings -Raw  
$Object = $Content | ConvertFrom-Json  
$Object.settings.'MicrosoftTelemetry::ms.CriticalData:SampleRate' = "100"  
$Object | ConvertTo-Json | Set-Content -Path $telemetrySampleSettings  

#Restart Diagtrack for change to take effect  
net stop diagtrack   
Start-Sleep -Seconds 5  
net start diagtrack  

# Suspend BitLocker to bypass Bitlocker PIN 
# ======================================== 
Suspend-BitLocker C:\ -RebootCount 10

# Disconnect from AD
# =================
$NetAdapter = Get-NetAdapter| Where-Object {$_.status -eq "Up"}
$NetAdapter | ForEach-Object {
    Write-Host "Disabling $($_.InterfaceDescription)"
    Disable-NetAdapter $_.Name -Confirm:$false
   }

Start-Sleep -Seconds 3

$disjoin_status = Remove-Computer -WorkgroupName "WorkGroup" -Force -PassThru -Verbose

$NetAdapter | ForEach-Object {
    Write-Host "Enabling $($_.InterfaceDescription)"
    Enable-NetAdapter $_.Name -Confirm:$false 
}

Start-Sleep -Seconds 60 #allow network to reconnect

#Halt script before breaking userprofile if disjoin fail
if ($disjoin_status.HasSucceeded -eq $false){
    Write-Warning "Terminating script... AD disjoin has failed."
    Write-Output $disjoin_status
    Exit 1
}

# Disconnect from AzureAD joined 
# ============================= 
Write-Host "Disjoiing from AAD..."
dsregcmd /leave  


# Migrate UserProfile 
# ===================
Start-Process -FilePath "$BinariesFolder\Migrate-CSODProfile.exe" -Wait 

# Remove existing provisioning package to prevent issues
# =====================================================
$ppkg = Get-ProvisioningPackage -AllInstalledPackages 
$ppkg | Where-Object {$_.PackageName -match "AADJ"} | ForEach-Object {Remove-ProvisioningPackage -PackageId $_.PackageID}

# Enroll device into Intune by running PPKG
# =========================================
[int]$os_build = (Get-WmiObject win32_operatingsystem).BuildNumber

if ($os_build -ge "19041"){
    Write-Output "Installing AADJM PPKG for $os_build"
    Add-ProvisioningPackage -PackagePath "$BinariesFolder\AADJM.ppkg" -QuietInstall -LogsDirectoryPath $EntraJoinedFolder 
}
Elseif ($os_build -lt "19041"){
    Write-Output "Installing AADJM1909andUnder PPKG for $Os_build"
    Add-ProvisioningPackage -PackagePath "$BinariesFolder\AADJM-1909AndUnder.ppkg" -QuietInstall -LogsDirectoryPath $EntraJoinedFolder 
}
Else {
    Write-Output "Installing AADJM1909andUnder PPKG for $Os_build"
    Add-ProvisioningPackage -PackagePath "$BinariesFolder\AADJM-1909AndUnder.ppkg" -QuietInstall -LogsDirectoryPath $EntraJoinedFolder 
}


Add-LocalGroupMember -Group Administrators -Member MigrationUser #Promote MigrationUser to local admin if PPKG failed to promote.

Stop-Transcript

Exit 0
