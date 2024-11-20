Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 943E33858D20; Wed, 20 Nov 2024 13:06:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 943E33858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732107971;
	bh=POcRzG6szveEQU6/rTh/PHRGsXdgMSuYjiXDJcr9sQU=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BCjBao0iwi9yla7cm/+qBMxvG+e08Wx7vgHmubA6kXAv+cStbFxZR4x9CW+xIywd5
	 joVjOa2iIfMMFyxu4RzNyAue9f1jkyZ6v1kFEFTqtz6TUPX/fCUBvZvzbMr9jl53AG
	 4kbaP2tTvVJVU5cA0ZWiA/TmyT3WpRT5Sdl/iKU8=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 6DBE0A80D6C; Wed, 20 Nov 2024 14:06:09 +0100 (CET)
Date: Wed, 20 Nov 2024 14:06:09 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/2] Cygwin: lockf: Fix access violation in
 lf_clearlock().
Message-ID: <Zz3ewXTd-0MuEX72@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241115131422.2066-1-takashi.yano@nifty.ne.jp>
 <20241115131422.2066-2-takashi.yano@nifty.ne.jp>
 <ZztjYs4Cu28xZgtl@calimero.vinschen.de>
 <20241119173939.5ba0cb14459b3da22d226262@nifty.ne.jp>
 <ZzxfM9T2uy5Bdiao@calimero.vinschen.de>
 <20241119191302.9dea6a8aabb69727cdd3feb8@nifty.ne.jp>
 <Zz0Ak0QKKPQdOxfJ@calimero.vinschen.de>
 <20241120215222.8ff263bfd7c24cfbe9c64034@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241120215222.8ff263bfd7c24cfbe9c64034@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 20 21:52, Takashi Yano wrote:
> On Tue, 19 Nov 2024 22:18:11 +0100
> Corinna Vinschen wrote:
> > On Nov 19 19:13, Takashi Yano wrote:
> > > On Tue, 19 Nov 2024 10:49:39 +0100
> > > Corinna Vinschen wrote:
> > > > >  [PATCH v2] Cygwin: flock: Fix overlap handling in lf_setlock() and lf_clearlock()
> > > > > as well?
> > > > 
> > > > Give me a bit of time.  While the patch might fix the problem, what
> > > > bugs me is the deviation from upstream code.  We will at least need
> > > > a few comments to explain why we don't follow the upstream behaviour.
> > > 
> > > I've got it. Does this code come from 'upstream'? From what code?
> > 
> > This was once ripped from FreeBSD code in 2008.  The upstream code
> > has changed considerably, though, so I'm not so sure if my reluctance
> > makes any sense.
> > 
> > > Essentially, the ovcase 1 can be a part of ovcase 3. I guess the
> > > 'upstream' does not add lock entry having same lock range unlike
> > > current cygwin (lf_ver related). So, ovcase 1 can break after
> > > handling 1 overlap. However, we need find overlap repeatedly
> > > because we have lf_ver.
> > 
> > Yeah, I get that.  What bugs me is that the structure of the upstream
> > snippets changed, not the necessity for change.  For that reason alone,
> > I would prefer that the `case 1:' expression stays where it is in
> > lf_clearlock.  But that's unreasonable.
> > 
> > It's a puzzle of life that one thinks in 2008, that this upstream
> > code will always stay what it is. A mere 16 years later...
> > 
> > Ok, never mind that.  Please push.  Maybe add a single-line comment
> > why we deviate from the original 2008 FreeBSD code at these points.
> 
> Thanks for reviewing. Pushed.

Thanks for the comments!


Corinna
