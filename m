Return-Path: <SRS0=9EPT=HS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 47DDB4BA9029
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 15:40:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 47DDB4BA9029
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 47DDB4BA9029
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790437248; cv=none;
	b=Uvt1psM05hGSfF6jDTTX+xPTk6OkQcuIyCaGCeS1mMeYBLXzWYfKusPxCb0Is8XsYauDXFknlaMn4C22iZaxqDur8vO3oM8tBTpY2oQkMCYsZgYL5hCg14Iwq7g7G+Qb0c0RNa1+z6PZAkeoA7oKP8AvwRlMqWgCpuDi/o0dY94=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790437248; c=relaxed/simple;
	bh=D+vSYpVWIud3FUscefvY2RlfyxMN1xXyAo5tEeqd7/A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=KKfp3tK9ZBDKW16O4RqhdRIENkcW6R6lLAZrZ3RuS9Zu+K6sBybh7C5DZX4KuAXK83rJbZjgKKb+5FadJVh2ueI8Wylg4SBp07nl1Xo4liWrzuyCQGdFRJUHOPZA4iLC4DqfH1qFEXmZ85CJsQOEV5XLZdWWKMOh3dWWGemYfWE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JQIGcMH5
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 47DDB4BA9029
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JQIGcMH5
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260926154045860.PGDM.18412.HP-Z230@nifty.com>;
          Sun, 27 Sep 2026 00:40:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5] Cygwin: console: Clear readahead buffer on tcflush()
Date: Sun, 27 Sep 2026 00:40:26 +0900
Message-ID: <20260926154038.3364-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790437245;
 bh=7swb7saQPsyZ5Bs7Xi0ju2fdqXh3mMLzG6xiygwdvKU=;
 h=From:To:Cc:Subject:Date;
 b=JQIGcMH59hrLxURKT2vCnqhRkqX2Cs2vZeSWb20exvLsZFyB3oKVP0/Dw57k7/w4doiSD/Zq
 IcETGvqvGQZ919rG38wLMoXsCNcHsQWFxdEfYYluOiaGYrl9E9qYl35O/101xf1xjo4qJFmaRe
 fTTvVgtaavakntehXufBcWFJGcUt3qD7sPAoKj1ElbKYrd1L1mtPtaamQ9K+VF5L8eiqenOYw0
 ZUwILxwUwL6azMGtea8qkXgzDbXjuWIPZONC5g9YFahY1DG9+GECj5KWHmnsuGBcyvQkeOlyYJ
 5zTSrB1/heJ3vKSFTTxTPPr32syC3vb1+1uKTLrDbPFhdA3g==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, tcflush(TCIFLUSH) only discarded the input events and
did not clear the readahead buffer. Because of this bug, when user
program called select() -> tcflush() -> read(), the last read()
returned the contents of the readahead buffer instead of blocking
as it should.

Correctly, tcflush() must discard all pending input, so read()
should block until new input arrives. With this patch, the read-
ahead buffer and `rapoi` are also cleared as well as input events.

Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Add input_mutex guard. Clear rapoi as well.
v3: Acquire input_mutex before output_mutex in ioctl() to avoid
    deadlock in tcflush().
    Make input_ready static as con_ra is.
v4: Revert input_mutex in ioctl() and move tcflush() outside
    output_mutex insted.
v5: Clear input_ready in close().

 winsup/cygwin/fhandler/console.cc       | 30 +++++++++++++++++++------
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/select.cc                 |  8 +++----
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d72bb39e0..fe15f15fa 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -70,6 +70,7 @@ bool NO_COPY fhandler_console::invisible_console;
 /* con_ra is shared in the same process.
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
+static bool input_ready;
 
 /* Write pending buffer for ESC sequence handling
    in xterm compatible mode */
@@ -1362,7 +1363,7 @@ fhandler_console::read (void *pv, size_t& buflen)
       (get_ttyp ()->ti.c_cc[VTIME]*100 ? : INFINITE)));
 
 read_more:
-  while (!input_ready && !get_cons_readahead_valid ())
+  while (!::input_ready && !get_cons_readahead_valid ())
     {
       int bgres;
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
@@ -1446,7 +1447,7 @@ wait_retry:
     get_readahead_into_buffer (buf + copied_chars, buflen - copied_chars);
 
   if (!con_ra.ralen)
-    input_ready = false;
+    ::input_ready = false;
   release_input_mutex ();
 
   fix_input_mode_if_necessary (); /* for win32_input_mode */
@@ -1500,7 +1501,7 @@ fhandler_console::process_input_message (size_t len)
   /* This code is reached only when being passed the input_ready check,
      however, the check was done outside input_mutex. Therefore, another
      thread may set input_ready after the check. Check it again here. */
-  if (input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
+  if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
     return input_ok;
 
   for (i = 0; i < total_read; i ++)
@@ -1879,14 +1880,14 @@ fhandler_console::process_input_message (size_t len)
 	    }
 	  else if (res == line_edit_input_done)
 	    {
-	      input_ready = true;
+	      ::input_ready = true;
 	      stat = input_ok;
 	      if (ti->c_lflag & ICANON)
 		goto out;
 	    }
 	}
       /* len == 0 if called from select.cc:peek_console() */
-      if (input_ready && (len == 0 || con_ra.ralen >= len))
+      if (::input_ready && (len == 0 || con_ra.ralen >= len))
 	goto out;
     }
 out:
@@ -2322,6 +2323,7 @@ fhandler_console::close (int flag)
   if (con_ra.rabuf)
     free (con_ra.rabuf);
   memset (&con_ra, 0, sizeof (con_ra));
+  ::input_ready = false;
 
   if (!have_execed && !invisible_console
       && (!CTTY_IS_VALID (myself->ctty)
@@ -2490,8 +2492,9 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	release_output_mutex ();
 	return res;
       case TCFLSH:
-	res = this->tcflush ((int)(intptr_t) arg);
 	release_output_mutex ();
+	/* tcflush() does not need output_mutex */
+	res = this->tcflush ((int)(intptr_t) arg);
 	return res;
     }
 
@@ -2506,6 +2509,9 @@ fhandler_console::tcflush (int queue)
   if (queue == TCIFLUSH
       || queue == TCIOFLUSH)
     {
+      /* tcflush() may be called inside the input_mutex,
+	 however, mutex of Win32 can be acquired recursively. */
+      acquire_input_mutex (mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       DWORD resume_pid = attach_console (con.owner);
       BOOL r = FlushConsoleInputBuffer (get_handle ());
@@ -2517,6 +2523,10 @@ fhandler_console::tcflush (int queue)
 	  res = -1;
 	}
       con.num_processed = 0;
+      eat_readahead (-1);
+      ::input_ready = false;
+      con.cons_rapoi = NULL;
+      release_input_mutex ();
     }
   return res;
 }
@@ -2543,7 +2553,7 @@ fhandler_console::tcgetattr (struct termios *t)
 }
 
 fhandler_console::fhandler_console (fh_devices devunit) :
-  fhandler_termios (), input_ready (false), thread_sync_event (NULL),
+  fhandler_termios (), thread_sync_event (NULL),
   input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV),
   num_input_events_processed (0)
 {
@@ -5122,3 +5132,9 @@ fhandler_console::tcdrain ()
 {
   return 0;
 }
+
+bool
+fhandler_console::input_ready ()
+{
+  return ::input_ready;
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 438b02bf0..a86da207b 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2187,7 +2187,6 @@ public:
     tty_min tty_min_state;
     dev_console con;
   };
-  bool input_ready;
   enum input_states
   {
     input_error = -1,
@@ -2374,6 +2373,7 @@ private:
   int fstat (struct stat *buf);
   void discard_key_events (size_t n);
   void fix_input_mode_if_necessary ();
+  bool input_ready ();
 
   class console_unit
   {
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 37b28d5d1..e0bd1726f 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1140,7 +1140,7 @@ peek_console (select_record *me, bool)
   if (fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
-  if (fh->input_ready)
+  if (fh->input_ready ())
     return me->read_ready = true;
 
   if (me->read_ready)
@@ -1154,7 +1154,7 @@ peek_console (select_record *me, bool)
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
-  while (!fh->input_ready && !fh->get_cons_readahead_valid ())
+  while (!fh->input_ready () && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
 	return me->read_ready = true;
@@ -1184,7 +1184,7 @@ peek_console (select_record *me, bool)
 	  return -1;
 	}
     }
-  if (fh->input_ready || fh->get_cons_readahead_valid ())
+  if (fh->input_ready () || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
   return me->write_ready;
@@ -1284,7 +1284,7 @@ fhandler_console::select_read (select_stuff *ss)
 
   s->peek = peek_console;
   s->read_selected = true;
-  s->read_ready = input_ready || get_cons_readahead_valid ();
+  s->read_ready = input_ready () || get_cons_readahead_valid ();
   s->cleanup = console_cleanup;
   return s;
 }
-- 
2.51.0

