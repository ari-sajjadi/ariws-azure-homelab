# 02 - Azure Networking

## Configuration
- VNet: ariws-vnet-main
- Server subnet: snet-servers
- CIDR: 10.10.2.0/24
- DC private IP: 10.10.2.4
- NSG: ariws-nsg-servers

## Traffic path
Admin PC -> Internet -> Public IP -> NSG -> Azure NIC -> 10.10.2.4 -> ariws-vm-srv01

## RDP security
RDP uses TCP 3389. The lab restricted RDP to the administrator's current public IP instead of exposing it to the entire Internet.

## Key lesson
The Public IP is for remote administration. AD and DNS depend on internal networking and the stable private IP.

> Never commit the administrator public IP to this public repository.
