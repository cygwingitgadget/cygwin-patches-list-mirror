Return-Path: <SRS0=9EPT=HS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 353334BA9017
	for <cygwin-patches@cygwin.com>; Sat, 26 Sep 2026 16:53:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 353334BA9017
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 353334BA9017
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790441617; cv=none;
	b=CJ4fLXvWIpWved4gh+0ozyBWB8H05UWtBMS00nw0JsuAOIGGWXtStvFuscGgKO12JkRbSkj4nXMn9tlDqrK+wD3cfMtRmSc8VEr8m3tsNEWTof0ojjTUxdt0JqzZoxOLvyc/XrsOL4DZ+MMKQX7U3xnfjpLy8ypxJQtZ942De9I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790441617; c=relaxed/simple;
	bh=g2AvK16Tv5sdMZM6ERzBPTKXbhu8Gtl3EvrCryJ//tk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=X6y8mVvE1w+oYbqyxEdjuZrvt39y8NkDGkX+/7B0/yf7XzLMqIwVERFby/R2C8gFBYSaZg+4db4NQzC8ao8V4dRoRilcBsa3VujGTcMkv++hVRGvBNQw5gYA7GxpUA/Zgp6zFvHcPNwkQ3xfu/6GVtyM+BilPt4iZ+6f+6Nskkg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mrwrfmED
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 353334BA9017
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mrwrfmED
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260926165333648.PVJP.18412.HP-Z230@nifty.com>;
          Sun, 27 Sep 2026 01:53:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4] Cygwin: console: Improve the performance of peek_console
Date: Sun, 27 Sep 2026 01:53:18 +0900
Message-ID: <20260926165326.16789-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1790441613;
 bh=WiCADeq5GCUgZmv9cPc6uR9ygMPnzRtrfR3YxXhfcqk=;
 h=From:To:Cc:Subject:Date;
 b=mrwrfmED3ObCNVAxVBfwhwPfeU7Ef2wGJZAlUgHy8tjZtlG3pQ7sAgkFw8XtpfXNpkcphcTx
 EJVZqp38xWfmSxbeE+sJvhS/XZqIuqFwVmLdR8rWillWDFR08lNarqIzcVZjTPhL/WHy3X2CtX
 PThZjtL4KUSIxFgYux/+E7fMHrxyp25DY6A0cb07k3c6+jUV747Q/Tkybpc8fLnYlDS3KzQGkx
 fXCcaTFz4zatBoMoVW7ED0x0voPZq7NdfRJl7Hftu0OYxZ+VaVdkj/clmKH7fk4z20/3XPreqc
 /eAmYF+m55u1Tq+vbH5mVMJPnt0pBgGHZFnQXjUMvZh+mLRQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/console.cc       | 21 +++++++++++++++++
 winsup/cygwin/local_includes/fhandler.h |  3 ++-
 winsup/cygwin/select.cc                 | 31 ++++++++++++++++---------
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index fe15f15fa..0d1f3fcee 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1432,6 +1432,24 @@ wait_retry:
 	  if (global_sigs[get_ttyp ()->last_sig].sa_flags & SA_RESTART)
 	    continue;
 	  goto sig_exit;
+	case input_empty:
+	  /* Reaches here input buffer is empty even though
+	     input handle is signalled. */
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
@@ -1504,6 +1522,9 @@ fhandler_console::process_input_message (size_t len)
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
index e0bd1726f..d899dcd65 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
       return 1;
     }
 
-  INPUT_RECORD irec;
-  DWORD events_read;
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
@@ -1161,12 +1159,7 @@ peek_console (select_record *me, bool)
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
@@ -1176,14 +1169,30 @@ peek_console (select_record *me, bool)
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
+	  __seterrno ();
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

