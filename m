Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.227.185])
	by sourceware.org (Postfix) with ESMTPS id 056234BA79A5
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 13:15:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 056234BA79A5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 056234BA79A5
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.185
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790514933; cv=none;
	b=dda91sRVpAHyz+TGnCzRYtW/MsI/54/Wp7eDs+781h2tDNSFTARq7dlS74PgWcpFj5zTGn2NrxYWg6RnYCHKM3SUG8K1JR5VxkZwYpKLd39BKUxKPj9li45dGR1skdmp6yVmbaWS4JcTsfAH8aUMQaff3uGPYFP6wUZZkVq57Go=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790514933; c=relaxed/simple;
	bh=rQnZdWf9iZs6FY0rzf4fbmpVUGhUjAcJH+bHewj3Mgg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=vtRn6O9v7FJRX5QocYAgQWHI4fbTmCvI/VOEUdeFhdx1ALN3EFHZiKqjfctJGGnpmN6dwcGg1Fkecrkk5mV4nbaVsGZHkBG781Y7FEqc6WDviq/SsZRLbD7eLFo9ll8HkDybZss1JfuWiGxmeeJh1c6fS8lUbPXrS//AwiY/9ZQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lPLu7t3s
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 056234BA79A5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lPLu7t3s
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260927131529391.FVLD.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 22:15:29 +0900
Date: Sun, 27 Sep 2026 22:15:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260927221527.023e9c999e33cf0cbb85e25b@nifty.ne.jp>
In-Reply-To: <fe46f2da-bcb0-37ea-b10b-307438c9bfb7@gmx.de>
References: <20260926165326.16789-1-takashi.yano@nifty.ne.jp>
	<f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
	<fe46f2da-bcb0-37ea-b10b-307438c9bfb7@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790514929;
 bh=LdLbagJfV/jFiuyKe1Do9C1vAJ4gDAC1jfFYENGx8oE=;
 h=Date:From:To:Subject:In-Reply-To;
 b=lPLu7t3sSz3efIMoq2QP36XVgr1IevSDQWJdgigNp0KEJ8BJrcKFJrq3UoeN01XGHGdr6g9O
 8ITxfUYgRycflaXTXZC0L1I+5M1qR9CQi0c3jqRGrJ2kdjOXoU3U4vpnjKrn9Eo1NlcLWY+d3T
 j0Z4gVU9TOEiBRwP+YvoMhcv9VFZsfYVyZoBAjYdC8vo6rQLw+g7Kf5dgoveF6GJRV3ZA7REeg
 QKF8j3430NmrV/QU69ECEXDsdtPPABk1AUDs90ZTZd38h5IEQv2giFXF70WbSenfnbVHBD83ka
 bkMrU4UdsnnmXnr4WD4TNTiY8xPuSFiBGx75MljyArLULh9Q==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 27 Sep 2026 13:54:26 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 26 Sep 2026, Johannes Schindelin wrote:
> 
> > On Sun, 27 Sep 2026, Takashi Yano wrote:
> > 
> > > [...]
> > > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > > index e0bd1726f..d899dcd65 100644
> > > --- a/winsup/cygwin/select.cc
> > > +++ b/winsup/cygwin/select.cc
> > > [...]
> > > @@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
> > >        fh->release_input_mutex ();
> > >        fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> > >  
> > > -      if (ret == fhandler_console::input_winch
> > > -	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > > -	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > > +      switch (ret)
> > >  	{
> > > +	case fhandler_console::input_processing:
> > > +	case fhandler_console::input_ok:
> > > +	  break;
> > > +	case fhandler_console::input_winch:
> > > +	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > > +	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > > +	    {
> > > +	      set_sig_errno (EINTR);
> > > +	      return -1;
> > > +	    }
> > > +	  break;
> > > +	case fhandler_console::input_signalled:
> > >  	  set_sig_errno (EINTR);
> > >  	  return -1;
> > > +	case fhandler_console::input_error:
> > > +	  __seterrno ();
> > > +	  return -1;
> > 
> > The caller of this function, `select_stuff::poll()` reacts to that -1 by
> > `set_errno (s->thread_errno)`, but `thread_errno` is not set by
> > `__seterrno ()`; In fact, it is not set anywhere in the call path,
> > remaining at value 0.
> > 
> > To set it properly, I think that the `process_input_message()` function
> > should record `GetLastError ()` when `PeekConsoleInputW ()` failed. Maybe
> > something like this?
> > 
> > -- snip --
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 77786a1a60..859b56c687 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1437,10 +1437,12 @@ fhandler_console::process_input_message (size_t len)
> >    DWORD resume_pid = attach_console (con.owner);
> >    BOOL r =
> >      PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
> > +  DWORD error = r ? ERROR_SUCCESS : GetLastError ();
> >    detach_console (resume_pid, con.owner);
> >    release_attach_mutex ();
> >    if (!r)
> >      {
> > +      __seterrno_from_win_error (error);
> >        termios_printf ("PeekConsoleInput failed, %E");
> >        return input_error;
> >      }
> > -- snap --
> 
> Oy, I completely missed that `__seterrno_from_win_error ()` does _not_ set
> `thread_errno`, sorry! The complete fix also needs something like this
> immediately after `process_input_message()` returns, before `cleanup()` can
> disturb `errno`:
> 
> -- snip --
> int ret = fh->process_input_message (0);
> if (ret == fhandler_console::input_error)
>   me->thread_errno = errno;
> -- snap --
> 
> Sorry about that!

np.
I'd rather set thread_errno as in v5, because it makes the
intent of the code clearer to the reader.
What do you think?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
