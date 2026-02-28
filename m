Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id BA63C4BA23F6
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:03:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA63C4BA23F6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA63C4BA23F6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269400; cv=none;
	b=cAMR53K/JOMCb4jMxH+JMS6aRJpsXS/EAZEUVzTaQ7/kCXEa+nqgkbWThQe+OK5ZAPcFls29Rbx8WyevLXv2Ok0NtO++i9acL8iM9w8tLcwk0lmZb4w5wVrYFPGeO1wxb+0V9knAyKDGpqa3n7c0xciegKNMMlAspnij3Tq6Ajg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269400; c=relaxed/simple;
	bh=mTNdarxUMMVawh3ziHi/3QDEll7vsRDIs3InLqDt+Mo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=KnHWjZmG0AIGMvelsSPUCpZgV7uwi9WgxYocmdUkgxO7Vx6htxRd8rDJZMzCoB+p089AElYHBHKDxeYW6Qd7ulH6apop814vWMuTP8RSujE59d4qJxrdzYqlzi7VsKgI8SrpfM4ecfdO5pZpuqaog+G7nW4aow9a02hqVnwJxgs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA63C4BA23F6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=a1SEweIq
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260228090317954.YDYH.127398.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:03:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Wolff <towo@towo.net>
Subject: [PATCH v4 1/4] Cygwin: pty: Use OpenConsole.exe if available
Date: Sat, 28 Feb 2026 18:02:50 +0900
Message-ID: <20260228090304.2562-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269398;
 bh=V+DaqhLCo3nc7xuuR//+FZw0SYw3XqBpNJ0iBjddKLo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a1SEweIqpy1RHUOiQvxdSla0PfnEljn+vlKSJbiG2pnX7/DO5Xlj0jKTV/mqvlqMg4+oTJkg
 NhDcWm8MDKg2aSvc/YHz1KdrPJROShELFNLXIKC8BngSd1Z6KlxEUFG1IZqo/kou9AdcJDep0h
 rbIJEkdCHXXT/DAMaJa5XRdncv7DTkIV/E4lJPo6Xk2Ot1jof8vm5hGcterasDFuDyG/5o0Fft
 ol6/wgcIsAWm3Nars7VE+xprr6MM/YVp7uknE8budl/odubjFvteto5jmsiUyfHiUg7PEiyuKI
 Mx8CDsAGBNp12SUH6H+xxcrQ/GDMYSKTyDdi24gWg8m0LnYw==
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch replaces legacy conhost.exe with OpenConsole.exe if
it is available. This enables various new features such as mouse
support in pseudo console and bug fixes. The legacy conhost has
problems, e.g. character attributes are mangled or ignored, and
terminal reports are not passed through. This patch resolve the
issue by loading /usr/bin/OpenColnsole.exe instead of conhost.exe
if it is available.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Suggested-by: Thomas Wolff <towo@towo.net>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc           | 218 ++++++++++++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |   1 +
 winsup/cygwin/local_includes/tty.h      |   1 +
 winsup/cygwin/tty.cc                    |   1 +
 4 files changed, 208 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 8f8d4f01e..fac4ae357 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -34,6 +34,165 @@ details. */
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
 #endif /* PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE */
 
+/* The source code of following two functions, i.e. create_conhost_handle()
+   and CreatePseudoConsole_new(), are borrowed from
+   Microsoft WindowsTerminal project: https://github.com/microsoft/terminal/
+   that is licensed under MIT license. */
+
+/* ----------------------------------------------------------------------------
+Copyright (c) Microsoft Corporation. All rights reserved.
+
+MIT License
+
+Permission is hereby granted, free of charge, to any person obtaining a copy
+of this software and associated documentation files (the "Software"), to deal
+in the Software without restriction, including without limitation the rights
+to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+copies of the Software, and to permit persons to whom the Software is
+furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in all
+copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+SOFTWARE.
+---------------------------------------------------------------------------- */
+
+static NTSTATUS
+create_conhost_handle (PHANDLE handle, PCWSTR device_name,
+		       ACCESS_MASK desired_access, HANDLE parent,
+		       BOOLEAN inheritable, ULONG open_options)
+{
+  ULONG flags = OBJ_CASE_INSENSITIVE;
+  if (inheritable)
+    flags |= OBJ_INHERIT;
+
+  UNICODE_STRING name;
+  RtlInitUnicodeString (&name, device_name);
+
+  OBJECT_ATTRIBUTES object_attributes;
+  InitializeObjectAttributes (&object_attributes, &name, flags, parent, NULL);
+
+  IO_STATUS_BLOCK io;
+  return NtOpenFile (handle, desired_access, &object_attributes, &io,
+		     FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE,
+		     open_options);
+}
+
+extern "C" WINBASEAPI HRESULT WINAPI
+CreatePseudoConsole_new (COORD size, HANDLE h_input, HANDLE h_output,
+			 DWORD flags, HPCON *hpcon)
+{
+
+  HANDLE h_con_server, h_con_reference;
+  NTSTATUS status;
+  BOOL res;
+  HANDLE h_read_pipe, h_write_pipe;
+  BOOL inherit_cursor;
+  path_conv conhost ("/usr/bin/OpenConsole.exe");
+  size_t len;
+  HANDLE inherited_handles[4];
+  STARTUPINFOEXW si = {0, };
+  PROCESS_INFORMATION pi;
+  SIZE_T list_size = 0;
+  LPPROC_THREAD_ATTRIBUTE_LIST attr_list;
+  HPCON_INTERNAL *hpcon_internal;
+
+  status = create_conhost_handle (&h_con_server, L"\\Device\\ConDrv\\Server",
+				  GENERIC_ALL, NULL, TRUE, 0);
+  if (!NT_SUCCESS (status))
+    goto cleanup;
+  status = create_conhost_handle (&h_con_reference, L"\\Reference",
+				  GENERIC_READ | GENERIC_WRITE | SYNCHRONIZE,
+				  h_con_server, FALSE,
+				  FILE_SYNCHRONOUS_IO_NONALERT);
+  if (!NT_SUCCESS (status))
+    goto cleanup_h_con_server;
+
+  res = CreatePipe (&h_read_pipe, &h_write_pipe, &sec_none, 0);
+  if (!res)
+    goto cleanup_h_con_reference;
+  res = SetHandleInformation (h_read_pipe,
+			      HANDLE_FLAG_INHERIT, HANDLE_FLAG_INHERIT);
+  if (!res)
+    goto cleanup_pipe;
+
+  inherit_cursor = (flags & PSEUDOCONSOLE_INHERIT_CURSOR) ? TRUE : FALSE;
+
+  WCHAR cmd[MAX_PATH];
+  len = conhost.get_wide_win32_path_len ();
+  conhost.get_wide_win32_path (cmd);
+  __small_swprintf (cmd + len,
+		    L" --headless %W"
+		    "--width %d --height %d --signal 0x%x --server 0x%x",
+		    inherit_cursor ? L"--inheritcursor " : L"",
+		    size.X, size.Y, h_read_pipe, h_con_server);
+
+  si.StartupInfo.cb = sizeof (STARTUPINFOEXW);
+  si.StartupInfo.hStdInput = h_input;
+  si.StartupInfo.hStdOutput = h_output;
+  si.StartupInfo.hStdError = h_output;
+  si.StartupInfo.dwFlags |= STARTF_USESTDHANDLES;
+
+  inherited_handles[0] = h_con_server;
+  inherited_handles[1] = h_input;
+  inherited_handles[2] = h_output;
+  inherited_handles[3] = h_read_pipe;
+
+  InitializeProcThreadAttributeList (NULL, 1, 0, &list_size);
+  attr_list =
+    (LPPROC_THREAD_ATTRIBUTE_LIST) HeapAlloc (GetProcessHeap (), 0, list_size);
+  if (!attr_list)
+    goto cleanup_pipe;
+
+  si.lpAttributeList = attr_list;
+  InitializeProcThreadAttributeList (si.lpAttributeList, 1, 0, &list_size);
+  UpdateProcThreadAttribute (si.lpAttributeList, 0,
+			     PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+			     inherited_handles, sizeof (inherited_handles),
+			     NULL, NULL);
+
+
+  res = CreateProcessW (NULL, cmd, NULL, NULL,
+			TRUE, EXTENDED_STARTUPINFO_PRESENT,
+			NULL, NULL, &si.StartupInfo, &pi);
+  if (!res)
+    goto cleanup_heap;
+
+  hpcon_internal = (HPCON_INTERNAL *)
+    HeapAlloc (GetProcessHeap (), 0, sizeof (HPCON_INTERNAL));
+  if (!hpcon_internal)
+    goto cleanup_heap;
+  hpcon_internal->hWritePipe = h_write_pipe;
+  hpcon_internal->hConDrvReference = h_con_reference;
+  hpcon_internal->hConHostProcess = pi.hProcess;
+  *hpcon = (HPCON) hpcon_internal;
+
+  HeapFree (GetProcessHeap(), 0, attr_list);
+  CloseHandle (h_con_server);
+  CloseHandle (pi.hThread);
+
+  return S_OK;
+
+cleanup_heap:
+  HeapFree (GetProcessHeap(), 0, attr_list);
+cleanup_pipe:
+  CloseHandle (h_read_pipe);
+  CloseHandle (h_write_pipe);
+cleanup_h_con_reference:
+  CloseHandle (h_con_reference);
+cleanup_h_con_server:
+  CloseHandle (h_con_server);
+cleanup:
+  return E_FAIL;
+}
+
+
 extern "C" int sscanf (const char *, const char *, ...);
 
 #define close_maybe(h) \
@@ -2149,13 +2308,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   push_process_state process_state (PID_TTYOU);
 
-  if (get_ttyp ()->pcon_start)
+  int pcon_start_mode =
+    get_ttyp ()->pcon_start ? 1 : (get_ttyp ()->pcon_start_csi_c ? 2 : 0);
+  if (pcon_start_mode)
     { /* Reaches here when pseudo console initialization is on going. */
       /* Pseudo condole support uses "CSI6n" to get cursor position.
 	 If the reply for "CSI6n" is divided into multiple writes,
 	 pseudo console sometimes does not recognize it.  Therefore,
 	 put them together into wpbuf and write all at once. */
-      static const int wpbuf_len = strlen ("\033[32768;32868R");
+      /* Do the same for CSIc. */
+      static const int wpbuf_len = 64; /* Enough space for CSIc response */
       static char wpbuf[wpbuf_len];
       static int ixput = 0;
       static int state = 0;
@@ -2185,7 +2347,15 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  else
 	    line_edit (p + i, 1, ti, &ret);
 	  if (state == 1 && p[i] == 'R')
-	    state = 2;
+	    {
+	      get_ttyp ()->pcon_start = false;
+	      state = 2;
+	    }
+	  if (state == 1 && p[i] == 'c')
+	    {
+	      get_ttyp ()->pcon_start_csi_c = false;
+	      state = 2;
+	    }
 	  if (state == 2)
 	    {
 	      /* req_xfer_input is true if "ESC[6n" was sent just for
@@ -2198,13 +2368,13 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      ixput = 0;
 	      state = 0;
 	      get_ttyp ()->req_xfer_input = false;
-	      get_ttyp ()->pcon_start = false;
-	      break;
+	      if (!get_ttyp ()->pcon_start && !get_ttyp ()->pcon_start_csi_c)
+		break;
 	    }
 	}
       ReleaseMutex (input_mutex);
 
-      if (!get_ttyp ()->pcon_start)
+      if (pcon_start_mode == 1 && !get_ttyp ()->pcon_start)
 	{ /* Pseudo console initialization has been done in above code. */
 	  pinfo pp (get_ttyp ()->pcon_start_pid);
 	  if (get_ttyp ()->switch_to_nat_pipe
@@ -2651,8 +2821,10 @@ pty_master_thread (VOID *arg)
 #define CONSOLE_HELPER "\\bin\\cygwin-console-helper.exe"
 #define CONSOLE_HELPER_LEN (sizeof (CONSOLE_HELPER) - 1)
 
-inline static DWORD
-workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
+DWORD
+fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
+							    DWORD rlen,
+							    tty *ttyp)
 {
   int state = 0;
   int start_at = 0;
@@ -2661,6 +2833,7 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
   int arg = 0;
   bool saw_greater_than_sign = false;
   bool saw_question_mark = false;
+  static bool in_pcon_start = false;
   for (DWORD i=0; i<rlen; i++)
     if (state == 0 && outbuf[i] == '\033')
       {
@@ -2741,8 +2914,21 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	    start_at = i;
 	    state = 1;
 	  }
+	else if (arg == 6 && outbuf[i] == 'n' && ttyp->pcon_start)
+	  {
+	    in_pcon_start = true;
+	    state = 0;
+	  }
+	else if (arg == 0 && outbuf[i] == 'c' && in_pcon_start)
+	  {
+	    ttyp->pcon_start_csi_c = true;
+	    state = 0;
+	  }
 	else
-	  state = 0;
+	  {
+	    in_pcon_start = false;
+	    state = 0;
+	  }
 
 	if (state < 2)
 	  {
@@ -2840,7 +3026,8 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
       char *ptr = outbuf;
       if (p->ttyp->pcon_activated)
 	{
-	  wlen = rlen = workarounds_for_pseudo_console_output (outbuf, rlen);
+	  wlen = rlen =
+	    workarounds_for_pseudo_console_output (outbuf, rlen, p->ttyp);
 
 	  if (p->ttyp->term_code_page != CP_UTF8)
 	    {
@@ -3340,9 +3527,14 @@ fhandler_pty_slave::setup_pseudoconsole ()
       const DWORD inherit_cursor = 1;
       hpcon = NULL;
       SetLastError (ERROR_SUCCESS);
-      HRESULT res = CreatePseudoConsole (size, get_handle_nat (),
-					 get_output_handle_nat (),
-					 inherit_cursor, &hpcon);
+      /* Try OpenConsole.exe before conhost.exe */
+      HRESULT res = CreatePseudoConsole_new (size, get_handle_nat (),
+					     get_output_handle_nat (),
+					     inherit_cursor, &hpcon);
+      if (res != S_OK) /* Fallback to legacy conhost.exe */
+        res = CreatePseudoConsole (size, get_handle_nat (),
+				   get_output_handle_nat (),
+				   inherit_cursor, &hpcon);
       if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
 	{
 	  if (res != S_OK)
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 16f55b4f7..dd907c4ba 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2572,6 +2572,7 @@ public:
 
   static DWORD pty_master_thread (const master_thread_param_t *p);
   static DWORD pty_master_fwd_thread (const master_fwd_thread_param_t *p);
+  static DWORD workarounds_for_pseudo_console_output (char *, DWORD, tty *);
   int process_slave_output (char *buf, size_t len, int pktmode_on);
   void doecho (const void *str, DWORD len);
   int accept_input ();
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index 9485e24c5..163b38222 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -120,6 +120,7 @@ private:
   bool pcon_activated;
   bool pcon_start;
   pid_t pcon_start_pid;
+  bool pcon_start_csi_c;
   bool switch_to_nat_pipe;
   DWORD nat_pipe_owner_pid;
   UINT term_code_page;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 3ab30c0a7..585762b20 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -243,6 +243,7 @@ tty::init ()
   fwd_not_empty = false;
   pcon_start = false;
   pcon_start_pid = 0;
+  pcon_start_csi_c = false;
   pcon_cap_checked = false;
   has_csi6n = false;
   need_invisible_console = false;
-- 
2.51.0

