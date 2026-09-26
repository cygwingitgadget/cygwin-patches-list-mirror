Return-Path: <SRS0=9EPT=HS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 504334BA901E
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 16:53:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 504334BA901E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 504334BA901E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790441620; cv=none;
	b=bxJR5RBPLGw68ih1FojjEwdZwHH4dV5Ctrt0MOq0+eTthaaC6x7YX3WZw+Dzt735153NFuv2ZvDjef0LeigYhl9xqI9XDOhF02WERSTJS3lmjIV2ZEIeeGrMh83CI7ZCH6Fhml5ayrCpS2WfJAgh9fSREFvaHN9QiceaFW8Ccd4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790441620; c=relaxed/simple;
	bh=vyQ/ZjEWtDfBUgXdAr0jKtKHJaujebgj2v72Hb7KpXU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=Pv6Nlg39X6jsL6ds3qw+mJAzQxcLXlCoSMw+JH8rgMSA6/PRHjLhKbWButgetkrKrftBlOlVW8d3Yno2JjPJKt2WZ8Uv5AT7v32CViGFh2C2HSJNx8bHhIZvjMNsaYG02+a26W8KCAUeevjbXNA0sB+5rcecOiisGvlymWpF8Yo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=U21+uEpa
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 504334BA901E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=U21+uEpa
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260926165338407.PVKU.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 01:53:38 +0900
Date: Sun, 27 Sep 2026 01:53:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260927015337.cd7ad714e5cc20e9ff5097df@nifty.ne.jp>
In-Reply-To: <f2c176e8-657e-1592-3b32-347ea0fddf14@gmx.de>
References: <20260915095532.531-1-takashi.yano@nifty.ne.jp>
	<f2c176e8-657e-1592-3b32-347ea0fddf14@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790441618;
 bh=fOpKS3KgNAYvIlFWLFiwMYAbOoOZvwbqRFR/2lgVpj0=;
 h=Date:From:To:Subject:In-Reply-To;
 b=U21+uEpauqnJG3MTMFDkqjU63303vXlFUhigYasr9xSTfo5NphO5N21QZlFLqdlyZjmSSsVQ
 5TcUXWEgne8KURNba5eEAXUJRMskr44dwldSrg+SXNgU9fVd+dby+me6G7YDm9MBvDfIVThjEI
 LFNkTrSjkbc3gaSnDLsb1k0eB3+jnhQqpc/WPiZTzlENC+qPvp4zVJzRmJ107G1pS1yeKhV/Xq
 URUG1s268BNQf4RcJMFba97D4tK0KvAEMPGPilvJQA7+7lgqO5nVHUtpps/l4jTFEvTy30xpuG
 en7Tnv1eB2naF78OVyorXlreHXOCxSVJ9Son3FGBBiwh1iIQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Thu, 24 Sep 2026 22:27:56 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 15 Sep 2026, Takashi Yano wrote:
> 
> > Previously, peek_console() used PeekConsoleInput() to confirm whether
> > the console input buffer has some input records. However, this need
> > attaching to the console if the process does not attach to the console.
> > To reduce that overhead, this patch uses WaitForSingleObject() with
> > console input handle instead. WaitForSingleObject() works without
> > attaching to the console, so this simplifies the peek_console()
> > code.
> > 
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Do not remove PeekConsoleInputW() call.
> > v3: Revert to v1 and check empty buffer in process_input_message()
> > 
> >  winsup/cygwin/fhandler/console.cc       |  3 +++
> >  winsup/cygwin/local_includes/fhandler.h |  3 ++-
> >  winsup/cygwin/select.cc                 | 34 +++++++++++++++----------
> >  3 files changed, 26 insertions(+), 14 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 0b0f11ee6..660fd3c41 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1494,6 +1494,9 @@ fhandler_console::process_input_message (size_t len)
> >    if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
> >      return input_ok;
> >  
> > +  if (total_read == 0)
> > +    return input_empty;
> > +
> 
> This change affects both callers, `peek_console()` and
> `fhandler_console::read()`. Does the latter also need to be adjusted (it
> would treat `input_empty` as an error, right)?

Hmm, currently yes. However, read() also waits for input_handle before
calling process_input_message(). Therefore, we should return with EAGAIN
in nonblocking mode, and should wait for real input in blocking mode,
I think, as the v4 patch.

> >    for (i = 0; i < total_read; i ++)
> >      {
> >        DWORD nread = 1;
> > diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> > index 392864ac4..341a326a6 100644
> > --- a/winsup/cygwin/local_includes/fhandler.h
> > +++ b/winsup/cygwin/local_includes/fhandler.h
> > @@ -2193,7 +2193,8 @@ public:
> >      input_processing = 0,
> >      input_ok = 1,
> >      input_signalled = 2,
> > -    input_winch = 3
> > +    input_winch = 3,
> > +    input_empty = 4,
> >    };
> >    typedef cons_handle_set_t handle_set_t;
> >    HANDLE thread_sync_event;
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index 48f66c954..212fd7127 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > @@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
> >        return 1;
> >      }
> >  
> > -  INPUT_RECORD irec;
> > -  DWORD events_read;
> >    HANDLE h;
> >    set_handle_or_return_if_not_open (h, me);
> >  
> > @@ -1161,29 +1159,39 @@ peek_console (select_record *me, bool)
> >        else
> >  	{
> >  	  fh->acquire_input_mutex (mutex_timeout);
> > -	  acquire_attach_mutex (mutex_timeout);
> > -	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
> > -	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
> > -	  fh->detach_console (resume_pid, fh->get_owner ());
> > -	  release_attach_mutex ();
> > -	  if (!r || !events_read)
> > +	  if (WaitForSingleObject (h, 0) != WAIT_OBJECT_0)
> >  	    {
> >  	      fh->release_input_mutex ();
> >  	      break;
> >  	    }
> >  	}
> > -      if (fhandler_console::input_winch == fh->process_input_message (0)
> > -	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > -	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > +      switch (fh->process_input_message (0))
> 
> Here, `input_mutex` is held while `process_input_message()` is called. And
> then...
> 
> >  	{
> > +	case fhandler_console::input_processing:
> > +	case fhandler_console::input_ok:
> > +	  fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> 
> ... this call waits for `cons_mode_mutex`.
> 
> Another process can concurrently enter `tcsetattr()`, acquire
> `cons_mode_mutex`, and call `set_input_mode()`, which waits for
> `input_mutex`.
> 
> These processes now dead-lock.
> 
> Maybe `input_mutex` should be released before calling
> `fix_input_mode_if_necessary()`?

Thanks. This issue has been already fixed in
a3dd824af Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Please have a look at the v4 patch.

> > +	  break;
> > +	case fhandler_console::input_winch:
> > +	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > +	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > +	    {
> > +	      set_sig_errno (EINTR);
> > +	      fh->release_input_mutex ();
> > +	      return -1;
> > +	    }
> > +	  break;
> > +	case fhandler_console::input_signalled:
> >  	  set_sig_errno (EINTR);
> >  	  fh->release_input_mutex ();
> >  	  return -1;
> > +	case fhandler_console::input_error:
> > +	case fhandler_console::input_empty:
> > +	  fh->release_input_mutex ();
> > +	  goto out;
> 
> This treats `input_error` in the same way as `input_empty`; Would this not
> let `select()` swallow errors? Should `input_error` not rather release the
> mutex and then return -1?

Thanks. Fixed in v4.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
