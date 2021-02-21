# 3.2 IXP policy

``` console
NEWY_router# sho route-map
[...]
BGP:
route-map: ATTACH_COMM_VALS Invoked: 2447
 permit, sequence 10 Invoked 2447
  Match clauses:
    community 20
  Set clauses:
    community 82:2 82:4 82:6 82:8 82:10 82:12 82:14
  Call clause:
  Action:
    Exit routemap
 permit, sequence 11 Invoked 1718
  Match clauses:
    ip address prefix-list our_prefix
  Set clauses:
    community 82:2 82:4 82:6 82:8 82:10 82:12 82:14
  Call clause:
  Action:
    Exit routemap
[...]
route-map: PERMIT_OTHER_REGION Invoked: 126
 permit, sequence 10 Invoked 126
  Match clauses:
    as-path only_our_region
  Set clauses:
    community none
  Call clause:
  Action:
    Exit routemap
```
ATTACH_COMM_VALS is the outgoing route-map that sets the IXP community values, so that the other region gets our advertisements. We only allow `community 20` (our customers) and `prefix-list our_prefix` (our /8 advertisement).
This way, we prevent beeing a transfer AS for our peer and our providers, which would add additional costs.

PERMIT_OTHER_REGION is ingoing route-map, which denies all ASes on our side if the IXP. (the name of the as-path access list `only_our_region` is missleading, as it denies AS 15|17|21|23|25)

``` console
NEWY_router# sho ip bgp

   Network          Next Hop            Metric LocPrf Weight Path
* i1.0.0.0/8        19.153.0.1                    100      0 20 1 i
* i                 19.152.0.1                    100      0 18 1 i
*                   180.82.0.2                             0 2 3 1 i
*>i                 19.157.0.1                    100      0 22 1 i
*> 2.0.0.0/8        180.82.0.2               0             0 2 i
* i3.0.0.0/8        19.153.0.1                    100      0 20 3 i
* i                 19.152.0.1                    100      0 18 3 i
*>                  180.82.0.2                             0 2 3 i
* i5.0.0.0/8        19.153.0.1                    100      0 20 5 i
* i                 19.152.0.1                    100      0 18 5 i
*>                  180.82.0.6                             0 6 5 i
[..]
*> 12.0.0.0/8       180.82.0.8                             0 8 9 12 i
*  13.0.0.0/8       180.82.0.2                             0 2 3 20 13 i
* i                 19.153.0.1                    100      0 20 13 i
* i                 19.152.0.1                    100      0 18 13 i
*>i                 19.157.0.1                    100      0 22 13 i
[..]
* i26.0.0.0/8       19.153.0.1                    100      0 20 7 26 i
* i                 19.152.0.1                    100      0 18 7 26 i
*>                  180.82.0.8                             0 8 23 26 i
* i                 19.158.0.1                    100      0 21 24 26 i
* i                 19.154.0.1                    100      0 21 23 26 i
* i                 19.157.0.1                    100      0 22 24 26 i
* i176.0.0.0/4      19.153.0.1                    100      0 20 18 17 i
*>                  180.82.0.8                             0 8 15 17 i

Displayed  26 routes and 64 total paths
```

As you can see, all routes that are **NOT** prefixed with an *i* (those who arrive via the IXP) only came from "the other side", none from our providers / customers.


## Output from Looking Glass NEWY from AS 8:
``` console
2021-02-21T17:43:58
[...]
   Network          Next Hop            Metric LocPrf Weight Path
[...]
*> 19.0.0.0/8       180.82.0.19              0             0 19 i
*  19.107.0.0/23    180.82.0.15                            0 15 17 18 3 24 i
*>i                 8.157.0.1                     100      0 9 24 i
[...]
```

This shows that ASes from the other region still have direct access to us via the IXP