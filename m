Return-Path: <SRS0=Uy4f=SP=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w01.mail.nifty.com (mta-snd-w01.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:21])
	by sourceware.org (Postfix) with ESMTPS id B8C023858416
	for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 13:00:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B8C023858416
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B8C023858416
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732107628; cv=none;
	b=XOjo3pE0up0jvVP9/XGOvJlLwk6sJ1RFEjOYPoGJ0yl2S2na88SLnKmGMs30Y4lgHZEsxapVDt1V2mu77ryk2fqzOiC6TXBRDZbZUeBghAgWAbT2yyUWXwl1r/eeDpTJwGlbyk8vk00ISRUWhZfmy8vQoGCT+a5QrdHQxrMWc0Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732107628; c=relaxed/simple;
	bh=iz+LLGmC5j8r3hd58dQF+ykzOURBZN+z5Gk2VwFmP9w=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=eNPWmPsLKF+DYDiB+QwJZ0Q3J/RWbrVtfbnVxEIhPTlsi8r3Vs4TbP5C657Ct0KlHM+P93d279/GKmjZ8O8gFmEWvQIjFqfIWd5we3+lm185f8/S3E7yuCM3+kAElTab7OZo/v9XijsDOb4FHCCssBzB8lalSN2A38IgUcfnxAU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B8C023858416
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=MuUln6dd
Received: from HP-Z230 by mta-snd-w01.mail.nifty.com with ESMTP
          id <20241120130025171.SAUJ.19323.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 20 Nov 2024 22:00:25 +0900
Date: Wed, 20 Nov 2024 22:00:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: sigtimedwait: Fix segfault when timeout is
 used
Message-Id: <20241120220024.dd039419f2523a6bc3339e26@nifty.ne.jp>
In-Reply-To: <ZzxtpcNi85kNQX2g@calimero.vinschen.de>
References: <20241119084057.945-1-takashi.yano@nifty.ne.jp>
	<ZzxtpcNi85kNQX2g@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1732107625;
 bh=+F/XiI77cUYCk9u7gN8fajo+ISWpRyJcGZPzmKfgWZs=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=MuUln6ddIJuy3hAUk20QYOLox7r69xr/KSLQ40zVfewCtWNL/wz7SfmGuq2+tvzGio8JhxEB
 hINqumykDjZUtinylVj3Ne2n2+bLOHl6jv160tQ1wz3VWuF0Rcj+FQFu2+vDlqPy8rGGPvIHAX
 7XSkN87Z4ExWuvcby0yaYL5lgl/koCGQUtw0Q0klJJfaQRWKpXFgp6+lU+KV3YvKlOzqF0nYJQ
 XFgRMf5PAu//BKwglwm8XSL7ytVQfKRFsovNO0E9KHYmCCdgKw110ki3d2g6/UmSaWGU1fWhCz
 XM2neAx4VJblf8jp4tbSJFBh3+RNlZfVdnrPqrFJ29NRWw5g==
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 19 Nov 2024 11:51:17 +0100
Corinna Vinschen wrote:
> On Nov 19 17:40, Takashi Yano wrote:
> > diff --git a/winsup/cygwin/signal.cc b/winsup/cygwin/signal.cc
> > index 77152910b..eca536e90 100644
> > --- a/winsup/cygwin/signal.cc
> > +++ b/winsup/cygwin/signal.cc
> > @@ -618,6 +618,20 @@ sigwait_common (const sigset_t *set, siginfo_t *info, PLARGE_INTEGER waittime)
> >        switch (cygwait (NULL, waittime,
> >  		       cw_sig_eintr | cw_cancel | cw_cancel_self))
> >  	{
> > +	case WAIT_TIMEOUT:
> > +	  _my_tls.lock ();
> > +	  if (_my_tls.sigwait_mask != 0)
> > +	    {
> > +	      /* Normal timeout */
> > +	      _my_tls.sigwait_mask = 0;
> > +	      _my_tls.unlock ();
> > +	      set_errno (EAGAIN);
> > +	      break;
> > +	    }
> > +	  /* sigpacket::process() already started.
> > +	     Go through to WAIT_SIGNALED case. */
> > +	  _my_tls.unlock ();
> > +	  fallthrough;
> >  	case WAIT_SIGNALED:
> >  	  if (!sigismember (set, _my_tls.infodata.si_signo))
> 
> I don't think this is safe.  infodata is only set in
> _cygtls::interrupt_setup(), called from sigpacket::setup_handler(),
> called from sigpacket::process() *after* _my_tls.sigwait_mask has
> been set to 0 and outside the tls lock.

Yeah, indeed. I didn't have enough thought...

> Unfortunately sigwait_mask only signals that processing the signal has
> started, but we have to make sure that signal processing for this signal
> has finished, so infodata is set up correctly.
> 
> Maybe we can utilize WaitOnAddress, kind of like this?
> 
> sigwait_common, just the fallthrough snippet:
> 
>   +       /* sigpacket::process() already started.
>   +          Go through to WAIT_SIGNALED case. */
>   +       _my_tls.unlock ();
>   +       sigset_t compare = 0;
>   +       WaitOnAddress (&_my_tls.sigwait_mask, &compare,
>   +                      sizeof (sigset_t), INFINITE);
>   +       _my_tls.sigwait_mask = 0;
>   +       fallthrough;
> 
> sigpacket::process():
> 
> @@ -1457,6 +1457,7 @@ sigpacket::process ()
>    bool issig_wait = false;
>    struct sigaction& thissig = global_sigs[si.si_signo];
>    void *handler = have_execed ? NULL : (void *) thissig.sa_handler;
> +  sigset_t orig_wait_mask = 0;
>  
>    threadlist_t *tl_entry = NULL;
>    _cygtls *tls = NULL;
> @@ -1527,11 +1528,15 @@ sigpacket::process ()
>    if ((HANDLE) *tls)
>      tls->signal_debugger (si);
>  
> -  if (issig_wait)
> +  tls->lock ();
> +  if (issig_wait && tls->sigwait_mask != 0)
>      {
> +      orig_wait_mask = tls->sigwait_mask;
>        tls->sigwait_mask = 0;
> +      tls->unlock ();
>        goto dosig;
>      }
> +  tls->unlock ();
>  
>    if (handler == SIG_IGN)
>      {
> @@ -1606,6 +1611,11 @@ dosig:
>    /* Dispatch to the appropriate function. */
>    sigproc_printf ("signal %d, signal handler %p", si.si_signo, handler);
>    rc = setup_handler (handler, thissig, tls);
> +  if (orig_wait_mask)
> +    {
> +      tls->sigwait_mask = orig_wait_mask;
> +      WakeByAddressAll (&tls->sigwait_mask);
> +    }
>  
>  done:
>    cygheap->unlock_tls (tl_entry);
> 
> Mind, that's just an idea.  There may be a simpler way to do this.
> 
> Alternatively we can just fallback to your version 1.

Using WaitOnAddress() may be nice idea, however, I prefer my v1 patch.
It's simpler and the intent of the code is clearer, isn't it?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
