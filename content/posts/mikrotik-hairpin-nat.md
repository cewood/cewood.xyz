---
title: "Mikrotik Hairpin NAT"
date: 2018-08-19T19:03:09+02:00
tag: [“mikrotik”, "routeros", "nat", "hairpin"]
draft: false
---

I recently had to configure Hairpin NAT[^wikipedia] on my MikroTik home router, so that I could locally access some services I was hosting for testing purposes. This turned out to be somewhat harder than I first expected, and so I wanted to write things down in case I forget and have to do this again at some point.

After a bit of searching I came across this MikroTik Wiki page[^mikrotik-wiki] on Hairpin NAT, but I wsa still unable to get a working configuration implemented after reading this. So I did a little more searching and came across this post[^mikrotik-forum] by jhgorse on the MikroTik Forums, which provided some valuable extra information on the issue I was experiencing.


 [^wikipedia]: https://en.wikipedia.org/wiki/Hairpinning
 [^mikrotik-wiki]: https://wiki.mikrotik.com/wiki/Hairpin_NAT
 [^mikrotik-forum]: https://forum.mikrotik.com/viewtopic.php?t=107851#p547024
