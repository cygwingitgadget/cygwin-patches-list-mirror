Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id C008E4B920E4
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:11:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C008E4B920E4
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C008E4B920E4
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444278; cv=none;
	b=bLYmGnXZI6ZJJQJByFbEocNFdFiO6F+bVUhHG55YL3HdICZOC2EtFdTcLJiCcjsZLh8LRxywt5T+4Zfn1F8aFLVXabWBP5DFybjYQZfyuMzpxd1cXrM0tIfhfW1cEmkKbqu1ooaicXsNFM7ZIwmQq0+ozWQbeaHy8sBJ9yYpzK0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444278; c=relaxed/simple;
	bh=FgKYXRij09fd3OWmnI5kIBttKbvHrUfpwsRFs+2/1Zo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=xxygba7e0Czviadlzbqu/gJP2QIy13j/aFuZvOq5o3PECU3QdE8B+NYBV0LeiCFSTpH9ynz+uFh5vy8Fmbh8Iik20Bc/BN84Dh15yA1gdURkP2gvzarshd+Te7lZEqHdTTma+L7i4rlapBv7M7V7aZzduSF8Z6CbADy/15pmRaI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C008E4B920E4
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=YgxpMHDn
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325131116067.TVQG.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:11:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Thomas Wolff <towo@towo.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v6 1/3] Cygwin: pty: Use OpenConsole.exe if available
Date: Wed, 25 Mar 2026 22:09:57 +0900
Message-ID: <20260325131056.69116-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
 <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444276;
 bh=CbEg/ePeXlFy154339rZ3MVyyWEbr6W4/wepgFlcVHk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YgxpMHDnZ7y1nwVr7ztwaFLAtK9wNJ6iwRiKL1U2XJirURL97xZmvHygzQdBUpE/y/jTMo8o
 R29utg5bzqwZ35/cEAS54AxgfZ/+fsqs2ZJo+HOs6bSOAPyMt1zRH9dsOaZu/TaKl/oF0/poQr
 W4ZX+YvbUA4CVyWUuVl80FVCcbVfp8hIs9JUOc33YuOCAzabTs5oV4imayd4JE362NCgZXhqkV
 DiKidffkg8/cXYquBcpLZWRfHgX+i/mQD6XT8J3Lxc7N2iLuL7c7d2/rIefh+0oKO0G+b5vZwb
 rojFAfx91Rwt3dl6NqRm8ATML2DOHZS2S0jIzhFbBM//2cNw==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_ASCII_DIVIDERS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch replaces legacy conhost.exe with OpenConsole.exe if
it is available. This enables various new features such as mouse
support in pseudo console and bug fixes. The legacy conhost has
problems, e.g. character attributes are mangled or ignored, and
terminal reports are not passed through. This patch resolve the
issue by loading /usr/bin/OpenConsole.exe instead of conhost.exe
if it is available.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Suggested-by: Thomas Wolff <towo@towo.net>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/environ.cc      |   1 +
 winsup/cygwin/fhandler/pty.cc | 173 +++++++++++++++++++++++++++++++++-
 winsup/cygwin/globals.cc      |   1 +
 3 files changed, 172 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
index d4cedcbdf..956a04a0c 100644
--- a/winsup/cygwin/environ.cc
+++ b/winsup/cygwin/environ.cc
@@ -114,6 +114,7 @@ static struct parse_thing
   } known[] NO_COPY =
 {
   {"disable_pcon", {&disable_pcon}, setbool, NULL, {{false}, {true}}},
+  {"use_legacy_pcon", {&use_legacy_pcon}, setbool, NULL, {{false}, {true}}},
   {"error_start", {func: error_start_init}, isfunc, NULL, {{0}, {0}}},
   {"export", {&export_settings}, setbool, NULL, {{false}, {true}}},
   {"glob", {func: glob_init}, isfunc, NULL, {{0}, {s: "normal"}}},
diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index dda892269..84ce9a7dc 100644
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
+static HRESULT
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
+  CloseHandle (h_read_pipe);
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
@@ -3500,9 +3660,16 @@ fhandler_pty_slave::setup_pseudoconsole ()
       const DWORD inherit_cursor = 1;
       hpcon = NULL;
       SetLastError (ERROR_SUCCESS);
-      HRESULT res = CreatePseudoConsole (size, get_handle_nat (),
-					 get_output_handle_nat (),
-					 inherit_cursor, &hpcon);
+      /* Try OpenConsole.exe before conhost.exe */
+      HRESULT res = E_FAIL;
+      if (!use_legacy_pcon)
+	res = CreatePseudoConsole_new (size, get_handle_nat (),
+				       get_output_handle_nat (),
+				       inherit_cursor, &hpcon);
+      if (res != S_OK) /* Fallback to legacy conhost.exe */
+        res = CreatePseudoConsole (size, get_handle_nat (),
+				   get_output_handle_nat (),
+				   inherit_cursor, &hpcon);
       if (res != S_OK || GetLastError () == ERROR_PROC_NOT_FOUND)
 	{
 	  if (res != S_OK)
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index f73c35f88..71ffbe793 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -73,6 +73,7 @@ bool reset_com;
 bool wincmdln;
 winsym_t allow_winsymlinks = WSYM_default;
 bool disable_pcon;
+bool use_legacy_pcon;
 bool winjitdebug = false;
 
 /* Taken from BSD libc:
-- 
2.51.0

