Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 20C603858406; Fri, 14 Feb 2025 09:53:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20C603858406
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739526795;
	bh=LL9Knwwul4jpOjM3xa8umQKtux+qhLjFODZlVOHa8jg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FUgb9Q1cTrVhc2gi6tbQsGnqdr74mSO9EgamO4JNVVxj+tBamU5T3WZqV3lWQp8xw
	 GAPqxw3d3SVGvuN69ULSAFaxXD+9imEZkus7Aof6tAfVmwiYGBlOx/c5ljN3C1DXe6
	 ROBbzA0Yi9kavOgBmneaA7y/NWsL61YpYkMeoxvU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E4B6FA80D3F; Fri, 14 Feb 2025 10:53:12 +0100 (CET)
Date: Fri, 14 Feb 2025 10:53:12 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: expose all windows volume mount points.
Message-ID: <Z68SiMcx-qSzxkxy@calimero.vinschen.de>
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
 <Z65EIr3quZyhFWRu@calimero.vinschen.de>
 <36cb1004-0f77-2676-c948-c5dd81bae7a6@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <36cb1004-0f77-2676-c948-c5dd81bae7a6@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 13 16:27, Jeremy Drake via Cygwin-patches wrote:
> On Thu, 13 Feb 2025, Corinna Vinschen wrote:
> 
> > The new behaviour makes more sense, actually.
> >
> > Pushed!
> >
> > Would you mind to send a patch with a release message we can add
> > to release/3.6.0?
> 
> 
> Sent.  I also documented my other patches that only seem to be on the
> master branch (ie, not backported to 3.5).

Thanks!  Yeah, as this is new behaviour, it doesn't really belong
into 3.5.  I think it's time to release 3.6 in the next few weeks,
anyway.


Corinna
