---
title: "Recursid and Raw Sock Port Mon Release"
#author: "Author Name"
description: "We're releasing two new open source tools.  Recursid is a data processing architecture useful for asynchronously processing honeypot events, and mining them for more information.  Raw Sock Port Mon monitors and reports all connections to a JSON listener (like FluentD or Logstash)."
date: 2019-06-02T00:00:00-00:00
draft: false
---

We've recently released two pieces of software useful to individuals running honeypots.  Both are open-source, GPL'd, available on [our site at GitHub][1].

# Recursid

[Recursid][2] is a recursive object processing platform.  Our use case lies primarily in processing and downloading URLs found during honeypot operation.  An attacker tries to pull tools from a URL, we observe this attempt and block it, separately we download the tools in a controlled manner, we search for further URLs embedded inside, download the results, and so-on.  Downloading attackers' tools and supporting capabilities is a baseline requirement for any honeypot operator.  After writing and modifying the software to do that, and interfacing it with the other tools we already employ, and then periodically updating and improving that software, we decided we needed something more maintainable.

Maintainability and flexibility are two primary benefits Recursid aims to provide.  These benefits were lacking in our previous solution - an amalgamation of shell scripts employing wget and curl, or a stack of Python code implementing this inherently recursive operation in a procedural way.

The core of the Recursid framework is simply a recursive object processing system, with processing completed by modular components.  Input modules build objects based upon inputs they receive from sources external to Recursid, feeding the objects into the core.  The core provides each object it receives to all registered processing modules ("re-emitter" modules) and output modules which have registered to accept the object type.  Re-emitters take objects as input, perform any functionality you can imagine in Python, then can re-emit other objects as output.  Output modules take objects as input, then output them in formats appropriate for sinks outside Recursid.  Objects are simply Python objects, and processing by all modules can happen in a multi-processed way.

For our use case then, FluentD forwards many types of actions observed on the honeypots to a Recursid FluentD input module.  All inputs get thrown into the core as FluentdRecord objects.  The URLParser re-emitter module can understand FluentdRecord objects, and look for URLs in appropriate fields.  It outputs the found URLs into the core as objects.  The DownloadURL re-emitter handles URL objects, as does a logging output module.  The URLs get downloaded with multiple user-agent strings, redundant downloads get eliminated, and the resulting downloaded objects are re-emitted into the core.  The URLParser can handle downloaded objects, in addition to the FluentdRecords, and parses those downloaded objects for URLs.  In the future, more fine-grained separation of URL parsing capability might be broken out by the type of the file downloaded.   For instance, an ELF URL parser might look for URLs encoded in separate pieces in an ELF file, or might look for URLs built in the memory of an ELF file executed in a sandbox (by some other re-emitter module).  Logging modules and FluentD output modules can output any objects desired for FluentD's input, which we throw into Elasticsearch.

Recursid stamps input module results with an initial TTL, and the TTL is decreased for every object output by a re-emitter.  This prevents infinite recursive looping.  The multi-processed (or multi-threaded) method of execution allows objects to be processed asynchronously.

One result of this structure is that the platform is ideal for handling actions that may be performed asynchronously, while the object typing system can automatically enforce an order of processing operations among the modules.

We're currently looking for applications beyond the honeypot system, so if you've got one, please let us know!

**[Download][2]**

# Raw Sock Port Mon

[Raw Sock Port Mon][3] counts activity on TCP and UDP ports, other IP protocols, and other Ethertypes.  It quantifies new TCP connections (packets with just SYN set) separately from other traffic.  The purpose is to provide situational awareness of all traffic arriving at a honeypot.  Instead of listening on all ports you're interested in, though, it uses Linux raw sockets to observe traffic.

Berkeley Packet Filter-based packet filters are in place to eliminate traffic from local networks, and to optionally include only traffic destined to a specific IP address.  These are helpful when running on a gateway device, and interested in only traffic coming from external.

Traffic counts are output in JSON to a TCP endpoint, with formatting that makes it simple to aggregate in Kibana.  CPU and memory footprint are very small.  Using raw sockets requires root access, or conferring a capability to the binary.  Instructions for conferring capability are included, but the binary also make sure to quickly drop root privileges you may have given it.

This one needs a catchier name, but it's a simple way to get insight into all the traffic you're not already catching.

**[Download][3]**


[1]: https://github.com/runningstream/
[2]: https://github.com/runningstream/recursid
[3]: https://github.com/runningstream/raw_sock_port_mon
