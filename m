From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Thu, 10 May 2001 14:23:00 -0000
Message-id: <20010510232258.H5386@cygbert.vinschen.de>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru>
X-SW-Source: 2001-q2/msg00231.html

On Thu, May 10, 2001 at 08:15:21PM +0400, egor duda wrote:
> ed>   i've modified cygwin slightly to store symlink value in shortcut's
> ed> extended attribute, and to try to get it from there. my (rough)
> ed> benchmarking shows 30%-50% speedup in symlink resolution code.
> 
> here's ready-to-go patch.
> 2001-05-10  Egor Duda  <deo@logos-m.ru>
> 
>         * path.cc (symlink): If symlink is created on NTFS, store its
>         value in EA.

Did you check that with a Samba drive as well? Samba drives
return NTFS as file system name in a call to GetVolumeInformation,
too. AFAICS, additionally a check if the flag FILE_NAMED_STREAMS
is returned would be good. Samba returns FALSE here. I'm not sure
if that would have real advantages. It would avoid a useless
write when creating a symlink on Samba...

Except for the above knit, I like the idea. It combines the
advantages of shortcuts with a faster read mechanism on NTFS.
I think it's worth a try.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
