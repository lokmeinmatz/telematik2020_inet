# telematik2020_inet
This repository contains documentation and backups of configuration of our autonomous system in the Telematik 2020/21 mini internet project at Freie Universität Berlin. The project is derived from the [Mini Internet Project](https://github.com/nsg-ethz/mini_internet_project) of ETH Zürich.

## Structure
[This](./netmap.png) netmap shows the overall network topology.
### Task 1: LAN and OSPF Routing
**1.1:** The document [swiss_local_routing.md](./swiss_local_routing.md) explains the configuration inside the local area network.  
**1.2:** The document [ospf_intra_routing.md](./ospf_intra_routing.md) documents the intra domain routing.  
**1.3:** The document [ospf_cost.md](./ospf_cost.md) documents the cost of various links in our network.  
**1.4:** The document [no_transit_swiss_local.md](./no_transit_swiss_local.md) documents how transit through swiss local gets prevented and *PARI-host* is reached differently  
**1.5:** The document [ibgp.md](./ibgp.md) documents which iBGP sessions are established and how.