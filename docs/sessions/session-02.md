# Session 02 - AD Users, Groups, NTFS and SMB Shares

Date: 2026-09-16

## Objective
Extend the AriWS domain into a small company-style identity and file-access lab.

## Starting point
- Domain: ad.ari-ws.ch
- NetBIOS: ARIWS
- Domain Controller / DNS server: ariws-vm-srv01.ad.ari-ws.ch
- Server private IP: 10.10.2.4
- Windows Server 2022 Datacenter Azure Edition

## Completed

### 1. Organizational Unit structure
Created the company OU structure under AriWS:

    OU=AriWS
    ├── OU=Users
    │   ├── OU=IT
    │   ├── OU=Management
    │   ├── OU=Sales
    │   └── OU=Support
    ├── OU=Computers
    ├── OU=Servers
    ├── OU=Groups
    └── OU=ServiceAccounts

### 2. Department users
Configured these lab identities:

| User | UPN | Department | Title |
|---|---|---|---|
| Ari Sajjadi | ari.sajjadi@ad.ari-ws.ch | Management | CEO |
| Ashkan Sajjadi | ashkan.sajjadi@ad.ari-ws.ch | Sales | Sales Manager |
| Pariya Rasti | pariya.rasti@ad.ari-ws.ch | Management | HR Manager |
| Ladan Sajjadi | ladan.sajjadi@ad.ari-ws.ch | Support | Support Manager |
| Bahareh Sajjadi | bahareh.sajjadi@ad.ari-ws.ch | Support | Support Employee |
| Samira Yari | samira.yari@ad.ari-ws.ch | Sales | Sales Employee |
| Mahdi Amini | mahdi.amini@ad.ari-ws.ch | IT | IT Support |
| Mahmood Amini | mahmood.amini@ad.ari-ws.ch | IT | IT Administrator |

Note: Lab passwords are intentionally NOT stored in GitHub.

### 3. Security groups
Created:
- GG_Management
- GG_HR
- GG_Sales
- GG_Support
- GG_IT
- GG_IT_Admins

Verified membership:
- GG_Management -> Ari Sajjadi
- GG_HR -> Pariya Rasti
- GG_Sales -> Ashkan Sajjadi, Samira Yari
- GG_Support -> Ladan Sajjadi, Bahareh Sajjadi
- GG_IT -> Mahdi Amini, Mahmood Amini
- GG_IT_Admins -> Mahmood Amini

### 4. File server folder structure
Created:

    C:\CompanyData
    ├── Management
    ├── HR
    ├── Sales
    ├── Support
    └── IT

### 5. NTFS permissions
Disabled inherited permissions on the department folders and applied group-based access.

| Folder | Department group | Department access | IT admin access |
|---|---|---|---|
| Management | GG_Management | Modify | GG_IT_Admins: Full Control |
| HR | GG_HR | Modify | GG_IT_Admins: Full Control |
| Sales | GG_Sales | Modify | GG_IT_Admins: Full Control |
| Support | GG_Support | Modify | GG_IT_Admins: Full Control |
| IT | GG_IT | Modify | GG_IT_Admins: Full Control |

SYSTEM and BUILTIN\\Administrators retain Full Control.

Example:

    icacls "C:\CompanyData\Sales" /inheritance:r

    icacls "C:\CompanyData\Sales" /grant:r `
      "ARIWS\GG_Sales:(OI)(CI)M" `
      "ARIWS\GG_IT_Admins:(OI)(CI)F" `
      "BUILTIN\Administrators:(OI)(CI)F" `
      "NT AUTHORITY\SYSTEM:(OI)(CI)F"

Permission flags learned:
- (OI) = Object Inherit
- (CI) = Container Inherit
- (F) = Full Control
- (M) = Modify
- (I) = Inherited

### 6. SMB shares
Published all five department folders through SMB:

    \\ariws-vm-srv01\Management
    \\ariws-vm-srv01\HR
    \\ariws-vm-srv01\Sales
    \\ariws-vm-srv01\Support
    \\ariws-vm-srv01\IT

Share permissions were verified:

| Share | Change | Full |
|---|---|---|
| Management | ARIWS\GG_Management | ARIWS\GG_IT_Admins |
| HR | ARIWS\GG_HR | ARIWS\GG_IT_Admins |
| Sales | ARIWS\GG_Sales | ARIWS\GG_IT_Admins |
| Support | ARIWS\GG_Support | ARIWS\GG_IT_Admins |
| IT | ARIWS\GG_IT | ARIWS\GG_IT_Admins |

### 7. Concepts learned
Access model:

    User
      -> AD Security Group
      -> SMB Share Permission
      -> NTFS Permission
      -> Folder / Files

Authentication answers: "Who are you?"
Authorization answers: "What are you allowed to access?"

Permissions are assigned to security groups rather than directly to individual users. This makes onboarding, offboarding and role changes easier to manage.

For network file access, both SMB share permissions and NTFS permissions apply. Effective access is constrained by the permissions that apply at both layers.

## Verification commands

    Get-ADUser -Filter * -SearchBase "OU=Users,OU=AriWS,DC=ad,DC=ari-ws,DC=ch" -Properties UserPrincipalName,Department,Title,Enabled

    Get-ADGroupMember -Identity "GG_Sales"

    icacls "C:\CompanyData\Sales"

    Get-SmbShare

    Get-SmbShareAccess -Name Sales

## Current checkpoint
AD users/groups, department folders, NTFS permissions and SMB shares are configured and verified.

## Next session
1. Create Windows 11 client VM: ariws-vm-client01.
2. Put the client on the AriWS Azure virtual network.
3. Configure client DNS to use 10.10.2.4.
4. Verify DNS/DC discovery from the client.
5. Join Windows 11 to ad.ari-ws.ch.
6. Test domain sign-in with department users.
7. Test SMB authorization:
   - Samira -> Sales allowed; HR denied.
   - Pariya -> HR allowed; Sales denied.
   - Mahmood -> administrative access according to GG_IT_Admins.
8. Begin Group Policy (GPO) configuration.
9. Deallocate VMs when the lab session is finished to reduce Azure compute charges.
