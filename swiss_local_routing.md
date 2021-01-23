# Basic Overview of Configuration

## Hosts
Hosts are given an IP address and a standard gateway. Students and Staff are in different subnets. The /23 subnet gets split up into two /24 subnets.
Hosts at switches *CERN* and *EPFL* use Router *GENE* as Router and Gateway, hosts at switch *EHTZ* use Router *ZURI*.

| Hostname | IP | 
| --- | ----------- | 
| staff_x | 19.200.0.x/24 | 
| student_x | 19.200.0.x/24 |

## Switches
Switches are configured to tag ports connected to staff with VLAN 10, ports with students with VLAN 20. Trunks exist between switches and from switches to routers.

## Routers
Routers are assigned two IP addresses each, one per virtual interface, that is, one per interface per VLAN. As they are connected via trunk with the switches, the incomming trafic gets split up onto ROUTER-L2.10 and ROUTER-L2.20. Corresponding to the VLANs and different subnets, L2.10 interfaces are assigned an IP in the 19.200.0.0/24 subnet and L2.20 are in the 19.200.1.0/24 subnet.

| Router | VLAN | IP |
| --- | ----------- | ---|
| GENE | 10 | 19.200.0.100/24 |
| | 20 | 19.200.1.100/24 |
| ZURI | 10 | 19.200.0.200/24 |
| | 20 | 19.200.1.200/24 |