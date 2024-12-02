Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 6BA503858C54; Mon,  2 Dec 2024 15:15:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BA503858C54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1733152501;
	bh=r0YQsOXY6K9a3TiEPpIcNcQ1QGPPanFPPIdQqHwh7yE=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=WoxHF62c9sm/FkBo9pJvC0Al168VTBJCr5koRdX+Jiwf7UlIGZLd9BehQhwaaQYmg
	 bERIvCGmEXcXTHRGdB5dTU23QHFvOgdY4bo9dBub1RaIwddpbjCWqfUTXId3M8chMU
	 DuZoib0BU1cyPQeFt5ZoUXdjZXshb5a5bPSC9K5E=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 63046A80BC2; Mon,  2 Dec 2024 16:14:59 +0100 (CET)
Date: Mon, 2 Dec 2024 16:14:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/9] Cygwin: signal: Remove queue entry from the queue
 chain when cleared
Message-ID: <Z03O873ZPfo9akuc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241129114835.14497-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 29 20:48, Takashi Yano wrote:
> The queue is cleaned up by removing the entries having si_signo == 0
> while processing the queued signals, however, sipacket::process() may
> set si_signo in the queue to 0 of the entry already processed but not
> succeed by calling sig_clear(). This patch ensures the sig_clear()
> to remove the entry from the queue chain.

Thanks for this patch.  I just have two questions.

> Addresses: https://cygwin.com/pipermail/cygwin/2024-November/256744.html
> Fixes: 9d2155089e87 ("(wait_sig): Define variable q to be the start of the signal queue.  Just iterate through sigq queue, deleting processed or zeroed signals")
> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/local_includes/sigproc.h |  3 +-
>  winsup/cygwin/sigproc.cc               | 48 +++++++++++++++++---------
>  2 files changed, 34 insertions(+), 17 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
> index 46e26db19..8b7062aae 100644
> --- a/winsup/cygwin/local_includes/sigproc.h
> +++ b/winsup/cygwin/local_includes/sigproc.h
> @@ -50,8 +50,9 @@ struct sigpacket
>    {
>      HANDLE wakeup;
>      HANDLE thread_handle;
> -    struct sigpacket *next;
>    };
> +  struct sigpacket *next;
> +  struct sigpacket *prev;

The former method using q and qnext ptr didn't need prev.  The question
is, why did you add prev?  If you think this has an advantage, even if
just better readability, it would be nice to document this in the commit
message.

>    int process ();
>    int setup_handler (void *, struct sigaction&, _cygtls *);
>  };
> diff --git a/winsup/cygwin/sigproc.cc b/winsup/cygwin/sigproc.cc
> index 4d50a5865..8ffb90a2c 100644
> --- a/winsup/cygwin/sigproc.cc
> +++ b/winsup/cygwin/sigproc.cc
> @@ -111,7 +111,7 @@ class pending_signals
>  public:
>    void add (sigpacket&);
>    bool pending () {retry = !!start.next; return retry;}
> -  void clear (int sig) {sigs[sig].si.si_signo = 0;}
> +  void clear (int sig);
>    void clear (_cygtls *tls);
>    friend void sig_dispatch_pending (bool);
>    friend void wait_sig (VOID *arg);
> @@ -432,21 +432,35 @@ sig_clear (int sig)
>    sigq.clear (sig);
>  }
>  
> +/* Clear pending signals of specific si_signo.
> +   Called from sigpacket::process(). */
> +void
> +pending_signals::clear (int sig)
> +{
> +  sigpacket *q = sigs + sig;
> +  if (!sig || !q->si.si_signo)
> +    return;
> +  q->si.si_signo = 0;
> +  q->prev->next = q->next;
> +  if (q->next)
> +    q->next->prev = q->prev;
> +}

This is called from sigpacket::process() as well as from wait_sig(),
_cygtls::handle_SIGCONT() and sigaction_worker().

The below clear method is called from _cygtls::remove_pending_sigs().

The calls from sigpacket::process() and _cygtls::handle_SIGCONT() are
under protection of the threadlist_t mutex (which actually isn't meant
to protect the sig queue), but the calls from wait_sig() and
sigaction_worker() are not.  wait_sig() also modifies the queue by itself.

Given that the signal queue is working on predefined memory, there's
fortunately not much chance of memory corruption, but without locking
or, better, lockfree add/clear using Interlocked functions, aren't
we potentially losing signals?


Thanks,
Corinna
