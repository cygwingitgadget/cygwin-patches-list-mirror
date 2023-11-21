Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A05F03858C30; Tue, 21 Nov 2023 18:41:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A05F03858C30
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1700592085;
	bh=ZK478lro1PIFU3TwIqgbKcFIIXJCbrfuZ962w+WuLd4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NMcIABBq/Lk3Yh+nvGGPuNXdVLhqb3u1SX7Rgb4CzcuPAHBver4I9fYHOQ8eFOSS2
	 Hco9mudFrUt3hetxVFcjIb1LIYD820l7RdeI9fMoCqK7joutexKCyFEvmxfzJQJmqb
	 Fst3/m97BGfncW3FLIXm5oSFLlfSUwwF86qkpRZY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0057AA8098C; Tue, 21 Nov 2023 19:41:23 +0100 (CET)
Date: Tue, 21 Nov 2023 19:41:23 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
Message-ID: <ZVz50yQyM0bHnbQc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
 <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
 <ZVsppVEdC+HW2NE5@calimero.vinschen.de>
 <ZVsrDfTnL6Fy3BfM@calimero.vinschen.de>
 <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
 <0ba1c78e-15e6-65a2-eb4d-16ac2495c356@t-online.de>
 <ZVzLnADL0i2X3orL@calimero.vinschen.de>
 <7d24b7f1-0dae-ad23-6bde-3502716edbad@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7d24b7f1-0dae-ad23-6bde-3502716edbad@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Nov 21 19:31, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > Looks good, but I just realized that I was already wondering about the
> > sanitization and forgot to talk about it:
> > 
> > On Nov 21 12:24, Christian Franke wrote:
> > > diff --git a/winsup/cygwin/fhandler/dev_disk.cc b/winsup/cygwin/fhandler/dev_disk.cc
> > > index c5d72816f..d12ac52fa 100644
> > > --- a/winsup/cygwin/fhandler/dev_disk.cc
> > > +++ b/winsup/cygwin/fhandler/dev_disk.cc
> > > @@ -64,10 +64,12 @@ sanitize_label_string (WCHAR *s)
> > >     /* Linux does not skip leading spaces. */
> > >     return sanitize_string (s, L'\0', L' ', L'_', [] (WCHAR c) -> bool
> > >       {
> > > -      /* Labels may contain characters not allowed in filenames.
> > > -	 Linux replaces spaces with \x20 which is not an option here. */
> > > +      /* Labels may contain characters not allowed in filenames.  Also
> > Apart from slash and backslash, we don't have this problem in Cygwin,
> > usually.  Even control characters are no problem.  All chars not allowed
> > in filenames are just transposed into the Unicode private use area, as
> > per strfuncs.cc, line 20ff on the way to storage, and back when reading
> > the names from storage.  This, and especially in a virtual filesystem
> > like /proc, there's no reason to avoid these characters.
> 
> Thanks for clarification.
> 
> 
> > 
> > > +         replace '#' to avoid that duplicate markers introduce new
> > > +	 duplicates.  Linux replaces spaces with \x20 which is not an
> > > +	 option here. */
> > >         return !((0 <= c && c <= L' ') || c == L':' || c == L'/' || c == L'\\'
> > > -	      || c == L'"');
> > > +	      || c == L'#' || c == L'"');
> > If you really want to avoid chars not allowed in DOS filenames, the
> > list seems incomplete, missing '<', '>', '?', '*', '|'.
> > 
> > But as I said, there's really no reason for that.  I simply reduced the
> > above expression to
> > 
> >    return !(c == L'/' || c == L'\\' || c == L'#');
> > 
> > and created a disk label
> > 
> >    test"foo*bar?baz:"
> > 
> > It works nicely, including stuff like
> > 
> >    $ ls *\"*
> >    $ ls *\**
> > 
> > So, I can push it as is, or we just allow everything and the kitchen sink
> > as per the reduced filter expression.  What do you prefer?
> 
> The latter - patch attached.

Pushed.

Thanks a lot,
Corinna
