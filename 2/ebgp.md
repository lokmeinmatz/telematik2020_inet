# 2.1: eBGP
## Function of `next-hop-self`
Since routing within the AS between routers belonging to the same AS shouldn't be determined by BGP, routers within the AS shouldn't add themselves to the respective paths when propagating routing information through the network.  
Because of that, the routers bordering a different AS don't add themselves onto the path provided by external routers when forwarding the info to their interal BGP partners. This is problematic because now these routers are missing the address of the router able to reach the advertised AS. Therefore, routers bordering a different AS need to set themselves as the next hop when forwarding the information to iBGP partners. This ensures that these partners know how to reach the targets known to the border router.

## PARI bgp table (shortened report)
``` console
PARI_router# sho ip bgp
...
   Network          Next Hop            Metric LocPrf Weight Path
*> 1.0.0.0/8        179.0.92.1                             0 20 1 i
* i                 19.152.0.1                    100      0 18 1 i
* i                 19.157.0.1                    100      0 22 1 i
*>i2.0.0.0/8        19.155.0.1               0    100      0 2 i
*  3.0.0.0/8        179.0.92.1                             0 20 1 3 i
*>i                 19.155.0.1                    100      0 2 3 i
*> 5.0.0.0/8        179.0.92.1                             0 20 5 i
* i                 19.152.0.1                    100      0 18 5 i
* i                 19.155.0.1                    100      0 8 5 i
...
*>i14.0.0.0/8       19.155.0.1               0    100      0 14 i
*>i15.0.0.0/8       19.155.0.1                    100      0 8 15 i
*> 16.0.0.0/8       179.0.92.1                             0 20 7 16 i
* i                 19.155.0.1                    100      0 8 7 16 i
*>i17.0.0.0/8       19.151.0.1               0    100      0 17 i
* i                 19.156.0.1               0    100      0 17 i
*                   179.0.92.1                             0 20 17 i
*>i18.0.0.0/8       19.152.0.1               0    100      0 18 i
*                   179.0.92.1                             0 20 18 i
* i19.0.0.0/8       19.155.0.1               0    100      0 i
*>i                 19.152.0.1               0    100      0 i
*> 20.0.0.0/8       179.0.92.1               0             0 20 i
* i21.0.0.0/8       19.158.0.1               0    100      0 21 i
*>i                 19.154.0.1               0    100      0 21 i
*>i22.0.0.0/8       19.157.0.1               0    100      0 22 i
...
* i                 19.155.0.1                    100      0 8 15 17 i
``` 

## Looking Glass from AS 20 (router: LOND)
``` console
2021-02-18T17:54:19
...

   Network          Next Hop            Metric LocPrf Weight Path
...
*>i19.0.0.0/8       20.153.0.1                    100      0 19 i
...
Displayed  34 routes and 57 total paths
```

## Traceroute to PARI host from AS 20
``` console
root@PARI_host:~# traceroute 20.153.0.1
traceroute to 20.153.0.1 (20.153.0.1), 30 hops max, 60 byte packets
 1  PARI-host.group19 (19.103.0.2)  0.537 ms  0.119 ms  0.062 ms
 2  20.153.0.1 (20.153.0.1)  2.172 ms  2.160 ms  2.126 ms
```