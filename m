Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 405034BA2E10
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 12:35:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 405034BA2E10
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 405034BA2E10
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782822951; cv=none;
	b=jWbL+o2UYXsEHEDJ8GoNV5kN9e5Z5bu5Q9z1uvjtlvnNkhk1fOqDcrD0Ni1DnHP0/MDe7w7w04av/fejZ/ftjcbSgPSbANbsIEQxYYhyjQWTkOGgF/cMBLZMKjKeSyDGg22mtf472KI2TD0XvOch1Ume5zkb7g7SeSzPIHiI7Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782822951; c=relaxed/simple;
	bh=stNHwI4ZdChgiQ1PxgW7QErA+fMmn9/XbrxFkZ2+Vt4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=lNKKdmQw4dTt6i5a9+duElWrQizdhYlGc76t42+TaLK9cPFRUzvxsUOKYyKUighMVXfCnAiAxg6P5gtXAr6XaBMgSM01tRzUFBs6/xUDsugzKCg04s3ibq/LW1uJn3iH/MAD/U4CQpP/WK6SZqGqMJXP+h0h5bGqeunjvuPa3dg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Lg/MgkWF
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 405034BA2E10
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Lg/MgkWF
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260630123549135.WEIW.102121.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 21:35:49 +0900
Date: Tue, 30 Jun 2026 21:35:47 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
Message-Id: <20260630213547.e66059127f8007b244c09ca0@nifty.ne.jp>
In-Reply-To: <20260630131135.e6996786a3b3ab8316d0ae3e@nifty.ne.jp>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-3-takashi.yano@nifty.ne.jp>
	<d8dacefa-68a4-d6bd-e6c4-d6291bb02256@gmx.de>
	<20260629233017.5e6eef4020915f0154623954@nifty.ne.jp>
	<20260630011456.ffd645885e56f7d33b4d1412@nifty.ne.jp>
	<20260630131135.e6996786a3b3ab8316d0ae3e@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782822949;
 bh=HQeMR6Rmn82lq8N9pDxfmtdszvkucVJdsQxYMn368O4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Lg/MgkWF/+0wH0CRmIA99mV/6IifrcbWvb3BT0k+yq4ZYc1nxxmiG7VqpmbFZusyVHLCVlU8
 U6SditNIaL+xJKUVFNpQF6ffT5Ic6dHj8F/JFncWUKM1PA2jIp7sBoWJF6uT5N39e6WjsKnemG
 b1qyMYF/35FBBmPbSdRT5Zzk1OHCbgDeq5aNzNcc6F1OXANwc+QSi4vqyZXVUKj7BVFMeYm7AJ
 D9SK47izgJYueVgjPR6m3cfkurCToxFiZ4IHzXOxEfIMRxO2ZGG60ZZosR6oPPfDpU3zA4jzu+
 eEB8EM4wWMINYF+KvTAZPYblmXvMdm4il6FkaExX5LMMFiVw==
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 30 Jun 2026 13:11:35 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Tue, 30 Jun 2026 01:14:56 +0900
> Takashi Yano wrote:
> > On Mon, 29 Jun 2026 23:30:17 +0900
> > Takashi Yano wrote:
> > > Hi Johannes,
> > > 
> > > Thanks for finding that.
> > > 
> > > On Sat, 27 Jun 2026 09:27:12 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > Hi Takashi, Mark,
> > > > 
> > > > I have a fix for the issue below sitting in
> > > > https://github.com/git-for-windows/msys2-runtime/pull/131/commits/0b0976a5e85de52312c17d21f1d3fc41dc572179
> > > > that I should have sent earlier, but I was struggling to find the time to
> > > > validate the fix via automated AutoHotKey-based tests. Sorry for the
> > > > delay.
> > > > 
> > > > On Thu, 11 Jun 2026, Takashi Yano wrote:
> > > > 
> > > > > If you run "stty noflsh; cat" in "bash", and stop "cat" by Ctrl-C,
> > > > > a stray ^C is passed to "bash". The current code calls tcflush() if
> > > > > NOFLSH is not set, however, tcflush() is not called when NOFLSH is
> > > > > set. So, Ctrl-C remains in console input buffer. This should be
> > > > > discarded even in NOFLSH mode. This patch introduces a helper
> > > > > function discard_key_events() and call it to erase Ctrl-C in the
> > > > > console input buffer.
> > > > > 
> > > > > Note that even with this patch, NOFLSH is not fully functional in
> > > > > console because the readahead buffer is unique to process, so it
> > > > > cannot be inherited to other processes. However, it should work
> > > > > intra process.
> > > > > 
> > > > > Fixes: 118e51be1d04 ("(tty_min::kill_pgrp): Handle tty flush when signal detected.")
> > > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > > Reviewed-by:
> > > > > ---
> > > > >  winsup/cygwin/fhandler/console.cc       | 20 +++++++++++++++++---
> > > > >  winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
> > > > >  winsup/cygwin/local_includes/fhandler.h |  2 ++
> > > > >  3 files changed, 26 insertions(+), 6 deletions(-)
> > > > > 
> > > > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > > > > index a5e6cd89d..9ac492980 100644
> > > > > --- a/winsup/cygwin/fhandler/console.cc
> > > > > +++ b/winsup/cygwin/fhandler/console.cc
> > > > > @@ -1744,17 +1744,31 @@ out:
> > > > >      discard_len = 0;
> > > > >    if (discard_len)
> > > > >      {
> > > > > -      DWORD discarded;
> > > > >        acquire_attach_mutex (mutex_timeout);
> > > > >        DWORD resume_pid = attach_console (con.owner);
> > > > > -      ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
> > > > > +      discard_key_events (discard_len);
> > > > >        detach_console (resume_pid, con.owner);
> > > > >        release_attach_mutex ();
> > > > > -      con.num_processed -= min (con.num_processed, discarded);
> > > > >      }
> > > > >    return stat;
> > > > >  }
> > > > >  
> > > > > +void
> > > > > +fhandler_console::discard_key_events (size_t n)
> > > > > +{
> > > > > +  DWORD discarded = 0;
> > > > > +  INPUT_RECORD input_rec[INREC_SIZE];
> > > > > +  DWORD n1 = min (INREC_SIZE, n);
> > > > > +  while (n)
> > > > > +    {
> > > > > +      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> > > > > +      n -= n1;
> > > > > +      discarded += n1;
> > > > > +      n1 = min (INREC_SIZE, n);
> > > > > +    }
> > > > > +  con.num_processed -= min (con.num_processed, discarded);
> > > > > +}
> > > > 
> > > > `discard_key_events()` loops on `ReadConsoleInputW()` until it has
> > > > consumed the requested count, and `ReadConsoleInputW()` blocks while the
> > > > input buffer is empty. The `sigflush()` caller passes a hard-coded `1`
> > > > with no guarantee that a record is actually queued: in the master-thread
> > > > path the signalling record has already been read out of the buffer before
> > > > `sigflush()` runs, so the call blocks until the user's next keystroke
> > > > arrives, and then swallows it. And because `ReadConsoleInputW()`'s return
> > > > is unchecked, a failed read leaves `n1` indeterminate, so `n -= n1` can
> > > > underflow and spin.
> > > 
> > > The root cause of above situation is that the master-thread is not
> > > disable even when line_edit() is called via read(). This may cause
> > > other issues we have not seen yet. Usually, input_mutex is held by
> > > the thread calling line_edit(), so the master-thread does not touch
> > > the input events. However, the current code calls discard_key_events()
> > > after release_input_mutex_if_necessary().
> > 
> > No, this is not correct. The root problem is that the key event should
> > not be touched if process_sigs() is called from cons_master_thread().
> > 
> > > So, what about the patch (1/2) attached instead?
> > 
> > New patch (1/2) attached.
> 
> This was still broken... Sorry.
> Please check out:
> https://cygwin.com/pipermail/cygwin-patches/2026q2/015129.html
> 
> The commit message is borrowed from your patch. Thanks!

Although you kindly reviewed my patches and even provided a proposed fix,
I have suggested an alternative patch.
https://cygwin.com/pipermail/cygwin-patches/2026q2/015129.html

I apologize for having wasted your efforts. However, your analysis was
extremely helpful, and I am also making good use of your commit messages.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
