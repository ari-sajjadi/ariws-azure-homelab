# 03 - Windows Server

## Server
- Hostname: ariws-vm-srv01
- OS: Windows Server 2022 Datacenter: Azure Edition
- VM size: Standard D2als v6
- 2 vCPU / 4 GiB RAM
- Private IP: 10.10.2.4

## Installed roles
- Active Directory Domain Services
- DNS Server

## Why static private IP?
A Domain Controller that also provides DNS must be reachable at a predictable internal address. The Azure NIC private IP allocation for 10.10.2.4 was therefore configured as static.
