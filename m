Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 02B063858C41; Thu, 13 Feb 2025 14:15:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 02B063858C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739456124;
	bh=GlMvkFCBx+kYkce/x39AqhV1HtJj4z//X7qV2KWlPXQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kFTYLeSUNtDGApDONzH+wHgDjFZo7Dagt1Dc6z3WA3IzZtPKKYlUrl8rSupbHm2wR
	 v6Itil0MP1xIMPOhaWvAMsxpRFjTbiIM7Lzhf//+DH4fqgYiPaclw9cAXBRr01vJUb
	 S9BhXKdcrxyQ+OhC5aYq5qeNZ1Zp84gTezJMq8lw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BCFA8A8066E; Thu, 13 Feb 2025 15:15:21 +0100 (CET)
Date: Thu, 13 Feb 2025 15:15:21 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
Message-ID: <Z63-eTxbCyo65Jlj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com>
 <Z60QiLIEAvDzSs5k@calimero.vinschen.de>
 <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com>
 <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com>
 <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 12 17:37, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:
> 
> > On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:
> >
> > > It was *supposed* to not return the second one.  Maybe I broke it when
> > > trying to break out of the loop early...  I will test this scenario and
> > > see why it doesn't work as expected.
> >
> > Yeah, I never actually looked at how posix_sorted was sorted.  It's sorted
> > by length first, then by strcmp.  This was probably a premature
> > optimization anyway.  conv_to_posix_path doesn't try to bail early, it
> > just continues, and that's going to be a much more common code path than
> > this...
> 
> Not only that, but there's a sash-vs-backslash mismatch between
> native_path and mnt_fsname resulting in the strcasematch not matching.  I
> must have only tested the root-of-drive-letter case (where the paths are
> like C:), because that was the case the existing code was handling:
> 
> diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> index 4be24fbe84..ef3070dbe1 100644
> --- a/winsup/cygwin/mount.cc
> +++ b/winsup/cygwin/mount.cc
> @@ -1645,14 +1645,8 @@ fillout_mntent (const char *native_path, const char
> *posix_path, unsigned flags)
>    struct mntent& ret=_my_tls.locals.mntbuf;
>    bool append_bs = false;
> 
> -  /* Remove drivenum from list if we see a x: style path */
>    if (strlen (native_path) == 2 && native_path[1] == ':')
> -    {
> -      int drivenum = cyg_tolower (native_path[0]) - 'a';
> -      if (drivenum >= 0 && drivenum <= 31)
> -       _my_tls.locals.available_drives &= ~(1 << drivenum);
>        append_bs = true;
> -    }
> 
> 
> I have a fix for these, and I also added a patch 3 on top which removes
> the de-duplication code and calls cygdrive_posix_path instead of
> conv_to_posix_path.  You can not apply patch 3, apply patch 3 in case it
> has to be reverted later, or squash it into 2 if you prefer, there's
> options.

I think this looks good, including patch 3.  If you're fine with that,
I'll push all three patches.


Corinna
