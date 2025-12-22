Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 0D3A54BA2E20; Mon, 22 Dec 2025 10:43:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0D3A54BA2E20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766400220;
	bh=Pbyp8dTLd7uvS32ZBYRIJtQ71Alp6kvzfm9oyu3eXt8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=xT0FMJd1kdAi/6iVcFMnkyXIc2y2acXCdqKhIjAyoN61GA0v/crpSHXnGzlVvu8WK
	 Lc2zMXNW92/nB0TsK0lVO3sR8i65QZtWFFJpoZ1ZaZURUr6i0te47z8cSRkljlNkr1
	 8lJPz2mkii0cB5dlfit+DhRFgaQBEORxOE5GZYBA=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 264C0A80D62; Mon, 22 Dec 2025 11:43:38 +0100 (CET)
Date: Mon, 22 Dec 2025 11:43:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Unicode 17.0 updates: build scripts and data tables
Message-ID: <aUkg2tjSLVawuqma@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <88d56dc4-1fb6-478b-8cf0-219313f52281@towo.net>
 <aUUy2isLSmhFR9b0@calimero.vinschen.de>
 <3890f049-28fd-4dc1-84e5-b25c427c4085@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3890f049-28fd-4dc1-84e5-b25c427c4085@SystematicSW.ab.ca>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 15:08, Brian Inglis wrote:
> On 2025-12-19 04:11, Corinna Vinschen wrote:
> 
> > thanks for the patches.  Three problems...
> > - The patches should ideally go to the newlib mailing list
> > - The patches are in `git show' format, not in `git format-patch'
> >    format, so they can't be applied via `git am'.
> > - The commit message doesn't contain an empty line to split the
> >    message into a summary line and the body, as in...
> > 
> 
> > On Dec 19 11:58, Thomas Wolff wrote:
> > >      Unicode table build: update scripts for generation of width data to recent changes in Unicode.org data file layout
> 
> >    Update scripts creating unicode tables
> >    Unicode.org data file layout changed,
> CLDR windowsZones.xml changed between v42 and v48: attached .diff is straight;
> .sum shows only changed zones.
> Any changes needed for tzset data or function?

Thanks, I updated the tzmap-from-unicode.org script to use main instead
of master as upstream branch name and refreshed tzmap.h accordingly.
There are not many changes, just a few ZZ zones going away, dropping
Asia/Choibalsan and adding America/Coyhaique.  But, either way, we're
refreshed :)


Thanks,
Corinna
