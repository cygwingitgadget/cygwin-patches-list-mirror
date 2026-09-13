Return-Path: <SRS0=bcf7=HF=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 093954BAE7E8
	for <cygwin-patches@cygwin.com>; Sun, 13 Sep 2026 21:45:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 093954BAE7E8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 093954BAE7E8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789335945; cv=none;
	b=Wv1mXIj+5tmglNoJh+0Ht0+5iXpihXix2D7D285tScnlUZ5g0dvJMfGIZ1ZQbxSW9Jw5BTIeyp61WtDEs8ngioQkCEwK83vReBQ8OxCviKpBoBWxNGJHLREzzAfcUeo8BOYMg98Mk/LU7dZ4POSTT4fQvBOA5i4Of9/L71Y2HS8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789335945; c=relaxed/simple;
	bh=fmkI1BEus0rSx+i8/VWiZ1EPSGcKXQi1NXCMuNqGkXE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=aEItgV3ZIjWyA5hfMfh6PQMBvWysJpjr5KOuiBmNvG8wXxrNtm2aGd5OQ59Md4e9tn0BCXe4i+MXFTNajmtZ7+zxPk1bvrW97fcmBgnXEAaqFqqePLdpANEbmgXTz4RKXIC28iER3WBa5U1Z2hzeNfQNTYGHKQyxx6dcIZfbbew=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G19t/Zo8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 093954BAE7E8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G19t/Zo8
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260913214541359.QJJL.17441.HP-Z230@nifty.com>;
          Mon, 14 Sep 2026 06:45:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: console: Clear readahead buffer on tcflush()
Date: Mon, 14 Sep 2026 06:45:25 +0900
Message-ID: <20260913214534.708-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789335941;
 bh=tUg5entERHgxuJ2ZR4ca1za/V4zmR/xQ2g28nDmKXA8=;
 h=From:To:Cc:Subject:Date;
 b=G19t/Zo8W0bpmbWmdecSNyMa1GBKahySl6X+VrFIkO6Ptu6/5rx+DE8qpgRmNVm9TuLMH0vM
 by6jz50s5QIl33a5GrqGaWv/FuidoPfkKfwZCnejhlxZDUPk0jdW9t7ysO+TFOpUF+FswQTM65
 ngD1u4V/WRgtMlNv2zE3AKN/qm99KRR7QTZInvrMiZQWdHFwjG5kpR6PMTyHyTgkJwMsB4CDpy
 kzu/a7xGuhl8umMfv92vsDwFvkH5enCDIxrnUluXDTaP2tRFCg7eL/xDNgz2t4deS8mXChrMk4
 N/Ma5/IGfmJ2lZYbcJqI8Mx8bAlHjLUM/OECIvNuUWe9lxlg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/console.cc       | 41 +++++++++++++++++++++----
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/select.cc                 |  8 ++---
 3 files changed, 40 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index be41bf3a2..a995f3acc 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -70,6 +70,7 @@ bool NO_COPY fhandler_console::invisible_console;
 /* con_ra is shared in the same process.
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
+static bool input_ready;
 
 /* Write pending buffer for ESC sequence handling
    in xterm compatible mode */
@@ -1224,7 +1225,7 @@ fhandler_console::read (void *pv, size_t& buflen)
       (get_ttyp ()->ti.c_cc[VTIME]*100 ? : INFINITE)));
 
 read_more:
-  while (!input_ready && !get_cons_readahead_valid ())
+  while (!::input_ready && !get_cons_readahead_valid ())
     {
       int bgres;
       if ((bgres = bg_check (SIGTTIN)) <= bg_eof)
@@ -1305,7 +1306,7 @@ wait_retry:
     get_readahead_into_buffer (buf + copied_chars, buflen - copied_chars);
 
   if (!con_ra.ralen)
-    input_ready = false;
+    ::input_ready = false;
   release_input_mutex ();
 
   if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
@@ -1357,7 +1358,7 @@ fhandler_console::process_input_message (size_t len)
   /* This code is reached only when being passed the input_ready check,
      however, the check was done outside input_mutex. Therefore, another
      thread may set input_ready after the check. Check it again here. */
-  if (input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
+  if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
     return input_ok;
 
   for (i = 0; i < total_read; i ++)
@@ -1736,14 +1737,14 @@ fhandler_console::process_input_message (size_t len)
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
@@ -2217,6 +2218,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
   int res = fhandler_termios::ioctl (cmd, arg);
   if (res <= 0)
     return res;
+  acquire_input_mutex (mutex_timeout);
   acquire_output_mutex (mutex_timeout);
   switch (cmd)
     {
@@ -2234,6 +2236,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 			   ((struct winsize *) arg)->ws_row,
 			   ((struct winsize *) arg)->ws_col);
 	    release_output_mutex ();
+	    release_input_mutex ();
 	    return 0;
 	  }
 	else
@@ -2241,17 +2244,21 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	    syscall_printf ("WINSZ failed");
 	    __seterrno ();
 	    release_output_mutex ();
+	    release_input_mutex ();
 	    return -1;
 	  }
 	release_output_mutex ();
+	release_input_mutex ();
 	return 0;
       case TIOCSWINSZ:
 	bg_check (SIGTTOU);
 	release_output_mutex ();
+	release_input_mutex ();
 	return 0;
       case KDGKBMETA:
 	*(int *) arg = (con.metabit) ? K_METABIT : K_ESCPREFIX;
 	release_output_mutex ();
+	release_input_mutex ();
 	return 0;
       case KDSKBMETA:
 	if ((intptr_t) arg == K_METABIT)
@@ -2262,19 +2269,23 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  {
 	    set_errno (EINVAL);
 	    release_output_mutex ();
+	    release_input_mutex ();
 	    return -1;
 	  }
 	release_output_mutex ();
+	release_input_mutex ();
 	return 0;
       case TIOCLINUX:
 	if (*(unsigned char *) arg == 6)
 	  {
 	    *(unsigned char *) arg = (unsigned char) con.nModifiers;
 	    release_output_mutex ();
+	    release_input_mutex ();
 	    return 0;
 	  }
 	set_errno (EINVAL);
 	release_output_mutex ();
+	release_input_mutex ();
 	return -1;
       case FIONREAD:
       case TIOCINQ:
@@ -2291,6 +2302,7 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	    {
 	      set_errno (EINVAL);
 	      release_output_mutex ();
+	      release_input_mutex ();
 	      return -1;
 	    }
 	  bool saw_eol = false;
@@ -2327,20 +2339,24 @@ fhandler_console::ioctl (unsigned int cmd, void *arg)
 	  else
 	    *(int *) arg = ret;
 	  release_output_mutex ();
+	  release_input_mutex ();
 	  return 0;
 	}
 	break;
       case TCXONC:
 	res = this->tcflow ((int)(intptr_t) arg);
 	release_output_mutex ();
+	release_input_mutex ();
 	return res;
       case TCFLSH:
 	res = this->tcflush ((int)(intptr_t) arg);
 	release_output_mutex ();
+	release_input_mutex ();
 	return res;
     }
 
   release_output_mutex ();
+  release_input_mutex ();
   return fhandler_base::ioctl (cmd, arg);
 }
 
@@ -2351,6 +2367,9 @@ fhandler_console::tcflush (int queue)
   if (queue == TCIFLUSH
       || queue == TCIOFLUSH)
     {
+      /* tcflush() may be called inside the input_mutex,
+	 however, mutex of Win32 can be acquired recursively. */
+      acquire_input_mutex (mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       DWORD resume_pid = attach_console (con.owner);
       BOOL r = FlushConsoleInputBuffer (get_handle ());
@@ -2362,6 +2381,10 @@ fhandler_console::tcflush (int queue)
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
@@ -2386,7 +2409,7 @@ fhandler_console::tcgetattr (struct termios *t)
 }
 
 fhandler_console::fhandler_console (fh_devices devunit) :
-  fhandler_termios (), input_ready (false), thread_sync_event (NULL),
+  fhandler_termios (), thread_sync_event (NULL),
   input_mutex (NULL), output_mutex (NULL), unit (MAX_CONS_DEV),
   num_input_events_processed (0)
 {
@@ -4912,3 +4935,9 @@ fhandler_console::tcdrain ()
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
index d11b3ec4f..73d121508 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2183,7 +2183,6 @@ public:
     tty_min tty_min_state;
     dev_console con;
   };
-  bool input_ready;
   enum input_states
   {
     input_error = -1,
@@ -2366,6 +2365,7 @@ private:
   void wpbuf_send ();
   int fstat (struct stat *buf);
   void discard_key_events (size_t n);
+  bool input_ready ();
 
   class console_unit
   {
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index b72083447..120273b70 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1140,7 +1140,7 @@ peek_console (select_record *me, bool)
   if (fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
-  if (fh->input_ready)
+  if (fh->input_ready ())
     return me->read_ready = true;
 
   if (me->read_ready)
@@ -1155,7 +1155,7 @@ peek_console (select_record *me, bool)
   set_handle_or_return_if_not_open (h, me);
 
   fh->acquire_input_mutex (mutex_timeout);
-  while (!fh->input_ready && !fh->get_cons_readahead_valid ())
+  while (!fh->input_ready () && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
 	{
@@ -1182,7 +1182,7 @@ peek_console (select_record *me, bool)
 	}
     }
   fh->release_input_mutex ();
-  if (fh->input_ready || fh->get_cons_readahead_valid ())
+  if (fh->input_ready () || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
   return me->write_ready;
@@ -1282,7 +1282,7 @@ fhandler_console::select_read (select_stuff *ss)
 
   s->peek = peek_console;
   s->read_selected = true;
-  s->read_ready = input_ready || get_cons_readahead_valid ();
+  s->read_ready = input_ready () || get_cons_readahead_valid ();
   s->cleanup = console_cleanup;
   return s;
 }
-- 
2.51.0

