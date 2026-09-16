# AriWS Domain Controller health check
Write-Host "=== AD Domain ==="
Get-ADDomain
Write-Host "`n=== Domain Controller ==="
Get-ADDomainController
Write-Host "`n=== DNS Client ==="
Get-DnsClientServerAddress -AddressFamily IPv4
Write-Host "`n=== DCDIAG ==="
dcdiag