# telematik2020_inet


# FU Telematics 20/21 Project 2 - Mini Internet
## Group 19
## by Corin Baurmann, Karl Skomski, Justus Purat, Matthias Kind

This repository contains documentation and backups of configuration of our autonomous system in the Telematik 2020/21 mini internet project at Freie Universität Berlin. The project is derived from the [Mini Internet Project](https://github.com/nsg-ethz/mini_internet_project) of ETH Zürich.
[Final PDF](./Telematik%2020_21%20FU%20Berlin%20Mini-Inet%20AS19.pdf)

## Contents
[This](./netmap.png) netmap shows the overall network topology.

### 1 - Internal Networking
- [1.1: VLAN and Swiss network](./1/swiss_local_routing.md)
- [1.2: OSPF basics](./1/ospf_intra_routing.md)
- [1.3: OSPF Cost adjusted to Network type 4](./1/ospf_cost.md)
- [1.4: No transit through swiss local](./1/no_transit_swiss_local.md)
- [1.5: iBGP](#1.5)

### 2 - eBGP
- [2.1: eBGP](./2/ebgp.md)
- [2.2: IXP Peering](./2/ixp_community_vals.md)

### 3 - Policies
- [3.1: Business relationships](./3/policy_routing.md)
- [3.2: IXP policy](./3/ixp_policy.md)
- [3.3 / 3.4: eBGP Load balancing](./3/incoming_balancing.md)
- [3.5: BGP Hijack](./3/hijack.md)
