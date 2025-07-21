Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id D04E93858D3C; Mon, 21 Jul 2025 13:38:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D04E93858D3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753105092;
	bh=LBQiDbj7EPAPXtBnYw9xxPgJD5/znJh0qTY4mXUTuiE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=BQ889chMArvmAPJquNJqC1F4wkP/2e3fYGJ41IO/20c2ytQf4pX6RFpwqvu7hB4bg
	 Cn9mWKJ4G5Dtmf9juZdD+uZ7mP5iumPKtFPhPsiVKLKNdkhHBr3+aUTGh6rcUHds6l
	 Uv/ZouoG9jpIn/OQtK0IAe6yXivWWh7AeRP0kI/4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C2234A80DCD; Mon, 21 Jul 2025 15:38:05 +0200 (CEST)
Date: Mon, 21 Jul 2025 15:38:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Message-ID: <aH5CvWENvjsmKbjJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bd64e817-ffa8-4299-a3bc-6d1ff691ca9b@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 21 14:15, Jon Turney wrote:
> On 14/07/2025 14:27, Corinna Vinschen wrote:
> > On Jul 14 15:22, Corinna Vinschen wrote:
> > > On Jul 10 19:21, Radek Barton via Cygwin-patches wrote:
> > > >  From 8bfc01898261e341bbc8abb437e159b6b33a9312 Mon Sep 17 00:00:00 2001
> > > > From: Evgeny Karpov <evgeny.karpov@microsoft.com>
> > > > Date: Fri, 4 Jul 2025 20:20:37 +0200
> > > > Subject: [PATCH] Cygwin: malloc_wrapper: port to AArch64
> > > > MIME-Version: 1.0
> > > > Content-Type: text/plain; charset=UTF-8
> > > > Content-Transfer-Encoding: 8bit
> > > > 
> > > > Implements import_address function by decoding adr AArch64 instructions to get
> > > > target address.
> > > > 
> > > > Signed-off-by: Evgeny Karpov <evgeny.karpov@microsoft.com>
> > > > [...]
> > > 
> > > Pushed.
> > > 
> > > 
> > > Thanks,
> > > Corinna
> > 
> > Sigh.  Actually I shouldn't have done that.  While Evgeny is the patch
> > author, the *attached* patch has you, Radek, in the Signed-off-by, and
> > that's what I now pushed.
> > 
> > Please make sure that Signed-off-by sticks to the author in the attached
> > patch as well, not to the person sending the patches to the list, please.
> 
> If Radek is going to be adding Signed-off: lines of behalf of his
> colleagues, maybe this is an appropriate place to ask what he thinks he's
> attesting to with it?
> 
> 
> Corinna,
> 
> Maybe the "Before you get started" section in [1] should mention Signed-off:
> and what we think it means?

That's a good point.

dll.html is outdated.  We don't use the CONTRIBUTORS file anymore.  It
was a remnant of the past, when we switched our license and we still
needed to keep track of the developers and the 2-clause BSD rule while
long-living contracts with the old buyout license were still active.

These days, I would like to enforce the Signed-off-by: line and it
should have the same place and same significance as in the Linux kernel,
that is...

  https://developercertificate.org/

Briefly, the sign-off means, that the contributor has, both, the right
and the willingness, to contribute code to this project under the
project's open source license, i.e., GPL v3+ in case of Cygwin.

> If we really want it to be mandatory, I guess I could explore the
> possibility of a push hook to enforce that?
> 
> [1] https://cygwin.com/contrib/dll.html

Yeah, but there's one twist: We don't and can't enforce Signed-off-by:
lines in case of contributions to newlib.  Newlib is not under GPL.
Rather it's a collection of multiple open source licenses.  So in case
of newlib the meaning of a signed-off is rather fuzzy.

Therefore we only can enforce contributions to Cygwin code and docs.


Corinna
