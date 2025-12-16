Return-Path: <SRS0=XNg2=6W=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 0DAD04BA2E04
	for <cygwin-patches@cygwin.com>; Tue, 16 Dec 2025 08:39:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0DAD04BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0DAD04BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765874396; cv=none;
	b=HgiXD8A8I6EffMtfVh3ZLZfA2dEnJMrKzv1lc1hCfKSYnsLjG71p9AWtLOpjZT9aWgmKJinfJmqDVlNVTpSaH0Vk4hF/0BF7dIW0SFQwtOrM06rzD1+Y39ip+NfDvipQ6zSnJ9rqNwK/gBQRNsiZL1tI8OflClEzVtrX9Zvv1FY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765874396; c=relaxed/simple;
	bh=7oUdBQofKr54pXNFH982SRx2zZuJiwd9t1JnxW8zPRU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=cTJGFNowlCo0n/gZjVvvQ2OU1YE6J5p2JFeq8s01uZW0Cej/isJWjzy5XxIyrJ/MntJhA2dvXPNTPQ+HIahRTFMhdPVjJLugFolFUaJmyryFc2tiumk78BEczONjFuZInnIW6J/0cmq6ZnqXaBgtMR+o+wxpfhnWQeB6awUgIM0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DAD04BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SMQtDeUK
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251216083953986.GBPR.36235.HP-Z230@nifty.com>;
          Tue, 16 Dec 2025 17:39:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: termios: Follow symlink in is_console_app()
Date: Tue, 16 Dec 2025 17:39:31 +0900
Message-ID: <20251216083945.235-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765874394;
 bh=SNdYO4joW6N9/73vGvKpqWcuN4oqTVBCGJvp+eHZTc8=;
 h=From:To:Cc:Subject:Date;
 b=SMQtDeUKAfLVQDpzbWpphB/h6MU6ect3OzTKVrLuqnuBXM1y5mAc+w9y1CimmIKEgTJ087VU
 GlzeP2YHjtQ3skjvj/uVoT6a223C9tEoBUB8J5BMgsScqzqTjZGbPmBRpxYmRKdmy+4SCl80aP
 fEhzhsaXb6DJV8yWDfQ2aSLXofx8Hm025Ymqqq2lC8qMZkE43fjVZw5JUpz7j68tde1FGPlvda
 s7isYUBQT2VzFY7NCO/JyTnX0eCDspVNR+eCHuCMKfi2aMRfELBhhcWJT7Z2IvupHSl41kp7yo
 NEpTEWau4gyv5RoxXJRDYZZDAhRrpm2aA5Gg3rj5gvMTRaDA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit f74dc93c6359, WSL cannot start by distribution name
such as debian.exe, which has '.exe' extention but actually is a symlink.
This is because is_console_app () returns false for that symlink due
to open-failure. This patch fixes the issue using PC_SYM_FOLLOW option
in path_conv.

Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc       | 19 ++++++++++++++-----
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 19d6220bc..ff6c06015 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -702,10 +702,19 @@ fhandler_termios::fstat (struct stat *buf)
 }
 
 static bool
-is_console_app (const WCHAR *filename)
+is_console_app (path_conv *pc)
 {
+  const WCHAR *native_path = pc->get_nt_native_path ()->Buffer;
+  if (pc->issymlink ())
+    {
+      UNICODE_STRING upath;
+      RtlInitUnicodeString (&upath, native_path);
+      path_conv target (&upath, PC_SYM_FOLLOW);
+      native_path = target.get_nt_native_path ()->Buffer;
+    }
+
   HANDLE h;
-  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
+  h = CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
   char buf[1024];
   DWORD n;
@@ -716,7 +725,7 @@ is_console_app (const WCHAR *filename)
   IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
   if (p && (char *) &p->OptionalHeader.DllCharacteristics <= buf + n)
     return p->OptionalHeader.Subsystem == IMAGE_SUBSYSTEM_WINDOWS_CUI;
-  wchar_t *e = wcsrchr (filename, L'.');
+  wchar_t *e = wcsrchr (native_path, L'.');
   if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
     return true;
   return false;
@@ -755,7 +764,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *varg)
 
 void
 fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
-				       const WCHAR *runpath, bool nopcon,
+				       path_conv *pc, bool nopcon,
 				       bool reset_sendsig,
 				       const WCHAR *envblock)
 {
@@ -794,7 +803,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
 	    ptys->setup_locale ();
 	  }
     }
-  if (!iscygwin && ptys_primary && is_console_app (runpath))
+  if (!iscygwin && ptys_primary && is_console_app (pc))
     {
       if (h_stdin == ptys_primary->get_handle_nat ())
 	stdin_is_ptys = true;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 0de82163e..d2d724fb7 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2036,7 +2036,7 @@ class fhandler_termios: public fhandler_base
     spawn_worker () :
       ptys_need_cleanup (false), cons_need_cleanup (false),
       stdin_is_ptys (false), ptys_ttyp (NULL) {}
-    void setup (bool iscygwin, HANDLE h_stdin, const WCHAR *runpath,
+    void setup (bool iscygwin, HANDLE h_stdin, path_conv *pc,
 		bool nopcon, bool reset_sendsig, const WCHAR *envblock);
     bool need_cleanup () { return ptys_need_cleanup || cons_need_cleanup; }
     void cleanup ();
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 71add8755..9c062d58f 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -579,7 +579,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 
       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
-			       runpath, no_pcon, reset_sendsig, envblock);
+			       &real_path, no_pcon, reset_sendsig, envblock);
 
       /* Set up needed handles for stdio */
       si.dwFlags = STARTF_USESTDHANDLES;
-- 
2.51.0

