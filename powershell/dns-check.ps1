# AriWS DNS checks
$Domain = "ad.ari-ws.ch"
$DcFqdn = "ariws-vm-srv01.ad.ari-ws.ch"
$SrvRecord = "_ldap._tcp.dc._msdcs.ad.ari-ws.ch"
Get-DnsServerZone
nslookup $Domain
nslookup $DcFqdn
nslookup -type=SRV $SrvRecord