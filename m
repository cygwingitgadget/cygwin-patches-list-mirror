From: Christopher Faylor <cgf@redhat.com>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Tue, 29 May 2001 18:41:00 -0000
Message-id: <20010529214139.B14906@redhat.com>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010511142639.A26920@redhat.com> <64168820861.20010512154228@logos-m.ru> <178350282529.20010514180653@logos-m.ru> <18289228183.20010524164714@logos-m.ru>
X-SW-Source: 2001-q2/msg00268.html

On Thu, May 24, 2001 at 04:47:14PM +0400, egor duda wrote:
>Hi!
>
>Monday, 14 May, 2001 egor duda deo@logos-m.ru wrote:
>
>CF>>> As a specific comment, I wonder if it would just make sense to store volume
>CF>>> information in the path_conv class to avoid going through the duplicate efforts
>CF>>> in symlink.
>
>ed>> i guess so. currently, GetVolumeInformation is called only when
>ed>> symlink is created, not resolved, but this will slow things down on
>ed>> file systems other than NTFS. to remove this penalty,
>ed>> GetVolumeInformation() should be called in symlink resolution code to, 
>ed>> and that's where volume information caching can save some cycles.
>
>ed> done. i think, however, that this patch should wait until 1.3.3
>
>ok to install?

I'm having some reservations about this.  Doesn't this essentially add a
third method for dealing with symlinks on NT?  I know that there are
benefits to your method but I wonder if we really want to go down
this road.

cgf
