From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Mon, 26 Feb 2001 15:45:00 -0000
Message-id: <20010227004550.X27406@cygbert.vinschen.de>
References: <u67ae79bw6v.fsf@rachel.hq.vtech> <u671ysl8xda.fsf@rachel.hq.vtech> <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de> <1825816804.20010226221015@logos-m.ru>
X-SW-Source: 2001-q1/msg00114.html

On Mon, Feb 26, 2001 at 10:10:15PM +0300, Egor Duda wrote:
> CV> Indeed. I would be interested in the trivial patch as well.
> 
> well, almost trivial ;-)
> It's not fully compatible with linux, as it doesn't allow seeking past
> the  end  of  media (i think this is ok), and, alas, for NT only :( (i
> don't  think  this  is ok, but i haven't found a way to get media size
> under w9x)

Did you try that even on raw partitions (\\.\X:)? From the MSDN:

"The IOCTL_DISK_GET_DRIVE_GEOMETRY control code retrieves information
 about the physical disk's geometry"
 
so I assume it will only work for raw harddisks (\\.\physicaldriveN).

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
