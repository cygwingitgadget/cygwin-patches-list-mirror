Return-Path: <cygwin-patches-return-10065-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50953 invoked by alias); 10 Feb 2020 17:45:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50929 invoked by uid 89); 10 Feb 2020 17:45:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: conuserg-02.nifty.com
Received: from conuserg-02.nifty.com (HELO conuserg-02.nifty.com) (210.131.2.69) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 17:45:23 +0000
Received: from localhost.localdomain (ntsitm196171.sitm.nt.ngn.ppp.infoweb.ne.jp [125.0.207.171]) (authenticated)	by conuserg-02.nifty.com with ESMTP id 01AHjDHb005143;	Tue, 11 Feb 2020 02:45:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-02.nifty.com 01AHjDHb005143
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1581356718;	bh=Q9qAcvJFyogXPpF9ipIS/SqxDKVkzZKDZc2WwBK/vaE=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=j9Qjb9CEoAVoAIDUbpbwoJD70r2VwGivJUEhqSkGcGFOBabe7iJ7LW/8p+WWLnZP6	 yhIF0iM/aqkiPdeTXZ5BB8rbPTXYxUETGFFTpYGcoPZYeaB7kOu37iBUI+O0NN8lvV	 NhvDG3vp1IYbejNRrudBUmuqSI+XzyjHaUFEwC2z+qXhX8t3vFJ7LEVtB+eoPtJ5Ek	 QB8U9KXtCGshhcqenbMlExZym5NiAPpvy1vjg+4x0qxwra94LdndOPU2nQfZUJrKwS	 Wtg9AAC+ZikBB7wsuu4ZNxqV2DZDAc72ftShjRFlvvWUVPLy907Rz8bws7VCYIH0dZ	 WqhcqPAcZ2AlA==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Add error handling in setup_pseudoconsole().
Date: Mon, 10 Feb 2020 17:45:00 -0000
Message-Id: <20200210174514.1164-1-takashi.yano@nifty.ne.jp>
In-Reply-To: <20200210153811.GF4442@calimero.vinschen.de>
References: <20200210153811.GF4442@calimero.vinschen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2020-q1/txt/msg00171.txt

- In setup_pseudoconsole(), many error handling was omitted. This
  patch adds missing error handling.
---
 winsup/cygwin/fhandler_tty.cc | 179 +++++++++++++++++++++-------------
 1 file changed, 111 insertions(+), 68 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index cfd4b1c44..153bdad79 100644
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
@@ -3423,12 +3426,7 @@ fhandler_pty_master::setup_pseudoconsole ()
       if (res != S_OK)
 	system_printf ("CreatePseudoConsole() failed. %08x\n",
 		       GetLastError ());
-      CloseHandle (from_master);
-      CloseHandle (to_slave);
-      from_master = from_master_cyg;
-      to_slave = NULL;
-      get_ttyp ()->h_pseudo_console = NULL;
-      return false;
+      goto fallback;
     }
 
   /* If master process is running as service, attaching to
@@ -3439,69 +3437,82 @@ fhandler_pty_master::setup_pseudoconsole ()
   if (is_running_as_service ())
     get_ttyp ()->attach_pcon_in_fork = true;
 
-  SIZE_T bytesRequired;
-  InitializeProcThreadAttributeList (NULL, 2, 0, &bytesRequired);
   STARTUPINFOEXW si_helper;
-  ZeroMemory (&si_helper, sizeof (si_helper));
-  si_helper.StartupInfo.cb = sizeof (STARTUPINFOEXW);
-  si_helper.lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
-    HeapAlloc (GetProcessHeap (), 0, bytesRequired);
-  InitializeProcThreadAttributeList (si_helper.lpAttributeList,
-				     2, 0, &bytesRequired);
-  UpdateProcThreadAttribute (si_helper.lpAttributeList,
-			     0,
-			     PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
-			     get_ttyp ()->h_pseudo_console,
-			     sizeof (get_ttyp ()->h_pseudo_console),
-			     NULL, NULL);
-  HANDLE hello = CreateEvent (&sec_none, true, false, NULL);
-  HANDLE goodbye = CreateEvent (&sec_none, true, false, NULL);
-  /* Create a pipe for receiving pseudo console handles */
+  HANDLE hello, goodbye;
   HANDLE hr, hw;
-  CreatePipe (&hr, &hw, &sec_none, 0);
-  /* Inherit only handles which are needed by helper. */
-  HANDLE handles_to_inherit[] = {hello, goodbye, hw};
-  UpdateProcThreadAttribute (si_helper.lpAttributeList,
-			     0,
-			     PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
-			     handles_to_inherit,
-			     sizeof (handles_to_inherit),
-			     NULL, NULL);
-  /* Create helper process */
-  WCHAR cmd[MAX_PATH];
-  path_conv helper ("/bin/cygwin-console-helper.exe");
-  size_t len = helper.get_wide_win32_path_len ();
-  helper.get_wide_win32_path (cmd);
-  __small_swprintf (cmd + len, L" %p %p %p", hello, goodbye, hw);
-  si_helper.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
-  si_helper.StartupInfo.hStdInput = NULL;
-  si_helper.StartupInfo.hStdOutput = NULL;
-  si_helper.StartupInfo.hStdError = NULL;
   PROCESS_INFORMATION pi_helper;
-  CreateProcessW (NULL, cmd, &sec_none, &sec_none,
-		  TRUE, EXTENDED_STARTUPINFO_PRESENT,
-		  NULL, NULL, &si_helper.StartupInfo, &pi_helper);
-  WaitForSingleObject (hello, INFINITE);
-  CloseHandle (hello);
-  CloseHandle (pi_helper.hThread);
-  /* Retrieve pseudo console handles */
-  DWORD rLen;
-  char buf[64];
-  ReadFile (hr, buf, sizeof (buf), &rLen, NULL);
-  buf[rLen] = '\0';
   HANDLE hpConIn, hpConOut;
-  sscanf (buf, "StdHandles=%p,%p", &hpConIn, &hpConOut);
-  DuplicateHandle (pi_helper.hProcess, hpConIn,
-		   GetCurrentProcess (), &hpConIn, 0,
-		   TRUE, DUPLICATE_SAME_ACCESS);
-  DuplicateHandle (pi_helper.hProcess, hpConOut,
-		   GetCurrentProcess (), &hpConOut, 0,
-		   TRUE, DUPLICATE_SAME_ACCESS);
-  CloseHandle (hr);
-  CloseHandle (hw);
-  /* Clean up */
-  DeleteProcThreadAttributeList (si_helper.lpAttributeList);
-  HeapFree (GetProcessHeap (), 0, si_helper.lpAttributeList);
+  {
+    SIZE_T bytesRequired;
+    InitializeProcThreadAttributeList (NULL, 2, 0, &bytesRequired);
+    ZeroMemory (&si_helper, sizeof (si_helper));
+    si_helper.StartupInfo.cb = sizeof (STARTUPINFOEXW);
+    si_helper.lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
+      HeapAlloc (GetProcessHeap (), 0, bytesRequired);
+    if (si_helper.lpAttributeList == NULL)
+      goto cleanup_pseudo_console;
+    if (!InitializeProcThreadAttributeList (si_helper.lpAttributeList,
+					    2, 0, &bytesRequired))
+      goto cleanup_heap;
+    if (!UpdateProcThreadAttribute (si_helper.lpAttributeList,
+				    0,
+				    PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE,
+				    get_ttyp ()->h_pseudo_console,
+				    sizeof (get_ttyp ()->h_pseudo_console),
+				    NULL, NULL))
+      goto cleanup_heap;
+    /* Create events for start/stop helper process. */
+    hello = CreateEvent (&sec_none, true, false, NULL);
+    goodbye = CreateEvent (&sec_none, true, false, NULL);
+    /* Create a pipe for receiving pseudo console handles */
+    CreatePipe (&hr, &hw, &sec_none, 0);
+    /* Inherit only handles which are needed by helper. */
+    HANDLE handles_to_inherit[] = {hello, goodbye, hw};
+    if (!UpdateProcThreadAttribute (si_helper.lpAttributeList,
+				    0,
+				    PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+				    handles_to_inherit,
+				    sizeof (handles_to_inherit),
+				    NULL, NULL))
+      goto cleanup_event_and_pipes;
+    /* Create helper process */
+    WCHAR cmd[MAX_PATH];
+    path_conv helper ("/bin/cygwin-console-helper.exe");
+    size_t len = helper.get_wide_win32_path_len ();
+    helper.get_wide_win32_path (cmd);
+    __small_swprintf (cmd + len, L" %p %p %p", hello, goodbye, hw);
+    si_helper.StartupInfo.dwFlags = STARTF_USESTDHANDLES;
+    si_helper.StartupInfo.hStdInput = NULL;
+    si_helper.StartupInfo.hStdOutput = NULL;
+    si_helper.StartupInfo.hStdError = NULL;
+    if (!CreateProcessW (NULL, cmd, &sec_none, &sec_none,
+			 TRUE, EXTENDED_STARTUPINFO_PRESENT,
+			 NULL, NULL, &si_helper.StartupInfo, &pi_helper))
+      goto cleanup_event_and_pipes;
+    WaitForSingleObject (hello, INFINITE);
+    CloseHandle (hello);
+    CloseHandle (pi_helper.hThread);
+    /* Retrieve pseudo console handles */
+    DWORD rLen;
+    char buf[64];
+    if (!ReadFile (hr, buf, sizeof (buf), &rLen, NULL))
+      goto cleanup_helper_process;
+    buf[rLen] = '\0';
+    sscanf (buf, "StdHandles=%p,%p", &hpConIn, &hpConOut);
+    if (!DuplicateHandle (pi_helper.hProcess, hpConIn,
+			  GetCurrentProcess (), &hpConIn, 0,
+			  TRUE, DUPLICATE_SAME_ACCESS))
+      goto cleanup_helper_process;
+    if (!DuplicateHandle (pi_helper.hProcess, hpConOut,
+			  GetCurrentProcess (), &hpConOut, 0,
+			  TRUE, DUPLICATE_SAME_ACCESS))
+      goto cleanup_pcon_in;
+    CloseHandle (hr);
+    CloseHandle (hw);
+    /* Clean up */
+    DeleteProcThreadAttributeList (si_helper.lpAttributeList);
+    HeapFree (GetProcessHeap (), 0, si_helper.lpAttributeList);
+  }
   /* Setting information of stuffs regarding pseudo console */
   get_ttyp ()->h_helper_goodbye = goodbye;
   get_ttyp ()->h_helper_process = pi_helper.hProcess;
@@ -3510,7 +3521,38 @@ fhandler_pty_master::setup_pseudoconsole ()
   CloseHandle (to_master);
   from_master = hpConIn;
   to_master = hpConOut;
+  ResizePseudoConsole (get_ttyp ()->h_pseudo_console, size);
   return true;
+
+cleanup_pcon_in:
+  CloseHandle (hpConIn);
+cleanup_helper_process:
+  SetEvent (goodbye);
+  WaitForSingleObject (pi_helper.hProcess, INFINITE);
+  CloseHandle (pi_helper.hProcess);
+  goto skip_close_hello;
+cleanup_event_and_pipes:
+  CloseHandle (hello);
+skip_close_hello:
+  CloseHandle (goodbye);
+  CloseHandle (hr);
+  CloseHandle (hw);
+cleanup_heap:
+  HeapFree (GetProcessHeap (), 0, si_helper.lpAttributeList);
+cleanup_pseudo_console:
+  {
+    HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
+    HANDLE tmp = hp->hConHostProcess;
+    ClosePseudoConsole (get_pseudo_console ());
+    CloseHandle (tmp);
+  }
+fallback:
+  CloseHandle (from_master);
+  CloseHandle (to_slave);
+  from_master = from_master_cyg;
+  to_slave = NULL;
+  get_ttyp ()->h_pseudo_console = NULL;
+  return false;
 }
 
 bool
@@ -3629,14 +3671,15 @@ fhandler_pty_master::setup ()
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
