# Basic Overview of Configuration

## Hosts
Hosts are given an IP address and a standard gateway. Students and Staff are in different subnets. The `/23` subnet gets split up into two `/24` subnets.
Hosts at switches *CERN* and *EPFL* use Router *GENE* as Router and Gateway, hosts at switch *EHTZ* use Router *ZURI*.

| Hostname | IP | 
| --- | ----------- | 
| staff_x | 19.200.0.x/24 | 
| student_x | 19.200.0.x/24 |

## Switches
Switches are configured to tag ports connected to staff with `VLAN 10`, ports with students with `VLAN 20`. Trunks exist between switches and from switches to routers.

## Routers
Routers are assigned two IP addresses each, one per virtual interface, that is, one per interface per VLAN. As they are connected via trunk with the switches, the incomming trafic gets split up onto `{ROUTERname}-L2.10` and `{ROUTERname}-L2`.20. Corresponding to the VLANs and different subnets, `L2.10` interfaces are assigned an IP in the `19.200.0.0/24` subnet and `L2.20` are in the `19.200.1.0/24` subnet.

| Router | VLAN | IP |
| --- | ----------- | ---|
| GENE | 10 | 19.200.0.100/24 |
| | 20 | 19.200.1.100/24 |
| ZURI | 10 | 19.200.0.200/24 |
| | 20 | 19.200.1.200/24 |

# Report

### Traceroute EPFL-student to EPFL-staff
```console
root@student_3:~# traceroute 19.200.0.3
traceroute to 19.200.0.3 (19.200.0.3), 30 hops max, 60 byte packets
 1  19.200.1.100 (19.200.1.100)  8.787 ms  8.309 ms  8.219 ms
 2  19.200.0.3 (19.200.0.3)  12.334 ms  11.103 ms  11.451 ms
```
### Traceroute ETHZ-staff to EPFL-student
```console
root@staff_2:~# traceroute 19.200.1.3
traceroute to 19.200.1.3 (19.200.1.3), 30 hops max, 60 byte packets
 1  19.200.0.200 (19.200.0.200)  4.062 ms  3.402 ms  3.400 ms
 2  19.200.1.3 (19.200.1.3)  13.809 ms  13.799 ms  13.832 ms
```
### Traceroute EPFL-student to ETHZ-staff
```console
root@student_3:~# traceroute 19.200.0.2
traceroute to 19.200.0.2 (19.200.0.2), 30 hops max, 60 byte packets
 1  19.200.1.100 (19.200.1.100)  6.800 ms  6.189 ms  6.093 ms
 2  19.200.0.2 (19.200.0.2)  14.132 ms  13.984 ms  14.051 ms
```

Since every traceroute is between subnets and respective VLANs, that is between staff's `VLAN 10` and subnet `19.200.0.0/24` and student's `VLAN 20` and subnet `19.200.1.0/24`, the respective host uses it's standard gateway as configured above to send the packet to the router. The router then sends the packet to over the corresponding interface to the recipient.
