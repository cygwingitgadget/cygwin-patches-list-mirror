From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Tue, 27 Feb 2001 07:52:00 -0000
Message-id: <20010227165149.A4647@cygbert.vinschen.de>
References: <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de> <1825816804.20010226221015@logos-m.ru> <20010227004550.X27406@cygbert.vinschen.de> <12658340509.20010227124539@logos-m.ru> <20010227120159.D27406@cygbert.vinschen.de> <475821030.20010227160430@logos-m.ru> <20010227151541.B4275@cygbert.vinschen.de> <14713826972.20010227181756@logos-m.ru>
X-SW-Source: 2001-q1/msg00125.html

On Tue, Feb 27, 2001 at 06:17:56PM +0300, Egor Duda wrote:
> Hi!
> 
> Tuesday, 27 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:
> 
> CV> On Tue, Feb 27, 2001 at 04:04:30PM +0300, Egor Duda wrote:
> >> CV> Has somebody a 2.4 kernel to test the behaviour there?
> >> 
> >> i've just tested it under 2.4.0. it seeks correctly from the end of device
> >> and returns device_size + offset.
> >> 
> >>  if  return  value > 2G, it returns -1 with EOVERFLOW. I feel EFBIG is
> >> more appropriate here, but it's arguable.
> 
> CV> Ok, that sounds more reasonable than the 2.2 behaviour. Would you
> CV> mind to change your current patch to work on physical drives
> CV> using IOCTL_DISK_GET_DRIVE_GEOMETRY and on partitions using the
> CV> IOCTL_DISK_GET_PARTITION_INFO call and, hmm, I think you're right,
> CV> to return EFBIG in the above case? That would be nice. I would
> CV> like to see the patch first but I'm pretty sure I will approve it.
> 
> i've  already  modified  it,  the  diff  in my previous message is the
> modified  one.  It  determines drive geometry, and fails if it cannot,

Ooops, sorry I missed that there was an attachment to your mail.
The patch looks good. Please check it in. Just one minor nit:

Please change

	set_errno ( EFBIG );

to

	set_errno (EFBIG);

Thanks for that patch, I will check it with my ZIP drive this week.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
