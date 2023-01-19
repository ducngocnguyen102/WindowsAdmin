Function Get-Uninstall {
<#
.SYNOPSIS
    Uninstall application using uninstall string from registry.
.DESCRIPTION
.PARAMETER Name
    match name of the application.
.PARAMETER QuietUninstallString
    Find quiet uninstall parameter if it output null then quiet string does not exist.
.EXAMPLE
.NOTES

#>

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
    $ItemProperty = Get-ItemProperty $Item
    #Match Regkey with string name.
    if ($ItemProperty.DisplayName -match "$Name"){
        #If QuietUninstallString switch is used then select QuietUninstallString. 
        if ($QuietUninstallString){
            $ItemProperty.QuietUninstallString
            }
        Else {
            $ItemProperty.UninstallString
        }
        }
    }
}

$String = Get-Uninstall -Name 7-zip -QuietUninstallString
Start-Process -FilePath "cmd.exe" -ArgumentList "/C $String" -Verb RunAs -WindowStyle Hidden
