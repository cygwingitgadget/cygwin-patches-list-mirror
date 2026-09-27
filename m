Return-Path: <SRS0=6sOE=HT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 9F0CA4BA7999
	for <cygwin-patches@cygwin.com>; Sun, 27 Sep 2026 20:35:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9F0CA4BA7999
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9F0CA4BA7999
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790541356; cv=none;
	b=Xy6SqzYaY0R1VXX69F4s8qdRKYY2g8eIuoQgi0jHGWIwdoiuhT6frhWimdnETC3GjwS5EW0pEK2sU3xwnG1Fni/T1MQxxvVAe+nML0h1duQTK/McgttpCfDvp0uU4cbENHMjhBPf/xDUfYapYIMnLkTdGEQDFXTdCai8Ja1c3xo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790541356; c=relaxed/simple;
	bh=c1T3cerh5LT5YiZpAjn5V1KWDMhQmS8OB8Dh3QgAcpc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=M5cLu0SNYAfraJVRmz9pqb7fk4h2wK+HnUdmlkvYLQb3nUEW2K5pi2WXjJiEXTRXwGSu5Bvbe3omOVQmS/wndcNXw4hGumlMtv59gzYsRBZidiBB339hFj84DIrXAD66AKSkiXs6HyR253y2k7lGxfjaB4ZIyWxou6YhVqUveZk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G1pT2e2/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9F0CA4BA7999
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=G1pT2e2/
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260927203552491.MLSL.17441.HP-Z230@nifty.com>;
          Mon, 28 Sep 2026 05:35:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v7] Cygwin: console: Improve the performance of peek_console
Date: Mon, 28 Sep 2026 05:35:37 +0900
Message-ID: <20260927203545.526-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790541352;
 bh=dj2WqLqLoU+aPw8kN3daW58o1zDjNYfKkYigSBY8Hiw=;
 h=From:To:Cc:Subject:Date;
 b=G1pT2e2/Wvcx9ywI12d3Lr84rci0C72u22d1YgZLgay8uWxhodrZ/VJvFLozlGaFXCw5ltAw
 rEf/l6WCOtCCT0xn6034Zb1SIvBf4YKGtS3xM7OaMimPNVvVmxd6N26dMWQDhZE517qyQD3nLV
 wEqOdAU+QqfLFFWdRuef0UutnCQ44FSw8xBq6ZU2tYakeNmpOIpO9VbCpcCYu+DeWy4LUJ5YLI
 X2yGGDBIHdfeucPTJlmIJGC8Fs3mXAFQaIkIEKsMhzQQx09R4gq3iNTAgpwRz9gCoYfmQBO6wV
 u2KTTJ8s4o7NPmnwNMNxMHuaFGf1UQjsJlo1E24PIC7G4fPQ==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
v7: Do not overwrite errno in input_error case.

 winsup/cygwin/fhandler/console.cc       | 26 ++++++++++++++++++-
 winsup/cygwin/local_includes/fhandler.h |  3 ++-
 winsup/cygwin/select.cc                 | 33 ++++++++++++++++---------
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index fe15f15fa..c9d870769 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1418,6 +1418,7 @@ wait_retry:
 	{
 	case input_error:
 	  release_input_mutex ();
+	  /* errno is already set in process_input_message() */
 	  goto err;
 	case input_processing:
 	  release_input_mutex ();
@@ -1432,9 +1433,28 @@ wait_retry:
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
+	  __seterrno ();
 	  goto err;
 	}
     }
@@ -1462,7 +1482,6 @@ wait_retry:
   return;
 
 err:
-  __seterrno ();
   buflen = (size_t) -1;
   return;
 
@@ -1489,10 +1508,12 @@ fhandler_console::process_input_message (size_t len)
   DWORD resume_pid = attach_console (con.owner);
   BOOL r =
     PeekConsoleInputW (get_handle (), input_rec, INREC_SIZE, &total_read);
+  DWORD error = GetLastError ();
   detach_console (resume_pid, con.owner);
   release_attach_mutex ();
   if (!r)
     {
+      __seterrno_from_win_error (error);
       termios_printf ("PeekConsoleInput failed, %E");
       return input_error;
     }
@@ -1504,6 +1525,9 @@ fhandler_console::process_input_message (size_t len)
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

