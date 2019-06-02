---
title: "Notes about SIP Connections"
#author: "Author Name"
description: "Initial looks at the traffic directed to a SIP port"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-20T00:00:00-00:00
draft: false
---
Something that requires more study for me: SIP connections.  SIP is a portion of the Voice over IP (VOIP) protocol.

Most are from a scanner called sipvicious, but after the obvious sipvicious connections behind there are a number of interesting ones remaining.  They seem to be probes of SIP capabilities at a remote address, which is similar to traffic at every other port.

There are some more interesting requests though - I saw one the other day requesting a connection to a specific 10.\* address and port.  I suspect a real SIP server has a number of ways to respond to such a request - it might require authentication before taking any action, it might provide a response that indicates whether a 10.\* address is routable to that server (indicating to an attacker properties of the private network), it might probe the specific server and port and provide a response indicating whether the port is open (even if it doesn't provide a SIP server), or it might just forward the connection blindly.  I suspect that some SIP server does each of those actions, actually.  Each of these possibilities after the first is interesting to an attacker, and if an attacker is spending time performing the action then some software must be providing a useful response.

```hex
4f5054494f4e53207369703a31303040 OPTIONS sip:100@
31382e3139312e302e31383120534950 18.191.0.181 SIP
2f322e300d0a5669613a205349502f32 /2.0..Via: SIP/2
2e302f554450203138352e32322e3135 .0/UDP 185.22.15
322e33373a36313539343b6272616e63 2.37:61594;branc
683d7a39684734624b2d313538313035 h=z9hG4bK-158105
333037383b72706f72740d0a436f6e74 3078;rport..Cont
656e742d4c656e6774683a20300d0a46 ent-Length: 0..F
726f6d3a2022416d6f6f54223c736970 rom: "AmooT"<sip
3a31303040312e312e312e313e3b7461 :100@1.1.1.1>;ta
673d3331333236323636333033303632 g=31326266303062
33353331333336333334303133383339 3531336334013839
33303334333733353334333733390d0a 30343735343739..
4163636570743a206170706c69636174 Accept: applicat
696f6e2f7364700d0a557365722d4167 ion/sdp..User-Ag
656e743a205042580d0a546f3a202241 ent: PBX..To: "A
6d6f6f54223c7369703a31303040312e mooT"<sip:100@1.
312e312e313e0d0a436f6e746163743a 1.1.1>..Contact:
207369703a313030403138352e32322e  sip:100@185.22.
3135322e33373a36313539340d0a4353 152.37:61594..CS
65713a2031204f5054494f4e530d0a43 eq: 1 OPTIONS..C
616c6c2d49443a203536363738363637 all-ID: 56678667
34373835313631323838373935313735 4785161288795175
0d0a4d61782d466f7277617264733a20 ..Max-Forwards: 
37300d0a0d0a                     70....
```

Today, though, I see another type of connection that occurs regularly, but much more rarely than the others.  This request came from the IP address and port it asks for contact back to, geo-located to Russia.  I wonder what would be delivered if my server had connected back sending anything more than just a mirrored data stream - more probes, or exploit code for a vulnerable service?  This server made only one UDP request, the one above, telling me that my reply did not meet its requirements.
