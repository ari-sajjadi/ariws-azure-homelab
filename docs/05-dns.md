# 05 - DNS for Active Directory

DNS is fundamental to Active Directory. Clients use DNS for name resolution and service discovery.

## Important checks
    Get-DnsClientServerAddress -AddressFamily IPv4
    Get-DnsServerZone
    nslookup ad.ari-ws.ch
    nslookup ariws-vm-srv01.ad.ari-ws.ch
    nslookup -type=SRV _ldap._tcp.dc._msdcs.ad.ari-ws.ch

## SRV records
AD clients use SRV records to discover Domain Controllers and services such as LDAP.

Expected relationship:

    _ldap._tcp.dc._msdcs.ad.ari-ws.ch
                  -> ariws-vm-srv01.ad.ari-ws.ch
                  -> 10.10.2.4
                  -> LDAP TCP 389

## Re-registration used during troubleshooting
    Restart-Service Netlogon
    ipconfig /registerdns
    nltest /dsregdns
