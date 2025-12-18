Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 6BAAF4BA2E25
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:29:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6BAAF4BA2E25
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6BAAF4BA2E25
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042946; cv=none;
	b=nQjA9qPH1yCQxG9POgf/zFNUsmOKq4h/rUNrulH1vcXiP+iCiv7twtak59DBFB96aPE18EoGUBo6nUg+5sm/0VOTcQhAP/Q4VivTPb2A0HEPF2AFfI7k2w2CI9EHQpciIKuDS9kLoRcd11dFbYTFqjMUjYXUxuw521VcgGXFx8s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042946; c=relaxed/simple;
	bh=DxETjF9TeTjvtLAZgogDrgGtMbfuLNsXUVM2IH3EtQs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=FAfcpcq5cAmBxdIkyiqA3FcTHe9dvsVWOjpQkWn6eUAepgKg5wePYsESTbFVnyH+NJ+U1whJ3N3focOO34uDUrm0lq5lRkx/DhQmYw/tzDsb37FXPnsAdroFt2lQsiqK29EovaFdh4x/USF3F7VpwsHNnK0BvT3lHt+xy+Q73ZQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BAAF4BA2E25
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=I3S7RIIj
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20251218072903386.LNYC.36235.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:29:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4 5/5] Cygwin: termios: Handle app execution alias in is_console_app()
Date: Thu, 18 Dec 2025 16:27:59 +0900
Message-ID: <20251218072813.1644-6-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
References: <20251218072813.1644-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042943;
 bh=SWHb7imXmsN5qxV0ZCGM5k1EomCv0GViWYlWaYfVRqU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I3S7RIIjNYbPsY/WK3RbNpoje9vlcEGR8TiK8A/lhQ2Aic86UQzFsfp0151yGOuloUE4P8Ch
 G729qJ1o+Ri4qU7c7T3N5F7NAVFYYsG2gOrbj8KtGVUHBLwho5/NHEy+c8JvEHBPUNoeoJ32JF
 BkHMno2Er0BFNFihk5+sryA5wbdd5YklGUa0c84c2xP0B4B7SOpdjzLLWu40kPpN1Sm6A/1/Et
 HXgpH3BPzwhB7V0lo9egbSgR3WjT5MAu6AIeDr+V73ZbDYoB8Rw2k/QalPPk0SMUZM9RVs6UT2
 0zTRuhmZVtQp4/w5WXYLz8Mp6Xw2tqM6nfbZYNHyImuc7BBw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

After the commit f74dc93c6359, WSL cannot start by distribution name
such as debian.exe, which has '.exe' extention but actually is an app
execution alias. This is because the commit f74dc93c6359 disabled to
follow windows reparse point by adding PC_SYM_NOFOLLOW_REP flag in
spawn.cc, that path is used for sapwning a process. As a result, the
path, that is_console_app () received, had been the reparse point of
app execution alias, then it returned false for the the path due to
open-failure because CreateFileW() cannot open an app execution alias,
while it can open normal reparse point.  If is_console_app() returns
false, standard handles for console app (such as WSL) would not be
setup. This causes that the console input cannot be transfered to the
non-cygwin app.

This patch fixes the issue by locally converting the path, which is
a path to the app execution alias, once again using PC_SYM_FOLLOW
(without PC_SYM_NOFOLLOW_REP) option path_conv for using inside of
is_console_app() to resolve the reparse point here, if the path is
an app execution alias.

Fixes: f74dc93c6359 ("fix native symlink spawn passing wrong arg0")
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc       | 23 ++++++++++++++++++-----
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 3 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index f99ae6c80..694a5c20f 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -702,13 +702,26 @@ fhandler_termios::fstat (struct stat *buf)
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
+
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
   if (h == INVALID_HANDLE_VALUE)
     return true;
@@ -761,7 +774,7 @@ fhandler_termios::ioctl (unsigned int cmd, void *varg)
 
 void
 fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
-				       const WCHAR *runpath, bool nopcon,
+				       path_conv &pc, bool nopcon,
 				       bool reset_sendsig,
 				       const WCHAR *envblock)
 {
@@ -800,7 +813,7 @@ fhandler_termios::spawn_worker::setup (bool iscygwin, HANDLE h_stdin,
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

