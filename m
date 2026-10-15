Return-Path: <SRS0=koVj=IF=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
	by sourceware.org (Postfix) with ESMTPS id 89CCD4BA2E2C
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:45:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 89CCD4BA2E2C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 89CCD4BA2E2C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::c2b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792050305; cv=none;
	b=k0HaAyBUSyp9CRQO6EmH82UIceE7Q/XCyyY1YIrbvFf5VcqlGIDOlBa8xZGwYaG+7Jzhr7Q5Rzpp0Oa8V5H23+wME1aUXou3dFe6AEr/tRNOF8ZJbU2ZadLh9nYNcSiUQZrTK1i6jwwMmFqzQw1D1fqoHI/2GTTU+4R50pLZ0vE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792050305; c=relaxed/simple;
	bh=aQCspZarMVnldIb783+Hj19l0rVL4d3Duuo3a7Dr2XI=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=h67Il8KMbIOyS8Wpsr83scxQ16hRLZzIAoVmbIAG+8phjigYI+GpYbxhWZXLmhXngZJiwZDBu2s77xa4aLp8ZT8GNIvk1DjcGqLx5UOCa8sn+lDcYO/FaGrnDzUBw7/rF8/ljdtwLh8sQRaRrjBGvyV8Yshu+Fe5V7uupCZ/7Tc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kNbBa5mX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 89CCD4BA2E2C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kNbBa5mX
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-6d68de53053so2115047eaf.0
        for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050305; x=1792655105; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NC4P3FnLuFJyCtH4sdKrYKI8FPXHeVYjAc7Qajh6eUM=;
        b=kNbBa5mXr/LCk7tPKOTI0eNoL1cTkWjsqkpc7+gw76OESLRl9JvsCnucs7jp3xWv6W
         cZhSxQ+3mBhyJkBVpz+Via58Ov8TRo4Ef7BVy//3fzPazfxXBUyRsiBNAvIWl4cnVIRV
         TsOiW2Q0sY4dgLOsoSzAE7ab5Fd253yh9QGSaF66nNYxYkbkVLtF+6UaLjh/yuUBMK5k
         zXDH1F7Aa0/WW3QDWLzsqqXudn7WW7JocNnAajx9BvUmSrlIRe3nfWd58yU8IRdM+xub
         3yMeq14mnPuSSHtEHfhduPOanUR8ZD8XNCZbjwSDXQkYmdpGoKa6dk36cQyfWlNfKZq3
         Lqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050305; x=1792655105;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NC4P3FnLuFJyCtH4sdKrYKI8FPXHeVYjAc7Qajh6eUM=;
        b=tg5LncIpRlPlGjPgxZD63vWPULYfbiJfcuIWcl1tzLcoqLCdftQDbUN1P2zRHZcHVg
         cLfkK6KhmQEhv8/dET7e0VUCJN/2J7Qeh97KP0xz7Pqgut6I5QdJSONtGVHqx5UkwIT8
         O+NkJtcl9s+ItgXgPY9WV+nhcg6hVX1dwuxp5AqhVgF3n157w3ocsI9Jnm4S27ofUGBH
         dgBo73HV6IB+ozJrbLUdgPJF3tSDOu/56oq12VQkne9aqnnXfOJ2nj26Uv+61OWBAp2d
         MYVgHSnN2eiHaLQ4wPsSx2hef2TGlmALQ47J0dMA77gm0SDe0FSmAo+T+Qqi/riidlcP
         kwSg==
X-Gm-Message-State: AFq9FYIoQo/U6NKRhK4hx8/Y6FIq9r0it33wTznY2Dn1ntBxPOhwL5hm
	hzmZnAaeVz7esZaz3+VkAfTyGrpqpg5gMgFfg6avkGUNpvTI1PLS95WwB25gO63ldCM=
X-Gm-Gg: AYBFou1rZ+b4hMUkJUGlUfWvhI7UzHLPwTyl8S69eUOf6R8rQoMcabzqO0SqepkpVNq
	UDkH88KapNAkepQ0+wWezh57CAKGsa67CtINfh6WEA8zNIjvaE6qLjw/CHtguaLgho4O3JzS65u
	qJGW8nKXLqhAv18LmPa40AUmsZv3Y9oWZJu0s69vg5KEBJEP9lzXF0LstbfuEFosIXSbYEKK3/e
	a2UzT1UOvGqrZpNoS7tP/CKjcZiuH62/Gdmjrhyp+kBuI788UcA9t1KaH/RG/2fWjnB58lai27T
	6IfTOmBb1274Sauc2mXBC/vfwDPAO+/VfwYUkiZLLnaGXbp7q5D8TRLKYWPuk4I1itbrQd1C7jH
	9blauVKkk0Izd97BNCavW+WuDkorKN5Zw6ggToMjA7M0dHPSh27anBtQui9MPM92MpCje/nXUR6
	s9GamB2gNMQaN9Jicxt7lvDWTdVqDbSwZ4K5++Uomjl/bkl6F6TUrANX9FYJsluqQsgFzX9zMjL
	232
X-Received: by 2002:a4a:ee06:0:b0:6dd:3105:1f8c with SMTP id 006d021491bc7-6ef113579c2mr11752337eaf.80.1792050304721;
        Thu, 15 Oct 2026 00:45:04 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.123.176])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6fe33486f5dsm2000315eaf.14.2026.10.15.00.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:03 -0700 (PDT)
Message-Id: <7f0615fc887114a0ec6112f0204dc6ee0d09086f.1792050298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 07:44:54 +0000
Subject: [PATCH v2 1/5] Cygwin: pty: restore foreground input routing after
 exec
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

Addresses: https://github.com/git-for-windows/git/issues/6403
Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Assisted-by: GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc           | 44 +++++++++++++++++--------
 winsup/cygwin/local_includes/fhandler.h |  1 +
 2 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index c5081bcaf..19e12c274 100644
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
@@ -2605,7 +2594,10 @@ void
 fhandler_pty_slave::fixup_after_exec ()
 {
   if (!close_on_exec ())
-    fixup_after_fork (NULL);	/* No parent handle required. */
+    {
+      fixup_after_fork (NULL);	/* No parent handle required. */
+      fixup_input_state_for_cygwin_app ();
+    }
 
   /* Hook Console API */
 #define DO_HOOK(module, name) \
@@ -4595,3 +4587,29 @@ fhandler_pty_slave::replace_nat_handles (HANDLE new_input, HANDLE new_output)
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

