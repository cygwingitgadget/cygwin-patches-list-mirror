From: Egor Duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: lseek() fails to seek on /dev/fd0 ('\\.\A:')
Date: Tue, 27 Feb 2001 01:47:00 -0000
Message-id: <12658340509.20010227124539@logos-m.ru>
References: <u67ae79bw6v.fsf@rachel.hq.vtech> <u671ysl8xda.fsf@rachel.hq.vtech> <613331659.20010226160225@logos-m.ru> <3A9A621F.7661F240@yahoo.com> <20010226161735.P27406@cygbert.vinschen.de> <1825816804.20010226221015@logos-m.ru> <20010227004550.X27406@cygbert.vinschen.de>
X-SW-Source: 2001-q1/msg00119.html

Hi!

Tuesday, 27 February, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> On Mon, Feb 26, 2001 at 10:10:15PM +0300, Egor Duda wrote:
>> CV> Indeed. I would be interested in the trivial patch as well.
>> 
>> well, almost trivial ;-)
>> It's not fully compatible with linux, as it doesn't allow seeking past
>> the  end  of  media (i think this is ok), and, alas, for NT only :( (i
>> don't  think  this  is ok, but i haven't found a way to get media size
>> under w9x)

CV> Did you try that even on raw partitions (\\.\X:)? From the MSDN:

CV> "The IOCTL_DISK_GET_DRIVE_GEOMETRY control code retrieves information
CV>  about the physical disk's geometry"
 
CV> so I assume it will only work for raw harddisks (\\.\physicaldriveN).

Yep,    you're    right.    I    can    work    around    this    with
IOCTL_DISK_GET_PARTITION_INFO  ioctl,  but here comes the problem with
off_t  and  size_t being long int :(  So we won't be able to work with
drives  and  partitions  longer  then  2G  (which  are  very  frequent
nowadays). Should we return EINVAL in such cases?

BTW,   does   anybody  have  MO drives around to test this ioctls with
partitioned removable media?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

