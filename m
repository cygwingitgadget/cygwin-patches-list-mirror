From: "matt" <matt@use.net>
To: "Corinna Vinschen" <cygwin-patches@cygwin.com>
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Mon, 26 Feb 2001 15:58:00 -0000
Message-id: <002c01c0a054$05fae680$3327f0d8@lag.net>
References: <u67ae79bw6v.fsf@rachel.hq.vtech> <u671ysl8xda.fsf@rachel.hq.vtech> <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de> <1825816804.20010226221015@logos-m.ru> <20010227004550.X27406@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00115.html

> On Mon, Feb 26, 2001 at 10:10:15PM +0300, Egor Duda wrote:
> > CV> Indeed. I would be interested in the trivial patch as well.
> >
> > well, almost trivial ;-)
> > It's not fully compatible with linux, as it doesn't allow seeking past
> > the  end  of  media (i think this is ok), and, alas, for NT only :( (i
> > don't  think  this  is ok, but i haven't found a way to get media size
> > under w9x)
>
> Did you try that even on raw partitions (\\.\X:)? From the MSDN:
>
> "The IOCTL_DISK_GET_DRIVE_GEOMETRY control code retrieves information
>  about the physical disk's geometry"
>
> so I assume it will only work for raw harddisks (\\.\physicaldriveN).

If memory serves, a reason why dual-booting between win9x, NT, Linux, etc is
difficult is because early versions of win95 don't properly interpret what the
BIOS tells them about drive geometry and massage/use the information in a
somewhat unpredictable way. I remember this being discussed (by intelligent
people) on the Linux Kernel Mailing List recently -- let me see if I can find
the message and I'll reply with a link.

I would suggest testing this ioctl quite a bit across win9x variants before
implementing, or only supporting it on win98/ME.
