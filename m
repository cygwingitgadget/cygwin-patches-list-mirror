From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Tue, 27 Feb 2001 06:15:00 -0000
Message-id: <20010227151541.B4275@cygbert.vinschen.de>
References: <u67ae79bw6v.fsf@rachel.hq.vtech> <u671ysl8xda.fsf@rachel.hq.vtech> <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de> <1825816804.20010226221015@logos-m.ru> <20010227004550.X27406@cygbert.vinschen.de> <12658340509.20010227124539@logos-m.ru> <20010227120159.D27406@cygbert.vinschen.de> <475821030.20010227160430@logos-m.ru>
X-SW-Source: 2001-q1/msg00123.html

On Tue, Feb 27, 2001 at 04:04:30PM +0300, Egor Duda wrote:
> CV> I have just checked on Linux kernel 2.2.x. For some reason it returns
> CV> the following on partitions and physical drives:
> 
> CV> lseek (fd, 0, SEEK_END) = 0 and the file pointer is set to the
> CV> beginning(!) of the raw device.
> 
> CV> lseek (fd, pos != 0, SEEK_END) = -1 (EINVAL)
> 
> CV> So if we want to be Linux compatible we could make our life very easy.
> 
> CV> Has somebody a 2.4 kernel to test the behaviour there?
> 
> i've just tested it under 2.4.0. it seeks correctly from the end of device
> and returns device_size + offset.
> 
>  if  return  value > 2G, it returns -1 with EOVERFLOW. I feel EFBIG is
> more appropriate here, but it's arguable.

Ok, that sounds more reasonable than the 2.2 behaviour. Would you
mind to change your current patch to work on physical drives
using IOCTL_DISK_GET_DRIVE_GEOMETRY and on partitions using the
IOCTL_DISK_GET_PARTITION_INFO call and, hmm, I think you're right,
to return EFBIG in the above case? That would be nice. I would
like to see the patch first but I'm pretty sure I will approve it.

BTW: I think we should begin to implement one or two 64bit calls
soon. At least `lseek64' would make much sense, IMO, and shouldn't
be too hard to implement.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
