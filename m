Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 6D6744BA7993
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 06:43:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D6744BA7993
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D6744BA7993
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789454599; cv=none;
	b=nu82vWfC/qsaEMyxLvSS78qmB5/68V9j0bHUuAFe4Puu8LYAy4mukyzsH8msMs4W27wpZi33HY3y17+/EFiyFGIQuqr6IPAyU/3DPj6M+/6OmTKw2wAJl5e7F4GfkbcdM1YmLmhxJuirXdyThtx+1cQOEaAHYzfSUuM6wkA+FWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789454599; c=relaxed/simple;
	bh=KD/olTvzEcgL2pAyYHBHqRX/735/q9zQQ6HZpAGjuGw=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=jCQlB7HQLGKvzI9rTXCQKDipvDY115XTw8+xBWdm0cVU0/osO/IqxPcI/2IfNCHIAuc1OmM4obcBhSzwB6aNG+ZqVRXNFTveZRhqWfq2v3oe/Aq3nGBacsWKrdN0mXTIuYrmRTV/d+jW0L2vmJ6l7t6WoFsTzJBm+sHkvZSpexI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gEMgZrcX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D6744BA7993
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gEMgZrcX
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260915064315415.IHFR.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 15:43:15 +0900
Date: Tue, 15 Sep 2026 15:43:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Clear readahead buffer on tcflush()
Message-Id: <20260915154316.483c0570221f5ade075dafd7@nifty.ne.jp>
In-Reply-To: <a7895a77-f5d2-739c-9e17-808f4142b8ec@gmx.de>
References: <20260913214534.708-1-takashi.yano@nifty.ne.jp>
	<a7895a77-f5d2-739c-9e17-808f4142b8ec@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789454595;
 bh=tPw0NAloq9zaMLjouqDS4thvBzVSlE+kC/ZiYd/eUZ8=;
 h=Date:From:To:Subject:In-Reply-To;
 b=gEMgZrcXqU/iRG1ZCSBijaINsothX+7EUsd0WtN6P2lTSI9315OQMI9EWFiyQmf2I5Ks2QA8
 +BUsmeVNBG7FNQFxchqkg1XsOl1KMzuJZl78OIYN+QoYlXoKoWsk7o1E8PtwMTGy/WJNayGsLA
 KaXZKQr3bG4wL4Dbpf4yeCMMJZ4EzSFTT79ZyAbD7YBXN+mg+OW4zhMVCgO/AtKQs+jAHBBIyT
 O9zsnboqGIlvJwsc+p9/35yKRToBdJ/swS0QwuCOkekhCmvt9CnxSXUSjEjxtwYovxxT6Cfcwr
 qrh15QZXaeFdk1YBSGILfL3pXY+UV22AVlL0IWdKzeen5dfg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Mon, 14 Sep 2026 14:55:13 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Mon, 14 Sep 2026, Takashi Yano wrote:
> 
> > Previously, tcflush(TCIFLUSH) only discarded the input events and
> > did not clear the readahead buffer. Because of this bug, when user
> > program called select() -> tcflush() -> read(), the last read()
> > returned the contents of the readahead buffer instead of blocking
> > as it should.
> > 
> > Correctly, tcflush() must discard all pending input, so read()
> > should block until new input arrives. With this patch, the read-
> > ahead buffer and `rapoi` are also cleared as well as input events.
> > 
> > Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
> > Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > ---
> > v2: Add input_mutex guard. Clear rapoi as well.
> > v3: Acquire input_mutex before output_mutex in ioctl() to avoid
> >     deadlock in tcflush().
> >     Make input_ready static as con_ra is.
> 
> Thank you! This addresses the examples I gave in my review of v2.
> 
> Thinking a bit deeper about this, I have two more questions:
> 
> - Can closing a console dead-lock now?
> 
>   Consider this scenario: Process A's `ioctl(TIOCGWINSZ)` takes
>   `input_mutex`, then waits for `output_mutex`. Meanwhile, process B's
>   `close()` can hold `output_mutex` and request `input_mutex` through
>   `set_disable_master_thread()`, when restoring the console's original
>   settings. A console-owning Cygwin process launched by a native parent
>   can take that restoration path. If A gets the input lock and B gets the
>   output lock first, don't they both wait forever for the other?
> 
>   These are named locks for the same console, shared across processes;
>   recursive acquisition does not resolve this cycle. The reverse order in
>   `close()` predates v3, but v3 newly exposes an otherwise output-only
>   size query to it. No reader or flush is required.

Ugh...
Things were getting messy, so I cleaned them up. Please take a look at v4.

> - Can the new readiness flag survive destruction of its buffer?
> 
>    A process whose controlling terminal is a PTY can open another live
>    console with `O_NOCTTY`, select a complete line without reading it,
>    close its last reference to that console, then reopen it while another
>    process keeps the console alive. Actual console close frees and zeroes
>    `con_ra`, but leaves the new static `input_ready` true. A fresh handler
>    no longer resets that flag, so wouldn't its next canonical `read()`
>    skip waiting, find no bytes and return zero, i.e. apparent EOF without
>    an EOF keystroke?
> 
>    Before v3, the fresh handler initialized its own flag to
>    false. This is a sequential close/reopen case, not closing one of
>    several surviving duplicates.

I do not think so. con_ra and input_ready is static but not shared
between processes. That is, the input_ready for 'another process' is
initially false without explicit initialization.

> We will want to keep the shared-readiness fix and input-flush
> serialization, but we might need to make lock ordering consistent with
> close, and retire readiness with its buffer. I don't think that we could
> clear readiness on every open, or equate it with a nonempty buffer: other
> descriptors and genuine canonical `VEOF` must keep working.
> 
> Ciao,
> Johannes
> 
> >  winsup/cygwin/fhandler/console.cc       | 41 +++++++++++++++++++++----
> >  winsup/cygwin/local_includes/fhandler.h |  2 +-
> >  winsup/cygwin/select.cc                 |  8 ++---
> >  3 files changed, 40 insertions(+), 11 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index be41bf3a2..a995f3acc 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -70,6 +70,7 @@ bool NO_COPY fhandler_console::invisible_console;
> >  /* con_ra is shared in the same process.
> >     Only one console can exist in a process, therefore, static is suitable. */
> >  static struct fhandler_base::rabuf_t con_ra;
> > +static bool input_ready;
> >  
> >  /* Write pending buffer for ESC sequence handling
> >     in xterm compatible mode */
> > @@ -1224,7 +1225,7 @@ fhandler_console::read (void *pv, size_t& buflen)
> >        (get_ttyp ()->ti.c_cc[VTIME]*100 ? : INFINITE)));
> >  
> >  read_more:
> > -  while (!input_ready && !get_cons_readahead_valid ())
> > +  while (!::input_ready && !get_cons_readahead_valid ())
> >      {
> >        int bgres;
> >        if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
> > @@ -1305,7 +1306,7 @@ wait_retry:
> >      get_readahead_into_buffer (buf + copied_chars, buflen - copied_chars);
> >  
> >    if (!con_ra.ralen)
> > -    input_ready = false;
> > +    ::input_ready = false;
> >    release_input_mutex ();
> >  
> >    if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
> > @@ -1357,7 +1358,7 @@ fhandler_console::process_input_message (size_t len)
> >    /* This code is reached only when being passed the input_ready check,
> >       however, the check was done outside input_mutex. Therefore, another
> >       thread may set input_ready after the check. Check it again here. */
> > -  if (input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
> > +  if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
> >      return input_ok;
> >  
> >    for (i = 0; i < total_read; i ++)
> > @@ -1736,14 +1737,14 @@ fhandler_console::process_input_message (size_t len)
> >  	    }
> >  	  else if (res == line_edit_input_done)
> >  	    {
> > -	      input_ready = true;
> > +	      ::input_ready = true;
> >  	      stat = input_ok;
> >  	      if (ti->c_lflag & ICANON)
> >  		goto out;
> >  	    }
> >  	}
> >        /* len == 0 if called from select.cc:peek_console() */
> > -      if (input_ready && (len == 0 || con_ra.ralen >= len))
> > +      if (::input_ready && (len == 0 || con_ra.ralen >= len))
> >  	goto out;
> >      }
> >  out:
> > @@ -2217,6 +2218,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >    int res = fhandler_termios::ioctl (cmd, arg);
> >    if (res <= 0)
> >      return res;
> > +  acquire_input_mutex (mutex_timeout);
> >    acquire_output_mutex (mutex_timeout);
> >    switch (cmd)
> >      {
> > @@ -2234,6 +2236,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  			   ((struct winsize *) arg)->ws_row,
> >  			   ((struct winsize *) arg)->ws_col);
> >  	    release_output_mutex ();
> > +	    release_input_mutex ();
> >  	    return 0;
> >  	  }
> >  	else
> > @@ -2241,17 +2244,21 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	    syscall_printf ("WINSZ failed");
> >  	    __seterrno ();
> >  	    release_output_mutex ();
> > +	    release_input_mutex ();
> >  	    return -1;
> >  	  }
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return 0;
> >        case TIOCSWINSZ:
> >  	bg_check (SIGTTOU);
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return 0;
> >        case KDGKBMETA:
> >  	*(int *) arg = (con.metabit) ? K_METABIT : K_ESCPREFIX;
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return 0;
> >        case KDSKBMETA:
> >  	if ((intptr_t) arg == K_METABIT)
> > @@ -2262,19 +2269,23 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	  {
> >  	    set_errno (EINVAL);
> >  	    release_output_mutex ();
> > +	    release_input_mutex ();
> >  	    return -1;
> >  	  }
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return 0;
> >        case TIOCLINUX:
> >  	if (*(unsigned char *) arg == 6)
> >  	  {
> >  	    *(unsigned char *) arg = (unsigned char) con.nModifiers;
> >  	    release_output_mutex ();
> > +	    release_input_mutex ();
> >  	    return 0;
> >  	  }
> >  	set_errno (EINVAL);
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return -1;
> >        case FIONREAD:
> >        case TIOCINQ:
> > @@ -2291,6 +2302,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	    {
> >  	      set_errno (EINVAL);
> >  	      release_output_mutex ();
> > +	      release_input_mutex ();
> >  	      return -1;
> >  	    }
> >  	  bool saw_eol = false;
> > @@ -2327,20 +2339,24 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
> >  	  else
> >  	    *(int *) arg = ret;
> >  	  release_output_mutex ();
> > +	  release_input_mutex ();
> >  	  return 0;
> >  	}
> >  	break;
> >        case TCXONC:
> >  	res = this->tcflow ((int)(intptr_t) arg);
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return res;
> >        case TCFLSH:
> >  	res = this->tcflush ((int)(intptr_t) arg);
> >  	release_output_mutex ();
> > +	release_input_mutex ();
> >  	return res;
> >      }
> >  
> >    release_output_mutex ();
> > +  release_input_mutex ();
> >    return fhandler_base::ioctl (cmd, arg);
> >  }
> >  
> > @@ -2351,6 +2367,9 @@ fhandler_console::tcflush (int queue)
> >    if (queue == TCIFLUSH
> >        || queue == TCIOFLUSH)
> >      {
> > +      /* tcflush() may be called inside the input_mutex,
> > +	 however, mutex of Win32 can be acquired recursively. */
> > +      acquire_input_mutex (mutex_timeout);
> >        acquire_attach_mutex (mutex_timeout);
> >        DWORD resume_pid = attach_console (con.owner);
> >        BOOL r = FlushConsoleInputBuffer (get_handle ());
> > @@ -2362,6 +2381,10 @@ fhandler_console::tcflush (int queue)
> >  	  res = -1;
> >  	}
> >        con.num_processed = 0;
> > +      eat_readahead (-1);
> > +      ::input_ready = false;
> > +      con.cons_rapoi = NULL;
> > +      release_input_mutex ();
> >      }
> >    return res;
> >  }
> > @@ -2386,7 +2409,7 @@ fhandler_console::tcgetattr (struct termios *t)
> >  }
> >  
> >  fhandler_console::fhandler_console (fh_devices devunit) :
> > -  fhandler_termios (), input_ready (false), thread_sync_event (NULL),
> > +  fhandler_termios (), thread_sync_event (NULL),
> >    input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV),
> >    num_input_events_processed (0)
> >  {
> > @@ -4912,3 +4935,9 @@ fhandler_console::tcdrain ()
> >  {
> >    return 0;
> >  }
> > +
> > +bool
> > +fhandler_console::input_ready ()
> > +{
> > +  return ::input_ready;
> > +}
> > diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
> > index d11b3ec4f..73d121508 100644
> > --- a/winsup/cygwin/local_includes/fhandler.h
> > +++ b/winsup/cygwin/local_includes/fhandler.h
> > @@ -2183,7 +2183,6 @@ public:
> >      tty_min tty_min_state;
> >      dev_console con;
> >    };
> > -  bool input_ready;
> >    enum input_states
> >    {
> >      input_error = -1,
> > @@ -2366,6 +2365,7 @@ private:
> >    void wpbuf_send ();
> >    int fstat (struct stat *buf);
> >    void discard_key_events (size_t n);
> > +  bool input_ready ();
> >  
> >    class console_unit
> >    {
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index b72083447..120273b70 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > @@ -1140,7 +1140,7 @@ peek_console (select_record *me, bool)
> >    if (fh->get_cons_readahead_valid ())
> >      return me->read_ready = true;
> >  
> > -  if (fh->input_ready)
> > +  if (fh->input_ready ())
> >      return me->read_ready = true;
> >  
> >    if (me->read_ready)
> > @@ -1155,7 +1155,7 @@ peek_console (select_record *me, bool)
> >    set_handle_or_return_if_not_open (h, me);
> >  
> >    fh->acquire_input_mutex (mutex_timeout);
> > -  while (!fh->input_ready && !fh->get_cons_readahead_valid ())
> > +  while (!fh->input_ready () && !fh->get_cons_readahead_valid ())
> >      {
> >        if (fh->bg_check (SIGTTIN, true) <= bg_eof)
> >  	{
> > @@ -1182,7 +1182,7 @@ peek_console (select_record *me, bool)
> >  	}
> >      }
> >    fh->release_input_mutex ();
> > -  if (fh->input_ready || fh->get_cons_readahead_valid ())
> > +  if (fh->input_ready () || fh->get_cons_readahead_valid ())
> >      return me->read_ready = true;
> >  
> >    return me->write_ready;
> > @@ -1282,7 +1282,7 @@ fhandler_console::select_read (select_stuff *ss)
> >  
> >    s->peek = peek_console;
> >    s->read_selected = true;
> > -  s->read_ready = input_ready || get_cons_readahead_valid ();
> > +  s->read_ready = input_ready () || get_cons_readahead_valid ();
> >    s->cleanup = console_cleanup;
> >    return s;
> >  }
> > -- 
> > 2.51.0
> > 
> > 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
