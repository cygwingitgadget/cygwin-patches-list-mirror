Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id A54894BA23EC
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:06:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A54894BA23EC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A54894BA23EC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359612; cv=none;
	b=MXfkyGCM60CKFgJDakXe6CitXElzk1YVnxKIGbapgPKXomAiK3BRsmqYESLNwW51QyRjxhqcdHS85xg5mxnzFB8ZvDFzk0Vg43HNn1EiyAqRIj6mMkAyjktb9zWtAphDJ6iCBigeLvBfQtxIYzMYbjonTChr7SqiMhYaPVY/oi0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359612; c=relaxed/simple;
	bh=u/iNzQgoJB2Dx+iwAvqszBb0plsv1pyrzYQy43QDGZE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SpCeDaBYRQLcgg/SBgQe1/39QpRG6lt8tE16uzjjartjz0ls7ImL0S5oeSbKIMB1ZlXhRXiobaT/BW33KIlEvfRXfP4DxKmxw9tSaS8cfCmKcBgrjPqvkKf51SgJpQlpe5XACATRaDvRGUDdwa4HHbq4bQ66ovu2NEVGE8FtCa8=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qxUlIjIt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A54894BA23EC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=qxUlIjIt
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260613140649778.UYQE.44671.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:06:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()
Date: Sat, 13 Jun 2026 23:06:19 +0900
Message-ID: <20260613140630.24451-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
References: <20260613140630.24451-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359609;
 bh=u5V05SpVBsl4mTt2vzjMsBURvGGjuhD4CF/ivoa1kkg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qxUlIjItstJQvKg1wNiepbFjoCmR+aOPCVbksKuXS5tC3ykWniLNtyU/0K74mYLvR7J03mRE
 6DTttHtlvn8kaY8fyIAfuL5wmkwowub0s4gdNLI9G/khhMBS8HMiQ+MLRyfx0uRW4HOB9uw1xV
 bPtXd1FIhAzc36JaqSC8LYlp9fB7yn7ECqNusO1Nf/RQ60DQ7H07RyQl+Jx9kN1/0FYkSNiLAn
 FWpvUzjyOYJFmSTY9Ew2+4xpEp+hj09rKSVyx154PXDs3auoPtCqxpxRHrWN0BmvwmCh+2d1VV
 bSOaXNqolSIAqzOxQx4dRsypVkG+gaXIm6MKAz+PQEsOGuEQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

