Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 170E1384059D; Mon, 23 Jun 2025 07:44:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 170E1384059D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750664661;
	bh=w415UQpbk4f1WfpT/wqzemmfInBfEUFsX7AAPKjpVlc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uTHzjFlnOal5rVf8KmF19RDdZqVHeAandNQxdrteNzU0Cjoz5T7g2zzeyDwwbIrJl
	 oIOb+WtTytwow5sZ/vO7vWJZHCw/x0zq/EudTtJjuQ0q6j6OwDjgOavPSvXcCG8fMp
	 UFP7TMCfEOBb7ZYN+dutrcPbx5V0yiDlfXZq7BWM=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D5EA4A80846; Mon, 23 Jun 2025 09:44:18 +0200 (CEST)
Date: Mon, 23 Jun 2025 09:44:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH][API-CONFORMAANCE] Increase SYMLOOP_MAX to 63
Message-ID: <aFkF0sdBek5cTNBH@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAHnbEG+-vkWb3F9HJFNdtMt1wAtm90kz81p8H=0Y7QrGHn50ag@mail.gmail.com>
 <aFFOZ0-JHbJKs1Fc@calimero.vinschen.de>
 <CAHnbEGJCqd3cdB-Ky4-PbWzw=PSO7u7WKoL_t0boQotCGK5SfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHnbEGJCqd3cdB-Ky4-PbWzw=PSO7u7WKoL_t0boQotCGK5SfQ@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 20 13:24, Sebastian Feld wrote:
> On Tue, Jun 17, 2025 at 1:16 PM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> >
> > Hi Sebastian,
> >
> > On Jun 17 09:48, Sebastian Feld wrote:
> > > The following patch increases from 10 to 63, per Windows spec
> > > https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points
> > >
> > > Security impact is minor, SYMLOOP_MAX is just an artificial limiter to
> > > prevent endless loops.
> >
> > In case of Cygwin (Cygwin is slow, we all know that), the rather low
> > SYMLOOP_MAX was chosen so the path handling didn't get even slower in
> > some circumstances I don't remember anymore.  Maybe the times when this
> > was relevant are over, so we can try this.
> 
> 1. Cygwin is NOT slow. Who says that?

It's an old meme.

> 2. If there is a performance impact, then this should be documented in
> the source code.
> 
> > However, please send a real git patch created with `git format-patch'
> > and don't forget your Signed-off-by:".
> 
> Patch attached.

Pushed.

> Are there CI or regression test scripts where I could add a test module?

You can add something to winsup/testsuite I guess.


Thanks,
Corinna
