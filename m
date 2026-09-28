Return-Path: <SRS0=jC8V=HU=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-oo2-x28.google.com (mail-oo2-x28.google.com [IPv6:2607:f8b0:4864:31::28])
	by sourceware.org (Postfix) with ESMTPS id 7F49E4B9DB71
	for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 10:46:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F49E4B9DB71
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7F49E4B9DB71
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:31::28
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790592370; cv=none;
	b=NdhCsQR8mCQ3Q4zCkAc/f9Dep3PorlKKHGD5IE72Fg6he8lt5gEXLuMEMR29++A9VjujFzgLL57q52feX1cxRnoepCLtper16yAAP+0IkmQ3A22KPFAfR0fKi9YnGXojdDzNDVZdcp2tCnTa8i6Lz+BD1oJHKELAMXkyGt32oCU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790592370; c=relaxed/simple;
	bh=PkUSEaRUTPm15uTgZQoqgCP7W9D9wWs17VyDTH5bxMw=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=agHvcvUpvqCfh2cmLanj6bbF6rXzaFLc7ym6B/MF9t2gY3MHn5VwgcgSAS33mIO/c5TDoh/oN0bIu/FAwnZJzfZLB0lpSZ/KZFGS/WA1HKo8RSyYBjij6K7XQm3CNND4obfGmCYFiG/XGylhs+ZUnMHq4shwtNobXA5qh5LVxD8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LppUtwDB
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7F49E4B9DB71
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LppUtwDB
Received: by mail-oo2-x28.google.com with SMTP id 006d021491bc7-6d752864e37so1035535eaf.0
        for <cygwin-patches@cygwin.com>; Mon, 28 Sep 2026 03:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790592370; x=1791197170; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bjzbOk0Jhs7XrF8LKWjeHRIqqkgsUTb/dyqljNCp1Aw=;
        b=LppUtwDBstIOIWcvnLYyxlRdYJnRTIAYQkSmNlGBOVYa+8FZ0SUT9CYMCSpNinmBFa
         0mR+EGdMZ9ZEI3blDzLSDgGblIc5j/JW1Dwu9INtwmFceGTCDcuVbHptp18cNTCBn9Aa
         9kxMUvI1z7igU8Wht8amnkTNG1/chOzrLKTzDtZedMZOa4OV8SOpKZb16JWdZ/dXwUD/
         HwpOVEm8qkkT1uu/ViThuv8fcTHC+HEXZW8uTvvYfzNnfnRxvpRqQO5FjWFHPYzD+e1Q
         pBdkf3jtjnKW89AcgFuEErLcqxcm6VHd5QgU4sI8/sVcf5TTE0UkMZDRdp5ir+HT74GZ
         SWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790592370; x=1791197170;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bjzbOk0Jhs7XrF8LKWjeHRIqqkgsUTb/dyqljNCp1Aw=;
        b=ZTdPhid4t5DDHGFvyPOOc2TQ4SzcgB2VDFngiCQrV15WiUzP8o9mPHxa16HnPtGCDB
         HK5ZjmUKUA6FBb1G7taU4zL93a2GHs4zZdBk6Ky6/1abrZrRYOMc1m/SY822XxWypW42
         7iG1+KDJyFVSoR1gmyeGAZePkimQ4VvpGefHaOhxorL0mlGd+u29s6aoIMLlaAuP4qjq
         Y7lyCHLCBiTm3P6X+a4Nr36pRSo0XfQfpJHXiEGygXw1JU0yubvtcdhLCjis2e64BevD
         7j6yCa965eQC5Vp5+7U6L/CVM80MVbR9VklwUMtdDClFxlAK25g2BQJfOx9vbaSShyZa
         ofZg==
X-Gm-Message-State: AFuF++kNY2kIHhcMoNoR5ruY7O1JJaG554BQJ6M2Pt/RKxR30oqpEYU9
	/8eIUYkCO4aDLlboO1O0Y7fG0P82QuDc8BkkGqkaQnHoonCGjL5T0mTfnRCuqQ==
X-Gm-Gg: AYBFou0Vem4NHmS7HUpdWBVddhWy8li2EFZ+hcF/j3ihdq+DnIRA5QbZqOUMCOxdll9
	ChbtlHeb2LzPHpAPlgOr8XzP5M6rDESUjTub4Al4bJTMlR/jMewxf48PdlvTtMlKFX7lBlfU27y
	CPCWvTV0EO2/F9yZ0X+QAiIlUB0t//gPN6mexlQlp68sp+I5uu1olAPeFyNVQChumu465OH/UEc
	jnOTbFqjq1yf9Fg+HRcL12CxGQj84PGsiD5bqE2VehD5Zy9bR6lpVae/lMXo4nvbRqJqdaYN4Dj
	0eIeBmkSwSOMA831fiWbwsYwtc6BNEZ383t1FkXNfGL7a82RKm42hqvn7sr7Sl1XxOfs6tf9iRI
	hutfmAT4++CawQR9CPesIPv9I2G7e9MgwytY7G9IewxU0NFw1HAEDvCIXf0egsff5IlCo5aj4g9
	lyI37khhSkZHNGZuZQTwaR18nAuMsp/kHf8BYY9ic1PMUVWJAoRCm1iZe16GNtl/FlssMdLoLt4
	A6eue0ZzSzAMg==
X-Received: by 2002:a05:6820:813:b0:6d9:5232:177c with SMTP id 006d021491bc7-6d9523217d8mr2225985eaf.33.1790592369599;
        Mon, 28 Sep 2026 03:46:09 -0700 (PDT)
Received: from [127.0.0.1] ([172.171.13.48])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8802f28b6sm4604764eaf.2.2026.09.28.03.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 03:46:08 -0700 (PDT)
Message-Id: <pull.11.cygwin.1790592366705.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 28 Sep 2026 10:46:06 +0000
Subject: [PATCH] Cygwin: console: Avoid deadlock with app execution aliases
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Christoph Reiter <reiter.christoph@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_ABUSEAT,RCVD_IN_SBL_CSS,RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Christoph Reiter <reiter.christoph@gmail.com>

Calling `winget.exe` through its app execution alias from an interactive
MSYS2 shell can leave the shell hanging after `winget.exe` exits. This
affects all app execution aliases, not only `winget.exe`.

App execution alias handling was introduced in 0631c6644e (Cygwin: Treat
Windows Store's "app execution aliases" as symbolic links, 2021-03-22),
and 6c3d26961d (Cygwin: termios: Handle app execution alias in
is_console_app(), 2025-12-10) taught `is_console_app()` to follow
aliases using another `path_conv`, which allocates cygheap memory.

618eb90fc2 (Cygwin: console: Fix undesired mode change at exit of
non-cygwin apps, 2026-09-19) added a second `is_console_app()` call from
`wait_for_resume_if_necessary()`. Unfortunately, at that point,
`child_info_spawn::worker()` already holds the non-recursive
`cygheap_protect`, so following an alias tries to acquire the same lock
recursively and deadlocks.

Let's avoid running `is_console_app()` under that lock by instead
classifying the executable _once_, in `spawn_worker::setup()`, before
acquiring the cygheap lock, then cache and reuse the result for both PTY
setup and the post-resume wait.

Addresses: https://github.com/msys2/msys2-runtime/issues/372
Fixes: 618eb90fc2 (Cygwin: console: Fix undesired mode change at exit
 of non-cygwin apps, 2026-09-19)
Signed-off-by: Christoph Reiter <reiter.christoph@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    Cygwin: console: Avoid deadlock with app execution aliases
    
    This hang was discovered really quickly after integrating v18 of the
    "Cygwin: console: Fix undesired mode change at exit of non-cygwin apps"
    patch into the MSYS2 runtime. Happily, Christoph Reiter jumped at the
    problem and came up with this patch.
    
    This is somewhat pressing for me, as I need to fast-track this patch
    into Git for Windows' fork of the MSYS2 runtime because Git for Windows
    v2.56.0 is due later today and I want to avoid shipping it with this
    regression. This urgency does not apply to Cygwin, of course!

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-11%2Fdscho%2Favoid-hang-with-app-execution-aliases-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-11/dscho/avoid-hang-with-app-execution-aliases-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/11

 winsup/cygwin/fhandler/termios.cc       | 10 +++++++---
 winsup/cygwin/local_includes/fhandler.h |  5 +++--
 winsup/cygwin/spawn.cc                  |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 423ca9ea1..8f01a8b5e 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -779,6 +779,10 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
   fhandler_pty_slave *ptys_primary = NULL;
   fhandler_console *cons_native = NULL;
 
+  /* This may resolve an app execution alias, which allocates cygheap memory.
+     Do it before child_info_spawn::worker() acquires the cygheap lock. */
+  console_app = !iscygwin && is_console_app (pc);
+
   for (int i = 0; i < 3; i ++)
     {
       const int chk_order[] = {1, 0, 2};
@@ -811,7 +815,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
 	    ptys->setup_locale ();
 	  }
     }
-  if (!iscygwin && ptys_primary && is_console_app (pc))
+  if (ptys_primary && console_app)
     {
       if (h_stdin == ptys_primary->get_handle_nat ())
 	stdin_is_ptys = true;
@@ -852,9 +856,9 @@ fhandler_termios::spawn_worker::is_attaching (DWORD pid)
 
 void
 fhandler_termios::spawn_worker::wait_for_resume_if_necessary
-			      (path_conv &pc, PROCESS_INFORMATION &pi)
+			      (PROCESS_INFORMATION &pi)
 {
-  if (is_attaching (myself->dwProcessId) && is_console_app (pc))
+  if (is_attaching (myself->dwProcessId) && console_app)
     {
       DWORD t0 = GetTickCount ();
       while (GetTickCount () - t0 < 40 && !is_attaching (pi.dwProcessId)
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 465ca2dc3..2f8049a7a 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2033,17 +2033,18 @@ class fhandler_termios: public fhandler_base
     bool ptys_need_cleanup;
     bool cons_need_cleanup;
     bool stdin_is_ptys;
+    bool console_app;
     tty *ptys_ttyp;
   public:
     spawn_worker () :
       ptys_need_cleanup (false), cons_need_cleanup (false),
-      stdin_is_ptys (false), ptys_ttyp (NULL) {}
+      stdin_is_ptys (false), console_app (false), ptys_ttyp (NULL) {}
     void setup (bool iscygwin, HANDLE h_stdin, path_conv &pc,
 		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
     bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
     void cleanup ();
     bool is_attaching (DWORD pid);
-    void wait_for_resume_if_necessary (path_conv &, PROCESS_INFORMATION &);
+    void wait_for_resume_if_necessary (PROCESS_INFORMATION &);
   };
 };
 
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 81be6e17c..37182ecb7 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -762,7 +762,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  DuplicateHandle (GetCurrentProcess (), wr_proc_pipe, pi.hProcess,
 			   NULL, 0, false, DUPLICATE_SAME_ACCESS);
 	  ResumeThread (pi.hThread);
-	  term_spawn_worker.wait_for_resume_if_necessary (real_path, pi);
+	  term_spawn_worker.wait_for_resume_if_necessary (pi);
 	}
 
       if (mode == _P_OVERLAY)

base-commit: 6bee3713a347ac9194f65a5c289f8f9cf2578a45
-- 
cygwingitgadget
