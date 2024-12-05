Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 9E7063858401; Thu,  5 Dec 2024 12:02:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9E7063858401
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733400137;
	bh=vre40yIyEmKJnod7AYJu4QAxZZCTt16k+O4AcfjnkEQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=bfPephjb5/iGUbNJ2zrEJXApgkKXdqRfoEeXTD1RQEndhhmmpbaUiI7o/I9OG7ume
	 fgOdrr5+BANmTAK1yuYt1o6I6V+u8woZzf/Dr1P+6x4Qc5VvagZlrH2Xk4PtftB93E
	 iOcQ8Y3ldzW2h0SysYdc7FT6TYVb4OPLmHa17aE4=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 4DFDCA80659; Thu,  5 Dec 2024 13:02:15 +0100 (CET)
Date: Thu, 5 Dec 2024 13:02:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: signal: Introduce a lock for the signal queue
Message-ID: <Z1GWR0MF5xuAYfJz@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241205032548.29799-1-takashi.yano@nifty.ne.jp>
 <Z1GFwzDzoLA88AI6@calimero.vinschen.de>
 <20241205204327.8382aaccd89b00779ee2114c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205204327.8382aaccd89b00779ee2114c@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  5 20:43, Takashi Yano wrote:
> On Thu, 5 Dec 2024 11:51:47 +0100
> Corinna Vinschen wrote:
> > On Dec  5 12:25, Takashi Yano wrote:
> > > Currently, the signal queue is touched by the thread sig as well as
> > > other threads that call sigaction_worker(). This potentially has
> > > a possibility to destroy the signal queue chain. A possible worst
> > > result may be a self-loop chain which causes infinite loop. With
> > > this patch, lock()/unlock() are introduce to avoid such a situation.
> > > 
> > > Fixes: 474048c26edf ("* sigproc.cc (pending_signals::add): Just index directly into signal array rather than treating the array as a heap.")
> > > Suggested-by: Corinna Vinschen <corinna@vinschen.de>
> > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > ---
> > >  winsup/cygwin/exceptions.cc            | 12 +++++------
> > >  winsup/cygwin/local_includes/sigproc.h |  2 +-
> > >  winsup/cygwin/signal.cc                |  4 ++--
> > >  winsup/cygwin/sigproc.cc               | 28 +++++++++++++++++++++-----
> > >  4 files changed, 32 insertions(+), 14 deletions(-)
> > 
> > LGTM, please push.
> 
> With the patch
> [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue chain when cleared
> ?

Erm... wasn't this patch replacing v3 3/9?

Looks like I seriously lost track. Can you please send a small series
with just the patches you still want to apply?

Thanks,
Corinna
