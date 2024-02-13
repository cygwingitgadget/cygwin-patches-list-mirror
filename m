Return-Path: <SRS0=edmR=JW=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0015.nifty.com (mta-snd00013.nifty.com [106.153.226.45])
	by sourceware.org (Postfix) with ESMTPS id 9AB6A385829D
	for <cygwin-patches@cygwin.com>; Tue, 13 Feb 2024 14:31:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9AB6A385829D
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9AB6A385829D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.45
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1707834698; cv=none;
	b=OGHdIv2mDHaxXjHiM4E1wwF8wGhgw8lIeipmQyZ5l/Zdn6omkSdvhxScGs1y7QqH34AeECpkXnfgVPNrzfGqZ4YRC40VgdQ28rQxqxCcTKa2qjvvlP9Gk9v5GBdtdwyJgex61Dg2wESjGBl8R0xTswpJe0OZKG6IhB/VrWZ2KYs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1707834698; c=relaxed/simple;
	bh=5hbpLo/Biboo+6Qv5pU7w+ji6aNKX0G8r/Lu7BseViI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=w8yPeCRJljuTyOO7zi+K3elcyfQMuey3GQLTYKAsBeYIHdHu4ZJ5uP1phO41Uu0XELs3X00jYN0p1cGObs/EOWg5a/bvOmi2MoT21a8kcl+eUmtsGnggc73zbrxP4gwANgXsInTvWUbxSTefRmwiIUyGzqL+T2AAru/UxJxNKrg=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0015.nifty.com with ESMTP
          id <20240213143133371.OEQ.14278.localhost.localdomain@nifty.com>;
          Tue, 13 Feb 2024 23:31:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Make VMIN and VTIME work.
Date: Tue, 13 Feb 2024 23:30:54 +0900
Message-ID: <20240213143104.1899-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, VMIN and VTIME did not work at all. This patch fixes that.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 26 ++++++++++++++++++--------
 winsup/cygwin/release/3.5.1       |  2 ++
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 1c8d383cd..b0907eb31 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1131,10 +1131,14 @@ fhandler_console::read (void *pv, size_t& buflen)
 
   push_process_state process_state (PID_TTYIN);
 
-  int copied_chars = 0;
+  size_t copied_chars = 0;
 
-  DWORD timeout = is_nonblocking () ? 0 : INFINITE;
+  DWORD timeout = is_nonblocking () ? 0 :
+    (get_ttyp ()->ti.c_lflag & ICANON ? INFINITE :
+     (get_ttyp ()->ti.c_cc[VMIN] == 0 ? 0 :
+      (get_ttyp ()->ti.c_cc[VTIME]*100 ? : INFINITE)));
 
+read_more:
   while (!input_ready && !get_cons_readahead_valid ())
     {
       int bgres;
@@ -1157,6 +1161,11 @@ wait_retry:
 	  pthread::static_cancel_self ();
 	  /*NOTREACHED*/
 	case WAIT_TIMEOUT:
+	  if (copied_chars)
+	    {
+	      buflen = copied_chars;
+	      return;
+	    }
 	  set_sig_errno (EAGAIN);
 	  buflen = (size_t) -1;
 	  return;
@@ -1204,19 +1213,20 @@ wait_retry:
     }
 
   /* Check console read-ahead buffer filled from terminal requests */
-  while (con.cons_rapoi && *con.cons_rapoi && buflen)
-    {
-      buf[copied_chars++] = *con.cons_rapoi++;
-      buflen --;
-    }
+  while (con.cons_rapoi && *con.cons_rapoi && buflen > copied_chars)
+    buf[copied_chars++] = *con.cons_rapoi++;
 
   copied_chars +=
-    get_readahead_into_buffer (buf + copied_chars, buflen);
+    get_readahead_into_buffer (buf + copied_chars, buflen - copied_chars);
 
   if (!con_ra.ralen)
     input_ready = false;
   release_input_mutex ();
 
+  if (buflen > copied_chars && !(get_ttyp ()->ti.c_lflag & ICANON)
+      && copied_chars < get_ttyp ()->ti.c_cc[VMIN])
+    goto read_more;
+
 #undef buf
 
   buflen = copied_chars;
diff --git a/winsup/cygwin/release/3.5.1 b/winsup/cygwin/release/3.5.1
index 715fcf74d..e041f98f3 100644
--- a/winsup/cygwin/release/3.5.1
+++ b/winsup/cygwin/release/3.5.1
@@ -16,3 +16,5 @@ Fixes:
 - Fix handle leak in pty master which occurs when non-cygwin process
   is started in pty.
   Addresses: https://github.com/msys2/msys2-runtime/issues/198
+
+- Fix the problem that VMIN and VTIME does not work at all in console.
-- 
2.43.0

