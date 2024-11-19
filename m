Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 539943858C98; Tue, 19 Nov 2024 10:51:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 539943858C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1732013479;
	bh=1asyLEu8CuLfccr1KSF3VUEdc9kn0sLlHTLzVjgvBHk=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=NluCn29RWd2A4T5BjA9u9C41xUKThw2tAH6B7yjC4VlIlzcRirbLqVL3VaYzEgxO2
	 U5NJlr6Gw9rcGayki+tocdobv7UXfE1C5ArGt5pEfkuX15xBkkXw7ofGlgbELzHwuV
	 rtWkOM82yrqeFtGmA6aE1KmlnKpjBnV110+OuwsQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3F4D8A80A6B; Tue, 19 Nov 2024 11:51:17 +0100 (CET)
Date: Tue, 19 Nov 2024 11:51:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: sigtimedwait: Fix segfault when timeout is
 used
Message-ID: <ZzxtpcNi85kNQX2g@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241119084057.945-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241119084057.945-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Nov 19 17:40, Takashi Yano wrote:
> diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
> index 77152910b..eca536e90 100644
> --- a/winsup/cygwin/signal.cc
> +++ b/winsup/cygwin/signal.cc
> @@ -618,6 +618,20 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
>        switch (cygwait (NULL, waittime,
>  		       cw_sig_eintr | cw_cancel | cw_cancel_self))
>  	{
> +	case WAIT_TIMEOUT:
> +	  _my_tls.lock ();
> +	  if (_my_tls.sigwait_mask != 0)
> +	    {
> +	      /* Normal timeout */
> +	      _my_tls.sigwait_mask = 0;
> +	      _my_tls.unlock ();
> +	      set_errno (EAGAIN);
> +	      break;
> +	    }
> +	  /* sigpacket::process() already started.
> +	     Go through to WAIT_SIGNALED case. */
> +	  _my_tls.unlock ();
> +	  fallthrough;
>  	case WAIT_SIGNALED:
>  	  if (!sigismember (set, _my_tls.infodata.si_signo))

I don't think this is safe.  infodata is only set in
_cygtls::interrupt_setup(), called from sigpacket::setup_handler(),
called from sigpacket::process() *after* _my_tls.sigwait_mask has
been set to 0 and outside the tls lock.

Unfortunately sigwait_mask only signals that processing the signal has
started, but we have to make sure that signal processing for this signal
has finished, so infodata is set up correctly.

Maybe we can utilize WaitOnAddress, kind of like this?

sigwait_common, just the fallthrough snippet:

  +       /* sigpacket::process() already started.
  +          Go through to WAIT_SIGNALED case. */
  +       _my_tls.unlock ();
  +       sigset_t compare = 0;
  +       WaitOnAddress (&_my_tls.sigwait_mask, &compare,
  +                      sizeof (sigset_t), INFINITE);
  +       _my_tls.sigwait_mask = 0;
  +       fallthrough;

sigpacket::process():

@@ -1457,6 +1457,7 @@ sigpacket::process ()
   bool issig_wait = false;
   struct sigaction& thissig = global_sigs[si.si_signo];
   void *handler = have_execed ? NULL : (void *) thissig.sa_handler;
+  sigset_t orig_wait_mask = 0;
 
   threadlist_t *tl_entry = NULL;
   _cygtls *tls = NULL;
@@ -1527,11 +1528,15 @@ sigpacket::process ()
   if ((HANDLE) *tls)
     tls->signal_debugger (si);
 
-  if (issig_wait)
+  tls->lock ();
+  if (issig_wait && tls->sigwait_mask != 0)
     {
+      orig_wait_mask = tls->sigwait_mask;
       tls->sigwait_mask = 0;
+      tls->unlock ();
       goto dosig;
     }
+  tls->unlock ();
 
   if (handler == SIG_IGN)
     {
@@ -1606,6 +1611,11 @@ dosig:
   /* Dispatch to the appropriate function. */
   sigproc_printf ("signal %d, signal handler %p", si.si_signo, handler);
   rc = setup_handler (handler, thissig, tls);
+  if (orig_wait_mask)
+    {
+      tls->sigwait_mask = orig_wait_mask;
+      WakeByAddressAll (&tls->sigwait_mask);
+    }
 
 done:
   cygheap->unlock_tls (tl_entry);

Mind, that's just an idea.  There may be a simpler way to do this.

Alternatively we can just fallback to your version 1.


Thanks,
Corinna
