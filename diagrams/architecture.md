# Architecture

## Current state

    Admin PC
       | RDP TCP 3389
       v
    Public IP
       v
    ariws-nsg-servers
       v
    Azure NIC
       v
    snet-servers (10.10.2.0/24)
       v
    ariws-vm-srv01 (10.10.2.4)
       +-- AD DS: ad.ari-ws.ch
       +-- DNS
       +-- Global Catalog

## Phase 2 target

Windows 11 Client -> DNS 10.10.2.4 -> Domain Controller -> ad.ari-ws.ch
                                          |
                                          +-> OUs / Users / Groups
                                          +-> Group Policy