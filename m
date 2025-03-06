Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A731B3858D20; Thu,  6 Mar 2025 18:56:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A731B3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741287379;
	bh=lPhmxE9R6+M4C59cUAdnyy/izlng//KIh0rtxEkHj6Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=jBpwfYaB4JvBLNX/lZHGh+dMrc5F2ihhPx67AMZHjvH5xdHx4U7kafufzCGSt4qWQ
	 481EDyRKOMWCwr6RmhsRkMPH9fsISuj5M5IIRzMN65VC5DAwhirP/no/kZgL4mNimn
	 4ox/oHJ5PMouEDl8tsdaXg4rx2lNOo0Xl7Cb/+Sk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 17B32A804BD; Thu, 06 Mar 2025 19:56:17 +0100 (CET)
Date: Thu, 6 Mar 2025 19:56:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: signal: Add one more guard to stop signal
 handling on exit().
Message-ID: <Z8nv0fp0pxAF1Vqv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250306110243.1233681-1-takashi.yano@nifty.ne.jp>
 <Z8mDKd2vqPJX2BX5@calimero.vinschen.de>
 <6ac50523-b7f7-40cb-8440-6e21af8a9deb@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ac50523-b7f7-40cb-8440-6e21af8a9deb@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Mar  6 14:36, Jon Turney wrote:
> On 06/03/2025 11:12, Corinna Vinschen wrote:
> > On Mar  6 20:02, Takashi Yano wrote:
> > > The commit 3c1308ed890e adds a guard to stop signal handling on exit()
> > > in call_signal_handler(). However, the signal that is already queued
> > > but does not use signal handler may be going to process even with that
> > > patch.
> > > This patch add one more guard at the begining of sigpacket::process()
> > > to avoid that situation.
> > > 
> > > Fixes: 3c1308ed890e ("Cygwin: signal: Fix a problem that process hangs on exit")
> > > Reviewed-by:
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >   winsup/cygwin/exceptions.cc | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> > > index 759f89dca..a67529b19 100644
> > > --- a/winsup/cygwin/exceptions.cc
> > > +++ b/winsup/cygwin/exceptions.cc
> > > @@ -1457,7 +1457,7 @@ sigpacket::process ()
> > >     /* Don't try to send signals if we're just starting up since signal masks
> > >        may not be available.  */
> 
> Looks like this comment should be updated? Maybe just "starting up or
> shutting down"? Or the reason why sending signal while shutting down is
> unsafe?

Sure!  Feel free to push a patch along these lines.


Corinna
