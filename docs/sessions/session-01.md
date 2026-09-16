# Session 01 - Azure to Windows Server to AD DS and DNS

## Objective
Build the first Domain Controller of the AriWS Azure home lab from scratch.

## Completed
1. Created/used the Azure lab subscription and resource group.
2. Deployed resources in Switzerland North.
3. Built ariws-vnet-main and used snet-servers (10.10.2.0/24).
4. Created Windows Server VM ariws-vm-srv01.
5. Restricted RDP through ariws-nsg-servers.
6. Set private IP 10.10.2.4 to static in Azure.
7. Installed AD DS and DNS.
8. Promoted the server with Add a new forest.
9. Created domain ad.ari-ws.ch with NetBIOS ARIWS.
10. Verified AD domain/DC discovery and DNS zones.
11. Troubleshot LDAP SRV lookup returning NXDOMAIN.
12. Refreshed Netlogon/DNS registration and verified the SRV record.
13. Ran dcdiag.
14. Deallocated the VM after the lab for compute cost control.

## Commands used

    Get-ADDomainController
    Get-ADDomain
    Get-DnsClientServerAddress -AddressFamily IPv4
    nslookup ad.ari-ws.ch
    nslookup ariws-vm-srv01.ad.ari-ws.ch
    Get-DnsServerZone
    Get-DnsServerResourceRecord -ZoneName "_msdcs.ad.ari-ws.ch"
    Restart-Service Netlogon
    ipconfig /registerdns
    nltest /dsregdns
    nslookup -type=SRV _ldap._tcp.dc._msdcs.ad.ari-ws.ch
    dcdiag

## Next session
- Design OU hierarchy
- Create users and security groups
- Deploy Windows 11 client
- Configure client DNS to use the DC
- Join client to ad.ari-ws.ch
- Test domain logon
- Start Group Policy