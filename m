Return-Path: <SRS0=oHIC=ET=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 3189D4BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 14:24:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3189D4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3189D4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782224667; cv=none;
	b=JUNNINJrmEL7d4DVpOWKxacWV+QvFbwoHsPrqEAWO1YVnURi6URlnS9WGhYngWANZaCzUi11RBT9WbCbQ/7loGNCB6ofOznbFyOgsA/irarFnCqEPphFgyUMUZ+yZLjTaXeFBClA+/16ukxhwQ2be0YsxNJ9zJAKLShiu1xqJ0s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782224667; c=relaxed/simple;
	bh=H/6n7nYJBfBxQwqJp7FxCKCdL9pmK2417IzhiiWeVvw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=e2Ljm/bOk6m1uzj3E6ToVpW+OVUB+LuAPjAL5xJMmKB5xbGk2H7RKgNO0qMcSH3zUDf9a+11u5vaJsSBXKxNUDe6n6rfzpFKb2ilZbsYhpNGv4vPy9DnRN8sa4TIxGndKidv/pMi8R7CXC1j+QmRWo1nI8bXRDsWUf7hXCGQdRE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b8OXb7W7
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3189D4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=b8OXb7W7
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260623142425401.PNPO.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 23 Jun 2026 23:24:25 +0900
Date: Tue, 23 Jun 2026 23:24:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Fix race issue between starting and
 exiting non-cygwin apps
Message-Id: <20260623232423.5dec0125b316a8b7503f18a4@nifty.ne.jp>
In-Reply-To: <20260623212925.b12a2d4dc3c2c52926d44874@nifty.ne.jp>
References: <20260613140718.25268-1-takashi.yano@nifty.ne.jp>
	<9e5fa557-3ff1-41c2-8bb0-f09630eb1834@maxrnd.com>
	<20260623212925.b12a2d4dc3c2c52926d44874@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782224665;
 bh=3FxMPz0sk9hk/Urx7FWGc8YSwbNE7TOFflbI9ehnOjw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=b8OXb7W7brPc9hr4w2nacMPT7i8knPSJAIGEpQ7kNBvvMlqVrGFF0FDIRmLQyJpzVKWhYUuF
 aetPW2FTx53VJ2fmJtiIyGOty0anMnet78GYJm7fCCagwGPWHlUGEzfjNogodEWodQ4aKq0kDn
 G2U4/Te5Q8WEcxcV6VAN/S6tfJNfv52Wpr4fkZwk0bMxDQCFeRnXTjHKXkMfsgiylyuQ0K2Vvu
 nV9HqGStX0NZ+gQI/KWjeDXtrkxkBfZ+O3UVKkM8qz4fHUq8Z4IRD1f/6ck49z1A3f7x0YOfMn
 0qFqJI8xjQQ5nX2SSL3o2uaha5yC+ME/90P4b3JDckg3clEA==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 23 Jun 2026 21:29:25 +0900
Takashi Yano wrote:
> > I am a little concerned if the replacement WFSO is equivalent to the 
> > looping WFSO being replaced.  I.e., it terminates for the same 
> > condition(s) with the pty being in correct state.  I can't point to 
> > something specific though.  Can you reassure me?  Or is this just 
> > re-establishing code to the way it was before?
> 
> The code before the patch intended to leave wait-loop when pcon_start
> mode is set even though the pipe_sw_mutex was not acquired. With this
> patch, to_be_read_from_nat_pipe() is not called from master::write()
> anymore, so the busy-loop is not necessary due to changes below.
> 
> @@ -2496,7 +2519,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> @@ -2580,20 +2603,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)

Ah, I forgot to mention.

to_be_read_from_nat_pipe() is called in master::write() below, however,
it is called only when pseudo console is not activated. In this case,
the slave is never in setup_pseudoconsole(). So to_be_read_from_nat_pipe()
can acquire pipe_sw_mutex after a short while.

> > @@ -2383,6 +2373,26 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >   
> >     int pcon_start_mode =
> >       get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
> > +
> > +  /* This input transfer is needed when cygwin-app which is started from
> > +     non-cygwin app is terminated if pseudo console is disabled. */
> > +  if (!get_ttyp ()->pcon_activated && !pcon_start_mode
> > +      && to_be_read_from_nat_pipe ())
> > +    {
> > +      WaitForSingleObject (input_mutex, mutex_timeout);
> > +      if (get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
> > +	  && get_ttyp ()->pty_input_state == tty::to_cyg)
> > +	{
> > +	  acquire_attach_mutex (mutex_timeout);
> > +	  fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
> > +					      get_ttyp (),
> > +					      input_available_event,
> > +					      input_transferred_to_cyg);
> > +	  release_attach_mutex ();
> > +	}
> > +      ReleaseMutex (input_mutex);
> > +    }
> > +
> >     if (pcon_start_mode)
> >       { /* Reaches here when pseudo console initialization is on going. */
> >         /* Pseudo condole support uses "CSI6n" to get cursor position.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
