# 2.2: IXP Peering

### Community Lists
``` console
NEWY_router# show bgp community-list
[...]
Community standard list 10
    permit 19:17
    permit 19:18
Community standard list 20
    permit 19:21
    permit 19:22
```
These community lists allow us to apply match expressions fitting either community-list 10, which are our providers, or community-list 20, which are our customers. We tag incoming routes by those partners on entry into our AS.

### Prefix-List
``` console
NEWY_router# show ip prefix-list
[...]
BGP: ip prefix-list our_prefix: 1 entries
   seq 5 permit 19.0.0.0/8
```
This prefix-list allows us to match our own prefix.

### Route-Map `ATTACH_COMM_VALS`
``` console
NEWY_router# show route-map
[...]
BGP:
route-map: ATTACH_COMM_VALS Invoked: 2291
 permit, sequence 10 Invoked 2291
  Match clauses:
    community 20
  Set clauses:
    community 82:2 82:4 82:6 82:8 82:10 82:12 82:14 82:15 82:17
  Call clause:
  Action:
    Exit routemap
 permit, sequence 11 Invoked 1592
  Match clauses:
    ip address prefix-list our_prefix
  Set clauses:
    community 82:2 82:4 82:6 82:8 82:10 82:12 82:14 82:15 82:17
  Call clause:
  Action:
    Exit routemap
 deny, sequence 12 Invoked 38
  Match clauses:
    community 10
  Set clauses:
  Call clause:
  Action:
    Exit routemap
 permit, sequence 13 Invoked 34
  Match clauses:
  Set clauses:
    community 82:2 82:4 82:6 82:8 82:10 82:12 82:14 82:15
  Call clause:
  Action:
    Exit routemap
```
The route-map `ATTACH_COMM_VALS` has three route entries. The first checks for routes being sent to us by our customers AS21 and AS22 via the community-list `20`. The second checks for our own prefix. Both of those route entries add community values advertising to all peers connected to the IXP.  
The third entry advertises all other prefixes and routes to all participants except to our Provider AS17. This prevents us from being used as a transit network to our provider for prefixes not associated with us or our customers.

>Info: These filtering steps become obsolete in light of new information provided in the requirements for the record for task 3.1 and the requirements of task 3.2. We highlight this change of our understanding in [3.1: Business Relations](../3/policy_routing.md).

### Looking Glass Entry AS6
``` console
2021-02-18T19:44:37
BGP table version is 4458187, local router ID is 6.155.0.2, vrf id 0
Default local pref 100, local AS 6
Status codes:  s suppressed, d damped, h history, * valid, > best, = multipath,
               i internal, r RIB-failure, S Stale, R Removed
Nexthop codes: @NNN nexthop's vrf id, < announce-nh-self
Origin codes:  i - IGP, e - EGP, ? - incomplete

   Network          Next Hop            Metric LocPrf Weight Path
   [...]
*> 19.0.0.0/8       180.82.0.19              0             0 19 i
   [...]
```

### Measuremnt Container Output from AS6
``` console 
root@d84c6ab09884:~# ./launch_traceroute.sh 6 19.155.0.1
Hop 1:  6.0.199.1 TTL=0 during transit
Hop 2:  6.0.4.2 TTL=0 during transit
Hop 3:  6.0.8.2 TTL=0 during transit
Hop 4:  19.155.0.1 Echo reply (type=0/code=0)
Hop 5:  19.155.0.1 Echo reply (type=0/code=0)
```