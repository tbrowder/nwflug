title: Home Network and Opnsense
<!-- insert-file headers.md -->
date: 2018-06-04

## Overview

Status of my home computer network project to:

+ upgrade to a new Win 10 computer
+ modify my home network per Kevin's and Chris's suggestions

## WAN to LAN

WAN => CenturyLink modem (10 Mbps)

+ wireless off, dhcp on
+ IP 192.168.0.1

## LAN

| <== future opnsense virtual firewall (HYPER-V)

TP-Link 8-port managed switch

+ IP 192.168.0.2

## SWITCH

6 ports enabled

- CenturyLink modem/router
- printer
- Win10 new computer (will host opnsense firewall VM later)
- Win10 old computer
- TP-Link AC1750 wireless router (as access point) IP 192.168.0.3
- Panasonic BL-PA300A power line NIC (30 Mbps)

## Other Devices

+ One network extender
+ One Linux laptop
+ Multiple Apple devices (iPhone, iPad, Appl TV)
+ Smart DVD (for streaming video)

## STATUS

+ The network works
+ I can access the three static devices through
  the Win10 computers

## Questions

+ Other than turning off the firewall in the CenturyLink router, are
   there any other of its settings I should change?
+ Can the appliance be used as the router in place of the CenturyLink
   router?

   - If so, should it be used as the router?
   - If so, anything special to do other than turn off dhcp in the CenturyLink router?
