$ExtensionID = 'fgadldooeamdpekomjcdfgofahnplbde' #Enter Extension ID you would want to push 

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

        New-ItemProperty -Path $RegistryPath -Name $ValueName -PropertyType $ValueType  -Value $Value -ErrorAction SilentlyContinue #Create string
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
$RegistryProperty = Get-ItemProperty $RegistryPath\$RegistryKeyName | Select '[0-9]*' #Select Properties that contains number
$ValueName = [int](($RegistryProperty.PSobject.Properties.Name | Measure-Object -Maximum).Maximum) + 1 #Find highest string number from ExtensionInstallForceList key and adds by 1
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = $ExtensionID #Change Extension ID

# Create ExtensionInstallForceList key if it does not exist
if (!($registryKey.Name)){
    Write-Output "[$RegistryKeyName]: Creating registry key"
    New-Item -Path $RegistryPath -Name $RegistryKeyName
} 

if ($RegistryProperty -match $Value){
    Write-Output "[$RegistryKeyName]: Key Found, skipped."
} Elseif ($RegistryPath -notmatch $Value){
    Write-Output "[$RegistryKeyName]: Creating $ValueName $ValueType $Value"
    New-ItemProperty -Path $RegistryPath\$RegistryKeyName -PropertyType $ValueType -Name $ValueName -Value $Value
}
