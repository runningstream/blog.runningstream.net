---
title: "Bold Claims and Okane"
#author: "Author Name"
description: "In which bold claims are made by an individual spreading Okane malware"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-09T00:00:00-00:00
draft: false
---
Here's a guy who is pretty bold with his malware: hxxp://46.243.189.101/

```html
<font size='12'> <center> IM HERE TO HACK UR BOTNET </center> </font>
<font size='12'> <center> if ur a security researcher, follow my twitter @decayable, ill glady anwser any questions </center> </font>
```

He shows up in my honeypot trying to use the GPON vulnerability to drop hxxp://46.243.189.101/w, which then tries to execute Mirai offshoot Okane on a variety of architectures.

@decayable does not seem like one of the smarter script kiddies out there, but he/she is trying hard to sell some botnets...

The boldness makes me wonder, what kind of OPSEC-like precautions has this person taken?  How have they setup their C2/dropper server?  Whois shows the IP address is in a block owned by "KV_Solutions_Net", in the Netherlands.  decayable doesn't seem to be from the Netherlands...  He's using these guys to host his server: https://www.kvsolutions.nl/

Cheap servers...

The attempts to infect using GPON come from 46.243.189.60, which is the same network block as this person's C2-type server...  That IP doesn't have a web server, but has SSH.

It's easy enough to report for abuse...
