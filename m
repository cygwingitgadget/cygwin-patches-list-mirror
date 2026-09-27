Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 8FB804BA79A1
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 09:20:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8FB804BA79A1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8FB804BA79A1
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790500810; cv=none;
	b=ZusCVSQkyqBy4UzQ+5cgr27H+up+Tbne8b8rZfKk9XWgceoH1uiM4Af+oH4GPcIGVPttRvkNDQitREZH3boz/sPDW8Bu1E/ls3WP6aNIdBprCBYST0DalVGXLuPjzAMQVmGkaWfUT7JTRNx0O8ebjhIbeSEQ5oRej9oU8uc87l0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790500810; c=relaxed/simple;
	bh=E+YtN2+1tQhjgwPSEHqgQT3PwNyq8v7E8T/fsQt8VTo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=P9ekpcoyuuPcLsDyvtaKB94s8dZG5ToVQ9g7xvByeMHqQXoeM05Vzd6sbpMpL/pNaZnlBR+jGI2Rf5Cft/1XSlleXTAYW5vquFtqea9jR6HufBJHnh2uFGN3gLM0043qnL4CdCRMss3g2V4Dm5n/f2DZCV81So8RwBvqLXfpFhg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mtt3trsv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8FB804BA79A1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mtt3trsv
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260927092004295.DJYH.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 18:20:04 +0900
Date: Sun, 27 Sep 2026 18:20:02 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260927182002.8423d03403b8f93d268aab16@nifty.ne.jp>
In-Reply-To: <f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
References: <20260926165326.16789-1-takashi.yano@nifty.ne.jp>
	<f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790500804;
 bh=JN64YejATOPnZjAya3HKkOWodl3gcac3nMJ39iRX2LM=;
 h=Date:From:To:Subject:In-Reply-To;
 b=mtt3trsvw0XWxnRyj8vr8BD/FULr/n88Arajb8wvQdkFojJpzGJjvFjlFD3b1ngb2H/T+xYO
 KIJSfvCfbf0bcWbZ0cKsQs6kn6svW9hJ02XuFDQvK4faFflHatgvu7o2eo/6vfqBfewu21wFUy
 z1SgOf1gqaHgYppdI/IrjTUJYQa8ZXFny+eZuB+uCg9cg+xRiYC2SU8lmlFFuIzNvbDV2m/Dxr
 1F76OBliPH/Wln+CluoHrha0/WnzscndZ+EGT64FwW1t5MHUTdc7FmWmLbRwQjRKP0C64lKxVo
 fhLBY7vFKTY71W7M0/yopMjHifA52xcst9VrGuQjO5e2Z7Cg==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sat, 26 Sep 2026 21:08:45 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sun, 27 Sep 2026, Takashi Yano wrote:
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
> > v4: Handle input_empty and input_error returned from process_input_message()
> >     properly.
> 
> Thank you! Just one more thing:
> 
> > [...]
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index e0bd1726f..d899dcd65 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > [...]
> > @@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
> >        fh->release_input_mutex ();
> >        fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> >  
> > -      if (ret == fhandler_console::input_winch
> > -	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > -	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > +      switch (ret)
> >  	{
> > +	case fhandler_console::input_processing:
> > +	case fhandler_console::input_ok:
> > +	  break;
> > +	case fhandler_console::input_winch:
> > +	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > +	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > +	    {
> > +	      set_sig_errno (EINTR);
> > +	      return -1;
> > +	    }
> > +	  break;
> > +	case fhandler_console::input_signalled:
> >  	  set_sig_errno (EINTR);
> >  	  return -1;
> > +	case fhandler_console::input_error:
> > +	  __seterrno ();
> > +	  return -1;
> 
> The caller of this function, `select_stuff::poll()` reacts to that -1 by
> `set_errno (s->thread_errno)`, but `thread_errno` is not set by
> `__seterrno ()`; In fact, it is not set anywhere in the call path,
> remaining at value 0.
> 
> To set it properly, I think that the `process_input_message()` function
> should record `GetLastError ()` when `PeekConsoleInputW ()` failed. Maybe
> something like this?

Since the return value of GetLastError() is preserved until
the next Win32 error occurs, wouldn’t your code and mine
produce the same result?

__seterrno() calls seterrno(), which calls seterrno_from_win_error()
with GetLastError().

So, what needed here is:
  me->thread_errno = get_errno();
after __seterrno(), isn't it?

Alternatively,
  me->thread_errno = geterrno_from_win_error();
where the the intent of the code might be clearer than above.

> -- snip --
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> index 77786a1a60..859b56c687 100644
> --- a/winsup/cygwin/fhandler/console.cc
> +++ b/winsup/cygwin/fhandler/console.cc
> @@ -1437,10 +1437,12 @@ fhandler_console::process_input_message (size_t len)
>    DWORD resume_pid = attach_console (con.owner);
>    BOOL r =
>      PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
> +  DWORD error = r ? ERROR_SUCCESS : GetLastError ();
>    detach_console (resume_pid, con.owner);
>    release_attach_mutex ();
>    if (!r)
>      {
> +      __seterrno_from_win_error (error);
>        termios_printf ("PeekConsoleInput failed, %E");
>        return input_error;
>      }
> -- snap --
> 
> Ciao,
> Johannes
> 
> > +	case fhandler_console::input_empty:
> > +	  goto out;
> >  	}
> >      }
> > +out:
> >    if (fh->input_ready () || fh->get_cons_readahead_valid ())
> >      return me->read_ready = true;
> >  
> > -- 
> > 2.51.0
> > 
> > 


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
