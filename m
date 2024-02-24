Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C9336385843B; Sat, 24 Feb 2024 12:21:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C9336385843B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1708777289;
	bh=QRYoTF3qAtzo7XIpgAuYtpCdgosAwAiBOC70gvifCos=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rMG3mOOBZ6zUGQHjHhQAvXWVVqVlbKcLVoVgiR/WyggFh04pveq/CpymAfxsL37Gl
	 zRnHk0UJ8DFM8RJWR8AzjYGkCSudCapoCPh2k1O5XOkcq4uMhcq8x5+fT2YHld6g1s
	 g97q0TZNJNliQ+USQ78OZU38eHE1svimPswDz5+w=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0F0E6A809E4; Sat, 24 Feb 2024 13:21:28 +0100 (CET)
Date: Sat, 24 Feb 2024 13:21:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED
 to ENODEV
Message-ID: <ZdnfSDqfh1ZCynjH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <04f337bf-7197-b4af-3519-832ad2be5b14@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 23 19:14, Christian Franke wrote:
> Experiments with damaged USB flash drives and ddrescue revealed that the
> current mapping of these Win32 errors to the fallback EACCES could be
> improved.
> 
> BTW: I wonder why EACCES was selected as the fallback. Source code control
> forensics suggest that this was decided in the last millennium. A related
> comment from CGF added August 2000 persists until today :-)
> /* FIXME: what's so special about EACCESS? */

This goes back until 1997 in pre-CVS times.  There's a ChangeLog entry

  Wed Oct 29 22:43:57 1997  Geoffrey Noer  <noer@cygnus.com>

        [...]
        * syscalls.cc (seterrno): on failure, set EACCES instead of EPERM
        which is better for the unknown error case

So the default was EPERM at first and has been changed to EACCES
because it "is better for the unknown error case".

I'm open to ideas for an improved error mapping.

> From 8aa19c7fd13dc3790dc271dede8954539bffcd4d Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Fri, 23 Feb 2024 19:01:09 +0100
> Subject: [PATCH] Cygwin: Map ERROR_NO_SUCH_DEVICE and ERROR_MEDIA_CHANGED to
>  ENODEV
> 
> If a removable (USB) device is disconnected after opening its raw
> device, R/W attempts fail with ERROR_NO_SUCH_DEVICE(433).  If the
> raw device of a partition is used, ERROR_MEDIA_CHANGED(1110) is
> returned instead.  Both are mapped to ENODEV(19) because <errno.h>
> does not offer a value which better matches ERROR_MEDIA_CHANGED.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/local_includes/errmap.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Pushed.

Thanks,
Corinna

