---
title: "Attacks Spreading Cryptocoin Miners"
#author: "Author Name"
description: "Description of an attack against the Redis port attempting to infect a target with a cryptocoin miner"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-27T00:00:00-00:00
draft: false
---

This morning showed similar behavior to "attacks spreading cryptocoin miners", but with new URL names and domains, choosing slightly less-obvious domains.

Today the attack came from 

The download domain is 4wgumbxicvicldow.onion.lu, which at least doesn't contain the term "zero-day" this time.  This is a TOR proxy, enabling connections to TOR "dark-web" sites from the regular web.  It then downloads files from pixeldra.in.

Pixeldra.in will give some file information just based on the URL...

```json
{"thumbnail":"https://pixeldra.in/api/thumbnail/zJNXG3","mime_image":"https://pixeldra.in/res/img/mime/application.png","date_upload":"2018-06-19 11:14:00.0","success":true,"file_name":"nodexx","mime":"application/x-executable","id":"zJNXG3","date_lastview":"2018-06-19 11:20:08.0","file_size":318992,"views":1,"desc":"PixelDrain File"}
```

```
{"thumbnail":"https://pixeldra.in/api/thumbnail/rVwG_N","mime_image":"https://pixeldra.in/res/img/mime/application.png","date_upload":"2018-06-19 11:12:59.0","success":true,"file_name":"clay","mime":"application/x-executable","id":"rVwG_N","date_lastview":"2018-06-19 11:18:53.0","file_size":1223123,"views":2,"desc":"PixelDrain File"}
```

Not too much useful in there...  We have the original file name, number of views, which doesn't seem to correspond to the number of downloads.  We have the original upload date.  The first scan in VirusTotal for both of these was 24 June 2018, so it took a couple days before they made it into VirusTotal.

Interestingly, the onion site, upon sending a 404, contains a Google analytics UA - UA-111383614-1.  Searching Google for a method to resolve this back to a user or URL doesn't reveal much, but does reveal wpzowe2oq2tyzvws.onion.lu, a site with the same tag included.  More research shows that this seems to be onion.lu's Google analytics code...  So, onion.lu appends their tracker to every 404, at least.
