# 1.5: iBGP

Each router was fed the following commands under `route bgp 19`:

```
neighbor 19.157.0.1 remote-as 19
neighbor 19.157.0.1 update-source lo
neighbor 19.157.0.1 next-hop-self
```



## BGP summary of ATLA:
``` console
ATLA_router# sho ip bg sum

IPv4 Unicast Summary:
BGP router identifier 19.157.0.1, local AS number 19 vrf-id 0
BGP table version 0
RIB entries 0, using 0 bytes of memory
Peers 7, using 143 KiB of memory

Neighbor        V         AS MsgRcvd MsgSent   TblVer  InQ OutQ  Up/Down State/PfxRcd
19.151.0.1      4         19      85      83        0    0    0 01:06:17            0
19.152.0.1      4         19      68      74        0    0    0 01:05:59            0
19.153.0.1      4         19      67      74        0    0    0 01:04:28            0
19.154.0.1      4         19      67      74        0    0    0 01:04:01            0
19.155.0.1      4         19      66      72        0    0    0 01:03:31            0
19.156.0.1      4         19      66      74        0    0    0 01:03:08            0
19.158.0.1      4         19      11      11        0    0    0 00:08:18            0

Total number of neighbors 7
```

## Necessity of update-source 
The command `update-source` needs to be used because the BGP-Session is established via the IP bound to the interface specified in the routing table as outgoing for the IP address of the partner. A temporary or permanent defect of this interface would tear down the connection, even though the router itself might still be online via one of the other interfaces. The command `update-source` allows binding the session to the IP and corresponding loopback interface, which will always be reachable as long as there is still a connection to the network.