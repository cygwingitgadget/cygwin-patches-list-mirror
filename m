From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Tue, 27 Feb 2001 03:02:00 -0000
Message-id: <20010227120159.D27406@cygbert.vinschen.de>
References: <u67ae79bw6v.fsf@rachel.hq.vtech> <u671ysl8xda.fsf@rachel.hq.vtech> <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de> <1825816804.20010226221015@logos-m.ru> <20010227004550.X27406@cygbert.vinschen.de> <12658340509.20010227124539@logos-m.ru>
X-SW-Source: 2001-q1/msg00120.html

On Tue, Feb 27, 2001 at 12:45:39PM +0300, Egor Duda wrote:
> CV> Did you try that even on raw partitions (\\.\X:)? From the MSDN:
> 
> CV> "The IOCTL_DISK_GET_DRIVE_GEOMETRY control code retrieves information
> CV>  about the physical disk's geometry"
>  
> CV> so I assume it will only work for raw harddisks (\\.\physicaldriveN).
> 
> Yep,    you're    right.    I    can    work    around    this    with
> IOCTL_DISK_GET_PARTITION_INFO  ioctl,  but here comes the problem with
> off_t  and  size_t being long int :(  So we won't be able to work with
> drives  and  partitions  longer  then  2G  (which  are  very  frequent
> nowadays). Should we return EINVAL in such cases?

I have just checked on Linux kernel 2.2.x. For some reason it returns
the following on partitions and physical drives:

lseek (fd, 0, SEEK_END) = 0 and the file pointer is set to the
beginning(!) of the raw device.

lseek (fd, pos != 0, SEEK_END) = -1 (EINVAL)

So if we want to be Linux compatible we could make our life very easy.

Has somebody a 2.4 kernel to test the behaviour there?

> BTW,   does   anybody  have  MO drives around to test this ioctls with
> partitioned removable media?

I have a ZIP-100 drive which is what you're looking for. I have
used it for testing the raw stuff earlier.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
