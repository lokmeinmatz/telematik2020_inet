# 1.4: No transit trough swiss local
## Technique
We stopped routing through the swiss local network by not changing the default weights of the links of the two routers *GENE* and *ZURI* into the swiss local network. The default weight has the value of **10**, where as the route between *ZURI* and *GENE* traversing *PARI* has a weight of **4** in our network cost configuration explained in [ospf_cost.md](./ospf_cost.md).  

The routing of all packets from *ZURI* to *PARI-host* over *GENE* explicitly is guaranteed by a static route at *ZURI*, routing pakets addressed to *PARI-host* to the Interface of *GENE* within the swiss local network `VLAN 10` with IP address `19.200.0.100`.  
Another static route at *GENE* forwards then forwards these pakets to *PARI*, although this second static route shouldn't be necessary anymore because it is the shortest route in OSPF routing anyways.

## Traceroute from *staff_2* to *PARI-host*
```console
root@staff_2:~# traceroute 19.103.0.1
traceroute to 19.103.0.1 (19.103.0.1), 30 hops max, 60 byte packets
1  19.200.0.200 (19.200.0.200)  5.594 ms  4.769 ms  4.787 ms
2  19.200.0.100 (19.200.0.100)  8.212 ms  8.192 ms  8.123 ms
3  PARI-GENE.group19 (19.0.3.1)  7.994 ms PARI-ZURI.group19 (19.0.1.2)  7.413 ms PARI-GENE.group19 (19.0.3.1)  8.192 ms
4  host-PARI.group19 (19.103.0.1)  7.900 ms  7.880 ms  8.159 ms
```
Note: In line three a paket is received on the interface of *ZURI* directly connected to *PARI*. This is not because a paket was sent directly to *PARI* from *ZURI*, but because the cost of the route from *PARI* to *ZURI* directly is the same as the detour via *GENE*. Therefore the timeout ICMP packages get loadbalanced and one is sent directly.