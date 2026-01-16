Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 8CEC64BA2E2D; Fri, 16 Jan 2026 11:21:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8CEC64BA2E2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1768562468;
	bh=HDFUqw8Tv9G3ZBqo6azw+qvK1Qb1hZPt4y0+10ZTdI8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WTxiq73TZACtZaKXRwU+vESYU+nbRqvvuLDxJQKv3gvwiODUIZUwlFRUZscH7AR9B
	 QJeti3VRRuLd0nsZidGisyC19X01jlClxEeqtBVBkzsTK4BbzYD6ZgJjk2Sh5sLTAW
	 VHGb9kQjXS0CrkhjmeQR5CxP3lGUrAcjiEwbExWU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A6754A80C7B; Fri, 16 Jan 2026 12:21:06 +0100 (CET)
Date: Fri, 16 Jan 2026 12:21:06 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: c32rtomb: add missing check for invalid UNICODE
 character
Message-ID: <aWofIqlGYp8JitfB@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260114223106.828985-1-corinna-cygwin@cygwin.com>
 <20260116200909.ebab69522f9e11445584e647@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260116200909.ebab69522f9e11445584e647@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jan 16 20:09, Takashi Yano wrote:
> On Wed, 14 Jan 2026 23:31:06 +0100
> Corinna Vinschen wrote:
> > From: Corinna Vinschen <corinna@vinschen.de>
> > 
> > c32rtomb neglects to check the input character for being outside
> > the valid UNICODE planes.  It happily converts the invalid character
> > into a valid (but wrong) surrogate pair and carries on.
> > 
> > Add a check so characters beyond 0x10ffff are not converted anymore.
> > Return -1 with errno set to EILSEQ instead.
> > 
> > Fixes: 4f258c55e87f ("Cygwin: Add ISO C11 functions c16rtomb, c32rtomb, mbrtoc16, mbrtoc32.")
> > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > ---
> >  winsup/cygwin/release/3.6.7 | 5 +++++
> >  winsup/cygwin/strfuncs.cc   | 7 +++++++
> >  2 files changed, 12 insertions(+)
> >  create mode 100644 winsup/cygwin/release/3.6.7
> > 
> > diff --git a/winsup/cygwin/release/3.6.7 b/winsup/cygwin/release/3.6.7
> > new file mode 100644
> > index 000000000000..defe55ffe75e
> > --- /dev/null
> > +++ b/winsup/cygwin/release/3.6.7
> > @@ -0,0 +1,5 @@
> > +Fixes:
> > +------
> > +
> > +- Guard c32rtomb against invalid input characters.
> > +  Addresses a testsuite error in current gawk git master.
> > diff --git a/winsup/cygwin/strfuncs.cc b/winsup/cygwin/strfuncs.cc
> > index eb6576051d90..0cf41cefc8a2 100644
> > --- a/winsup/cygwin/strfuncs.cc
> > +++ b/winsup/cygwin/strfuncs.cc
> > @@ -146,6 +146,13 @@ c32rtomb (char *s, char32_t wc, mbstate_t *ps)
> >      if (wc <= 0xffff || !s)
> >        return wcrtomb (s, (wchar_t) wc, ps);
> >  
> > +    /* Check for character outside valid UNICODE planes */
> > +    if (wc > 0x10ffff)
> > +      {
> > +	_REENT_ERRNO(_REENT) = EILSEQ;
> > +	return (size_t)(-1);
> > +      }
> > +
> >      wchar_t wc_arr[2];
> >      const wchar_t *wcp = wc_arr;
> >  
> > -- 
> > 2.52.0
> 
> LGTM.

THanks

> What does this change address for?

I mentioned it above in the release/3.6.7 entry, a testsuite error in
gawk git master.  It checks the input functions with invalid input and
this uncovered the missing EILSEQ handling in c32rtomb.


Corinna
