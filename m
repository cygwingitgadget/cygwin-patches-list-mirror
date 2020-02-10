Return-Path: <cygwin-patches-return-10062-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85524 invoked by alias); 10 Feb 2020 15:12:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85515 invoked by uid 89); 10 Feb 2020 15:12:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=wchar, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-01.nifty.com
Received: from conuserg-01.nifty.com (HELO conuserg-01.nifty.com) (210.131.2.68) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 15:12:43 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-01.nifty.com with ESMTP id 01AFCDQq022763;	Tue, 11 Feb 2020 00:12:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-01.nifty.com 01AFCDQq022763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581347539;	bh=b+JFZvRk9YLaUK2jNrobTtlwdNrrGHoVn3gQUFaZ/iQ=;	h=From:To:Cc:Subject:Date:From;	b=dj6Mr3PrBi29oH9Rgki/F4LAs0210rmxmUN8GhPbr8+3PunwYuPukzk5iywixxRxQ	 dXbJUyI0Jbz6VOHFmPpJVBZz1l6172p4Ml9Ep7yG1TqjctOuM7IeaT3NndXCdCXqFH	 2bAQLszwH5nw6ar1svs1qjfb1nvKEGruKd8DPZvtjQyZv10C2xPwNVJm8hRxOilGlb	 GCX6g4n/kypriIvjmYVz2ax31/RWdxeKqk4CeZzEDG9t+ltrVnHJyCcG8fEmw1VNj5	 fEkhW5eXQj+h9DwZKtbwFGKfi6RNkwYZHDsoUoS3BVUpZjBkYqW6ijk7dUK4wXD5/P	 /MJwWHo6IfXzA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Add error handling in setup_pseudoconsoe().
Date: Mon, 10 Feb 2020 15:12:00 -0000
Message-Id: <20200210151214.39-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00168.txt

- In setup_pseudoconsole(), many error handling was omitted. This
  patch adds missing error handling.
---
 winsup/cygwin/fhandler_tty.cc | 94 +++++++++++++++++++++++++----------
 1 file changed, 68 insertions(+), 26 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index cfd4b1c44..f5c97de14 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3413,7 +3413,10 @@ fhandler_pty_master::setup_pseudoconsole ()
      process in a pseudo console and get them from the helper.
      Slave process will attach to the pseudo console in the
      helper process using AttachConsole(). */
-  COORD size = {80, 25};
+  COORD size = {
+    (SHORT) get_ttyp ()->winsize.ws_col,
+    (SHORT) get_ttyp ()->winsize.ws_row
+  };
   CreatePipe (&from_master, &to_slave, &sec_none, 0);
   SetLastError (ERROR_SUCCESS);
   HRESULT res = CreatePseudoConsole (size, from_master, to_master,
@@ -3423,6 +3426,7 @@ fhandler_pty_master::setup_pseudoconsole ()
       if (res != S_OK)
 	system_printf ("CreatePseudoConsole() failed. %08x\n",
 		       GetLastError ());
+err1:
       CloseHandle (from_master);
       CloseHandle (to_slave);
       from_master = from_master_cyg;
@@ -3446,14 +3450,29 @@ fhandler_pty_master::setup_pseudoconsole ()
   si_helper.StartupInfo.cb = sizeof (STARTUPINFOEXW);
   si_helper.lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
     HeapAlloc (GetProcessHeap (), 0, bytesRequired);
-  InitializeProcThreadAttributeList (si_helper.lpAttributeList,
-				     2, 0, &bytesRequired);
-  UpdateProcThreadAttribute (si_helper.lpAttributeList,
-			     0,
-			     PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
-			     get_ttyp ()->h_pseudo_console,
-			     sizeof (get_ttyp ()->h_pseudo_console),
-			     NULL, NULL);
+  if (si_helper.lpAttributeList == NULL)
+    {
+err2:
+      HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
+      HANDLE tmp = hp->hConHostProcess;
+      ClosePseudoConsole (get_pseudo_console ());
+      CloseHandle (tmp);
+      goto err1;
+    }
+  if (!InitializeProcThreadAttributeList (si_helper.lpAttributeList,
+					  2, 0, &bytesRequired))
+    {
+err3:
+      HeapFree (GetProcessHeap (), 0, si_helper.lpAttributeList);
+      goto err2;
+    }
+  if (!UpdateProcThreadAttribute (si_helper.lpAttributeList,
+				  0,
+				  PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
+				  get_ttyp ()->h_pseudo_console,
+				  sizeof (get_ttyp ()->h_pseudo_console),
+				  NULL, NULL))
+    goto err3;
   HANDLE hello = CreateEvent (&sec_none, true, false, NULL);
   HANDLE goodbye = CreateEvent (&sec_none, true, false, NULL);
   /* Create a pipe for receiving pseudo console handles */
@@ -3461,12 +3480,21 @@ fhandler_pty_master::setup_pseudoconsole ()
   CreatePipe (&hr, &hw, &sec_none, 0);
   /* Inherit only handles which are needed by helper. */
   HANDLE handles_to_inherit[] = {hello, goodbye, hw};
-  UpdateProcThreadAttribute (si_helper.lpAttributeList,
-			     0,
-			     PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
-			     handles_to_inherit,
-			     sizeof (handles_to_inherit),
-			     NULL, NULL);
+  if (!UpdateProcThreadAttribute (si_helper.lpAttributeList,
+				  0,
+				  PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+				  handles_to_inherit,
+				  sizeof (handles_to_inherit),
+				  NULL, NULL))
+    {
+err4:
+      CloseHandle (hello);
+err5:
+      CloseHandle (goodbye);
+      CloseHandle (hr);
+      CloseHandle (hw);
+      goto err3;
+    }
   /* Create helper process */
   WCHAR cmd[MAX_PATH];
   path_conv helper ("/bin/cygwin-console-helper.exe");
@@ -3478,9 +3506,10 @@ fhandler_pty_master::setup_pseudoconsole ()
   si_helper.StartupInfo.hStdOutput = NULL;
   si_helper.StartupInfo.hStdError = NULL;
   PROCESS_INFORMATION pi_helper;
-  CreateProcessW (NULL, cmd, &sec_none, &sec_none,
-		  TRUE, EXTENDED_STARTUPINFO_PRESENT,
-		  NULL, NULL, &si_helper.StartupInfo, &pi_helper);
+  if (!CreateProcessW (NULL, cmd, &sec_none, &sec_none,
+		       TRUE, EXTENDED_STARTUPINFO_PRESENT,
+		       NULL, NULL, &si_helper.StartupInfo, &pi_helper))
+    goto err4;
   WaitForSingleObject (hello, INFINITE);
   CloseHandle (hello);
   CloseHandle (pi_helper.hThread);
@@ -3491,12 +3520,23 @@ fhandler_pty_master::setup_pseudoconsole ()
   buf[rLen] = '\0';
   HANDLE hpConIn, hpConOut;
   sscanf (buf, "StdHandles=%p,%p", &hpConIn, &hpConOut);
-  DuplicateHandle (pi_helper.hProcess, hpConIn,
-		   GetCurrentProcess (), &hpConIn, 0,
-		   TRUE, DUPLICATE_SAME_ACCESS);
-  DuplicateHandle (pi_helper.hProcess, hpConOut,
-		   GetCurrentProcess (), &hpConOut, 0,
-		   TRUE, DUPLICATE_SAME_ACCESS);
+  if (!DuplicateHandle (pi_helper.hProcess, hpConIn,
+			GetCurrentProcess (), &hpConIn, 0,
+			TRUE, DUPLICATE_SAME_ACCESS))
+    {
+err6:
+      SetEvent (goodbye);
+      WaitForSingleObject (pi_helper.hProcess, INFINITE);
+      CloseHandle (pi_helper.hProcess);
+      goto err5;
+    }
+  if (!DuplicateHandle (pi_helper.hProcess, hpConOut,
+			GetCurrentProcess (), &hpConOut, 0,
+			TRUE, DUPLICATE_SAME_ACCESS))
+    {
+      CloseHandle (hpConIn);
+      goto err6;
+    }
   CloseHandle (hr);
   CloseHandle (hw);
   /* Clean up */
@@ -3510,6 +3550,7 @@ fhandler_pty_master::setup_pseudoconsole ()
   CloseHandle (to_master);
   from_master = hpConIn;
   to_master = hpConOut;
+  ResizePseudoConsole (get_ttyp ()->h_pseudo_console, size);
   return true;
 }
 
@@ -3629,14 +3670,15 @@ fhandler_pty_master::setup ()
     }
   get_ttyp ()->fwd_done = CreateEvent (&sec_none, true, false, NULL);
 
+  t.winsize.ws_col = 80;
+  t.winsize.ws_row = 25;
+
   setup_pseudoconsole ();
 
   t.set_from_master (from_master);
   t.set_from_master_cyg (from_master_cyg);
   t.set_to_master (to_master);
   t.set_to_master_cyg (to_master_cyg);
-  t.winsize.ws_col = 80;
-  t.winsize.ws_row = 25;
   t.master_pid = myself->pid;
 
   dev ().parse (DEV_PTYM_MAJOR, unit);
-- 
2.21.0
