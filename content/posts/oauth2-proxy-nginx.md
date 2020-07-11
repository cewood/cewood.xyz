---
title: "Oauth2_proxy with Nginx"
date: 2018-09-08T14:39:01+02:00
tags: [“bitly”, "oauth2", "proxy", "nginx", "google"]
draft: false
---

Recently I had been thinking about having some remote access to some of the Docker containers I run on my home server. Namely my Sickrage, Transmission, and other instances. My first thought was to set up an OpenVPN instance, but then it dawned on me why not use an authenticating reverse proxy and just host them publicly over the internet. 

So afer a bit of searching I came across bitly's oauth2_proxy[^oauth2_proxy], which was exactly what I had been looking for. After reading the docs and doing a quick local test, I used Docker Compose to run oauth2_proxy, which you can see here in my docker-compose.yml[^docker-compose.yml].

Rather than using individual routes and authenticating those, I opted to have Nginx terminate all connections using the JrCs/docker-letsencrypt-nginx-proxy-companion[^docker-letsencrypt-nginx-proxy-companion] and hand all traffic to oauth2_proxy[^oauth2_proxy]. This has the nice side-effect of ensuring that anything behind these domains are authenticated first, before being handed off to another Nginx instance which is handling the reverse proxy configuration, which you can see here in my nginx-private.conf[^nginx-private.conf].

Another imoprtant thing to note about this approach, is that in my nginx-private.conf[^nginx-private.conf] I am using sub-domains. As opposed to sub-paths and complicated rewrites, which sometimes aren't possible if the downstream application isn't aware of this and doing things like relative redirects and similar.


 [^oauth2_proxy]: https://github.com/bitly/oauth2_proxy
 [^docker-compose.yml]: https://github.com/cewood/ansible-playbooks/blob/2a8ef46/roles/local.babushka/templates/docker-compose.yml.j2#L66
 [^docker-letsencrypt-nginx-proxy-companion]: https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion
 [^nginx-private.conf]: https://github.com/cewood/ansible-playbooks/blob/2a8ef46/roles/local.babushka/templates/nginx-private.conf.j2
