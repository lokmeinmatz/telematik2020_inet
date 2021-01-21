# basics
fully configured example router is MIAM (8)

all frrouting commands can get shortened till unique, like `sho interf br` for `show interface brief` 

`exit` moves you one layer back

# TODO per router with id Y and name <ROUTER_NAME>

check which interfaces are allready configured with `show interface brief`

## configure loopback

interface name `lo`
router Y needs lo address 19.[150+Y].0.1/24

To set this:
* `conf t` (goes into config mode)
* `interface lo`
* `ip address <LOOPBACK_ADDRESS>/24`

To test:
`ping <LOOPBACK_ADDRESS>` should work

## configure router interfaces

For addresses see netmap.png
Process same as for loopback, interface names are `port_<CONNECTED_ROUTER>`


## configure host connection

* `conf t`
* `interface host`
* `ip address 19.[100+Y].0.2/24`

* go back to AS root, then `./goto.sh <ROUTER_NAME> host`
* `ip address add 19.[100+Y].0.1/24 dev <ROUTER_NAME>router`
ping between host and rotuer should work