From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: storing symlink in extended attribute (on ntfs)
Date: Fri, 11 May 2001 11:28:00 -0000
Message-id: <20010511142639.A26920@redhat.com>
References: <1791875116.20010510172000@logos-m.ru> <12912395994.20010510201521@logos-m.ru>
X-SW-Source: 2001-q2/msg00242.html

On Thu, May 10, 2001 at 08:15:21PM +0400, egor duda wrote:
>Hi!
>
>Thursday, 10 May, 2001 egor duda deo@logos-m.ru wrote:
>
>ed>   i've modified cygwin slightly to store symlink value in shortcut's
>ed> extended attribute, and to try to get it from there. my (rough)
>ed> benchmarking shows 30%-50% speedup in symlink resolution code.
>
>[...]
>
>ed> the patch is only proof-of-concept. of course, if will be cleaned up
>ed> (work only on ntfs, better error checking, etc.) if we decide we need
>ed> such functionality in cygwin. 
>
>here's ready-to-go patch.
>2001-05-10  Egor Duda  <deo@logos-m.ru>
>
>        * security.h (NTWriteEA): Change prototype.
>        * ntea.cc (NTReadEA): Don't check for global ntea setting, now
>        it's caller responsibility.
>        (NTWriteEA): Ditto.
>        * path.cc (symlink): If symlink is created on NTFS, store its
>        value in EA.
>        (symlink_info::check): Get symlink value from EA.
>        * path.h: Define SYMLINK_EA_NAME
>        * security.cc (get_file_attribute): Read attribute from EA only 
>        if 'ntea' is enabled.
>        (set_file_attribute): Ditto.

This looks ok.  I'm a little concerned about adding YA way to set symlinks,
though.

As a specific comment, I wonder if it would just make sense to store volume
information in the path_conv class to avoid going through the duplicate efforts
in symlink.

I'd also prefer that the stuff in symlink and symlink_info::check be put into
separate functions.

cgf
