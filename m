Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CCD083858D33; Tue,  3 Dec 2024 13:22:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CCD083858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733232133;
	bh=x2GwDUpO6x0gb9JO0hAu6BZKSuougpkqm5WaHv7D++Y=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dJWaqLJjcZpNGCvKlRXvinwVaqhlvFCByZiXOncjaxYXA9HA71Lm1m9fmuIKFJx4l
	 CI5P2sjPcLMZ+XSaJyb9equWUZxjqWNzYmfNJp6Voz0aISrkYkAdUevutzM2y6ejul
	 U83LEfqheqJIwFINwRKhaNlYLcwu8vMxtA55QtQo=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A8E60A80B66; Tue,  3 Dec 2024 14:22:11 +0100 (CET)
Date: Tue, 3 Dec 2024 14:22:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue
 chain when cleared
Message-ID: <Z08GA2sRmKhgGqeq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
 <Z03O873ZPfo9akuc@calimero.vinschen.de>
 <20241203211747.926c7428ffd35ac600dc4659@nifty.ne.jp>
 <20241203213145.6fff24af965cf988234e87bc@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241203213145.6fff24af965cf988234e87bc@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Dec  3 21:31, Takashi Yano wrote:
> On Tue, 3 Dec 2024 21:17:47 +0900
> Takashi Yano wrote:
> > On Mon, 2 Dec 2024 16:14:59 +0100
> > Corinna Vinschen wrote:
> > > On Nov 29 20:48, Takashi Yano wrote:
> > > > The queue is cleaned up by removing the entries having si_signo == 0
> > > > while processing the queued signals, however, sipacket::process() may
> > > > set si_signo in the queue to 0 of the entry already processed but not
> > > > succeed by calling sig_clear(). This patch ensures the sig_clear()
> > > > to remove the entry from the queue chain.
> > > 
> > > Thanks for this patch.  I just have two questions.
> > > 
> > > > Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> > > > Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> > > > Reported-by: Christian Franke <Christian.Franke@t-online.de>
> > > > Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > ---
> > > >  winsup/cygwin/local_includes/sigproc.h |  3 +-
> > > >  winsup/cygwin/sigproc.cc               | 48 +++++++++++++++++---------
> > > >  2 files changed, 34 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
> > > > index 46e26db19..8b7062aae 100644
> > > > --- a/winsup/cygwin/local_includes/sigproc.h
> > > > +++ b/winsup/cygwin/local_includes/sigproc.h
> > > > @@ -50,8 +50,9 @@ struct sigpacket
> > > >    {
> > > >      HANDLE wakeup;
> > > >      HANDLE thread_handle;
> > > > -    struct sigpacket *next;
> > > >    };
> > > > +  struct sigpacket *next;
> > > > +  struct sigpacket *prev;
> > > 
> > > The former method using q and qnext ptr didn't need prev.  The question
> > > is, why did you add prev?  If you think this has an advantage, even if
> > > just better readability, it would be nice to document this in the commit
> > > message.
> > 
> > Consider the queued signal chain is like:
> > A->B->C->D
> > Assume that now 'q' and 'qnext' ptr points to C and process() is
> > processing C. If B is cleared in process(), A->next should be set
> > to C.
> in clear().
> 
> > Then, if process() for C succeeds, C should be removed from
> > the queue, so A->next should be set to D. However, now we cannot
> > access to A because we do not have the pointer to A.
> in while loop in wait_sig().

Thanks for the reasoning behind this.  On second thought, there's
no reason to add this to the commit message.  Or just a single brief
sentence.


Corinna
