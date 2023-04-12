function Get-FolderSize {
    [CmdletBinding()]
    Param (
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
    $Path
    )
    if ( (Test-Path $Path) -and (Get-Item $Path).PSIsContainer ) {
        $Measure = Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
        $Sum = '{0:N2}' -f ($Measure.Sum / 1Gb)
        [PSCustomObject]@{
            "Path" = $Path
            "Size($Gb)" = $Sum
        }
    }
}

$Path = "E:\Shares\Users\XXX-SetToDelete"
$Drive = Get-ChildItem $Path
$Output = $Drive | % {

    $FolderPath = $Path + "\" + $_.Name
    Get-FolderSize -Path $FolderPath
}

$Output | Export-Csv C:\Temp\UserDrive.csv