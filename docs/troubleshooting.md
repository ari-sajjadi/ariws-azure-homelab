# Troubleshooting Runbook

Follow layers instead of changing random settings.

## 1. Azure layer
- VM running?
- NIC attached?
- Private IP still 10.10.2.4?
- Correct NSG rule?

## 2. Windows networking
    ipconfig /all
    Get-DnsClientServerAddress -AddressFamily IPv4

## 3. DNS
    nslookup ad.ari-ws.ch
    nslookup ariws-vm-srv01.ad.ari-ws.ch
    nslookup -type=SRV _ldap._tcp.dc._msdcs.ad.ari-ws.ch

## 4. Active Directory
    Get-ADDomain
    Get-ADDomainController
    dcdiag

## 5. DNS re-registration when appropriate
    Restart-Service Netlogon
    ipconfig /registerdns
    nltest /dsregdns

## Session 01 incident
The LDAP DC SRV lookup initially returned NXDOMAIN. AD DNS zones were inspected, registration was refreshed, and nltest /dsregdns completed successfully. The final SRV query resolved the DC on LDAP port 389.

Key lesson: for domain join and authentication problems, verify DNS early.