Return-Path: <SRS0=ji6e=BM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id AD1B84BBC0C8
	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 11:39:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AD1B84BBC0C8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AD1B84BBC0C8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773315596; cv=none;
	b=NW3CYdyC0h5Xw509/1MyG/GetS4vdbo2s6DmWc2X262kvAdoxmh1SrIHB549RZTqzvcgD6NZjCIWHEIhLbagKXkp+2zBg7iWg3CuhkwEXEffNkfXh69ZQyd4uXAurDCQs7OM2vODgbjs8hEIBubVrIg+fyWR5YwXnOav+W7Q6A8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773315596; c=relaxed/simple;
	bh=3hbmtdEYKyN8KyZ6YrSzkIp/hAEJVTEQ+VsYQqYS/2U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Fdt2Q7/sXNV8K1DL7ZW9GJLxK5XEe4buZqR1iz9+KdQKaRVyxtWWDUDBjI+maiKNQVgO3mSaLULoryCTq/8JR2PVjed1VfVWzPrUh485I4ghwrV+/QqiOdqwIywxLZ7GusEjCynyBR3CcMllNT+8ZnTXz7pmV6Iwb0so7zFDZfM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AD1B84BBC0C8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hHUcvO61
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260312113953779.XLYO.127398.HP-Z230@nifty.com>;
          Thu, 12 Mar 2026 20:39:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 2/3] Cygwin: pty: Update workaround for rlwrap for pseudo console
Date: Thu, 12 Mar 2026 20:38:56 +0900
Message-ID: <20260312113923.1528-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773315593;
 bh=4hi4aXrLB4IC9eim7WTLWEFHgaBd7oqspbYR+Gv6Bqw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hHUcvO610YigGGf9R4XyycNbe5qyb7VIyvmbmOP6OoOnK7vryTM05ujZDEpDFftzDqrfTOxw
 65MW/Ys8pwKO6k/Hr2VbjhVF5m57LgrakPZJREIXKzqvUivJAlDp1jqZNrKUJWDnkLXgSVLI+q
 0zwzMxGQ87AAr7VlwMhNUSgT8pVPRc0jwiQQg9c8DWPse5bsQiuTFg+BMalwUXz68VqAT4S/1m
 VMsoYV2pd2Y66Ktmf2iF3fPo9qpnwCNwPDoUkFuXMupB5pn66pB2IjQpV1D2CTP/rtXTWTzFe0
 +7CrpSlDrX2Rfl36ojlctVWqgXVm9Qk9+uzVZIXYyhENd4fw==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In tcgetattr(), the conventional workaround for rlwrap v0.40 or later
is not work as expected with OpenConsole.exe for some reason. This
patch update the workaround so that it works even with OpenConsole.exe
by rebuilding tcgetattr responce reffering the corrent console mode
instead of just overriding it depends on pseudo console setting up
state. The patch also handle tcsetattr() so that the change is applied
to the console mode.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 148 ++++++++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 85d29f1cc..bd5c24625 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1764,18 +1764,37 @@ fhandler_pty_slave::tcgetattr (struct termios *t)
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
+  if (get_ttyp ()->pcon_activated
+      && (to_be_read_from_nat_pipe ()
+	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
+    {
+      DWORD mode = ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      t->c_lflag &= ~(ICANON | ECHO);
+      t->c_iflag &= ~ICRNL;
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      HANDLE h_pcon_in;
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &h_pcon_in,
+		       0, FALSE, DUPLICATE_SAME_ACCESS);
+      DWORD resume_pid =
+	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+      if (!GetConsoleMode (h_pcon_in, &mode)
+	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
+	mode = 0;
+      resume_from_temporarily_attach (resume_pid);
+      CloseHandle (h_pcon_in);
+      CloseHandle (pcon_owner);
+
+      if (mode & ENABLE_LINE_INPUT)
+	t->c_lflag |= ICANON;
+      if (mode & ENABLE_ECHO_INPUT)
+	t->c_lflag |= ECHO;
+    }
   return 0;
 }
 
@@ -1784,6 +1803,40 @@ fhandler_pty_slave::tcsetattr (int, const struct termios *t)
 {
   acquire_output_mutex (mutex_timeout);
   get_ttyp ()->ti = *t;
+
+  if (get_ttyp ()->pcon_activated
+      && (to_be_read_from_nat_pipe ()
+	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
+    {
+      DWORD mode;
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      HANDLE h_pcon_in;
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &h_pcon_in,
+		       0, FALSE, DUPLICATE_SAME_ACCESS);
+      DWORD resume_pid =
+	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+      if (!GetConsoleMode (h_pcon_in, &mode)
+	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
+	mode = 0;
+
+      mode &= ~(ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT
+		| ENABLE_PROCESSED_INPUT);
+      if (t->c_lflag & ICANON)
+	mode |= ENABLE_LINE_INPUT;
+      if (t->c_lflag & ECHO)
+	mode |= ENABLE_ECHO_INPUT;
+      if (t->c_lflag & ISIG)
+	mode |= ENABLE_PROCESSED_INPUT;
+      SetConsoleMode (h_pcon_in, mode);
+
+      resume_from_temporarily_attach (resume_pid);
+      CloseHandle (h_pcon_in);
+      CloseHandle (pcon_owner);
+
+      get_ttyp ()->ti.c_iflag |= ICRNL;
+    }
   release_output_mutex ();
   return 0;
 }
@@ -2508,11 +2561,38 @@ int
 fhandler_pty_master::tcgetattr (struct termios *t)
 {
   *t = cygwin_shared->tty[get_minor ()]->ti;
-  /* Workaround for rlwrap v0.40 or later */
-  if (get_ttyp ()->pcon_start)
-    t->c_lflag &= ~(ICANON | ECHO);
-  if (get_ttyp ()->pcon_activated)
-    t->c_iflag &= ~ICRNL;
+
+  /* Conventional workaround for rlwrap v0.40 or later is not work
+     as expected with OpenConsole.exe for some reason. The following
+     workaround is perhaps better solution even for apps other than
+     rlwrap under pcon_activated mode. */
+  if (get_ttyp ()->pcon_activated
+      && (to_be_read_from_nat_pipe ()
+	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
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
+      if (!GetConsoleMode (h_pcon_in, &mode)
+	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
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
 
@@ -2520,6 +2600,40 @@ int
 fhandler_pty_master::tcsetattr (int, const struct termios *t)
 {
   cygwin_shared->tty[get_minor ()]->ti = *t;
+
+  if (get_ttyp ()->pcon_activated
+      && (to_be_read_from_nat_pipe ()
+	  || get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
+    {
+      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+				       get_ttyp ()->nat_pipe_owner_pid);
+      HANDLE h_pcon_in;
+      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+		       GetCurrentProcess (), &h_pcon_in,
+		       0, FALSE, DUPLICATE_SAME_ACCESS);
+      DWORD resume_pid =
+	attach_console_temporarily (get_ttyp()->nat_pipe_owner_pid);
+      DWORD mode;
+      if (!GetConsoleMode (h_pcon_in, &mode)
+	  && (get_ttyp ()->pcon_start || get_ttyp ()->pcon_start_csi_c))
+	mode = 0;
+
+      mode &= ~(ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT
+		| ENABLE_PROCESSED_INPUT);
+      if (t->c_lflag & ICANON)
+	mode |= ENABLE_LINE_INPUT;
+      if (t->c_lflag & ECHO)
+	mode |= ENABLE_ECHO_INPUT;
+      if (t->c_lflag & ISIG)
+	mode |= ENABLE_PROCESSED_INPUT;
+      SetConsoleMode (h_pcon_in, mode);
+
+      resume_from_temporarily_attach (resume_pid);
+      CloseHandle (h_pcon_in);
+      CloseHandle (pcon_owner);
+
+      cygwin_shared->tty[get_minor ()]->ti.c_iflag |= ICRNL;
+    }
   return 0;
 }
 
-- 
2.51.0

