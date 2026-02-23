Return-Path: <SRS0=vXQ3=A3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e03.mail.nifty.com (mta-snd-e03.mail.nifty.com [106.153.226.35])
	by sourceware.org (Postfix) with ESMTPS id B008C4BA2E16
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:00:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B008C4BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B008C4BA2E16
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771833644; cv=none;
	b=s7/Q64ESqRp1Qv/3H/VXFtZi3cVP9s77PL+x5pc7ftU6+4ZDcdLgyIKzU0i/akua1RxO4GkvTOtfych9WNu+HY47jMaMNPvYd5/wtXd1fMA4XKK7l27xsDOuXd4wDnBTor9QmBrsT1oi/mgShgQSYSmEVylKv/Htua0peHjeKL4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771833644; c=relaxed/simple;
	bh=A+2mofyywQYXagebE/Y3R/Ws/gKxaf6HL6v/jrwKYkE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=AKNqqSlWx6sXaxDuWXDUsl8G6XfV/D0fCqNKmMSL003T5uMK+QpjMvPysDt/lAG5aAJaO+9y3swV+xJ5Jyh/ja25UfA34yjeEPfnH4vNmkpiQUS6HjgGoq1LW6msfw0h/gE/B+P3dwbm6D0vIW3ROuEj8oUM/ll1HlDysuEmEY0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B008C4BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=sRLrRpJ/
Received: from HP-Z230 by mta-snd-e03.mail.nifty.com with ESMTP
          id <20260223080041765.PUIX.110778.HP-Z230@nifty.com>;
          Mon, 23 Feb 2026 17:00:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Discard remnants of win32-input-mode
Date: Mon, 23 Feb 2026 17:00:19 +0900
Message-ID: <20260223080031.320-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771833641;
 bh=iwc9IHNiu7EqbTNrHWhIiX5WgBKKk71f9WVchqWcIVg=;
 h=From:To:Cc:Subject:Date;
 b=sRLrRpJ/39eaXEFJWn1606ZwOvYLErd9JgSXH8aHIBvz8NCP6W9itVGDfLJljW8DI3GR5K6Y
 yJ0bg/FK/QG09bixXzNnR9ry+RgxG8wob8Jup49e3+ytK2y5Rt9V6fX0ebn7UT8sP7C2SWMDpL
 ZOrOgWiaReWcXJHNbDpyQ7+FBE+ljc06QDkkTeqaZYBHeRtzKjwtM7GNaKVURFwpZUcLdwOs5/
 IH/bJQv/UE53xefVp8//PvvwrCI8DOvivgoq0itM0IwD5ySN/GIkY+OTqTKI3TqkEZPKi43XMK
 5xpZ3Vklc7l7VB6PaSmBsVIVwTXOuz2fSEU6hBgxhQZ+S6pw==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windoes 11, some remnants sequences of win32-input-mode used by
pseudo console occasionally sent to shell which start non-cygwin
apps. With this patch, the remnants sequneces just after closing
pseudo console will be discarded.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc      | 11 +++++++++++
 winsup/cygwin/local_includes/tty.h |  1 +
 winsup/cygwin/tty.cc               |  1 +
 3 files changed, 13 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index b30cb0128..b90b2b609 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2504,6 +2504,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       return len;
     }
 
+  /* Remnants of win32-input-mode sequence in pcon_activated mode */
+  bool is_remnants_to_nat =
+    GetTickCount64 () - get_ttyp ()->pcon_close_time < 32
+    && len >= 3 && p[0] == '\033' && p[1] == '[' && p[len - 1] =='_';
+  if (is_remnants_to_nat) /* Discard */
+    {
+      ReleaseMutex (input_mutex);
+      return len;
+    }
+
   /* The code path reaches here when pseudo console is not activated
      or cygwin process is foreground even though pseudo console is
      activated. */
@@ -3947,6 +3957,7 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  /* HeapFree() will be called in ClosePseudoConsole() */
 	  ClosePseudoConsole ((HPCON) hp);
 	  CloseHandle (ttyp->h_pcon_conhost_process);
+	  ttyp->pcon_close_time = GetTickCount64 ();
 	  ttyp->pcon_activated = false;
 	  ttyp->switch_to_nat_pipe = false;
 	  ttyp->nat_pipe_owner_pid = 0;
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 9485e24c5..14b8f0278 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -141,6 +141,7 @@ private:
   xfer_dir pty_input_state;
   bool discard_input;
   bool stop_fwd_thread;
+  ULONGLONG pcon_close_time;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 0c49dc2bd..defd3ead5 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -255,6 +255,7 @@ tty::init ()
   last_sig = 0;
   discard_input = false;
   stop_fwd_thread = false;
+  pcon_close_time = 0;
 }
 
 HANDLE
-- 
2.51.0

