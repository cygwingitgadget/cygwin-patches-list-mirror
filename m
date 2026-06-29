Return-Path: <SRS0=TksR=EZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 5B7AD4BA23D6
	for <cygwin-patches@cygwin.com>; Mon, 29 Jun 2026 14:30:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5B7AD4BA23D6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5B7AD4BA23D6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782743424; cv=none;
	b=ZLtXP0DOeGcVLzq2bWMoJIjDO657WCGhCJdCSjXYz3DtSgby/vALsganDx2s3+2fqM+yl3ziRKjKMZe/4Va78R7DFaoz0wFvncrARPdOqKa+NlHEzOWL3SSuO5I6Tn/9FZ9gbd21Y+gcZDI4HV8ohRipvfFXvWKJ9jej626yyYc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782743424; c=relaxed/simple;
	bh=SWMWtG66UhJVJypAebuB4Syu/NUSu6iGzutTZI7EHJI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=GurVF/UilJeALmDusGZ10Uk6R4VRq1+cwHep7MsZi7lxIBt2WNW+LBpSP5WRhhICB0CF30yugfNd8wJR30IiRYI0V3ONzk0YtRKpeKOYv2r8HQvf6x6PNuKPBkCxiXw7/Qp4rJuj3rQYf3yfro74g6ceVpFu9XDexzYzPGGuZR4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=CgFKsjM3
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5B7AD4BA23D6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=CgFKsjM3
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260629143020697.FHGA.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Mon, 29 Jun 2026 23:30:20 +0900
Date: Mon, 29 Jun 2026 23:30:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little
Message-Id: <20260629233017.5e6eef4020915f0154623954@nifty.ne.jp>
In-Reply-To: <d8dacefa-68a4-d6bd-e6c4-d6291bb02256@gmx.de>
References: <20260610163533.10187-1-takashi.yano@nifty.ne.jp>
	<20260610163533.10187-3-takashi.yano@nifty.ne.jp>
	<d8dacefa-68a4-d6bd-e6c4-d6291bb02256@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__29_Jun_2026_23_30_17_+0900_jserlc_XJsXqHjqL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782743420;
 bh=kc8ARhvwC5hRkH+YDsv2W9UrEVzWUCA6tfFbRzXP/T4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=CgFKsjM3LY9ZJyK8F5UEN3ocMMsPmt01kffDGEfEedi0lV1uaF7GzVmponaeXqRVEN7w2maE
 WWVQbphrOzMpRcAL5h2VZtHJpTC5TPzg7J84II8492Gpy/wK52f9tUe5vwhm4QChUtSha6jtfy
 J7eKplHQdGMQgk22FSpL8y3yPfoeDToEVSpuCK8xzphbdCvPDSWpWHOKC/aqUwhvMf9LaEuZXV
 mka2HQ6E3kV7HANehQ4AI3/VRfy8eje1KirgWhtNt788o60gDs0ruwUO6H/it9lJU5OEd4wUhj
 hvxvuF50z2rh7AyapYq/v6gE4ISKn0w/08zp9tWKhxtdrSdA==
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Mon__29_Jun_2026_23_30_17_+0900_jserlc_XJsXqHjqL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Johannes,

Thanks for finding that.

On Sat, 27 Jun 2026 09:27:12 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi, Mark,
> 
> I have a fix for the issue below sitting in
> https://github.com/git-for-windows/msys2-runtime/pull/131/commits/0b0976a5e85de52312c17d21f1d3fc41dc572179
> that I should have sent earlier, but I was struggling to find the time to
> validate the fix via automated AutoHotKey-based tests. Sorry for the
> delay.
> 
> On Thu, 11 Jun 2026, Takashi Yano wrote:
> 
> > If you run "stty noflsh; cat" in "bash", and stop "cat" by Ctrl-C,
> > a stray ^C is passed to "bash". The current code calls tcflush() if
> > NOFLSH is not set, however, tcflush() is not called when NOFLSH is
> > set. So, Ctrl-C remains in console input buffer. This should be
> > discarded even in NOFLSH mode. This patch introduces a helper
> > function discard_key_events() and call it to erase Ctrl-C in the
> > console input buffer.
> > 
> > Note that even with this patch, NOFLSH is not fully functional in
> > console because the readahead buffer is unique to process, so it
> > cannot be inherited to other processes. However, it should work
> > intra process.
> > 
> > Fixes: 118e51be1d04 ("(tty_min::kill_pgrp): Handle tty flush when signal detected.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/console.cc       | 20 +++++++++++++++++---
> >  winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
> >  winsup/cygwin/local_includes/fhandler.h |  2 ++
> >  3 files changed, 26 insertions(+), 6 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index a5e6cd89d..9ac492980 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -1744,17 +1744,31 @@ out:
> >      discard_len = 0;
> >    if (discard_len)
> >      {
> > -      DWORD discarded;
> >        acquire_attach_mutex (mutex_timeout);
> >        DWORD resume_pid = attach_console (con.owner);
> > -      ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
> > +      discard_key_events (discard_len);
> >        detach_console (resume_pid, con.owner);
> >        release_attach_mutex ();
> > -      con.num_processed -= min (con.num_processed, discarded);
> >      }
> >    return stat;
> >  }
> >  
> > +void
> > +fhandler_console::discard_key_events (size_t n)
> > +{
> > +  DWORD discarded = 0;
> > +  INPUT_RECORD input_rec[INREC_SIZE];
> > +  DWORD n1 = min (INREC_SIZE, n);
> > +  while (n)
> > +    {
> > +      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
> > +      n -= n1;
> > +      discarded += n1;
> > +      n1 = min (INREC_SIZE, n);
> > +    }
> > +  con.num_processed -= min (con.num_processed, discarded);
> > +}
> 
> `discard_key_events()` loops on `ReadConsoleInputW()` until it has
> consumed the requested count, and `ReadConsoleInputW()` blocks while the
> input buffer is empty. The `sigflush()` caller passes a hard-coded `1`
> with no guarantee that a record is actually queued: in the master-thread
> path the signalling record has already been read out of the buffer before
> `sigflush()` runs, so the call blocks until the user's next keystroke
> arrives, and then swallows it. And because `ReadConsoleInputW()`'s return
> is unchecked, a failed read leaves `n1` indeterminate, so `n -= n1` can
> underflow and spin.

The root cause of above situation is that the master-thread is not
disable even when line_edit() is called via read(). This may cause
other issues we have not seen yet. Usually, input_mutex is held by
the thread calling line_edit(), so the master-thread does not touch
the input events. However, the current code calls discard_key_events()
after release_input_mutex_if_necessary().

So, what about the patch (1/2) attached instead?

> The fix is to consume only what `GetNumberOfConsoleInputEvents()` reports
> as currently queued (so the helper never waits for input that is not
> there) and to bail on a failed or zero-length read (so it cannot
> underflow).
> 
> One separate point worth flagging: the `process_input_message()` caller
> wraps `discard_key_events()` in `acquire_attach_mutex()` + `attach_console
> (con.owner)`, but the `sigflush()` call site does not, so the
> `ReadConsoleInputW()` there runs against whatever console the calling
> process happens to be attached to. With the guard above the worst case is
> a no-op when the calling process happens not to be attached, but it would
> be more correct to wrap the `sigflush()` discard the same way, or to move
> the attach into the helper itself.

Yeah, you are right. Then, what about the patch (2/2) attached?

Sorry for no commit message for both patches yet.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Mon__29_Jun_2026_23_30_17_+0900_jserlc_XJsXqHjqL
Content-Type: text/plain;
 name="0001-Cygwin-console-discard_key_events-patch-1-2.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-console-discard_key_events-patch-1-2.patch"
Content-Transfer-Encoding: 7bit

From 47377a1e286de55ea5b24529e35afdad6c747ea4 Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Mon, 29 Jun 2026 23:22:05 +0900
Subject: [PATCH 1/2] Cygwin: console: discard_key_events patch (1/2)

---
 winsup/cygwin/fhandler/console.cc |  3 ++-
 winsup/cygwin/fhandler/termios.cc | 12 +++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 730bb0b45..ccd087f92 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1770,7 +1770,8 @@ fhandler_console::discard_key_events (size_t n)
   DWORD n1 = min (INREC_SIZE, n);
   while (n)
     {
-      ReadConsoleInputW (get_handle (), input_rec, n1, &n1);
+      if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1)
+	break;
       n -= n1;
       discarded += n1;
       n1 = min (INREC_SIZE, n);
diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 605258731..a2b14d14b 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -449,6 +449,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  fh->eat_readahead (-1);
 	  fh->discard_input ();
 	}
+      if (is_flush_sig (sig) && cygheap->ctty)
+	cygheap->ctty->discard_key_events (1);
       if (fh)
 	fh->release_input_mutex_if_necessary ();
       ttyp->kill_pgrp (sig, pgid);
@@ -666,13 +668,9 @@ fhandler_termios::sigflush ()
      be NULL while this is alive.  However, we can conceivably close a
      ctty while exiting and that will zero this. */
   if ((!have_execed || have_execed_cygwin) && tc ()
-      && (tc ()->getpgid () == myself->pgid))
-    {
-      if (!(tc ()->ti.c_lflag & NOFLSH))
-	tcflush (TCIFLUSH);
-      else
-	discard_key_events (1);
-    }
+      && (tc ()->getpgid () == myself->pgid)
+      && !(tc ()->ti.c_lflag & NOFLSH))
+    tcflush (TCIFLUSH);
 }
 
 pid_t
-- 
2.51.0


--Multipart=_Mon__29_Jun_2026_23_30_17_+0900_jserlc_XJsXqHjqL
Content-Type: text/plain;
 name="0002-Cgywin-console-discard_key_events-patch-2-2.patch"
Content-Disposition: attachment;
 filename="0002-Cgywin-console-discard_key_events-patch-2-2.patch"
Content-Transfer-Encoding: 7bit

From 6b8f413c29345a902d2cd23bd9798597d5cbb548 Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Mon, 29 Jun 2026 23:24:42 +0900
Subject: [PATCH 2/2] Cgywin: console: discard_key_events patch (2/2)

---
 winsup/cygwin/fhandler/console.cc | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index ccd087f92..c1497d97c 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1752,13 +1752,7 @@ out:
   if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
     discard_len = 0;
   if (discard_len && (len || stat != input_ok))
-    {
-      acquire_attach_mutex (mutex_timeout);
-      DWORD resume_pid = attach_console (con.owner);
-      discard_key_events (discard_len);
-      detach_console (resume_pid, con.owner);
-      release_attach_mutex ();
-    }
+    discard_key_events (discard_len);
   return stat;
 }
 
@@ -1768,6 +1762,8 @@ fhandler_console::discard_key_events (size_t n)
   DWORD discarded = 0;
   INPUT_RECORD input_rec[INREC_SIZE];
   DWORD n1 = min (INREC_SIZE, n);
+  acquire_attach_mutex (mutex_timeout);
+  DWORD resume_pid = attach_console (con.owner);
   while (n)
     {
       if (!ReadConsoleInputW (get_handle (), input_rec, n1, &n1) || !n1)
@@ -1776,6 +1772,8 @@ fhandler_console::discard_key_events (size_t n)
       discarded += n1;
       n1 = min (INREC_SIZE, n);
     }
+  detach_console (resume_pid, con.owner);
+  release_attach_mutex ();
   con.num_processed -= min (con.num_processed, discarded);
 }
 
-- 
2.51.0


--Multipart=_Mon__29_Jun_2026_23_30_17_+0900_jserlc_XJsXqHjqL--
