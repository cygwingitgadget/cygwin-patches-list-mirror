Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1331.google.com (mail-dy1-x1331.google.com [IPv6:2607:f8b0:4864:20::1331])
	by sourceware.org (Postfix) with ESMTPS id 9078F4BA2E1E
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9078F4BA2E1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9078F4BA2E1E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1331
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336070; cv=none;
	b=X0dg14lFxDYn2Ta8nvT7ZKYXA/tZpf40H44eS+Za8YA1QdcjsPBOVT8Lq1IOqAJPItbnrcRTy3MIF8neWWFazyIavWLoloxyetocGWerJ6Kw45F3mym78tyzmXQmT/SvC+ZTbH9qyCZlWA6bhtVzXFor5y69tOdLswOYgU++Jpk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336070; c=relaxed/simple;
	bh=BX5Cl9eJCh8l5OyknMDmy4ZcVoNBA71H4o3v0jgkw98=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=iKmTxZR+vg20ycAr9ntr8Oqam9IvFnuhVZcjPSuosXmwbIvTjv0Z1aMxr1L1nVJQ6ZbY3pdgInJ0NY3s6e0rVpxzMfvIDfINgc6DDIvIPT0/ZXNy3XP6qMnmS5wV3RGISlxMCrYN2OEORotgW7UpM05rpeypLGzR2KsKZEsVgkY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sqJxCt26
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9078F4BA2E1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sqJxCt26
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-35a31bb9fb6so3233592eec.1
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336069; x=1792940869; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSi/6elR2fChgfiMMkLEEDEp8no+iOPKUesgm4ZlxmQ=;
        b=sqJxCt26PrO6/PYMp6yM2jlTik4MZWbaKpiuvJfXcEynZdn+tpzxKSCshA1bGJ1QSZ
         H/B/+iUEXnv+5FfBcEIUv0egIHMlzTtkc374ox3XDPSOJIIhqkxjT09Fl8EFOHRLo4OK
         7A1IynxBhQwDC5RjE6OriZsnEAEQ6UIjUwImRrTbE2ueD+d2EaPVALVNJxCDWla90ec/
         5f+dOnKQQaswIR9TBlyr3wlkwkJ4uWT79FFkH1wgCD2Lq5jBPWh3AasM3Bp6pvxgVdXC
         3NTBNYCFHb44Thimdgmj4JpcLMTfViSKXvsyNCwIHsb2Eo30oYAufKLzkfUUoLl1Ddvr
         IJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336069; x=1792940869;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSi/6elR2fChgfiMMkLEEDEp8no+iOPKUesgm4ZlxmQ=;
        b=wS895zKfmiGtUwUmj+YoDmezkWUdmAiH9PXEt44n1vxwcfXTtB1oWPygCcp1/lOngw
         aQ7YKZP93DhJDPhPkvkrp3GU/BeMtCrB6er2/oBqSKu2/ClODR3TkHfJzj/HZVP1Tlm3
         INYncH2OuI+lUPo+n5I1F8+QlDwTY1IVUA9jJzjLitPCjjHFK0PrY3gxmgWwXmPHVhUm
         nBltzfZ0sZoNpb+OEb+GKGRJUn+NPntdOKTHyri27MubyXcYEFriL9ey9MqHK5ydU+A9
         RcOzDC3y8zq+qensOK1TOPtSq10gcckr7QbIsHOfHr5QB4GUeCwiBpaD3twsOKdM5m/m
         +W/Q==
X-Gm-Message-State: AFq9FYKLaAcwdg4420nO9gdwg14NZ558HPOi7fOeLC5WArumbzdwP2yL
	5uUhWcr33izahlr1rLn2bIebUeo0U+wJnGJdjJu2hPQ5XAopjapQ3tx3d/X5Kg==
X-Gm-Gg: AYBFou0IUnnGuUjoLYa5CqpvxKnMtML/7gszY8rQxhq78fFVXRNRRaXECH7rxrdHKH7
	uVNV9G5xp/uEL41uJ6ANbuzQbxuqFyyml0hTeEf2ivFi0dqlu/EEDLgeN7w+7905mt+OHAOqL+F
	rnGEO5wT+FEoCS6ruc2r/3IIJ9s2DnIChjUN8IB67tcpZUIvlRWmR+moPiXRS1Se9O4txxIK2jM
	9Rm8bDGP6rwLxB2x14jW9a/fl/2bCHE/84iY3MQT24igjtzHgofvW4KKygaWNFafFmDCvagJmv6
	7prP3Gns65rUG4D2RXBElMPV1yD6NvDinjp93J8SCJL1bNSpjgwN0vi331seC3QkvyKJP5k13M6
	+9g5bWLGT8F7sd7UuWK7+qj99X8TolzccyrHwi1tHzzHrA74t0tYzKzTE4fSkFClpdH3oryDbR6
	PJ2iEIYS8FpWNr4Aek5E2h/Hla+sjdSGzNV+VQVmgpqgywGQlND6KS8kK4s7QjofDOGYB5d3DVw
	egS9qF+kDnP
X-Received: by 2002:a05:7300:dd49:b0:35d:800:6344 with SMTP id 5a478bee46e88-3619ea243b4mr7477226eec.4.1792336069356;
        Sun, 18 Oct 2026 08:07:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm41605875eec.28.2026.10.18.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:48 -0700 (PDT)
Message-Id: <8a6255016b4c9964a0358049293e73c5b3cbdb85.1792336066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:41 +0000
Subject: [PATCH v3 1/6] Cygwin: pty: restore foreground input routing after
 exec
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On the 3.6 branch, a native background program can leave PTY input
routed to the native console while the foreground Cygwin process calls
`exec()` to start `vim.exe`. At that moment, the PTY can still be in
canonical mode. The application then switches to raw mode and sends
terminal queries before its first read, but the replies can remain on
the native input path, leaving the queries unanswered.

Therefore, let's restore foreground input routing during `exec()`, even
when the PTY is still canonical, rather than waiting for the first read.
The existing debugger-recovery handover can do this once the attachment
mutex has been reopened.

Note that this logic must be careful to keep the `disable_pcon` mode
working as-is.

Addresses: https://github.com/git-for-windows/git/issues/6403
Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Assisted-by: GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc           | 45 ++++++++++++++++++-------
 winsup/cygwin/local_includes/fhandler.h |  1 +
 2 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c5081bcaf..e05d7ba5b 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1120,18 +1120,7 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 	  mutex_timeout = INFINITE;
 	  if (isHybrid)
 	    {
-	      WaitForSingleObject (input_mutex, mutex_timeout);
-	      if (get_ttyp ()->getpgid () == myself->pgid
-		  && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
-		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
-		{
-		  acquire_attach_mutex (mutex_timeout);
-		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-				  input_available_event,
-				  input_transferred_to_cyg);
-		  release_attach_mutex ();
-		}
-	      ReleaseMutex (input_mutex);
+	      fixup_input_state_for_cygwin_app ();
 	      if (get_ttyp ()->master_is_running_as_service
 		  && get_ttyp ()->pcon_activated)
 		/* If the master is running as service, re-attaching to
@@ -2605,7 +2594,11 @@ void
 fhandler_pty_slave::fixup_after_exec ()
 {
   if (!close_on_exec ())
-    fixup_after_fork (NULL);	/* No parent handle required. */
+    {
+      fixup_after_fork (NULL);	/* No parent handle required. */
+      if (get_ttyp ()->pcon_activated)
+	fixup_input_state_for_cygwin_app ();
+    }
 
   /* Hook Console API */
 #define DO_HOOK(module, name) \
@@ -4595,3 +4588,29 @@ fhandler_pty_slave::replace_nat_handles (HANDLE new_input, HANDLE new_output)
   CloseHandle (orig_input_handle_nat);
   CloseHandle (orig_output_handle_nat);
 }
+
+void
+fhandler_pty_slave::fixup_input_state_for_cygwin_app ()
+{
+  DWORD wait = WaitForSingleObject (input_mutex, mutex_timeout);
+  if (wait != WAIT_OBJECT_0 && wait != WAIT_ABANDONED_0)
+    {
+      termios_printf ("input fixup mutex wait returned %u", wait);
+      return;
+    }
+  if (get_ttyp ()->getpgid () == myself->pgid
+      && GetStdHandle (STD_INPUT_HANDLE) == get_handle ()
+      && get_ttyp ()->pty_input_state_eq (tty::to_nat))
+    {
+      wait = acquire_attach_mutex (mutex_timeout);
+      if (wait == WAIT_OBJECT_0 || wait == WAIT_ABANDONED_0)
+	{
+	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+			  input_available_event, input_transferred_to_cyg);
+	  release_attach_mutex ();
+	}
+      else
+	termios_printf ("input fixup attach wait returned %u", wait);
+    }
+  ReleaseMutex (input_mutex);
+}
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 70c2270fa..b69a358f6 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2541,6 +2541,7 @@ class fhandler_pty_slave: public fhandler_pty_common
   void setpgid_aux (pid_t pid);
   static void release_ownership_of_nat_pipe (tty *ttyp, fhandler_termios *fh);
   void replace_nat_handles (HANDLE new_input, HANDLE new_output);
+  void fixup_input_state_for_cygwin_app (void);
 };
 
 #define __ptsname(buf, unit) __small_sprintf ((buf), "/dev/pty%d", (unit))
-- 
cygwingitgadget

