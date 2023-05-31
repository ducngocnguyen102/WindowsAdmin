$Creds = Get-Credential
Start-Process -FilePath PowerShell.exe -ArgumentList "Start-Process -FilePath quickassist.exe -Verb Runas" -Credential $Creds


