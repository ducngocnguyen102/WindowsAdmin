Function Get-Uninstall {

[CmdletBinding()]
Param (
    [Parameter(Mandatory = $True)]
    [String]$Name,
    [Switch]$QuietUninstallString = $false
)

$UninstallKeys = @( 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
                    'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall',
                    'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall')

$UninstallItems = Get-ChildItem $UninstallKeys

Foreach ($Item in $UninstallItems.PSPath){
    
    #Match Regkey with string name.
    if ($Item -match "$Name"){
        #If QuietUninstallString switch is used then select QuietUninstallString. 
        if ($QuietUninstallString){
            $ItemProperty = Get-ItemProperty Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip
            $ItemProperty.QuietUninstallString

            }
        Else {
            $ItemProperty = Get-ItemProperty Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\7-Zip
            $ItemProperty.UninstallString
        }
        }
    }
}

$String = Get-Uninstall -Name 7-zip -QuietUninstallString
Start-Process -FilePath "cmd.exe" -ArgumentList "/C $String" -Verb RunAs -WindowStyle Hidden
