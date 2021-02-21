# 3.5: BGP Hijack

The hijack consists of the Stub / Tier1 AS advertisements, for the 19.107.0.0/23 subnet (the one of Atlanta Host connection). This can be seen in any Looking Glass Entry of another AS. \
In our AS, we only accept /8 prefixes, so we don't have any of the malicious routes in our network.

To prevent our ATLA host subnet from beeing stolen, we could advertise the same ip with an /24 mask, as routers normally search for the longest matching path. This wouldn't be a good solution though, if the attackers advertised the /24 from the start, because we need to choose a more specific Subnet, and thus we must advertise more subnets, as all addresses inside it could possibly be in use.

For the example Attack on 19.107.0.0/24 -> we would need to advertise 19.107.0.0/25 and 19.107.0.ff/25 for example to cover all possible IPs of this subnet. This adds more advertisements = more load on the network. Alos, this doesn't work if an AS advertises a single IP (e.g. 19.107.0.1/32), as we can't announce a more specific path.