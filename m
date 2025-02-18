Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E63B53858D20; Tue, 18 Feb 2025 21:20:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E63B53858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739913642;
	bh=kg+GuTIBrGY3OGB7Q0w0EWvx1QNu53Yyoq33GlUhvtg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Z369irqJN9x6aF0LWvWNzsmpWD0LUb88t0Pnwp7rquwpO+3bNlKA7F6rB06b8y7WW
	 qohd6T4o42eg8Bn+yyVERYJTWTnmlX+w7EGpWqod/iFjGBK1vFJ38MIjIGUARdFPdg
	 ItHad0cSjQr/uVebphxXU6VHwDuHDI8+BYvyfcH8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DF4FEA817D2; Tue, 18 Feb 2025 22:20:40 +0100 (CET)
Date: Tue, 18 Feb 2025 22:20:40 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: skip floppy drives in cygdrive_getmntent.
Message-ID: <Z7T5qE7rp3WpZH4D@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <df854454-c96e-8fe0-ead7-c70c566ec1d3@jdrake.com>
 <Z7TsohGAWwR9nOhX@calimero.vinschen.de>
 <e2c71487-2b97-e74d-0683-962f41decab6@jdrake.com>
 <Z7T4-niDlDcaaf9E@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z7T4-niDlDcaaf9E@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 18 22:17, Corinna Vinschen wrote:
> On Feb 18 13:10, Jeremy Drake via Cygwin-patches wrote:
> > On Tue, 18 Feb 2025, Corinna Vinschen wrote:
> > 
> > > Actually, given that we can't do without GetLogicalDrives anyway,
> > > this could be folded into the mapping list creation within
> > > dos_drive_mappings::dos_drive_mappings.
> > 
> > I don't agree.  That would affect the other user(s) of dos_drive_mappings.
> > What if somebody had a mapped file on a file on a floppy drive and looked
> > in /proc/<PID>/maps?
> 
> Good point.  Bad enough we still have to care for floppies.

Alternatively... calling the constructor with a parameter
`bool with_floppies'?


Corinna
