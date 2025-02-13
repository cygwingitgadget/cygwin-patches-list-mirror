Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 08CF43858D20; Thu, 13 Feb 2025 14:33:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 08CF43858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739457182;
	bh=uY9bhSbjLCriF6ehojlQmH1O9srVKZi1a3w7LL+b4Zg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WlIm1LWOAKKLyuf0aE0/p+t8hjpCrODa/e/ft7+bbD/5dSTKhDID9/wnaKTvrg9w9
	 yL9gymA2RI/Nnuy807lSsgGlmhSiWaAjxS+VfXjZDOIweQ3pJoEBBVkCzPn5K8+btu
	 sgi52wR6PT7Ug6RNTvtEoxJRCAsb9hjskM23FAXU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E7933A8066E; Thu, 13 Feb 2025 15:32:59 +0100 (CET)
Date: Thu, 13 Feb 2025 15:32:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
Message-ID: <Z64Cm3wHdcgw__6U@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com>
 <Z60QiLIEAvDzSs5k@calimero.vinschen.de>
 <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com>
 <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com>
 <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
 <Z63-eTxbCyo65Jlj@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z63-eTxbCyo65Jlj@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 13 15:15, Corinna Vinschen wrote:
> On Feb 12 17:37, Jeremy Drake via Cygwin-patches wrote:
> > On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:
> > 
> > > On Wed, 12 Feb 2025, Jeremy Drake via Cygwin-patches wrote:
> > >
> > > > It was *supposed* to not return the second one.  Maybe I broke it when
> > > > trying to break out of the loop early...  I will test this scenario and
> > > > see why it doesn't work as expected.
> > >
> > > Yeah, I never actually looked at how posix_sorted was sorted.  It's sorted
> > > by length first, then by strcmp.  This was probably a premature
> > > optimization anyway.  conv_to_posix_path doesn't try to bail early, it
> > > just continues, and that's going to be a much more common code path than
> > > this...
> > 
> > Not only that, but there's a sash-vs-backslash mismatch between
> > native_path and mnt_fsname resulting in the strcasematch not matching.  I
> > must have only tested the root-of-drive-letter case (where the paths are
> > like C:), because that was the case the existing code was handling:
> > 
> > diff --git a/winsup/cygwin/mount.cc b/winsup/cygwin/mount.cc
> > index 4be24fbe84..ef3070dbe1 100644
> > --- a/winsup/cygwin/mount.cc
> > +++ b/winsup/cygwin/mount.cc
> > @@ -1645,14 +1645,8 @@ fillout_mntent (const char *native_path, const char
> > *posix_path, unsigned flags)
> >    struct mntent& ret=_my_tls.locals.mntbuf;
> >    bool append_bs = false;
> > 
> > -  /* Remove drivenum from list if we see a x: style path */
> >    if (strlen (native_path) == 2 && native_path[1] == ':')
> > -    {
> > -      int drivenum = cyg_tolower (native_path[0]) - 'a';
> > -      if (drivenum >= 0 && drivenum <= 31)
> > -       _my_tls.locals.available_drives &= ~(1 << drivenum);
> >        append_bs = true;
> > -    }
> > 
> > 
> > I have a fix for these, and I also added a patch 3 on top which removes
> > the de-duplication code and calls cygdrive_posix_path instead of
> > conv_to_posix_path.  You can not apply patch 3, apply patch 3 in case it
> > has to be reverted later, or squash it into 2 if you prefer, there's
> > options.
> 
> I think this looks good, including patch 3.

To wit:

  $ mount | grep drvmount
  C:/drvmount on /mnt/c/drvmount type ntfs (binary,posix=0,noumount,auto)
  $ mount C:/drvmount /home/corinna/drv
  $ mount | grep drvmount
  C:/drvmount on /home/corinna/drv type ntfs (binary,user)
  C:/drvmount on /mnt/c/drvmount type ntfs (binary,posix=0,noumount,auto)
  $ df /mnt/c/drvmount
  Filesystem     1K-blocks  Used Available Use% Mounted on
  C:/drvmount      4175868 56744   4119124   2% /mnt/c/drvmount
  $ df /home/corinna/drv
  Filesystem     1K-blocks  Used Available Use% Mounted on
  C:/drvmount      4175868 56744   4119124   2% /home/corinna/drv

> If you're fine with that,
> I'll push all three patches.
> 
> 
> Corinna
