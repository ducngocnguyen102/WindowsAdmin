$WiFIAdapter = Get-DnsClientServerAddress | Where-Object {$_.InterfaceAlias -eq 'Wi-FI'}
$WiFIAdapter | % {
    if ($_.ServerAddresses -match "127.0.0.1")
    {
        Write-Output "Resetting ServerAddresses"
        Set-DnsClientServerAddress -InterfaceIndex $_.InterfaceIndex -ResetServerAddresses         $_.InterfaceIndex
    }
}