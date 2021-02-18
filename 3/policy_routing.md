# 3.1: Business relationships

### Example of route-maps
We tagged the incoming bgp routes on all customer / provider routers with the AS they came from with the schema 19:\<AS-Nr>

For example from `sh run` on LOND router (conn. to provider 1 / AS 17):
``` console
route-map TAG_17 permit 10
    set community 19:17
```

route-map TAG_17 tags all incoming routes from AS 17 with 19:17 to filter them for the IXP eBGP connections.

<br>

``` console
bgp community-list 20 permit 19:21
bgp community-list 20 permit 19:22
```

creates a community list nr. 20, which matches on the tags from AS 21 and 22

<br>

``` console
route-map PROVIDER_FILTER permit 10
 match community 20
 set community none
...
ip prefix-list our_prefix seq 5 permit 19.0.0.0/8
...
route-map PROVIDER_FILTER permit 11
 match ip address prefix-list our_prefix
```

creates the route-map `PROVIDER_FILTER`, which only permits bgp routes to the provider, which either came from  community list 20 (AS 21 / 22 aka. our customers) or our own 19.0.0.0/8 prefix and also clears our internal community tags.
    
<br>

``` console
router bgp 19
    neighbor 179.0.91.1 route-map TAG_17 in
    neighbor 179.0.91.1 route-map PROVIDER_FILTER out
```
activates the two route-maps for in and out on the interface towards AS 17.

## Intermezzo
> Up until this point, we considered the requirements to configure our advertisements according to the customer/provider relationships without the additional information of what was expected in the report of 3.1 and the following requirements of task 3.2, namely that peers should **only** now about our and our customers prefix (3.1 report info) and that we should not peer with IXP participants in our region (3.2 requirements).  
>
>We will therefore from this point on revise the route-maps provided and explained in [2.2: IXP Peering](../2/ixp_community_vals.md) to adhere to the new (or better: newly evident) requirements.

### Peering
At NEWY facing the IXP82 and PARI facing our PEER AS20 we made sure to only export our routes and those of our customers with the community and prefix lists outlined above and to only accept routes incoming from the other region. The latter we achieved by creating a route-map matching an as-path with regex and denying routes going to AS's 15,17,21,23, and 25.

### Looking Glass of Peer AS20
``` console
2021-02-18T20:38:39
BGP table version is 570014, local router ID is 20.153.0.1, vrf id 0
Default local pref 100, local AS 20
Status codes:  s suppressed, d damped, h history, * valid, > best, = multipath,
               i internal, r RIB-failure, S Stale, R Removed
Nexthop codes: @NNN nexthop's vrf id, < announce-nh-self
Origin codes:  i - IGP, e - EGP, ? - incomplete

   Network          Next Hop            Metric LocPrf Weight Path
*>i1.0.0.0/8        20.155.0.1               0    100      0 1 i
*>i2.0.0.0/8        20.155.0.1                    100      0 1 3 2 i
*>i3.0.0.0/8        20.155.0.1                    100      0 1 3 i
*>i5.0.0.0/8        20.155.0.1               0    100      0 5 i
*>i6.0.0.0/8        20.155.0.1                    100      0 1 3 2 8 6 i
*>i7.0.0.0/8        20.155.0.1               0    100      0 7 i
*>i8.0.0.0/8        20.155.0.1                    100      0 1 3 2 8 i
*>i9.0.0.0/8        20.155.0.1               0    100      0 9 i
*>i10.0.0.0/8       20.155.0.1                    100      0 7 10 i
*>i11.0.0.0/8       20.155.0.1               0    100      0 11 i
*>i12.0.0.0/8       20.155.0.1                    100      0 7 9 12 i
*>i13.0.0.0/8       20.155.0.1               0    100      0 13 i
*>i14.0.0.0/8       20.155.0.1                    100      0 11 14 i
*>i16.0.0.0/8       20.155.0.1                    100      0 7 16 i
*>i17.0.0.0/8       20.152.0.1               0    100      0 17 i
* i18.0.0.0/8       20.156.0.1               0    100      0 18 i
*>i                 20.151.0.1               0    100      0 18 i
*> 19.0.0.0/8       179.0.92.2                             0 19 i
* i20.0.0.0/8       20.155.0.1               0    100      0 i
* i                 20.157.0.1               0    100      0 i
* i                 20.158.0.1               0    100      0 i
* i                 20.154.0.1               0    100      0 i
* i                 20.151.0.1               0    100      0 i
* i                 20.156.0.1               0    100      0 i
*>                  0.0.0.0                  0         32768 i
* i                 20.152.0.1               0    100      0 i
*> 21.0.0.0/8       179.0.92.2                             0 19 21 i
* i22.0.0.0/8       20.155.0.1                    100      0 7 22 i
*>                  179.0.92.2                             0 19 22 i
* i23.0.0.0/8       20.155.0.1                    100      0 7 22 23 i
*>                  179.0.92.2                             0 19 21 23 i
*>i24.0.0.0/8       20.155.0.1                    100      0 7 24 i
*                   179.0.92.2                             0 19 21 24 i
*>i25.0.0.0/8       20.155.0.1                    100      0 7 24 25 i
*>i26.0.0.0/8       20.155.0.1                    100      0 7 26 i
* i176.0.0.0/4      20.156.0.1                    100      0 18 17 i
*>i                 20.151.0.1                    100      0 18 17 i
* i179.0.12.0/24    20.156.0.1                    100      0 18 17 i
*>i                 20.151.0.1                    100      0 18 17 i
* i179.0.16.0/24    20.156.0.1                    100      0 18 17 i
*>i                 20.151.0.1                    100      0 18 17 i
* i179.0.84.0/24    20.156.0.1                    100      0 18 17 i
*>i                 20.151.0.1                    100      0 18 17 i
*>i179.0.89.0/24    20.152.0.1               0    100      0 17 i
*>i179.0.90.0/24    20.152.0.1                    100      0 17 i
* i179.0.91.0/24    20.156.0.1                    100      0 18 17 i
*>i                 20.151.0.1                    100      0 18 17 i
*>i180.82.0.0/24    20.152.0.1                    100      0 17 i

Displayed  32 routes and 48 total paths
```

### Measurement Traceroute from Customer AS22 to Peer AS6
``` console
root@d84c6ab09884:~# ./launch_traceroute.sh 22 6.155.0.1
Hop 1:  22.0.199.1 TTL=0 during transit
Hop 2:  179.0.96.1 TTL=0 during transit
Hop 3:  19.0.11.1 TTL=0 during transit
Hop 4:  6.155.0.1 Echo reply (type=0/code=0)
Hop 5:  6.155.0.1 Echo reply (type=0/code=0)
```