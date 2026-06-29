Return-Path: <SRS0=TksR=EZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 6FC1F4BA2E08
	for <cygwin-patches@cygwin.com>; Mon, 29 Jun 2026 16:14:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FC1F4BA2E08
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6FC1F4BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782749700; cv=none;
	b=oU3bm8cuxhj63a5snO/XBsPbYT1nia0o1YlRU0tUNM1tnN7Furki/Xe1ja519RTxdd1zktEAjXl7HBr81eKlHmFGXnkEK6XKWEDqqlbj1YM8kwuinbM2fX/5xbRCUsA+v/V9SlcF4XWuoOEu9CkdE/Bg4FQXwDXiZ88UO9HrPLk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782749700; c=relaxed/simple;
	bh=DYWad35scUVtdPVVl1fiBGiVLoqqit83CzO1D24ScvA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=s1XYnmJvaP239maCgC9cwK2U70HUV7SsujAEWJr4WHdP1h20V3qfUqLKu330neIzXyEx9hQ/NlrrjLZhHufPy5Cx3C/TtAL6FPVAQKiuRttY5djDYuEbRST4UKtV/ZJPTQu/pJ030X64VyIy6fCQ8iwvyUWMIcNTLNUQxchR33A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WL2uSx7A
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6FC1F4BA2E08
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WL2uSx7A
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260629161457042.ZKSN.18412.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 01:14:57 +0900
Date: Tue, 30 Jun 2026 01:14:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
Message-Id: <20260630011456.ffd645885e56f7d33b4d1412@nifty.ne.jp>
In-Reply-To: <20260629233017.5e6eef4020915f0154623954@nifty.ne.jp>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-3-takashi.yano@nifty.ne.jp>
	<d8dacefa-68a4-d6bd-e6c4-d6291bb02256@gmx.de>
	<20260629233017.5e6eef4020915f0154623954@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Tue__30_Jun_2026_01_14_56_+0900_UTW7EhiYrfkIjsGv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782749697;
 bh=43mspdyIbQ+Wgc1z4D+LE2jpGEoX2q888kCfvKfYRic=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=WL2uSx7AGwAQsTlMaV30l8z9x7ZUh55Mk5oAltr9Rfxuwqs/HvY8FKwDMaU9f0xpMa+bw9qI
 BNPIWb19F7sbQ6pf1S2//S3488PIJsIUwJj86VohKkh424C0GuTkXrm58iscbHNzBMYazJ0+c0
 aS7oHEPckQyShcXuZryyPWNXTupxqy9EDugEwzV46f62AHImC7uW2zITtv/Fw4AjYXvwodGC2b
 D5qoFlTjQ0d2IFkbCi7RoE8/jjrgfJztyHb/0GwxpqcZzAwtFKmMTg7jYhzIWqd/czWGjE2x3+
 wLGfubCtKybbJDeA3KhESHqcNdUZ/MQ0pEQXvZFtycDUt4gA==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Tue__30_Jun_2026_01_14_56_+0900_UTW7EhiYrfkIjsGv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jun 2026 23:30:17 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> Thanks for finding that.
> 
> On Sat, 27 Jun 2026 09:27:12 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi, Mark,
> > 
> > I have a fix for the issue below sitting in
> > https://github.com/git-for-windows/msys2-runtime/pull/131/commits/0b0976a5e85de52312c17d21f1d3fc41dc572179
> > that I should have sent earlier, but I was struggling to find the time to
> > validate the fix via automated AutoHotKey-based tests. Sorry for the
> > delay.
> > 
> > On Thu, 11 Jun 2026, Takashi Yano wrote:
> > 
> > > If you run "stty noflsh; cat" in "bash", and stop "cat" by Ctrl-C,
> > > a stray ^C is passed to "bash". The current code calls tcflush() if
> > > NOFLSH is not set, however, tcflush() is not called when NOFLSH is
> > > set. So, Ctrl-C remains in console input buffer. This should be
> > > discarded even in NOFLSH mode. This patch introduces a helper
> > > function discard_key_events() and call it to erase Ctrl-C in the
> > > console input buffer.
> > > 
> > > Note that even with this patch, NOFLSH is not fully functional in
> > > console because the readahead buffer is unique to process, so it
> > > cannot be inherited to other processes. However, it should work
> > > intra process.
> > > 
> > > Fixes: 118e51be1d04 ("(tty_min::kill_pgrp): Handle tty flush when signal detected.")
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > Reviewed-by:
> > > ---
> > >  winsup/cygwin/fhandler/console.cc       | 20 +++++++++++++++++---
> > >  winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
> > >  winsup/cygwin/local_includes/fhandler.h |  2 ++
> > >  3 files changed, 26 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > > index a5e6cd89d..9ac492980 100644
> > > --- a/winsup/cygwin/fhandler/console.cc
> > > +++ b/winsup/cygwin/fhandler/console.cc
> > > @@ -1744,17 +1744,31 @@ out:
> > >      discard_len = 0;
> > >    if (discard_len)
> > >      {
> > > -      DWORD discarded;
> > >        acquire_attach_mutex (mutex_timeout);
> > >        DWORD resume_pid = attach_console (con.owner);
> > > -      ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
> > > +      discard_key_events (discard_len);
> > >        detach_console (resume_pid, con.owner);
> > >        release_attach_mutex ();
> > > -      con.num_processed -= min (con.num_processed, discarded);
> > >      }
> > >    return stat;
> > >  }
> > >  
> > > +void
> > > +fhandler_console::discard_key_events (size_t n)
> > > +{
> > > +  DWORD discarded = 0;
> > > +  INPUT_RECORD input_rec[INREC_SIZE];
> > > +  DWORD n1 = min (INREC_SIZE, n);
> > > +  while (n)
> > > +    {
> > > +      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> > > +      n -= n1;
> > > +      discarded += n1;
> > > +      n1 = min (INREC_SIZE, n);
> > > +    }
> > > +  con.num_processed -= min (con.num_processed, discarded);
> > > +}
> > 
> > `discard_key_events()` loops on `ReadConsoleInputW()` until it has
> > consumed the requested count, and `ReadConsoleInputW()` blocks while the
> > input buffer is empty. The `sigflush()` caller passes a hard-coded `1`
> > with no guarantee that a record is actually queued: in the master-thread
> > path the signalling record has already been read out of the buffer before
> > `sigflush()` runs, so the call blocks until the user's next keystroke
> > arrives, and then swallows it. And because `ReadConsoleInputW()`'s return
> > is unchecked, a failed read leaves `n1` indeterminate, so `n -= n1` can
> > underflow and spin.
> 
> The root cause of above situation is that the master-thread is not
> disable even when line_edit() is called via read(). This may cause
> other issues we have not seen yet. Usually, input_mutex is held by
> the thread calling line_edit(), so the master-thread does not touch
> the input events. However, the current code calls discard_key_events()
> after release_input_mutex_if_necessary().

No, this is not correct. The root problem is that the key event should
not be touched if process_sigs() is called from cons_master_thread().

> So, what about the patch (1/2) attached instead?

New patch (1/2) attached.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__30_Jun_2026_01_14_56_+0900_UTW7EhiYrfkIjsGv
Content-Type: text/plain;
 name="0001-Cygwin-console-discard_key_events-patch-1-2.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-console-discard_key_events-patch-1-2.patch"
Content-Transfer-Encoding: 7bit

From 2d04a679e90a6e009d239322e0fb4b8064f4d22c Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Tue, 30 Jun 2026 00:31:52 +0900
Subject: [PATCH] Cygwin: console discard_key_events patch (1/2)

---
 winsup/cygwin/fhandler/console.cc       | 8 +++++++-
 winsup/cygwin/local_includes/fhandler.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 730bb0b45..ae7940039 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -430,6 +430,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	return sizeof (INPUT_RECORD) * n;
       }
   };
+  con.master_thread_tid = GetCurrentThreadId ();
   termios &ti = ttyp->ti;
   while (con.owner == GetCurrentProcessId ())
     {
@@ -1765,12 +1766,17 @@ out:
 void
 fhandler_console::discard_key_events (size_t n)
 {
+  /* Do not touch key events if called from cons_master_thread. */
+  if (con.master_thread_tid == GetCurrentThreadId ())
+    return;
+
   DWORD discarded = 0;
   INPUT_RECORD input_rec[INREC_SIZE];
   DWORD n1 = min (INREC_SIZE, n);
   while (n)
     {
-      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
+      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1)
+	break;
       n -= n1;
       discarded += n1;
       n1 = min (INREC_SIZE, n);
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8e9cbef4b..3b3589c25 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2150,6 +2150,7 @@ class dev_console
   char *cons_rapoi;
   bool cursor_key_app_mode;
   volatile bool disable_master_thread;
+  DWORD master_thread_tid;
   tty::cons_mode curr_input_mode;
   tty::cons_mode curr_output_mode;
   DWORD prev_input_mode;
-- 
2.51.0


--Multipart=_Tue__30_Jun_2026_01_14_56_+0900_UTW7EhiYrfkIjsGv--
