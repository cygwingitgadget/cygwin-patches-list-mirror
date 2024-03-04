Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CAC883858D28; Mon,  4 Mar 2024 17:38:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CAC883858D28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709573889;
	bh=p7gZLQpFYl099Dd/rHQf5UaMYMl0dIm/EufH/nlE0Dg=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NRZA557QwvgoDU19H7Xw0b66DLiQqbINN5DGBBGq8dkWSKEMlZYj7lFQG8NGnpyJS
	 YZ/FV2kZ7fXzRejEoS2m1zjA+JQ4SkR9C5aMO3oYAkYOIkzh9vnw1b854m2T+hOCFP
	 0kkDCIw9HSxkdeHntounF38L9/oA1uKY52q8cKjU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 797CEA80C2F; Mon,  4 Mar 2024 18:38:07 +0100 (CET)
Date: Mon, 4 Mar 2024 18:38:07 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-ID: <ZeYG_11UfRTLzit1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
 <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
 <20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
 <87a5nfbnv7.fsf@Gerda.invalid>
 <20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
 <ZeWjmEikjIUushtk@calimero.vinschen.de>
 <87edcqgfwc.fsf@>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edcqgfwc.fsf@>
List-Id: <cygwin-patches.cygwin.com>

On Mar  4 16:45, ASSI wrote:
> Corinna Vinschen writes:
> > Right you are.  We always said that independent Cygwin installations
> > are supposed to *stay* independent.
> >
> > Keep in mind that they don't share the same shared objects in the native
> > NT namespace and they don't know of each other.  It's not only the
> > process table but also in-use FIFO stuff, pty info, etc.
> 
> What I was getting at is that a process not showing up in the process
> list in one Cygwin installation doesn't automatically mean it's a native
> Windows process, it could be a process started by an independent Cygwin
> installation.  So this way of checking for "native" Windows processes
> may or may not do what was originally intended.

But that was my point. A "foreign" Cygwin process from another
installation is not a Cygwin process.  Lots of interoperability
just won't work, so it's basically a native process.


Corinna
