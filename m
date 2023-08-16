Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A27983858C52; Wed, 16 Aug 2023 07:54:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A27983858C52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1692172492;
	bh=EUYmcG67faOqD7x1UxPG0Juo9cx6XWp9m+n6kG3SyL4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=oiJBQ4Hoze9I2tStSlhi4XIDjoNahCxY3QS0D7OOXBvxyQ/VnsDHUDOxvskDtIgza
	 LxvcGJsuaMv+p2mAQ2vO9+ulTA/MtdeFL6zfGsiIvetdrxs/7f0rAedPxqzpLKx/Ej
	 EDrnUlmr7maW3K/4OQt+BtTS5h+B5Iq+tJYqb78I=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id EA57EA80C03; Wed, 16 Aug 2023 09:54:50 +0200 (CEST)
Date: Wed, 16 Aug 2023 09:54:50 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: shared: Fix access permissions setting in
 open_shared().
Message-ID: <ZNyAyklqKEKianyY@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230815233746.1424-1-takashi.yano@nifty.ne.jp>
 <ZNx/9DTJf9CXTlDU@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZNx/9DTJf9CXTlDU@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Aug 16 09:51, Corinna Vinschen wrote:
> On Aug 16 08:37, Takashi Yano wrote:
> > After the commit 93508e5bb841, the access permissions argument passed
> > to open_shared() is ignored and always replaced with (FILE_MAP_READ |
> > FILE_MAP_WRITE). This causes the weird behaviour that sshd service
> > process loses its cygwin PID. This triggers the failure in pty that
> > transfer_input() does not work properly.
> > 
> > This patch resumes the access permission settings to fix that.
> > 
> > Fixes: 93508e5bb841 ("Cygwin: open_shared: don't reuse shared_locations parameter as output")
> > Signedd-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > ---
> >  winsup/cygwin/mm/shared.cc | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/winsup/cygwin/mm/shared.cc b/winsup/cygwin/mm/shared.cc
> > index 40cdd4722..7977df382 100644
> > --- a/winsup/cygwin/mm/shared.cc
> > +++ b/winsup/cygwin/mm/shared.cc
> > @@ -139,8 +139,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
> >        if (name)
> >  	mapname = shared_name (map_buf, name, n);
> >        if (m == SH_JUSTOPEN)
> > -	shared_h = OpenFileMappingW (FILE_MAP_READ | FILE_MAP_WRITE, FALSE,
> > -				     mapname);
> > +	shared_h = OpenFileMappingW (access, FALSE, mapname);
> >        else
> >  	{
> >  	  created = true;
> > @@ -165,8 +164,7 @@ open_shared (const WCHAR *name, int n, HANDLE& shared_h, DWORD size,
> >    do
> >      {
> >        addr = (void *) next_address;
> > -      shared = MapViewOfFileEx (shared_h, FILE_MAP_READ | FILE_MAP_WRITE,
> > -				0, 0, 0, addr);
> > +      shared = MapViewOfFileEx (shared_h, access, 0, 0, 0, addr);
> >        next_address += wincap.allocation_granularity ();
> >        if (next_address >= SHARED_REGIONS_ADDRESS_HIGH)
> >  	{
> > -- 
> > 2.39.0
> 
> Oh drat, whatever was I thinking at the time?  Thanks for catching
> and fixing this!  Please push.

Please also add a release message to 3.4.8.  I'll create the release
this week.


Thanks,
Corinna
