Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 4241D4BA2E1C
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 02:27:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4241D4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4241D4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766111256; cv=none;
	b=sHzn8W/59qVIkYf73xw6bAHfkvbltPYKMlgIVZmBCFQKeqqJn30HSxZV/GV7xQyWe5d4p/fmrIVIfjRpAXZmleKnJcWhoVuB0XZdSjmv2gGu0nQjIDLzLu8424zY8eQsA9Lb3FYfwG5ejIPVxR7k/ipMpFJVetxLgixE+VHM7tk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766111256; c=relaxed/simple;
	bh=CbtFx9Tkun8nG/tKZB/jvaylVBtHHTzLQ5qLbfRAtwQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Zu5whmmPaOuWeEIgIvZBICOSQSN9cmUEZJWdnQhK1o3d1i73CahKUvC7ifh67INCtNy+Vj3wiDkIAwaEibQFJ8raTirxVfMMY2EuWqXV32ha+K18lFJfxVqqAEMhvchRiAV8tVYaAS+PsyCtL0MEkszyzrYWI/oJr/ju7UXG/qQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4241D4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ddpbkfGi
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219022734354.VHUJ.116672.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 11:27:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v5 5/6] Cygwin: termios: Change argument of fhandler_termios::spawn_worker()
Date: Fri, 19 Dec 2025 11:26:38 +0900
Message-ID: <20251219022650.2239-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
References: <20251219022650.2239-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766111254;
 bh=rx4CoxjHYCdTfE0KprpoW3TzYMTp0sJck1D2jJk4zoU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ddpbkfGiml4RUiFANXHAZNMuI2SnT6GnbUfCB8gScQeJBTMg7CfyvABTsjTdj47eM3iLEiZ6
 nRuz4Eq5BvJxLcRQVoQUKQp0X4xePq6KcbKiz/t3dLs8kB89BRT+URRNBZn+o21qKCdWXmfIIf
 n0ZS9FIYkUgP0bZ4QmuSn9LXGFwQQ2ziBlXrYt3NY3ZtltzwQxF9Jnyg4TVoN/V6Rb0OZNu6bK
 QIQHmICmiBWv1orTsF9JhiJKx0QykrFP6jK5Hxu9rQNZtbq+OExuy4lfBcKh2nPsEDFMAnqZFe
 zQFUlcyPJhajhY1b/E9Md/h2mRH9al0lwG2Qeq3JdvUbSD4Q==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch changes the argument for passsing a path to an app
to fhandler_termios::spawn_worker() from const WCHAR *runpath
to path_conv &pc. The purpose of this patch is to prepare for
a subsequent patch, that is intended to fix a bug in executing
Microsoft Store apps.

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc       | 14 +++++++++-----
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index f99ae6c80..63b8f63fc 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -702,13 +702,17 @@ fhandler_termios::fstat (struct stat *buf)
 }
 
 static bool
-is_console_app (const WCHAR *filename)
+is_console_app (path_conv &pc)
 {
-  wchar_t *e = wcsrchr (filename, L'.');
+  tmp_pathbuf tp;
+  WCHAR *native_path = tp.w_get ();
+  pc.get_wide_win32_path (native_path);
+
+  wchar_t *e = wcsrchr (native_path, L'.');
   if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
     return true;
   HANDLE h;
-  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
+  h = CreateFileW (native_path, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
   if (h == INVALID_HANDLE_VALUE)
     return true;
@@ -761,7 +765,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *varg)
 
 void
 fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
-				       const WCHAR *runpath, bool nopcon,
+				       path_conv &pc, bool nopcon,
 				       bool reset_sendsig,
 				       const WCHAR *envblock)
 {
@@ -800,7 +804,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
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

