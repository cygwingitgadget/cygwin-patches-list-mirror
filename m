Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.117])
	by sourceware.org (Postfix) with ESMTPS id 875B14BA7999
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 13:26:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 875B14BA7999
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 875B14BA7999
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.117
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790515600; cv=none;
	b=XU0cPm9/lzsgEZBrU9bJUk+IV2U6mZQpSerHE8NMAuj1CYkrQTuUUnSlzbpdY0SMCfRkpwCd8tGyN7vLq0C0xaGGu8avzhY1CCoTv6ydHW3ZGnc21WSNvmlb8zrsVA5NBV9RRhv+dMy4f234sQtbz/eMMcpuMF8R85Iin7OpI3I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790515600; c=relaxed/simple;
	bh=OWWQMZL5Pr75rN6HfH7ezz8JVSxdMeT47WPUO7xH4as=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=HUIOIEaC3FqOs5VPAtjzhesumOse1hwnrFJd8RaZb66P5hemOQX3ypUY9SUkdJif4V2LGBBkOw68iYz3SyzGXdEYOBJpNTV+fOcIVoMaqkQMXoNQyPaZhZ8KgKNgt6EfPNqq710yq0bnD/5CcHfA9v/LS2EpaZZhcwHPCeQdJz4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cLS6cGK4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 875B14BA7999
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=cLS6cGK4
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260927132636724.BKFH.102121.HP-Z230@nifty.com>;
          Sun, 27 Sep 2026 22:26:36 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6] Cygwin: console: Improve the performance of peek_console
Date: Sun, 27 Sep 2026 22:26:11 +0900
Message-ID: <20260927132627.1002-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790515596;
 bh=rI5CyGxHIP4xmkLMLkdYHWbwWF57RmT+KGgtyTTaTxM=;
 h=From:To:Cc:Subject:Date;
 b=cLS6cGK4OPVnq3TDtUfzR5G8CaUV9MIWHwKUp1G9+fgwEckH8VBz7zpWIJFjCxFqxvjnmIVT
 3c42DYZFG5bBJcCQGu9Mcr5M0gk8fTP+RX7t6c99c05NWOmx5bAzdG2Bqz/BISSf01OdO/BoIV
 G2BEtNmK1vd8U3KWTgnlJAF/I8aN7kttUEywPB8s5w/IFwZpJMsN1vgI/YHCLtijfZDnRsaNSd
 2LNJycpMr+3v8AsYM/hPh6BKYzeDY6GuHzxqF+xTKcV+MjwbVPFITun2GpSWsx7yjqjfoJq9fV
 QvxIZfTLoQE8UmfRYC4U7bOPWrfcCMQpkF7dt65nJ87SKgFQ==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, peek_console() used PeekConsoleInput() to confirm whether
the console input buffer has some input records. However, this need
attaching to the console if the process does not attach to the console.
To reduce that overhead, this patch uses WaitForSingleObject() with
console input handle instead. WaitForSingleObject() works without
attaching to the console, so this simplifies the peek_console()
code.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Do not remove PeekConsoleInputW() call.
v3: Revert to v1 and check empty buffer in process_input_message()
v4: Handle input_empty and input_error returned from process_input_message()
    properly.
v5: Set thread_errno rather than errno in peek_console().
v6: Preserve errno/thread_errno as soon as the error occurs.

 winsup/cygwin/fhandler/console.cc       | 23 +++++++++++++++++
 winsup/cygwin/local_includes/fhandler.h |  3 ++-
 winsup/cygwin/select.cc                 | 33 ++++++++++++++++---------
 3 files changed, 47 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index fe15f15fa..bf708ffc3 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1432,6 +1432,24 @@ wait_retry:
 	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
 	    continue;
 	  goto sig_exit;
+	case input_empty:
+	  /* Reaches here when the input buffer is empty even though
+	     the input handle is signalled. */
+	  release_input_mutex ();
+	  if (is_nonblocking ())
+	    {
+	      if (copied_chars)
+		{
+		  fix_input_mode_if_necessary (); /* for win32_input_mode */
+		  buflen = copied_chars;
+		  return;
+		}
+	      set_sig_errno (EAGAIN);
+	      buflen = (size_t) -1;
+	      return;
+	    }
+	  cygwait (40);
+	  continue;
 	default:
 	  /* Should not come here */
 	  release_input_mutex ();
@@ -1489,10 +1507,12 @@ fhandler_console::process_input_message (size_t len)
   DWORD resume_pid = attach_console (con.owner);
   BOOL r =
     PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
+  DWORD error = GetLastError ();
   detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   if (!r)
     {
+      __set_errno_from_win_error (error);
       termios_printf ("PeekConsoleInput failed, %E");
       return input_error;
     }
@@ -1504,6 +1524,9 @@ fhandler_console::process_input_message (size_t len)
   if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
     return input_ok;
 
+  if (total_read == 0)
+    return input_empty;
+
   for (i = 0; i < total_read; i ++)
     {
       DWORD nread = 1;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index a86da207b..65e326135 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2193,7 +2193,8 @@ public:
     input_processing = 0,
     input_ok = 1,
     input_signalled = 2,
-    input_winch = 3
+    input_winch = 3,
+    input_empty = 4,
   };
   typedef cons_handle_set_t handle_set_t;
   HANDLE thread_sync_event;
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index e0bd1726f..7c14800fd 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
       return 1;
     }
 
-  INPUT_RECORD irec;
-  DWORD events_read;
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
@@ -1161,29 +1159,42 @@ peek_console (select_record *me, bool)
       else
 	{
 	  fh->acquire_input_mutex (mutex_timeout);
-	  acquire_attach_mutex (mutex_timeout);
-	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
-	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
-	  fh->detach_console (resume_pid, fh->get_owner ());
-	  release_attach_mutex ();
-	  if (!r || !events_read)
+	  if (WaitForSingleObject (h, 0) != WAIT_OBJECT_0)
 	    {
 	      fh->release_input_mutex ();
 	      break;
 	    }
 	}
       fhandler_console::input_states ret = fh->process_input_message (0);
+      if (ret == fhandler_console::input_error)
+	me->thread_errno = get_errno ();
       fh->release_input_mutex ();
       fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
 
-      if (ret == fhandler_console::input_winch
-	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
-	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
+      switch (ret)
 	{
+	case fhandler_console::input_processing:
+	case fhandler_console::input_ok:
+	  break;
+	case fhandler_console::input_winch:
+	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
+	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
+	    {
+	      set_sig_errno (EINTR);
+	      return -1;
+	    }
+	  break;
+	case fhandler_console::input_signalled:
 	  set_sig_errno (EINTR);
 	  return -1;
+	case fhandler_console::input_error:
+	  /* thread_errno is already set */
+	  return -1;
+	case fhandler_console::input_empty:
+	  goto out;
 	}
     }
+out:
   if (fh->input_ready () || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
-- 
2.51.0

