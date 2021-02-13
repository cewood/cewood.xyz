---
title: "DNS Rebinding for Plex with a MikroTik"
date: 2018-08-15T20:24:01+02:00
tags: ["mikrotik", "routeros", "plex"]
draft: false
---

I wrote an earlier post on how I had recently updated my home router setup to a RouterOS based MikroTik device. While I really love the extra flexibility and power user features of RouterOS, at times it can be frustrating when something that used to just work doesn't anymore. One such example of this was when trying to use my Plex with my Chromecast and having issues, which I later discovered was DNS Rebinding.

At first I wasn't quite sure what was going on, but after doing some searching I came across this post by KuroRaion on the Plex Forums[^plex-forum-thread] which suggested that the problem might be DNS Rebinding.

So I set off searching the MikroTik Forums and came across this post[^mikrotik-forum-thread] by user msatter explaining how to create a wildcard/regex local DNS entry for the `plex.direct` domain.


```
ip dns static add regexp=*.plex.direct address=192.168.88.2
```

If you're using secure connections in Plex, their documentation on How to Use Secure Server Connections[^plex-https-docs] might also come in handy.


 [^plex-forum-thread]: https://forums.plex.tv/t/can-no-longer-cast-local-media-to-chromecast/229914/12
 [^mikrotik-forum-thread]: https://forum.mikrotik.com/viewtopic.php?t=115330#p571146
 [^plex-https-docs]: https://support.plex.tv/articles/206225077-how-to-use-secure-server-connections/
