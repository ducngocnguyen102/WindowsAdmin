Function Winget {
    <#
    .SYNOPSIS
        Install and Uninstall application using Winget.exe 
    .DESCRIPTION
        By default Winget function will install in user context unless specific parameter type as "machine".
    .NOTES
        Author: Ngoc Nguyen
        Version: 2023.10.1
    .EXAMPLE
        Winget -Type Install -InstallType Machine -AppID Cisco.CiscoWebexMeetings
        Winget -Type Uninstall -AppID Cisco.CiscoWebexMeetings
    
    .EXAMPLE for Intune
        Powershell.exe -ExecutionPolicy Bypass ; . .\Winget.ps1 ; Winget -AppID Cisco.CiscoWebexMeetings -Type Uninstall
        Powershell.exe -ExecutionPolicy Bypass ; . .\Winget.ps1 ; Winget -AppID Cisco.CiscoWebexMeetings -Type Install -InstallType Machine
    #>
    Param(
        [parameter(Mandatory = $true, ParameterSetName = "Type")]
            [ValidateSet("Install", "Uninstall")]
            [string]$Type,
        [parameter(ParameterSetName = "Type")]
            [ValidateSet("Machine", "User","Default")]
            [string]$InstallType,
        [string]$AppID

    )
    
    #Find Winget.exe absolute path
    $WindowsApps = 'C:\Program Files\WindowsApps'
    $Winget_exe = Get-ChildItem $WindowsApps -Recurse -Include winget.exe 
    
    
    switch ($Type) {

        'Install' {    
            switch ($InstallType) {
                'Machine' {Start-Process $Winget_exe -ArgumentList "install --id $AppID --silent --scope machine --accept-source-agreements --accept-package-agreements --disable-interactivity" -Wait}
                'User' {Start-Process $Winget_exe -ArgumentList "install --id $AppID --silent --scope machine --accept-source-agreements --accept-package-agreements --disable-interactivity" -Wait}
                'Default' {Start-Process $Winget_exe -ArgumentList "install --id $AppID --silent --accept-source-agreements --accept-package-agreements --disable-interactivity" -Wait}
            }
        }

        'Uninstall' {
            Start-Process $Winget_exe -ArgumentList "uninstall --id $AppID --silent --purge --accept-source-agreements --disable-interactivity" -Wait
            
        }
    }
}

