# Automatically pin Extension by modifying ExtensionSettings string value. If string has existing value, it will keep existing and add-on to it.
#=============================================================================================================================================
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Google\Chrome' #Change
$RegistryProperties = Get-ItemProperty $RegistryPath
$ValueName = 'ExtensionSettings' #Change
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = '{"fgadldooeamdpekomjcdfgofahnplbde":{"toolbar_pin":"force_pinned"}}' #Change <fgadldooeamdpekomjcdfgofahnplbde>
$ExtensionID = 'fgadldooeamdpekomjcdfgofahnplbde' #Change
$ToolBar_Pin = '{"toolbar_pin": "force_pinned" }' | ConvertFrom-Json


if (!($RegistryProperties.ExtensionSettings)){ 
    Write-Output "$ValueName not found, creating $ValueName $ValueType $Value"

        New-ItemProperty -Path $RegistryPath -Name $ValueName -PropertyType $ValueType  -Value $Value -ErrorAction SilentlyContinue #Create string
        Set-ItemProperty -Path $RegistryPath -Name $ValueName -Value $Value #Update String Value if ExtensionSettings value already created
    
} ElseIf ($RegistryProperties.ExtensionSettings){
    Write-Output "Found $ValueName ..."
    
    if ($RegistryProperties.ExtensionSettings -match $ExtensionID){
        Write-Output "$ValueName $ValueType contains $ExtensionID, terminating script... no action required."
    } ElseIf ($RegistryProperties.ExtensionSettings -notmatch $ExtensionID){
        Write-Output "Missing $ExtensionID value in $ValueName..."
        Write-Output "Adding $ExtensionID to $ValueName"
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
$RegistryKeyName = 'ExtensionInstallForceList' #Change
$RegistryProperty = Get-ItemProperty $RegistryPath\$RegistryKeyName | Select '[0-9]*' #Select Properties that contains number
$ValueName = [int](($RegistryProperty.PSobject.Properties.Name | Measure-Object -Maximum).Maximum) + 1 #Find highest string number from ExtensionInstallForceList key and adds by 1
$ValueType = 'String' #Change String, DWORD,MultiString registry value type
$Value = "fgadldooeamdpekomjcdfgofahnplbde" #Change Extension ID

# Create ExtensionInstallForceList key if it does not exist
if (!($registryKey.Name)){
    Write-Output "Creating registry key $RegistryKeyName"
    New-Item -Path $RegistryPath -Name $RegistryKeyName
} 

if ($RegistryProperty -match $Value){
    Write-Output "$Value found, skipped."
} Elseif ($RegistryPath -notmatch $Value){
    Write-Output "Creating $ValueName $ValueType $Value"
    New-ItemProperty -Path $RegistryPath\$RegistryKeyName -PropertyType $ValueType -Name $ValueName -Value $Value
}
