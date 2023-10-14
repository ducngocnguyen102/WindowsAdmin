Function Install-ChromeExtension {
<#
.SYNOPSIS
    Install Google Chrome Extension and automatically pin Extension
.EXAMPLE
    Install-ChromeExtension -ExtensionID cnlefmmeadmemmdciolhbnfeacpdfbkd
.NOTES
    Author: Ngoc Nguyen 
#>

    param (
        [Parameter(Position=0,mandatory=$true)]
        [string]$ExtensionID
    )
    

# Automatically pin Extension by modifying ExtensionSettings string value. If string has existing value, it will keep existing and add-on to it.
#=============================================================================================================================================
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Google\Chrome' #Change
$RegistryProperties = Get-ItemProperty $RegistryPath
$ToolBar_Pin = '{"toolbar_pin": "force_pinned" }' | ConvertFrom-Json
$ValueName = 'ExtensionSettings' #Change
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = [PSCustomObject]@{
    $ExtensionID = $ToolBar_Pin
} | ConvertTo-Json

if (!($RegistryProperties.ExtensionSettings)){ 
    Write-Output "$ValueName not found, creating $ValueName $ValueType $Value"

        New-ItemProperty -Path $RegistryPath -Name $ValueName -PropertyType $ValueType  -Value $Value -ErrorAction SilentlyContinue -Force #Create string
        Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value #Update String Value if ExtensionSettings value already created
    
} ElseIf ($RegistryProperties.ExtensionSettings){
    Write-Output "[$ValueName]: Value found."
    
    if ($RegistryProperties.ExtensionSettings -match $ExtensionID){
        Write-Output "[$ValueName]: contains $ExtensionID, skipped."
    } ElseIf ($RegistryProperties.ExtensionSettings -notmatch $ExtensionID){
        Write-Output "[$ValueName]: does not contains $ExtensionID."
        Write-Output "[$ValueName] Adding $ExtensionID..."
        $ExistingValue_HashTable = $RegistryProperties.ExtensionSettings | ConvertFrom-Json
        $ExistingValue_HashTable | Add-Member -NotePropertyName $ExtensionID -NotePropertyValue $ToolBar_Pin
        $Value_JSON = $ExistingValue_HashTable | ConvertTo-Json
        Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value_JSON
    }
}


# Install Chrome Extension 
#=========================
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Google\Chrome\' #Change
$RegistryKey =  Get-ChildItem $RegistryPath
$RegistryKeyName = 'ExtensionInstallForcelist' #Change
$RegistryProperty = Get-ItemProperty $RegistryPath\$RegistryKeyName | Select-Object '[0-9]*' #Select Properties that contains number
$ValueName = [int](($RegistryProperty.PSobject.Properties.Name | Measure-Object -Maximum).Maximum) + 1 #Find highest string number from ExtensionInstallForceList key and adds by 1
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = $ExtensionID #Change Extension ID

# Create ExtensionInstallForceList key if it does not exist
if (!($registryKey.Name)){
    Write-Output "[$RegistryKeyName]: Creating registry key"
    New-Item -Path $RegistryPath -Name $RegistryKeyName -Force
} 

if ($RegistryProperty -match $Value){
    Write-Output "[$RegistryKeyName]: Key Found, skipped."
} Elseif ($RegistryPath -notmatch $Value){
    Write-Output "[$RegistryKeyName]: Creating $ValueName $ValueType $Value"
    New-ItemProperty -Path $RegistryPath\$RegistryKeyName -PropertyType $ValueType -Name $ValueName -Value $Value -Force
}

}

Function Install-EdgeExtension {
<#
.SYNOPSIS
    Install Microsoft Edge Extension and automatically pin Extension to toolbar
.EXAMPLE
    Install-EdgeExtension -ExtensionID cnlefmmeadmemmdciolhbnfeacpdfbkd
.NOTES
    Author: Ngoc Nguyen 
#>
    param (
        [Parameter(Position=0,mandatory=$true)]
        [string]$ExtensionID
    )
    

# Automatically pin Extension by modifying ExtensionSettings string value. If string has existing value, it will keep existing and add-on to it.
#=============================================================================================================================================
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge\' #Change
$RegistryProperties = Get-ItemProperty $RegistryPath
$ToolBar_Pin = '{ "toolbar_state": "force_shown" }' | ConvertFrom-Json
$ValueName = 'ExtensionSettings' #Change
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = [PSCustomObject]@{
    $ExtensionID = $ToolBar_Pin
} | ConvertTo-Json

if (!($RegistryProperties.ExtensionSettings)){ 
    Write-Output "$ValueName not found, creating $ValueName $ValueType $Value"

        New-ItemProperty -Path $RegistryPath -Name $ValueName -PropertyType $ValueType  -Value $Value -ErrorAction SilentlyContinue -Force #Create string
        Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value #Update String Value if ExtensionSettings value already created
    
} ElseIf ($RegistryProperties.ExtensionSettings){
    Write-Output "[$ValueName]: Value found."
    
    if ($RegistryProperties.ExtensionSettings -match $ExtensionID){
        Write-Output "[$ValueName]: contains $ExtensionID, skipped."
    } ElseIf ($RegistryProperties.ExtensionSettings -notmatch $ExtensionID){
        Write-Output "[$ValueName]: does not contains $ExtensionID."
        Write-Output "[$ValueName] Adding $ExtensionID..."
        $ExistingValue_HashTable = $RegistryProperties.ExtensionSettings | ConvertFrom-Json
        $ExistingValue_HashTable | Add-Member -NotePropertyName $ExtensionID -NotePropertyValue $ToolBar_Pin
        $Value_JSON = $ExistingValue_HashTable | ConvertTo-Json
        Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value_JSON
    }
}


# Install Edge Extension 
#=========================
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge\' #Change
$RegistryKey =  Get-ChildItem $RegistryPath
$RegistryKeyName = 'ExtensionInstallForcelist' #Change
$RegistryProperty = Get-ItemProperty $RegistryPath\$RegistryKeyName | Select-Object '[0-9]*' #Select Properties that contains number
$ValueName = [int](($RegistryProperty.PSobject.Properties.Name | Measure-Object -Maximum).Maximum) + 1 #Find highest string number from ExtensionInstallForceList key and adds by 1
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = $ExtensionID #Change Extension ID

# Create ExtensionInstallForceList key if it does not exist
if (!($registryKey.Name)){
    Write-Output "[$RegistryKeyName]: Creating registry key"
    New-Item -Path $RegistryPath -Name $RegistryKeyName -Force
} 

if ($RegistryProperty -match $Value){
    Write-Output "[$RegistryKeyName]: Key Found, skipped."
} Elseif ($RegistryPath -notmatch $Value){
    Write-Output "[$RegistryKeyName]: Creating $ValueName $ValueType $Value"
    New-ItemProperty -Path $RegistryPath\$RegistryKeyName -PropertyType $ValueType -Name $ValueName -Value $Value -Force
}

}

Function Install-ChromeExtension {
    <#
    .SYNOPSIS
        Install Google Chrome Extension and automatically pin Extension
    .EXAMPLE
        Install-ChromeExtension -ExtensionID cnlefmmeadmemmdciolhbnfeacpdfbkd
    .NOTES
        Author: Ngoc Nguyen 
    #>
    
        param (
            [Parameter(Position=0,mandatory=$true)]
            [string]$ExtensionID
        )
        
    # Install Chrome Extension 
    #=========================
    $RegistryPath = 'HKLM:\SOFTWARE\Policies\Google\Chrome\' #Change
    $RegistryKey =  Get-ChildItem $RegistryPath
    $RegistryKeyName = 'ExtensionInstallForcelist' #Change
    $RegistryProperty = Get-ItemProperty $RegistryPath\$RegistryKeyName | Select-Object '[0-9]*' #Select Properties that contains number
    $ValueName = [int](($RegistryProperty.PSobject.Properties.Name | Measure-Object -Maximum).Maximum) + 1 #Find highest string number from ExtensionInstallForceList key and adds by 1
    $ValueType = 'String' #Change String, DWORD,MultiString registry value type
    $Value = $ExtensionID #Change Extension ID
    
    # Create ExtensionInstallForceList key if it does not exist
    if (!($registryKey.Name)){
        Write-Output "[$RegistryKeyName]: Creating registry key"
        New-Item -Path $RegistryPath -Name $RegistryKeyName -Force
    } 
    
    if ($RegistryProperty -match $Value){
        Write-Output "[$RegistryKeyName]: Key Found, skipped."
    } Elseif ($RegistryPath -notmatch $Value){
        Write-Output "[$RegistryKeyName]: Creating $ValueName $ValueType $Value"
        New-ItemProperty -Path $RegistryPath\$RegistryKeyName -PropertyType $ValueType -Name $ValueName -Value $Value -Force
    }

    
    # Automatically pin Extension by modifying ExtensionSettings string value. If string has existing value, it will keep existing and add-on to it.
    #=============================================================================================================================================
    $RegistryPath = 'HKLM:\SOFTWARE\Policies\Google\Chrome' #Change
    $RegistryProperties = Get-ItemProperty $RegistryPath
    $ToolBar_Pin = '{"toolbar_pin": "force_pinned" }' | ConvertFrom-Json
    $ValueName = 'ExtensionSettings' #Change
    $ValueType = 'String' #Change String, DWORD,MultiString registry value type
    $Value = [PSCustomObject]@{
        $ExtensionID = $ToolBar_Pin
    } | ConvertTo-Json
    
    #Create Hierarchy 

    # Pin Google Chrome Extensions
    if (!($RegistryProperties.ExtensionSettings)){ 
        Write-Output "$ValueName not found, creating $ValueName $ValueType $Value"
    
            New-ItemProperty -Path $RegistryPath -Name $ValueName -PropertyType $ValueType  -Value $Value -ErrorAction SilentlyContinue -Force #Create string
            Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value #Update String Value if ExtensionSettings value already created
        
    } ElseIf ($RegistryProperties.ExtensionSettings){
        Write-Output "[$ValueName]: Value found."
        
        if ($RegistryProperties.ExtensionSettings -match $ExtensionID){
            Write-Output "[$ValueName]: contains $ExtensionID, skipped."
        } ElseIf ($RegistryProperties.ExtensionSettings -notmatch $ExtensionID){
            Write-Output "[$ValueName]: does not contains $ExtensionID."
            Write-Output "[$ValueName] Adding $ExtensionID..."
            $ExistingValue_HashTable = $RegistryProperties.ExtensionSettings | ConvertFrom-Json
            $ExistingValue_HashTable | Add-Member -NotePropertyName $ExtensionID -NotePropertyValue $ToolBar_Pin
            $Value_JSON = $ExistingValue_HashTable | ConvertTo-Json
            Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value_JSON
        }
    }

#Ends
}
    
    Function Install-EdgeExtension {
    <#
    .SYNOPSIS
        Install Microsoft Edge Extension and automatically pin Extension to toolbar
    .EXAMPLE
        Install-EdgeExtension -ExtensionID cnlefmmeadmemmdciolhbnfeacpdfbkd
    .NOTES
        Author: Ngoc Nguyen 
    #>
        param (
            [Parameter(Position=0,mandatory=$true)]
            [string]$ExtensionID
        )

    # Install Edge Extension 
    #=========================
    $RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge\' #Change
    $RegistryKey =  Get-ChildItem $RegistryPath
    $RegistryKeyName = 'ExtensionInstallForcelist' #Change
    $RegistryProperty = Get-ItemProperty $RegistryPath\$RegistryKeyName | Select-Object '[0-9]*' #Select Properties that contains number
    $ValueName = [int](($RegistryProperty.PSobject.Properties.Name | Measure-Object -Maximum).Maximum) + 1 #Find highest string number from ExtensionInstallForceList key and adds by 1
    $ValueType = 'String' #Change String, DWORD,MultiString registry value type
    $Value = $ExtensionID #Change Extension ID
    
    # Create ExtensionInstallForceList key if it does not exist
    if (!($registryKey.Name)){
        Write-Output "[$RegistryKeyName]: Creating registry key"
        New-Item -Path $RegistryPath -Name $RegistryKeyName -Force
    } 
    
    if ($RegistryProperty -match $Value){
        Write-Output "[$RegistryKeyName]: Key Found, skipped."
    } Elseif ($RegistryPath -notmatch $Value){
        Write-Output "[$RegistryKeyName]: Creating $ValueName $ValueType $Value"
        New-ItemProperty -Path $RegistryPath\$RegistryKeyName -PropertyType $ValueType -Name $ValueName -Value $Value -Force
    }

    
    # Automatically pin Extension by modifying ExtensionSettings string value. If string has existing value, it will keep existing and add-on to it.
    #=============================================================================================================================================
    $RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Edge\' #Change
    $RegistryProperties = Get-ItemProperty $RegistryPath
    $ToolBar_Pin = '{ "toolbar_state": "force_shown" }' | ConvertFrom-Json
    $ValueName = 'ExtensionSettings' #Change
    $ValueType = 'String' #Change String, DWORD,MultiString registry value type
    $Value = [PSCustomObject]@{
        $ExtensionID = $ToolBar_Pin
    } | ConvertTo-Json
    

    # Pin Edge Extensions to Toolbar
    if (!($RegistryProperties.ExtensionSettings)){ 
        Write-Output "$ValueName not found, creating $ValueName $ValueType $Value"
    
            New-ItemProperty -Path $RegistryPath -Name $ValueName -PropertyType $ValueType  -Value $Value -ErrorAction SilentlyContinue -Force #Create string 
            Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value #Update String Value if ExtensionSettings value already created
        
    } ElseIf ($RegistryProperties.ExtensionSettings){
        Write-Output "[$ValueName]: Value found."
        
        if ($RegistryProperties.ExtensionSettings -match $ExtensionID){
            Write-Output "[$ValueName]: contains $ExtensionID, skipped."
        } ElseIf ($RegistryProperties.ExtensionSettings -notmatch $ExtensionID){
            Write-Output "[$ValueName]: does not contains $ExtensionID."
            Write-Output "[$ValueName] Adding $ExtensionID..."
            $ExistingValue_HashTable = $RegistryProperties.ExtensionSettings | ConvertFrom-Json
            $ExistingValue_HashTable | Add-Member -NotePropertyName $ExtensionID -NotePropertyValue $ToolBar_Pin
            $Value_JSON = $ExistingValue_HashTable | ConvertTo-Json
            Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value_JSON
        }
    }
    
    
    
    
#Ends
}
    
    


    Write-Output "Installing Chrome Extension and automatically pin extension...."
    Install-ChromeExtension -ExtensionID fgadldooeamdpekomjcdfgofahnplbde #Install EdgeCast MyGuidePlayer and pin Extension
    
    Write-Output "Installing Edge Extension and automatically pin extension...."
    Install-EdgeExtension -ExtensionID ppmjgfmomdebkmmclnphnoojnjaaodlj #Install EdgeCast MyGuidePlayer and pin Extension
    