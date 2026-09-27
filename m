Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id CF4E94BA799B
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 20:35:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CF4E94BA799B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CF4E94BA799B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790541359; cv=none;
	b=b5ce1zcJSQf13kRs1uVDhBZRQD1JAdT8VJDs0ZBvH+pa2JLOskKhF/QvrprR/Xv5SKJw6CoUy2ao51pO1l2umQlhehuS/XDSjX7/3FCYvVdDtPwGrIipX362LZsa9/vVptcO7KnbIW93ED4vhHsuLS5syRjKo2bwe1nho/efqTc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790541359; c=relaxed/simple;
	bh=NQXFZgQSqXIie5IRTfIcRE6SB1pGltg4X6q+ThYxMg4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=FFdXrF80VvYALVK/+k1xiIOSBg1Gd1v3osENjaj8rpHYjEZmdxSCsJbnjSKFkpjnNsUXBPl4qkeuTcZBf+EBea9lyFw7RmN8MLcdc4RJXijkBPiwUvdtb8NRfxliNhWgdwRu+9u7CbLpdQ1VMrcSNUn9QGVYttDMXnzxlvjlSuQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ajDxdvTY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CF4E94BA799B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ajDxdvTY
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260927203557118.MLSZ.17441.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 05:35:57 +0900
Date: Mon, 28 Sep 2026 05:35:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260928053556.2078425bb6793d8afa1cde09@nifty.ne.jp>
In-Reply-To: <618524df-cdcd-d697-0d4c-1244bfa49c68@gmx.de>
References: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
	<618524df-cdcd-d697-0d4c-1244bfa49c68@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790541357;
 bh=3z14OmGAb6fFZchuNSa5IMRsRKnl5GTXel3I5CsUjBQ=;
 h=Date:From:To:Subject:In-Reply-To;
 b=ajDxdvTYMJqECTuY1QNRCJL8VK00+mjQ9K9Lr+8kWZQ/qzu3x86igKyRONaRSPT3vAbyrjT+
 BWHUqhlcZE6VHRUV2RM9l1YwGRxS5M0RHfMV8Xr+O2UvI9RuaKO7jlwcoPK/eskgExL8xvfWtU
 /oqS5la6Zl5BZ0s2GwhLmVuwV6VXMQRgyUzPQtCZZbVgbGofyg34on0ZBB/eKMIMeJZBNadDvE
 kTxocAbgbnvVsBFi19gDrVJyjz9Wnd5fKN4FYff1jz4F7Go7JAT4RVJYtxeD+sQ5S7zbvhI0Vm
 /DzVTFot6bjp6vscJKPbhM9rD980vHymDTNJSUQzVRBpwKSQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Sun, 27 Sep 2026 21:39:27 +0200 (CEST)
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
> > v5: Set thread_errno rather than errno in peek_console().
> > v6: Preserve errno/thread_errno as soon as the error occurs.
> 
> Great, thanks!
> 
> One more question:
> 
> > [...]
> > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > index e0bd1726f..7c14800fd 100644
> > --- a/winsup/cygwin/select.cc
> > +++ b/winsup/cygwin/select.cc
> > [...]
> > @@ -1161,29 +1159,42 @@ peek_console (select_record *me, bool)
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
> >        fhandler_console::input_states ret = fh->process_input_message (0);
> > +      if (ret == fhandler_console::input_error)
> > +	me->thread_errno = get_errno ();
> 
> Do we need to preserve `errno` in `fhandler_console::read()`, too? In
> https://github.com/Cygwin/cygwin/blob/2867786d2412/winsup/cygwin/fhandler/console.cc#L1419-L1421:
> 
> 	case input_error:
> 	  release_input_mutex ();
> 	  goto err;
> 
> and then
> https://github.com/cygwin/cygwin/blob/2867786d2412/winsup/cygwin/fhandler/console.cc#L1464-L1465:
> 
> 	err:
> 	  __seterrno ();
> 
> the `errno` from `PeekConsoleInputW()` would be overwritten otherwise,
> correct?

Ah, you are right. needs v7 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
