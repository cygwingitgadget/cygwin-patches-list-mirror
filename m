Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 7993B4BA2E32
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:30:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7993B4BA2E32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7993B4BA2E32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765963826; cv=none;
	b=rxR+lAw7B3oEDqEJdDtPpY6w83I/LA1NBrdQjzxaO7HymyPck01PjRjgrO/dLe167OHeTAcFoGzUFpIrQ8OjJmou8LRT/CG6wQK9JQxGdnvMWWUFn1R531Yvw/6Sx+7LcPQLQpqTdpRN1kX4VgEY9F4Aa/PSbL6ZCyO05Co69MQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765963826; c=relaxed/simple;
	bh=6lpfUtxiDTS4h0BG6f0XDENx2C8hdgetEexW048rZ2k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ErXA919oHzRGSeN98PSDHDIJWz3HGMp4CB3YlxHoFli9HFM7op2bPiJi0FS6p1GS/DcdLLdoOHx/YrwycapXLVUmkd7DpOqIMVn36T/vWYeZXy3EC3hX/f7lT/SwHQoF/3Ip+KwL3S4ONwHcXYYpdrNWPfIm1HzKoxFdiXppjeY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7993B4BA2E32
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qM8Ox6UL
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20251217093023638.JYMT.38814.HP-Z230@nifty.com>;
          Wed, 17 Dec 2025 18:30:23 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3 2/2] Cygwin: termios: Handle app execution alias in is_console_app()
Date: Wed, 17 Dec 2025 18:29:55 +0900
Message-ID: <20251217093003.375-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765963823;
 bh=3glUKgxdNYYHmS5HZP5M1gYdmogPsZ0RSAFMVoxlRog=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qM8Ox6ULAIjjvKI1uiUC086IkZwzv0Lq4b7WvDXGnF/Fk0N1OizrKnR1ouCQNb5dVciepz2Q
 WuMhNG6Jk374+UtWqQ1zHCFYR9kIfLNkJhVJwfs4hzloQNAQ83XL9Ak0gkHsIh2K9lwYziE3l2
 hRW0Oq9nCLOPFOHUMPnRD9zkwW4csxANp3VsSxGHFRGIDtHlFa/AP12s25B8FBXM+M5uLsDlK8
 e2FlSV+mL6cFJz30GU/KbMJ5aOdIzvbaoO8qgnNfYkoHy4O4v/3gjP8/am+NSpd/xVLc127Rpo
 nDycPfKAblH0ABnbUm2wz5KTp3xKwYaBGW9MDU7Rn8XXWeOA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit f74dc93c6359, WSL cannot start by distribution name
such as debian.exe, which has '.exe' extention but actually is an app
execution alias. The commit f74dc93c6359 disables to follow windows
reparse point by adding PC_SYM_NOFOLLOW_REP flag in spawn.cc. As a
result, is_console_app () returns false for the app execution alias
due to open-failure because CreateFileW() cannot open an app execution
alias. This patch fixes the issue by converting the path again using
PC_SYM_FOLLOW (without PC_SYM_NOFOLLOW_REP) option in path_conv if
the path is an app execution alias.

Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc       | 21 ++++++++++++++++-----
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 19d6220bc..7fdbf6a97 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -702,10 +702,21 @@ fhandler_termios::fstat (struct stat *buf)
 }
 
 static bool
-is_console_app (const WCHAR *filename)
+is_console_app (path_conv &pc)
 {
+  tmp_pathbuf tp;
+  WCHAR *native_path = tp.w_get ();
+  pc.get_wide_win32_path (native_path);
+  if (pc.is_app_execution_alias ())
+    {
+      UNICODE_STRING upath;
+      RtlInitUnicodeString (&upath, native_path);
+      path_conv target (&upath, PC_SYM_FOLLOW);
+      target.get_wide_win32_path (native_path);
+    }
+
   HANDLE h;
-  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
+  h = CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
   char buf[1024];
   DWORD n;
@@ -716,7 +727,7 @@ is_console_app (const WCHAR *filename)
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
   if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
     return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
-  wchar_t *e = wcsrchr (filename, L'.');
+  wchar_t *e = wcsrchr (native_path, L'.');
   if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
     return true;
   return false;
@@ -755,7 +766,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *varg)
 
 void
 fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
-				       const WCHAR *runpath, bool nopcon,
+				       path_conv &pc, bool nopcon,
 				       bool reset_sendsig,
 				       const WCHAR *envblock)
 {
@@ -794,7 +805,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
 	    ptys->setup_locale ();
 	  }
     }
-  if (!iscygwin && ptys_primary && is_console_app (runpath))
+  if (!iscygwin && ptys_primary && is_console_app (pc))
     {
       if (h_stdin == ptys_primary->get_handle_nat ())
 	stdin_is_ptys = true;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 0de82163e..16f55b4f7 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2036,7 +2036,7 @@ class fhandler_termios: public fhandler_base
     spawn_worker () :
       ptys_need_cleanup (false), cons_need_cleanup (false),
       stdin_is_ptys (false), ptys_ttyp (NULL) {}
-    void setup (bool iscygwin, HANDLE h_stdin, const WCHAR *runpath,
+    void setup (bool iscygwin, HANDLE h_stdin, path_conv &pc,
 		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
     bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
     void cleanup ();
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 71add8755..7d993d081 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -579,7 +579,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
-			       runpath, no_pcon, reset_sendsig, envblock);
+			       real_path, no_pcon, reset_sendsig, envblock);
 
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
-- 
2.51.0

