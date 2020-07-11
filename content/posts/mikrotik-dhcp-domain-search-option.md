---
title: "Mikrotik Dhcp Domain Search Option"
date: 2018-08-02T20:24:01+02:00
tag: [“mikrotik”, "routeros", "dd-wrt", "unifi"]
draft: false
---

I recently decided to replace my Netgear Nighthawk R7800[^r7800] running DD-WRT[^dd-wrt], after encountering some stability problems which I wasn't able to resolve. I decided to move away from normal consumer/enthusiast options and went for a Mikrotik hEX PoE[^hex-poe] paired with a UniFi AP AC LITE[^unifi-ac-lite].

RouterOS[^routeros] is a very capable commercial grade operating system (OS). Coming from a consumer grade networking device/OS can involve a steep learning curve if you're not reasonably familiar with networking already. That said, even if you are, there can be some edge cases where the feature or documentation doesn't behave as expected/described.

My first encounter with this in RouterOS was configuring a DHCP Option to set the Domain Search list[^rfc2131]<sup>,</sup>[^rfc2131-params]<sup>,</sup>[^rfc3397-formatting]. Despite what the RouterOS documentation[^ros-dhcp-options] says, it turns out that you can't just use a string value to set this option properly in RouterOS. As noted by pessoft[^blog-pessoft] and others on the Mikrotik Forums[^mikrotik-forum] this particular DHCP option (there may be others, I am only commenting on this one here), must be correctly formatted according to some rules.

Unlike in the pessoft[^blog-pessoft] example, I elected not to use compression and simply concatenated the elements with a series of `0x00XX` entries finishing with `0x00`, as shown below:

```
/ip dhcp-server option add name=domain-search-list code=119 value="0x0A'engineroom'0x0A'middlearth'0x03'lan'0x0006'bridge'0x0A'middlearth'0x03'lan'0x000A'middlearth'0x03'lan'0x00"
```


 [^r7800]: https://www.netgear.com/home/products/networking/wifi-routers/r7800.aspx
 [^dd-wrt]: https://dd-wrt.com/
 [^hex-poe]:  https://mikrotik.com/product/RB960PGS
 [^unifi-ac-lite]: https://www.ubnt.com/unifi/unifi-ap-ac-lite/
 [^routeros]: https://mikrotik.com/software
 [^ros-dhcp-options]: https://wiki.mikrotik.com/wiki/Manual:IP/DHCP_Server#DHCP_Options
 [^rfc2131]: https://tools.ietf.org/html/rfc2131
 [^rfc2131-params]: https://www.iana.org/assignments/bootp-dhcp-parameters/bootp-dhcp-parameters.xhtml
 [^rfc3397-formatting]: https://tools.ietf.org/html/rfc3397#section-2
 [^blog-pessoft]: https://blog.pessoft.com/2016/03/17/domain-search-list-as-dhcp-option-in-mikrotik-routeros/
 [^mikrotik-forum]: https://forum.mikrotik.com/viewtopic.php?f=2&t=133801#p658109
