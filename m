From: egor duda <deo@logos-m.ru>
To: Christopher Faylor <cygwin-patches@cygwin.com>
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Sat, 12 May 2001 04:43:00 -0000
Message-id: <64168820861.20010512154228@logos-m.ru>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010511142639.A26920@redhat.com>
X-SW-Source: 2001-q2/msg00248.html

Hi!

Friday, 11 May, 2001 Christopher Faylor cgf@redhat.com wrote:

CF> This looks ok.  I'm a little concerned about adding YA way to set symlinks,
CF> though.

well, i really hope this change is both backward and forward
compatible. i.e. old dll should work seamlessly  with "new" symlinks,
and new dll -- with the old ones. the only problem is with moving and
copying cygwin symlinks with native tools -- it's still here, as it
was before. 

CF> As a specific comment, I wonder if it would just make sense to store volume
CF> information in the path_conv class to avoid going through the duplicate efforts
CF> in symlink.

i guess so. currently, GetVolumeInformation is called only when
symlink is created, not resolved, but this will slow things down on
file systems other than NTFS. to remove this penalty,
GetVolumeInformation() should be called in symlink resolution code to, 
and that's where volume information caching can save some cycles.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

