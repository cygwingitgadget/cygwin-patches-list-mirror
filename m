From: egor duda <deo@logos-m.ru>
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Mon, 14 May 2001 02:40:00 -0000
Message-id: <38334234654.20010514133925@logos-m.ru>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru> <20010510232258.H5386@cygbert.vinschen.de>
X-SW-Source: 2001-q2/msg00249.html

Hi!

Friday, 11 May, 2001 Corinna Vinschen cygwin-patches@cygwin.com wrote:

CV> Did you check that with a Samba drive as well? Samba drives
CV> return NTFS as file system name in a call to GetVolumeInformation,
CV> too. AFAICS, additionally a check if the flag FILE_NAMED_STREAMS
CV> is returned would be good. Samba returns FALSE here.

unfortunately, NT 4.0 returns FALSE too. on my ntfs partitions
fsflags == 0x1f. can you check what samba returns in fsflags?

additionally, there's 'fstype' option in smb.conf, which allows setting
reported file system type to any string, say, "Samba". I'm not sure if
such change won't break some native applications.

CV> I'm not sure if that would have real advantages. It would avoid a
CV> useless write when creating a symlink on Samba...

there will be. i think that checking fs for "fast ea" support is
desirable on symlink reads too, to avoid unnecessary ea reading
efforts. so, i believe, we'll reduce symlink resolution time if we'll
be able to say by volume information, whether it supports EA's or not.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19

