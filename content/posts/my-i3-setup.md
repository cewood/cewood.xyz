---
title: "My i3 setup"
date: 2020-03-23
tags: ["i3", "systemd", "minimalist", "kiss"]
---

I'm a long time user of i3 and have been meaning to document my setup for some time now, so here we are at last.


## No Desktop Environment or Display / Login Manager

I've tried to keep my setup as simple as possible, I don't use a Desktop Environment, nor any Display/Login Manager either. The implication of this is that we need to set some other way to start i3, and you'll also need to configure a way to unlock your keyring after login. In my case I have opted to configure PAM to unlock my keyring[^gnome-keyring] for me, and I use `startx` and the `.xinitrc` config file to start i3. Below is a copy of my `.xinitrc` file:

```bash
#!/bin/bash

# Source the xprofile
[[ -f ~/.xprofile ]] && ~/.xprofile

# Source our xmodmap
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

## Remap Caps to Super, and Shift_L + Sift_R = Toggle_Caps
setxkbmap -option "shift:both_capslock"
setxkbmap -option "caps:super"


##
# Execute our .Xresources file
#
xrdb ~/.Xresources


## Interface scaling
export GDK_SCALE=0
export GDK_DPI_SCALE=0


##
# From https://wiki.archlinux.org/index.php/GNOME/Keyring#Without_a_display_manager
#
eval "$(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)"
export SSH_AUTH_SOCK
export GPG_AGENT_INFO
export GNOME_KEYRING_CONTROL
export GNOME_KEYRING_PID


##
# Propogate DISPLAY vars to Systemd, for more info see this
#  https://wiki.archlinux.org/index.php/Systemd/User#Environment_variables
#
systemctl --user import-environment DISPLAY WAYLAND_DISPLAY


xset b off
setxkbmap -option ctrl:nocaps

case "$1" in
gnome)
    exec /usr/bin/gnome-session
    ;;
i3-gnome)
    exec /usr/bin/i3-gnome
    ;;
*)
    exec /usr/bin/i3
    ;;
esac
```


## Autostarting applications via systemd user units

Using the i3 config to exec things would admittedly be simpler, but I wanted reliability and flexibility, which systemd user services provide nicely. To configure this I created a systemd user target `xsession.target` which makes use of the special `graphical-session.target`[^graphical-session.target] you can see the contents of below:

```systemd
[Unit]
Description=xsession for starting other user units, exec'd during i3wm startup
BindsTo=graphical-session.target
Wants=blueman-applet.service
Wants=dropbox.service
Wants=dunst.service
Wants=nm-applet.service
Wants=pnmixer.service
Wants=redshift-gtk.service
Wants=syncthing-gtk.service
Wants=xautolock.service
```

Some of these units are from the system, but the majority are user units I've created myself, an example of one is the `dunst.service` which you can see below:

```systemd
[Unit]
Description=dunst
PartOf=graphical-session.target

[Service]
ExecStart=/usr/bin/dunst
Restart=always

[Install]
WantedBy=xsession.target
```

You'll notice I've added the `PartOf` and `WantedBy` fields to this service, this links them all together and gives me more options depending on how I want to use them. For example instead of having to manually enable each of them, by listing them as explicit `Wants` in the target definition, I can start them all in one step by invoking/starting the target. An example of how I do that is the following command, which I include in my i3 config like so `exec systemctl --user start xsession.target`

Astute readers may have noticed the `systemctl --user import-environment`[^systemd-user-display-xauthority] command in the `.xinitrc` file earlier, this is important for the systemd user units to work with graphical applications. That command copies in environment variables for the display so that systemd started applications will have access to this variable that they need.


## HiDPI settings

Without a Desktop Environment you'll need to manually take care of setting up HiDPI if you have a high resolution display. For me that was as simple as setting two variables in my .xinitrc[^hidpi-gtk3] file, which you may have noticed earlier:

```
export GDK_SCALE=0
export GDK_DPI_SCALE=0
```


## Other approaches I considered

I considered some other solutions before arriving at this setup. Most of these revolved around using .desktop files based on some Desktop Environments autostart mechanism, which since I don't have a Desktop Environment lead me to look at tools like dex[^dex]. What I didn't like about Dex or similar solutions was that they weren't a process supervisor, and rightly so, which to me was another plus to using systemd user units.


 [^gnome-keyring]: https://wiki.archlinux.org/index.php/GNOME/Keyring#Without_a_display_manager
 [^graphical-session.target]: https://www.freedesktop.org/software/systemd/man/systemd.special.html#graphical-session.target
 [^systemd-user-display-xauthority]: https://wiki.archlinux.org/index.php/Systemd/User#DISPLAY_and_XAUTHORITY
 [^hidpi-gtk3]: https://wiki.archlinux.org/index.php/HiDPI#GDK_3_.28GTK_3.29
 [^dex]: https://github.com/jceb/dex
