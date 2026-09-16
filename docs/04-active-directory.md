# 04 - Active Directory

## Forest and domain
- Forest root domain: ad.ari-ws.ch
- NetBIOS: ARIWS
- First DC: ariws-vm-srv01.ad.ari-ws.ch
- DC/DNS private IP: 10.10.2.4

## Server roles after promotion
- Domain Controller
- AD DS
- DNS
- Global Catalog

## Concepts
**Forest** - top-level logical AD structure.

**Domain** - administrative and naming unit containing directory objects.

**Domain Controller** - server hosting AD DS and authenticating domain identities.

**Global Catalog** - searchable partial representation of forest objects.

**Kerberos** - primary AD authentication protocol.

**LDAP** - protocol used to query/interact with directory services.

**SYSVOL** - replicated domain folder used for Group Policy and related domain data.
