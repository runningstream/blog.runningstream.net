---
title: "Strange POST Requests..."
#author: "Author Name"
description: "A brief description of unusual POST requests targeting the honeypot"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-16T00:00:00-00:00
draft: false
---
Strange POST requests are directed at Glastopf...  Several IP addresses have sent requests to random looking URLs ending in .php, URLs that are unlikely to exist anywhere unless someone specifically places them.  They contain POST data like:

```
ip=\\my_ip\\&port=8080&uuid=8cd96698-3207-49bb-a815-e0fb979c4a16
```

```
ip=\\my_ip\\&port=8080&uuid=c0aac97a-371f-4864-aaf1-c4afacbdbccf
```

These are directed towards host checkrealtys.com, with a variety of useragent strings, including:

```
BlackBerry9000/4.6.0.167 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/102
Mozilla/5.0 (iPhone; U; CPU iPhone OS 4_2_1 like Mac OS X; da-dk) AppleWebKit/533.17.9 (KHTML, like Gecko) Version/5.0.2 Mobile/8C148 Safari/6533.18.5
```

The UUIDs don't seem to correspond to anything in particular, there are no future GET requests for anything similar...  I'm not sure what the purpose of these requests is.
