Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	by sourceware.org (Postfix) with ESMTPS id CD6704BA2E11
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:05:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD6704BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD6704BA2E11
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1333
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792335910; cv=none;
	b=aHj0ebUiISoLVdQ932B6gmihuvwSDLiydQJ20EwB6Er45fNL2kQ3S6FIfmKuO+X0l9LHmgmz8PZIqSRh6a4gyWnios0cvrKjMBvA0H0CoQ5rPXyuhhc0mnewpJgI3xNvzVJP4xXRBr3zJhbLvKbMcLo64SdAJML6CBGijgdaQbo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792335910; c=relaxed/simple;
	bh=BX5Cl9eJCh8l5OyknMDmy4ZcVoNBA71H4o3v0jgkw98=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=KdKsyekTuiMvUUEiu9WoHUAcUFZvtlGkTg//xbGOFqBEDeu65359mjd8QO8AscoybxcOoJYs0RdKhuwrf/71pUDls2nRdJz5APG95IhzwVuHrafrrZwoGdpHc6wimtPHmaHpHXXEWhXw71FEDxSolg/IfmhHpEvhOdYhjYXZI8E=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VC2zl2Lj
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD6704BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VC2zl2Lj
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3326077eec.1
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792335909; x=1792940709; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hSi/6elR2fChgfiMMkLEEDEp8no+iOPKUesgm4ZlxmQ=;
        b=VC2zl2LjE8CZJjGen/mklJrvvK3aLZFa/cPoWIeGQ2gVKarSNRpSITf0MJ2RlXz0gr
         SyzF9W2BwyhpjErkD6QRm084DWUKFAq2sAW2A8B5XHAG7my0IMdoCu4IhXrdk6r1SnIu
         OE7jVi/oH6bzZMdIem/P2COHHPyrtlCeLqqJ9c3mHoMZqbpS7wyGLKdo2vx7Gr4JV+vZ
         4g9IdQPh+0/dNPfc4m5ZS2W3lMjNmHEBCSXqcv+NgWCdVwzXC673971XBaAYapeb8KHU
         vWw130qsUdOJu79/t7a/yRq4ngWx2bvURu16JroNDI9z9QbAv4ysASc8oH2x1DBj8TC+
         I9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792335909; x=1792940709;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSi/6elR2fChgfiMMkLEEDEp8no+iOPKUesgm4ZlxmQ=;
        b=YuzlyXUnUXSFrAOzo3kEljkRQHGy/eHX2xGYw8qPC0Hj8HOW7ajqFm7uQgrl6KlxNi
         FjUiOTFRvyoFWkDlRxphdYgyBVnbdUQcjR5Ojqy5VNFLo+P4G9GSPJKtbqx3bkLudKoK
         m8jGxOBovPQr4/bdNjmC3g/4iutDo3vN3RXudElon1PRaTKI1TnSvxU9X6ZmTLooWfiW
         DtL0DJV3rnpq3hPOiLaeutNvmYB6SFML68ejbNiE8MuGmvoInQjFZcGiqqKTNA6T92ux
         sBgoRZOeY6uijWpmMEK/6VgcbSioSNyI+nxYW07lv6bn1+C7FciOSlVhO8ujyfT7HJsl
         rTHA==
X-Gm-Message-State: AFq9FYLYSXEN74LSfVd/aNdcbre0DYnf6TNlDFTlSj+3npITai1tynMo
	r+TXJEA6fq4uJP3Ve4SJCmKd6KZa/LfP4uewF1I1SISnAaye+TScXh80IGi0rw==
X-Gm-Gg: AYBFou1Pb9QLIUgnyESaHXsA29leT4vBQUpXDp+Wz4OOl1ANWp2PdPZYZhJJr8saYzo
	iD5HwTIBwVsMtqfOASymGDTK5JW+lSlfBjH6/guSIotUCViAplunWdGC7nebpH87Na1SErk+ZIp
	oM/0MBMtZ1hxVl7uoE7oAbDCE9mE4QdJV7thUKhRvFYc62u+D0ARjisKftsXWKsdFHftnswz6qK
	D9O3jVkJjQflwW72J7ojnD0y6ggNK9+RtcviwKPDv58Xez6rEu/t/UGWWnuFf8e5uzRgzfT/hrD
	R4a1EpfSTXP+SB1LN2GoefYqQ/OAs3fVvKirQoMlB3jBVivqFecLgLIAL9ROSA4FG76dJuSh2DL
	pMUB/L5JWYyvF+vLIkBkTkYHb5tw31xBIxtW2MYgjrxZ1WyJeiupcgzGHs85YXejCJe4mWgiCDZ
	5vWXglYbkxk2BjaA6SkAgAKjTNxFoZD/7BRFiHWT9ugPdbiWIAr9mhZqpGcFsUD5fSAPQjDyAmw
	w==
X-Received: by 2002:a05:7022:e804:b0:168:6ad8:e89e with SMTP id a92af1059eb24-18514cf2721mr8318309c88.45.1792335908656;
        Sun, 18 Oct 2026 08:05:08 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.247.51])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831919fc14sm27681026c88.6.2026.10.18.08.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:05:07 -0700 (PDT)
Message-Id: <8a6255016b4c9964a0358049293e73c5b3cbdb85.1792335902.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792335902.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792335902.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:04:57 +0000
Subject: [PATCH v3 1/6] Cygwin: pty: restore foreground input routing after
 exec
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

