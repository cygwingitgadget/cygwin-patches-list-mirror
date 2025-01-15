Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 96D67385E006; Wed, 15 Jan 2025 12:26:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 96D67385E006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1736944006;
	bh=g8SOuGvODp/ob498xrSR4WJFdMZYqaysTeTxL4o+lbM=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Sfw9gdjEZ9fe47GZUz4LDqmGVeF9bGE2c+cuM8mrgLs7tTccIBgFtK84zbVVV9hex
	 P3JL9R2mstFOki095fMj+MWQOQmrycWikQU0ChkWLnvaRVWuj1XhyYWfunT+JKvujf
	 CrW76yHH1eygaLIwrHJSIT1LVI5htjZonjS1rPM0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8F385A80D2F; Wed, 15 Jan 2025 13:26:44 +0100 (CET)
Date: Wed, 15 Jan 2025 13:26:44 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 7/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 merge function variants on one line
Message-ID: <Z4ephA66xm6IF8hb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <39517f2a7fdd36a043c2029e0a24e16e8e7f3bee.1736552566.git.Brian.Inglis@SystematicSW.ab.ca>
 <Z4UXaKQmj2s22H3B@calimero.vinschen.de>
 <6115072e-ca00-4f51-b7c6-fcafa9b0a8c4@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6115072e-ca00-4f51-b7c6-fcafa9b0a8c4@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jan 13 17:22, Jon Turney wrote:
> On 13/01/2025 13:38, Corinna Vinschen wrote:
> > On Jan 10 17:01, Brian Inglis wrote:
> > > Move circular F/Ff/Fl and similar functions to put
> > > base entries and -f -l variants on the same line.
> > > 
> > > Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> > > ---
> > >   winsup/doc/posix.xml | 336 +++++++++++--------------------------------
> > >   1 file changed, 84 insertions(+), 252 deletions(-)
> > 
> > Hmm.  This makes more sense than the previous patch.
> > 
> > However, it doesn't make sense if only the math functions are affected
> > If you want to do this systematically, you'd have to group them
> > following the Open Group Base Spec Issue 8.
> > 
> > That would also imply merging stuff like
> > 
> >    iswalnum/iswalnum_l		-- page 1280
> >    le16toh/le32toh/le64toh	-- page 1327
> >    localtime/localtime_r		-- page 1354
> >    mlock/munlock			-- pages 1433, 1488
> >    sig2str/str2sig		-- page 2040
> > 
> > etc. etc.
> > 
> > Nevertheless, while this has a certain charm and I don't see
> > a disadvantage, I'd like to get Jon's input to this as well.
> 
> Well, I'd just go for one function per line, in alphabetical order, because
> it's unambiguous if we've done that correctly.
> 
> Otherwise, it devolves into arguments about "I think it looks nicer this
> way", which... well, "de gustibus non est disputandum".

Good point.  Yeah, let's keep them one per line in ASCII order.


Corinna
