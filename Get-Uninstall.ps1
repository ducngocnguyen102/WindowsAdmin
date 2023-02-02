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
                    
                [PSCustomObject]@{
                    InstallLocation = $ItemProperty.InstallLocation
                    GUID = $ItemProperty.PSChildName
                    UninstallString = $ItemProperty.UninstallString
                    QuietUninstallString = $ItemProperty.QuietUninstallString
            }
        }
    }
}
    
#Get uninstall string and store in $string var. You can select Uninstall
$String = (Get-Uninstall -Name "Google Chrome").UninstallString ; $String

#Uninstall using uninstall string 
Start-Process -FilePath "cmd.exe" -ArgumentList "/C $String" -Verb RunAs 
    