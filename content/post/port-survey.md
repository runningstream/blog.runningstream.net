---
title: "Port Survey Analysis"
#author: "Author Name"
description: "Investigating the ports attackers/scanners try to connect to, providing better targeting for future honeypot activities"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-05-15T00:00:00-00:00
draft: false
---
I've edited this post over time, primarily trying to determine where the most common attacks are hitting.  This analysis will lead to more focused analysis of the spots attackers are targeting.

Most popular ports 15 May 18:

- 69 - tftp
- 445 - smb
- 8545 - not in /etc/services - maybe misconfigured ethereum client search
- 3389 - remote desktop
- 2323 - telnet alternative maybe
- 5555 - "personal-agent" - maybe just easy to type
- 5060 - sip - voip
- 6379 - maybe redis

On 16 May 18, same ports largely, but also:

- 2004 - emce?  mailbox?

On 18 May 18, same ports largely, but also:

- 81
- 8888
- 123 - ntp
- 3392

Most of these aren't very notable, maybe just trial ports for scans.

Going a bit deeper, I've begun to employ some software that records the data provided to TCP connections.  Initial analysis, after one day, shows that, of all the ports above, the only ones that actually get sent data are 445, 3389, 8545.  445 is getting a lot of traffic that looks like WannaCry, or variants.  3389 is getting remote desktop requests with "mstshash" set to a variety of values.  8545 is getting requests from Geth and etherium-connection bots, probably trying to steal etherium.

I need to expand to look at UDP too, and put up smarter honeypot endpoints on 445 and 3389.
