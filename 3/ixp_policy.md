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
ATTACH_COMM_VALS is the outgoing route-map that sets the IXP community values, so that the other region gets our advertiesments. We only allow `community 20` (our customers) and `prefix-list our_prefix` (our /8 advertisement).
This way, we prevent beeing a transfer AS for our peer and our providers, which would add additional costs.

PERMIT_OTHER_REGION is ingoing route-map, which denies all ASes on our side if the IXP. (the name of the as-path access list `only_our_region` is missleading, as it denies AS 15|17|21|23|25)