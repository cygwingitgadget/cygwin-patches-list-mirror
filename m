From: egor duda <deo@logos-m.ru>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Thu, 24 May 2001 05:48:00 -0000
Message-id: <18289228183.20010524164714@logos-m.ru>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010511142639.A26920@redhat.com> <64168820861.20010512154228@logos-m.ru> <178350282529.20010514180653@logos-m.ru>
X-SW-Source: 2001-q2/msg00265.html

Hi!

Monday, 14 May, 2001 egor duda deo@logos-m.ru wrote:

CF>>> As a specific comment, I wonder if it would just make sense to store volume
CF>>> information in the path_conv class to avoid going through the duplicate efforts
CF>>> in symlink.

ed>> i guess so. currently, GetVolumeInformation is called only when
ed>> symlink is created, not resolved, but this will slow things down on
ed>> file systems other than NTFS. to remove this penalty,
ed>> GetVolumeInformation() should be called in symlink resolution code to, 
ed>> and that's where volume information caching can save some cycles.

ed> done. i think, however, that this patch should wait until 1.3.3

ok to install?

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

