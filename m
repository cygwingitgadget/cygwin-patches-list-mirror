Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 17E003858C41; Thu, 13 Feb 2025 19:13:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17E003858C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739474029;
	bh=UHSEOk1SK2QcB0tAwsNMuzl7W4UHvyGkiPTCdgYEA5w=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fHfq/9AwHWSUBfbxDa/D4uR2u8XTI7FJNgegEIDu142Dot6Jm+mx0k7GvszB+Q5lo
	 0TbaEhpd/MWP53J3zpE7viJJqTPxnSAaVVp2kdw88jJ8yfl18dQS//ueceEP9/0SRb
	 FyVuyvHBKuTNTBBYw2eyqGrAZ3YbCojOuADiIWLo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 757DEA8066E; Thu, 13 Feb 2025 20:12:34 +0100 (CET)
Date: Thu, 13 Feb 2025 20:12:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
Message-ID: <Z65EIr3quZyhFWRu@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4f314ab3-8406-0a5c-2cc5-9f2f0af9df50@jdrake.com>
 <Z60QiLIEAvDzSs5k@calimero.vinschen.de>
 <9fd9ec5e-f9a5-d510-2792-3e0ca24e3f11@jdrake.com>
 <522175b6-08ed-9929-3705-aaadf30283ff@jdrake.com>
 <ed1a01aa-8908-47a2-70e2-b955c65962c0@jdrake.com>
 <Z63-eTxbCyo65Jlj@calimero.vinschen.de>
 <Z64Cm3wHdcgw__6U@calimero.vinschen.de>
 <1ad8846b-2a13-b0d4-f70f-e1413bc48fcb@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ad8846b-2a13-b0d4-f70f-e1413bc48fcb@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 13 10:08, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 13 Feb 2025, Corinna Vinschen wrote:
> 
> > On Feb 13 15:15, Corinna Vinschen wrote:
> >
> > > I think this looks good, including patch 3.
> >
> > To wit:
> >
> >   $ mount | grep drvmount
> >   C:/drvmount on /mnt/c/drvmount type ntfs (binary,posix=0,noumount,auto)
> >   $ mount C:/drvmount /home/corinna/drv
> >   $ mount | grep drvmount
> >   C:/drvmount on /home/corinna/drv type ntfs (binary,user)
> >   C:/drvmount on /mnt/c/drvmount type ntfs (binary,posix=0,noumount,auto)
> >   $ df /mnt/c/drvmount
> >   Filesystem     1K-blocks  Used Available Use% Mounted on
> >   C:/drvmount      4175868 56744   4119124   2% /mnt/c/drvmount
> >   $ df /home/corinna/drv
> >   Filesystem     1K-blocks  Used Available Use% Mounted on
> >   C:/drvmount      4175868 56744   4119124   2% /home/corinna/drv
> >
> > > If you're fine with that,
> > > I'll push all three patches.
> 
> Sounds good to me.  It's less code, and the code it calls
> (cygdrive_posix_path) is more efficient because it doesn't have to loop
> through all mounts.  As long as you're ok with the change in behavior
> that:
> 
> mount C: /c
> mount
> 
> will now show C: on both /c and /cygdrive/c, instead of just /c as before
> (this is the behavior all of that de-duplication mess was trying to
> replicate).

The new behaviour makes more sense, actually.

Pushed!

Would you mind to send a patch with a release message we can add
to release/3.6.0?


Thanks,
Corinna
