Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-sp-e04.mail.nifty.com (mta-sp-e04.mail.nifty.com [106.153.228.4])
	by sourceware.org (Postfix) with ESMTPS id 643094BA7990
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 13:18:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 643094BA7990
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 643094BA7990
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.228.4
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790515085; cv=none;
	b=YVcpkQXmyIR4f/Y2J2F+n2Zw+vnteEbyp3cTVY/uHNLMLvVyCmSQFkWQeiSAtI4BrbqyQg5SRILAy0EJy6JmV2Qj5fWWMD7xpr9g/WMpe+by2ArA1OVFgGO3ohB3ofRzAxXg6w0H3NdsQlUFIlpEdpqCCnpJFQmU/1t8bC2IkVY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790515085; c=relaxed/simple;
	bh=A47eJc/nW21tMD/c357qs5x0EEACdnM061JmMpnUtPo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=af9xL0e9ujoZM/wnfP4QqAwgvzQCmMJkUf2ribo+pJdPF8RbzPqV2tzZFOrAH1sVlaCbIYIe1/nLF1pKfCWMf2B+SvmqK3zWX5X4atX//EunaPvKwlp80wweDJl9cOvEyZhhKI7DMpHeEX7/VQl1JYKp9a3Mj2u6TbKdOGtKZgI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LNfz2lut
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 643094BA7990
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=LNfz2lut
Received: from mta-snd-e09.mail.nifty.com by mta-sp-e04.mail.nifty.com
          with ESMTP
          id <20260927131802383.VZQL.67869.mta-snd-e09.mail.nifty.com@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 22:18:02 +0900
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260927131802290.FWBC.60338.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 22:18:02 +0900
Date: Sun, 27 Sep 2026 22:17:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260927221759.43fbe8ceb92117362429821b@nifty.ne.jp>
In-Reply-To: <7c662a3b-1d30-3f2b-525b-80226c394e50@gmx.de>
References: <20260926165326.16789-1-takashi.yano@nifty.ne.jp>
	<f280b842-7618-c159-5288-52a4fad8dfd1@gmx.de>
	<20260927182002.8423d03403b8f93d268aab16@nifty.ne.jp>
	<7c662a3b-1d30-3f2b-525b-80226c394e50@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790515082;
 bh=xihxu3Spxw5286pDHpnO94rMGEJOrhLoBlidAdKY88s=;
 h=Date:From:To:Subject:In-Reply-To;
 b=LNfz2lutTRlMA3/fEHfiuEQS3akkjK0FibTqKggQUptYj3maz7wEGIlOAmJz4dNHyzONGG0O
 Xlvk98VQzUItNBc9mofy6JsBTgPc8oKSyHtaraTPm9HZux3j3slK9PejiAYztWz1uHWrug7Lxo
 chOX039naO53deghZCVyJc6xKJmafh22wMtVWstDfR0LTgTGiAWXS6T3v1Wc9K8raCDq/Ufnq3
 xAYBhcrrpwtL2rhjoTt+MDsKuZEBUWnFPUzOZzNoHEYRuBtUh7LCx1uFdNvXbAEtXDYOuBA6/l
 m2yQRcsb6z3VqMWhRFG6G4AZW/GcgQg5AHcXwKlwNzR1Aszw==
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 27 Sep 2026 15:15:27 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sun, 27 Sep 2026, Takashi Yano wrote:
> 
> > On Sat, 26 Sep 2026 21:08:45 +0200 (CEST)
> > Johannes Schindelin wrote:
> > > 
> > > On Sun, 27 Sep 2026, Takashi Yano wrote:
> > > 
> > > > [...]
> > > > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > > > index e0bd1726f..d899dcd65 100644
> > > > --- a/winsup/cygwin/select.cc
> > > > +++ b/winsup/cygwin/select.cc
> > > > [...]
> > > > @@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
> > > >        fh->release_input_mutex ();
> > > >        fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
> > > >  
> > > > -      if (ret == fhandler_console::input_winch
> > > > -	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > > > -	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > > > +      switch (ret)
> > > >  	{
> > > > +	case fhandler_console::input_processing:
> > > > +	case fhandler_console::input_ok:
> > > > +	  break;
> > > > +	case fhandler_console::input_winch:
> > > > +	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
> > > > +	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
> > > > +	    {
> > > > +	      set_sig_errno (EINTR);
> > > > +	      return -1;
> > > > +	    }
> > > > +	  break;
> > > > +	case fhandler_console::input_signalled:
> > > >  	  set_sig_errno (EINTR);
> > > >  	  return -1;
> > > > +	case fhandler_console::input_error:
> > > > +	  __seterrno ();
> > > > +	  return -1;
> > > 
> > > The caller of this function, `select_stuff::poll()` reacts to that -1 by
> > > `set_errno (s->thread_errno)`, but `thread_errno` is not set by
> > > `__seterrno ()`; In fact, it is not set anywhere in the call path,
> > > remaining at value 0.
> > > 
> > > To set it properly, I think that the `process_input_message()` function
> > > should record `GetLastError ()` when `PeekConsoleInputW ()` failed. Maybe
> > > something like this?
> > 
> > Since the return value of GetLastError() is preserved until
> > the next Win32 error occurs, wouldn’t your code and mine
> > produce the same result?
> > 
> > __seterrno() calls seterrno(), which calls seterrno_from_win_error()
> > with GetLastError().
> > 
> > So, what needed here is:
> >   me->thread_errno = get_errno();
> > after __seterrno(), isn't it?
> > 
> > Alternatively,
> >   me->thread_errno = geterrno_from_win_error();
> > where the the intent of the code might be clearer than above.
> 
> Oops, I should have checked my mail first before sending the follow-up
> https://inbox.sourceware.org/cygwin-patches/fe46f2da-bcb0-37ea-b10b-307438c9bfb7@gmx.de/.
> Happily, you saw my mistake.
> 
> However, I do want to point out that preserving the return value of
> `GetLastError()` directly after a failed `PeekConsoleInputW()` is
> necessary, as the in-between code calls:
> 
> - `detach_console()`, which can call `FreeConsole()` and `AttachConsole()`
> - `release_attach_mutex()`
> - `release_input_mutex()`
> - `fix_input_mode_if_necessary()`, which invokes several more Win32 APIs
> 
> Each of those could cause a different value than desired to be returned by
> `GetLastError()`.

Hmm, maybe. OK, I'll revise the v5 patch. Thanks!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
