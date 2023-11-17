Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8B9F03858C66; Fri, 17 Nov 2023 12:11:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8B9F03858C66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700223111;
	bh=6XzTJqWf10IE4oppGatmdxmkK/z1F0IZa0pgg95hu1A=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=rZqhwS/M2Sd5S0eBNTKhVs2Ko+ltEm3ki8UOjqDgj/AKDbeXzA6uRxMk7WMXNNb/A
	 XGjrkqaHuxcSCWhRYOPsj90qwDV9ds4CQPuZ6F4f6dYBG67BL46itkoD3N65bLcVQd
	 YHiL1PwewxbiDq+Kwg61AUHnQwzyPDkCVpRssJ90=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C77EDA80BE0; Fri, 17 Nov 2023 13:11:49 +0100 (CET)
Date: Fri, 17 Nov 2023 13:11:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-drive and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVdYhc9oSoXqWtpm@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <5db42b33-ed93-2e7c-977a-89d407137d86@t-online.de>
 <ZVXwnUgd3UnIqBQf@calimero.vinschen.de>
 <d4cd305a-1a23-633b-3327-6ec01cf462b6@t-online.de>
 <ZVYI6QQ+zOB2KCPy@calimero.vinschen.de>
 <2d02d56a-a2bc-6c15-10ff-2364aa73fd21@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d02d56a-a2bc-6c15-10ff-2364aa73fd21@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 16 18:02, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Nov 16 12:50, Christian Franke wrote:
> > ...
> > > > I also tried an NTFS partition and the output looks like this:
> > > > 
> > > >     0FD4F62866CFBF09 -> ../../sdc1
> > > > 
> > > > This is the 64 bit volume serial number as returned by
> > > > DeviceIoControl(FSCTL_GET_NTFS_VOLUME_DATA)(*).
> > > > 
> > > > Wouldn't that be what we want to see, too?
> > > Hmm...... yes. Should both information be provided in by-uuid or only the
> > > serial numbers? In the latter case, should we add e.g. by-voluuid for the
> > > volume GUIDs ?
> > Good question... by-voluuid sounds like a nice idea.  It's a Windows-only
> > concept anyway, so it might make sense to present it in its own directory.
> 
> Then by-voluuid is easy, changed patch is attached.

Pushed.


> I try to provide a patch
> for a new by-uuid with filesystem serial numbers soon.

Cool!


Thanks,
Corinna
