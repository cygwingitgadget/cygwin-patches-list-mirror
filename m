Return-Path: <SRS0=N3FD=EE=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id A1FDD51A4323
	for <cygwin-patches@cygwin.com>; Mon,  8 Jun 2026 13:35:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A1FDD51A4323
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A1FDD51A4323
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780925727; cv=none;
	b=dBKBYJYPo3KhzepDzuUW+n8s18zFtp8iYk27wvZlo2YmFsaBdcBpA7pNJMArinfhDLsegpgkfg99I7cQfG8jaMPx9sBLywwQ9K7yGF1UPNsUFHryYwB3x18Du3zBmqVVWx7dhpDCKi83pEuhrkSusJX4cztO+zxw98OFODcsdlA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780925727; c=relaxed/simple;
	bh=u/iNzQgoJB2Dx+iwAvqszBb0plsv1pyrzYQy43QDGZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=YFDpA9L5t5KqAd1iIhvYXPNohpibI9WTuFhki+xWrWlw/ezyQ9ec+rkxbXGGCdn3St/JQtUgL80pKJ1RtkdhjuAWRBOMMmxAdaG6ISpP1XvuedVZY5iylWjx1QxrEjOHHgLUxvu7deqw7V9/5dACK5ZfcyNBfNd5uu6xWdEjpR4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JC1GmD+J
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A1FDD51A4323
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JC1GmD+J
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260608133524828.PAAE.102121.HP-Z230@nifty.com>;
          Mon, 8 Jun 2026 22:35:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()
Date: Mon,  8 Jun 2026 22:34:47 +0900
Message-ID: <20260608133507.1990-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260608133507.1990-1-takashi.yano@nifty.ne.jp>
References: <20260608133507.1990-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1780925724;
 bh=u5V05SpVBsl4mTt2vzjMsBURvGGjuhD4CF/ivoa1kkg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JC1GmD+JhPGC/xpjtSxKgKzx0Fd83/hGtRIPPZKqomihMIW9UIYvyRgQt33iDWd6zX0eldeb
 3U2Gheu8dFzMDhkNRkm+Ek6SLkHlzuc7n7si2Dbbp6HKBnxsuFvDPHVh7Q+EPc2hg8sJnsCEAf
 19TJUQ0iKG09ZTExYK9EAQ91tA39GHtIekgLkxLkIaS0n+OCqoglO/SnOx71V7urix1/N8h3dU
 V8DM9WjhH6cz0/WAHaSu2hoiRuciJiylL5Z2lrOpui0sVqa1T0Hm2Hx8VQfXzu/tcdhx7CaX5o
 rdTS9++l6CdDWpF2d0az4z7NnwQHyYDJ1J9g61Obgj/rsqhg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The current pty code performs the sequence:
  OpenProcess() -> DuplicateHandle()
in various places. This helper function encapsulates that sequence
to improve readability and maintainability.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 66 +++++++++++++++++------------------
 1 file changed, 33 insertions(+), 33 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 2558fa799..e60e30230 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2213,6 +2213,23 @@ fhandler_pty_common::close (int flag)
   return 0;
 }
 
+static inline HANDLE
+get_handle_from_process (DWORD pid, HANDLE h, bool inh = false)
+{
+  HANDLE ret = NULL;
+  HANDLE owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, pid);
+  if (owner)
+    {
+      if (!DuplicateHandle (owner, h, GetCurrentProcess (), &ret, 0, inh,
+			    DUPLICATE_SAME_ACCESS))
+	termios_printf ("DuplicateHandle() %p from process %d (%E)", h, pid);
+      CloseHandle (owner);
+    }
+  else
+    termios_printf ("OpenProcess (%d) failed (%E).", pid);
+  return ret;
+}
+
 void
 fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
 {
@@ -2220,15 +2237,14 @@ fhandler_pty_common::resize_pseudo_console (struct winsize *ws)
   size.X = ws->ws_col;
   size.Y = ws->ws_row;
   HPCON_INTERNAL hpcon_local;
-  HANDLE pcon_owner =
-    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->nat_pipe_owner_pid);
-  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_write_pipe,
-		   GetCurrentProcess (), &hpcon_local.hWritePipe,
-		   0, FALSE, DUPLICATE_SAME_ACCESS);
+  hpcon_local.hWritePipe =
+    get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
+			     get_ttyp ()->h_pcon_write_pipe);
+  if (hpcon_local.hWritePipe == NULL)
+    return;
   acquire_attach_mutex (mutex_timeout);
   ResizePseudoConsole ((HPCON) &hpcon_local, size);
   release_attach_mutex ();
-  CloseHandle (pcon_owner);
   CloseHandle (hpcon_local.hWritePipe);
 }
 
@@ -2490,18 +2506,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    {
 	      if (h_pcon_in_dupped)
 		ForceCloseHandle (h_pcon_in_dupped);
-	      h_pcon_in_dupped = NULL;
-	      nat_pipe_owner_pid_dupped = 0;
-	      HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
-					       get_ttyp ()->nat_pipe_owner_pid);
-	      if (pcon_owner)
-		{
-		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
-				   GetCurrentProcess (), &h_pcon_in_dupped,
-				   0, FALSE, DUPLICATE_SAME_ACCESS);
-		  nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
-		  CloseHandle (pcon_owner);
-		}
+	      h_pcon_in_dupped =
+		get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
+					 get_ttyp ()->h_pcon_in);
+	      if (h_pcon_in_dupped)
+		nat_pipe_owner_pid_dupped = get_ttyp ()->nat_pipe_owner_pid;
+	      else
+		nat_pipe_owner_pid_dupped = 0;
 	    }
 	  else
 	    {
@@ -4265,16 +4276,9 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
     to = ttyp->to_slave ();
 
   pinfo p (ttyp->master_pid);
-  HANDLE pty_owner = NULL;
   if (p)
-    pty_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE, p->dwProcessId);
-  if (pty_owner)
-    {
-      DuplicateHandle (pty_owner, to, GetCurrentProcess (), &to,
-		       0, TRUE, DUPLICATE_SAME_ACCESS);
-      CloseHandle (pty_owner);
-    }
-  else
+    to = get_handle_from_process (p->dwProcessId, to, true);
+  if (to == NULL)
     {
       char pipe[MAX_PATH];
       __small_sprintf (pipe,
@@ -4571,12 +4575,8 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
       if (get_ttyp ()->pcon_activated && get_ttyp ()->nat_pipe_owner_pid
 	  && !get_console_process_id (get_ttyp ()->nat_pipe_owner_pid, true))
 	{
-	  HANDLE pcon_owner = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
-					   get_ttyp ()->nat_pipe_owner_pid);
-	  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
-			   GetCurrentProcess (), &from,
-			   0, TRUE, DUPLICATE_SAME_ACCESS);
-	  CloseHandle (pcon_owner);
+	  from = get_handle_from_process (get_ttyp ()->nat_pipe_owner_pid,
+					  get_ttyp ()->h_pcon_in, true);
 	  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
 	  resume_pid = attach_console_temporarily (target_pid);
 	  attach_restore = true;
-- 
2.51.0

