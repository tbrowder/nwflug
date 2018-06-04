title: Home Network and Opnsense
<!-- insert-file headers.md -->
date: 2018-06-04

## Overview

Using a new Win 10 computer and modifying my home network.

## Specifics

WAN
|
CenturyLink modem (wireless off, dhcp on) LAN IP 192.168.0.1
|
| <== intended future opnsense firewall placement
|
TP-Link 8-port managed switch IP 192.168.0.2

6 ports enabled:

1 CenturyLink modem/router
2 printer
3 Win10 new computer (will become opnsense firewall later)
4 Win10 old computer
5 TP-Link AC1750 wireless router (as access point) IP 192.168.0.3
6 power line router

The network works, and I can access the three static devices through
the Win10 computers.

## Questions

0. Other than turning off the firewall in the CenturyLink router, are there any other of its settings I should change?

1. Can the appliance be used as the router in place of the CenturyLink router?

  a. If so, should it be used as the router?

  b. If so, anything special to do other than turn off dhcp in the CenturyLink router?
