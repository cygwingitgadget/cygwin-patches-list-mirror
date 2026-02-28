Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id B98324BA23FA
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:03:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B98324BA23FA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B98324BA23FA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269407; cv=none;
	b=ZXg+Hi2BK/QyS2uzMieybhAeCaz+2E7PGiwkwaUbK4HdSH44drWdyRrGXT3XNYcKPE1vAQd+4P+Gff4XBfkO6XdU1MnP30My1g5GdWmPo0ZEClpkpYb0XmvV8T+ISAkfteU9fQPAr6vwyn7WHlliIGyAO4vf8c0TfsggNrE+++s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269407; c=relaxed/simple;
	bh=0zuAOyKbbSmgKQ3FIjf3K8mqlxqoVaRKgn39LHLrItA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=faBW1Ju5aBFGPZM07WR9uZe1LZWdLlqbm5H34VYmBDz7e2uVA5SqDrEgiUHAd5mHaU+jOKmbwMoPVMidbN5uB5/e0PxvEzckXUlYpoqAaZflOj1lGxXQyYNjObpe5hRt1ZOqKFQBXZnrFNEwwW/Hr6zHMYN19e7Sr9xMOxQkkSw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B98324BA23FA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZdBPV3Ya
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260228090324840.YDYN.127398.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:03:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 2/4] Cygwin: pty: Update workaround for rlwrap for pseudo console
Date: Sat, 28 Feb 2026 18:02:51 +0900
Message-ID: <20260228090304.2562-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269404;
 bh=2yQYwt31ulRfehIQfYWetd2OTUNfF2j1zsEf57sVxCQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZdBPV3Yan3Mmn0eOBBNf9si+EfxYbAECCJV+NGaqSZRUjvTQOyU+MAQPxPA2o1Vv4Sa/V/MT
 7raoZeeycZ15DV3iW/bRGiUJ5RxcmQ1n+doDJnNEHd11hky2zKPQne+ubhAWKn0XrK6udl0Dmq
 ySn0xY9CcajaSjpxBCSNUZK0v71UJh18nvnz2NENJ04znpLXJHW2DN+40OfIHcxZeXADu15t4v
 hes4Lndz1QD7G9kCVEynYtiY1GgUuceeDDTf8F9V+eP3TuKvL5D2TYO+Oav2Tj8sNhHhbEuTJC
 DWVmLd1RFlRhXLEJmBbGQqI94twCB8krKhckw+VNf5aci51w==
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In tcgetattr(), the conventional workaround for rlwrap v0.40 or later
is not work as expected with OpenConsole.exe for some reason. This
patch update the workaround so that it works even with OpenConsole.exe
by rebuilding tcgetattr responce reffering the corrent console mode
instead of just overriding it depends on pseudo console setting up
state.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 86 ++++++++++++++++++++++++++++-------
 1 file changed, 70 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index fac4ae357..7366eea09 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1737,18 +1737,48 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
 {
   *t = get_ttyp ()->ti;
 
-  /* Workaround for rlwrap */
-  cygheap_fdenum cfd (false);
-  while (cfd.next () >= 0)
-    if (cfd->get_major () == DEV_PTYM_MAJOR
-	&& cfd->get_minor () == get_minor ())
-      {
-	if (get_ttyp ()->pcon_start)
-	  t->c_lflag &= ~(ICANON | ECHO);
-	if (get_ttyp ()->pcon_activated)
-	  t->c_iflag &= ~ICRNL;
-	break;
-      }
+  /* Conventional workaround for rlwrap v0.40 or later is not work
+     as expected with OpenConsole.exe for some reason. The following
+     workaround is perhaps better solution even for apps other than
+     rlwrap under pcon_activated mode. */
+  if (get_ttyp ()->pcon_activated)
+    {
+      DWORD mode = ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      t->c_lflag &= ~(ICANON | ECHO);
+      t->c_iflag &= ~ICRNL;
+      cygheap_fdenum cfd (false);
+      while (cfd.next () >= 0)
+	if (cfd->get_major () == DEV_PTYM_MAJOR
+	    && cfd->get_minor () == get_minor ())
+	  {
+	    if (nat_pipe_owner_self (get_ttyp ()->nat_pipe_owner_pid))
+	      {
+		DWORD resume_pid =
+		  attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+		GetConsoleMode (get_ttyp ()->h_pcon_in, &mode);
+		resume_from_temporarily_attach (resume_pid);
+		break;
+	      }
+	    HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					     get_ttyp ()->nat_pipe_owner_pid);
+	    HANDLE h_pcon_in;
+	    DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+			     GetCurrentProcess (), &h_pcon_in,
+			     0, FALSE, DUPLICATE_SAME_ACCESS);
+	    DWORD resume_pid =
+	      attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+	    if (!GetConsoleMode (h_pcon_in, &mode) && get_ttyp ()->pcon_start)
+	      mode = 0;
+	    resume_from_temporarily_attach (resume_pid);
+	    CloseHandle (h_pcon_in);
+	    CloseHandle (pcon_owner);
+	    break;
+	  }
+      if (mode & ENABLE_LINE_INPUT)
+	t->c_lflag |= ICANON;
+      if (mode & ENABLE_ECHO_INPUT)
+	t->c_lflag |= ECHO;
+    }
   return 0;
 }
 
@@ -2476,11 +2506,35 @@ int
 fhandler_pty_master::tcgetattr (struct termios *t)
 {
   *t = cygwin_shared->tty[get_minor ()]->ti;
-  /* Workaround for rlwrap v0.40 or later */
-  if (get_ttyp ()->pcon_start)
-    t->c_lflag &= ~(ICANON | ECHO);
+
+  /* Conventional workaround for rlwrap v0.40 or later is not work
+     as expected with OpenConsole.exe for some reason. The following
+     workaround is perhaps better solution even for apps other than
+     rlwrap under pcon_activated mode. */
   if (get_ttyp ()->pcon_activated)
-    t->c_iflag &= ~ICRNL;
+    {
+      t->c_lflag &= ~(ICANON | ECHO);
+      t->c_iflag &= ~ICRNL;
+
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      HANDLE h_pcon_in;
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &h_pcon_in,
+		       0, FALSE, DUPLICATE_SAME_ACCESS);
+      DWORD resume_pid =
+	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+      DWORD mode = ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      if (!GetConsoleMode (h_pcon_in, &mode) && get_ttyp ()->pcon_start)
+	mode = 0;
+      resume_from_temporarily_attach (resume_pid);
+      CloseHandle (h_pcon_in);
+      CloseHandle (pcon_owner);
+      if (mode & ENABLE_LINE_INPUT)
+	t->c_lflag |= ICANON;
+      if (mode & ENABLE_ECHO_INPUT)
+	t->c_lflag |= ECHO;
+    }
   return 0;
 }
 
-- 
2.51.0

