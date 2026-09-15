Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id C87F04BA7987
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 09:55:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C87F04BA7987
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C87F04BA7987
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789466143; cv=none;
	b=eGfoLjiadf+IvgQaqHWw2ZwALQa93mbgkWczjo5izHAnltOK3ctLlZU61b6WP41PZC5W1n32CRJvquX/IZBkV+1x9YrKZZIDmjnBIOrCF8ok8iqkl02zLTy5CLv1qdoW8UgGgag3GOnhnHSJCpy4SbG5+9INVweTij3wtDqmEBA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789466143; c=relaxed/simple;
	bh=lLynpMKZRegv1jb2GUn3QN86TbnKhkW3SH+ELLtwvxI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BVybvAiU9WK1Q2SQylg/VL12/fMTVLVeKDONaNDOmdThrRgqXvWOEv9ekBaivzg/9BLX/qPobmZ6ZOr9vp7uW5Ruklke+rlXCDTUAuKCh+H7qqfWOXQ1f4NZmSEtBiwNT7VQCPjkQKJVcZS6pG9M4U+oQlCWAnSuI/sgAL9ckQo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IHu7M1pY
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C87F04BA7987
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IHu7M1pY
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260915095540112.RLOT.17441.HP-Z230@nifty.com>;
          Tue, 15 Sep 2026 18:55:40 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: console: Improve the performance of peek_console
Date: Tue, 15 Sep 2026 18:55:24 +0900
Message-ID: <20260915095532.531-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789466140;
 bh=0ib/LuIzVPlrxj2arD3we7xlnFBKQO7MQHwV+yaL95o=;
 h=From:To:Cc:Subject:Date;
 b=IHu7M1pYFPINfNMS7HUCHjv/Id7eOcYU9sc/7kDECJ8J7BaKS1Ev/3+6BTmFyNym/SeTFX5+
 qIKENRn6E7+csotZ75MG9gwBASED1hUACuIotjUQecQymGrY7xmi+T41dkbvDBBDOizPCN7CNo
 qscoMDENXgYtimmsCLG6c3j7KlX8csQ1YCIjbGwdCaVS31sNgPIo9JJ1IuoSgWq3Mpwojv6H6x
 N+Y8ZY3orUWEWQ+OSK/SNGV2M85sQqEenXOs0+KJjhvhJWmttVc78P181EK9JxT6e8jOwXiAxQ
 b5kBYoTMnsw286vYryV+oqsCS8cOqaQvu+L/IU7Qix0nAGkA==
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

 winsup/cygwin/fhandler/console.cc       |  3 +++
 winsup/cygwin/local_includes/fhandler.h |  3 ++-
 winsup/cygwin/select.cc                 | 34 +++++++++++++++----------
 3 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 0b0f11ee6..660fd3c41 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1494,6 +1494,9 @@ fhandler_console::process_input_message (size_t len)
   if (::input_ready && (len == 0 || (get_ttyp ()->ti.c_lflag & ICANON)))
     return input_ok;
 
+  if (total_read == 0)
+    return input_empty;
+
   for (i = 0; i < total_read; i ++)
     {
       DWORD nread = 1;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 392864ac4..341a326a6 100644
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
index 48f66c954..212fd7127 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
       return 1;
     }
 
-  INPUT_RECORD irec;
-  DWORD events_read;
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
@@ -1161,29 +1159,39 @@ peek_console (select_record *me, bool)
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
-      if (fhandler_console::input_winch == fh->process_input_message (0)
-	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
-	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
+      switch (fh->process_input_message (0))
 	{
+	case fhandler_console::input_processing:
+	case fhandler_console::input_ok:
+	  fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
+	  break;
+	case fhandler_console::input_winch:
+	  if (global_sigs[SIGWINCH].sa_handler != SIG_IGN
+	      && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
+	    {
+	      set_sig_errno (EINTR);
+	      fh->release_input_mutex ();
+	      return -1;
+	    }
+	  break;
+	case fhandler_console::input_signalled:
 	  set_sig_errno (EINTR);
 	  fh->release_input_mutex ();
 	  return -1;
+	case fhandler_console::input_error:
+	case fhandler_console::input_empty:
+	  fh->release_input_mutex ();
+	  goto out;
 	}
       fh->release_input_mutex ();
-
-      fh->fix_input_mode_if_necessary (); /* for win32_input_mode */
     }
+out:
   if (fh->input_ready () || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
-- 
2.51.0

