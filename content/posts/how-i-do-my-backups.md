---
title: "How I do my backups"
date: 2020-07-14
tags: ["backups", "archiving", "kiss"]
---

Here I explain how I decided to implement my backups. I'm providing this for informational purposes only, so do with it as you will.


## Tooling options

My initial research lead me to look at Borg[^borg], Restic[^restic], Bup[^bup], and the other popular options. However I didn't like that these tools used non standard storage formats, and/or required additional tools to access the backups.

I wanted something simpler that used a native storage format, just plain files would be ideal, and also wanted to have support for incremental backups.


## Other considerations

Another important consideration for me was how to handle laptops and other transient clients reliably.

I tried using Fcron[^fcron] with Rsync[^rsync] and some connectivity checks to do the syncing. The idea was to use some tried and tested tools and try to keep things less complex. This turned out to be more complicated than I first thought, and this was also particularly brittle. Handling retries properly wasn't trivial, and the syncing itself could be quite a long process at times. And last but not least, don't forget about handling remote access for performing backups. While this might be as simple as an SSH connection in some situations. If you're on the road there's always the chance that such connections are blocked. So keep this in mind if that's important to you, and plan accordingly.


## Tooling choice

Syncthing[^syncthing] seemed like the logical choice for handling the syncing of transient clients. I can use it to sync constantly, and then have something else do the backups locally from the server on a predictable schedule.

Rsnapshot[^rsnapshot] was the logical choice for the backup tool, it's simple and has all the features I was looking for. Sure it's not the flashiest, newest, or coolest tool, but it gets the job done comfortably, and that's all I care about.

I liked this approach of splitting the two functions apart, it gives you the freedom to choose the best tool for the job. If your requirements are different, use a different sync tool, or a different backup tool as needed.


## Scheduling the backups

Running the Rsnapshot[^rsnapshot] backups is a little different. The incremental backups in Rsnapshot[^rsnapshot] are implemented by way of retention targets, which are essentially different backups you need to individually run. Which wasn't so easy to orchestrate at first.

How do you ensure that the monthly and weekly targets, start and finish before the daily target. I considered using Fcron[^fcron] to accomplish this, as it has a richer set of expressions than regular cron, which would help in this case. However I later realised that Systemd[^systemd] timers[^systemd-timer] would be even better, and were already available to me, so I opted for that.

We can use exclusion/constraints to express the schedule, this approach is capable of handling yearly, monthly, weekly, and daily targets this way. In my case I have chosen to run all my backups on Mondays at 01:00. This allows me to make some assumptions to help constrain/exclude when the other targets are able to run. For example the yearly job is only allowed to run in January, on a Monday, in the first seven days of the month. The monthly job is able to run on any month other than January, on a Monday, in the first seven days. The weekly job is able to run on Mondays, whenever the day is after the first seven days. And last of all the daily job is allowed to run on any day other than a Monday.

Below you can see the corresponding OnCalendar expressions for schedules/timers:

```shell
Mon *-1-1..7 1:00:00       <-- Yearly
Mon *-2..12-1..7 1:00:00   <-- Monthly
Mon *-*-8..31 1:00:00      <-- Weekly
Tue..Sun *-*-* 1:00:00     <-- Daily
```

The resulting timer definition would look as follows:

```shell
[Unit]
Description=rsnapshot monthly backup

[Timer]
OnCalendar=Mon *-2..12-1..7 1:00:00
Unit=rsnapshot-monthly.service

[Install]
WantedBy=timers.target
```

Then simply chain the targets from highest to lowest on the exclusive dates. For example a yearly target would run the yearly, monthly, weekly, and daily targets. The monthly target would run the monthly, weekly, and daily targets, and so on. Fortunately the systemd-service[^systemd-service] `ExecStart` directive can be specified multiple times. They're run sequentially, stops processing on errors, and marks the job/service as failed. This works nicely for our use case, because we can have a cleaner looking service definition. Also we don't have to write a wrapper script or hack anything, because systemd services don't run in a shell environment.

And below is an example of the service that the timer calls:

```shell
[Unit]
Description=rsnapshot monthly backup

[Service]
Type=oneshot
Nice=19
IOSchedulingClass=idle
ExecStart=/usr/bin/rsnapshot monthly
ExecStart=/usr/bin/rsnapshot weekly
ExecStart=/usr/bin/rsnapshot daily
```



 [^borg]: https://github.com/borgbackup/borg
 [^bup]: https://github.com/bup/bup
 [^fcron]: https://github.com/yo8192/fcron
 [^restic]: https://github.com/restic/restic
 [^rsnapshot]: https://github.com/rsnapshot/rsnapshot
 [^rsync]: https://rsync.samba.org/
 [^syncthing]: https://github.com/syncthing/syncthing
 [^systemd-service]: https://www.freedesktop.org/software/systemd/man/systemd.service.html#
 [^systemd-timer]: https://www.freedesktop.org/software/systemd/man/systemd.timer.html#
 [^systemd]: https://www.freedesktop.org/wiki/Software/systemd/
