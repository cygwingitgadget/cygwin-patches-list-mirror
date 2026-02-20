Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 5BADE4B9DB75
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:19:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5BADE4B9DB75
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5BADE4B9DB75
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771607994; cv=none;
	b=Tpr31Xz185uielyyqKQmnQAG6kroS9DKHUmMyrJZbhqbKqC/Ueph+EX8aJAAcbDK6cbAlGwTGltP82K/EbTKgtN7SYovHf/GoLr5gGji5d1mJGMThI7g8VZ+dIktke+a0iyODjBesolrWDW9wn34ZTcOB0HDSofZMFKYMKmCx5Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771607994; c=relaxed/simple;
	bh=fuxFebqzQ36pP8DGmkTuZP38WAjRMZ5z6b0cGXzcWa4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=u8TI52FqQRYvTYVsTMY7LKBq9sRG6HfXX5QUPlnGvrEMVnZ8re7TGnlmE07Dg7PnxyRbSFzEAFx3pQeJTeBTVxUwlcvTYroZA8n/2+nZOQfc7/aZg7dtUkgM4MbT6auD3rS7xHRfX07xiuOculgyDcSgVvdJ/26136njfFNjAMk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5BADE4B9DB75
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aXzbwxIV
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260220171952468.HPMZ.50988.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:19:52 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Wolff <towo@towo.net>
Subject: [PATCH v2 1/4] Cygwin: pty: Use OpenConsole.exe if available
Date: Sat, 21 Feb 2026 02:19:12 +0900
Message-ID: <20260220171937.1969-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
References: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771607992;
 bh=MMLB2uZ1NpAgTIN2oPKDvC+PrM5MeH+wTtUsEbPpC6I=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aXzbwxIVkrdcKzmQw9DyyAhkRR0j8a2R69Auv8leqgP5nGF5jXIVq2L2SRWOualp9AlKRfC6
 aD0h5ByE3/7v/B1V1j61mpI2uJEeWcaoP0dRHQIWvbdbUyra+fKGeYr3L9GMY580inwgJdYtZW
 tcV0xfcgF4tNDll/seBozE66jLE+q/0IyLaC+BUsNH4GHGjmATU4Yi1eiC91xZ//0Iobyj0+Lp
 LJ7/pcG/n+Zbdcet7/R8/7H3IQ0WgkUf/oZqYdqy7peglzCJ7Y9uUe65RLF1lf4kOcW33WcbVM
 wOW3w/pEPeb3jfX2Dh5/csLZe+zhIQ1SSVjFeoLan+0YtrHQ==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/pty.cc | 221 ++++++++++++++++++++++++++++++----
 1 file changed, 198 insertions(+), 23 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 838be4a2b..a4bb53573 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -34,6 +34,166 @@ details. */
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
+  CloseHandle (pi.hProcess);
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
@@ -2137,6 +2297,8 @@ fhandler_pty_master::close (int flag)
 ssize_t
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
+  size_t towrite = len;
+
   ssize_t ret;
   char *p = (char *) ptr;
   termios &ti = tc ()->ti;
@@ -2153,7 +2315,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	 If the reply for "CSI6n" is divided into multiple writes,
 	 pseudo console sometimes does not recognize it.  Therefore,
 	 put them together into wpbuf and write all at once. */
-      static const int wpbuf_len = strlen ("\033[32768;32868R");
+      /* Do the same for "CSIc" that is used by OpenConsole.exe */
+      static const int wpbuf_len = 64; /* for response to CSI6n and CSIc */
       static char wpbuf[wpbuf_len];
       static int ixput = 0;
       static int state = 0;
@@ -2162,7 +2325,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       WaitForSingleObject (input_mutex, mutex_timeout);
       for (size_t i = 0; i < len; i++)
 	{
-	  if (p[i] == '\033')
+	  if (state == 0 && p[i] == '\033')
 	    {
 	      if (ixput)
 		line_edit (wpbuf, ixput, ti, &ret);
@@ -2171,6 +2334,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  if (state == 1)
 	    {
+	      towrite--;
 	      if (ixput < wpbuf_len)
 		wpbuf[ixput++] = p[i];
 	      else
@@ -2182,21 +2346,27 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 		}
 	    }
 	  else
-	    line_edit (p + i, 1, ti, &ret);
-	  if (state == 1 && p[i] == 'R')
+	    {
+	      if (ixput)
+		line_edit (wpbuf, ixput, ti, &ret);
+	      get_ttyp ()->pcon_start = false;
+	      ptr = p + i;
+	      break;
+	    }
+	  if (state == 1 && isalpha(p[i]))
 	    state = 2;
-	}
-      if (state == 2)
-	{
-	  /* req_xfer_input is true if "ESC[6n" was sent just for
-	     triggering transfer_input() in master. In this case,
-	     the responce sequence should not be written. */
-	  if (!get_ttyp ()->req_xfer_input)
-	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
-	  ixput = 0;
-	  state = 0;
-	  get_ttyp ()->req_xfer_input = false;
-	  get_ttyp ()->pcon_start = false;
+	  if (state == 2)
+	    {
+	      /* req_xfer_input is true if "ESC[6n" was sent just for
+		 triggering transfer_input() in master. In this case,
+		 the responce sequence should not be written. */
+	      if (!get_ttyp ()->req_xfer_input)
+		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
+	      if (p[i] == 'R')
+		get_ttyp ()->req_xfer_input = false;
+	      ixput = 0;
+	      state = 0;
+	    }
 	}
       ReleaseMutex (input_mutex);
 
@@ -2220,8 +2390,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
-
-      return len;
+      if (towrite == 0)
+	return len;
     }
 
   /* Write terminal input to to_slave_nat pipe instead of output_handle
@@ -2233,14 +2403,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	 is activated. */
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
-      size_t nlen = len;
+      size_t nlen = towrite;
       if (get_ttyp ()->term_code_page != CP_UTF8)
 	{
 	  static mbstate_t mbp;
 	  buf = tp.c_get ();
 	  nlen = NT_MAX_PATH;
 	  convert_mb_str (CP_UTF8, buf, &nlen,
-			  get_ttyp ()->term_code_page, (const char *) ptr, len,
+			  get_ttyp ()->term_code_page, (const char *) ptr, nlen,
 			  &mbp);
 	}
 
@@ -3323,9 +3493,14 @@ fhandler_pty_slave::setup_pseudoconsole ()
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
-- 
2.51.0

