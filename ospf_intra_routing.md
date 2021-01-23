# basics
fully configured example router is MIAM (8)

all frrouting commands can get shortened till unique, like `sho interf br` for `show interface brief` 

`exit` moves you one layer back

each router (except GENE and ZURI) has an associated host device, you can access via `./goto.sh <ROUTER_NAME> host`

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



# Configure OSPF

enable ospf with
* `router ospf`
* `network 19.0.0.0/24 area 0` for inter-router-ospf
* `network 19.10x.0.0/24 area 0` for host ospf


To check if ospf is working, wait a few seconds and type `show ip route ospf`
There you can check which entries came from other routers and via which port the packet is routed

each host also needs a default route configured, where to send all packets that don't belong in the subnet between host and router.
Set with `ip route add default via 19.10x.0.2`


# result
``` console
root@PARI_host:~# traceroute ATLA-host.group19
traceroute to ATLA-host.group19 (19.107.0.2), 30 hops max, 60 byte packets
 1  PARI-host.group19 (19.103.0.2)  0.162 ms  0.055 ms  0.053 ms
 2  NEWY-PARI.group19 (19.0.5.2)  2.216 ms MIAM-PARI.group19 (19.0.6.2)  0.285 ms NEWY-PARI.group19 (19.0.5.2)  2.114 ms 
 3  ATLA-host.group19 (19.107.0.2)  2.461 ms  0.570 ms  2.472 ms
root@PARI_host:~#
```

Here a traceroute and DNS lookup work, the packet gets send

PARI-host -> PARI-router -> NEWY-router -> ATLA-router -> ATLA-host