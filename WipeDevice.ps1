# Kill OneDrive to prevent removing data from OneDrive/SharePoint Cloud
Get-Process -Name *onedrive* | Stop-Process -Force

$ExcludeList = @(
    '$Windows.~BT'
    'PerfLogs'
    'Program Files'
    'Program Files (x86)'
    'Windows'
)

# Exclude Windows System Path
$CDrive_File = Get-ChildItem C:\  | Where {$ExcludeList -notcontains $_.Name}

# Remove non-system files
$CDrive_File | % {
    $_ | Remove-Item -Recurse -Force
}

# Stop all processes and trigger logoff.exe to unload the profile
Get-Process | Stop-Process
Start-Process Logoff.exe -Wait

# Remove UserProfile
Get-CimInstance -Class Win32_UserProfile | % { 
    $_ | Remove-CimInstance
}


# Remote Wipe PC
$namespaceName = "root\cimv2\mdm\dmmap"
$className = "MDM_RemoteWipe"
$methodName = "doWipeMethod"
$session = New-CimSession
$params = New-Object Microsoft.Management.Infrastructure.CimMethodParametersCollection
$param = [Microsoft.Management.Infrastructure.CimMethodParameter]::Create("param", "", "String", "In")
$params.Add($param)
try
{
    $instance = Get-CimInstance -Namespace $namespaceName -ClassName $className -Filter "ParentID='./Vendor/MSFT' and InstanceID='RemoteWipe'"
    $session.InvokeMethod($namespaceName, $instance, $methodName, $params)
}
catch [Exception]
{
    write-host $_ | out-string
}

