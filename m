Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 7E5483858D39
 for <cygwin-patches@cygwin.com>; Tue, 19 Oct 2021 08:40:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7E5483858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 19J8eTvH005998;
 Tue, 19 Oct 2021 17:40:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 19J8eTvH005998
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1634632835;
 bh=36xVRXfzQzxJkRTbFFByB1O0X0Hrv3nQvC54q5c/960=;
 h=From:To:Cc:Subject:Date:From;
 b=fLIYEp5hVyQap8UCPqJM7aKgjth18DxOw/rsvtEaj4DM7/mErv4yDBxkiz/ra0fCj
 tknaMdpvmELuH+ugzjS/S6BKzcAgQ+CEjY1u//JHqwLBSOkGkc/ek66UsEvbdPJbJe
 fu/P/IfXd+I6fzAfRGYgv9eoEbOzdJbEr450jUpcykuI3CYovRdojSLXPg3FbMlNa4
 Wtvwb+MoZBR9jfPneXOm1B1h8yfcjjCC+4WkbLiTat09eBPo1Pe8+gm6tPzlXJss8z
 KT/i3/NwVh0aY2pNzYW6cyC9FG3SbWtK9LFRVKar+WjzHQ24XA2MepYoaOAEi5x6ZH
 Y0aMYzHojsGhg==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Use NtQuerySystemInformation() instead of
 EnumProcesses().
Date: Tue, 19 Oct 2021 17:40:19 +0900
Message-Id: <20211019084019.1660-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 19 Oct 2021 08:40:56 -0000

- Using EnumProcess() breaks Windows Vista compatibility. This patch
  replaces EnumProcesses() with NtQuerySystemInformation().

Addresses:
https://cygwin.com/pipermail/cygwin-developers/2021-October/012422.html
---
 winsup/cygwin/fhandler_pipe.cc | 50 +++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/fhandler_pipe.cc b/winsup/cygwin/fhandler_pipe.cc
index dd8b4f317..63e432160 100644
--- a/winsup/cygwin/fhandler_pipe.cc
+++ b/winsup/cygwin/fhandler_pipe.cc
@@ -20,7 +20,6 @@ details. */
 #include "pinfo.h"
 #include "shared_info.h"
 #include "tls_pbuf.h"
-#include <psapi.h>
 
 /* This is only to be used for writing.  When reading,
 STATUS_PIPE_EMPTY simply means there's no data to be read. */
@@ -1190,27 +1189,47 @@ HANDLE
 fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 					  OBJECT_NAME_INFORMATION *ntfn)
 {
+  NTSTATUS status;
   ULONG len;
-  BOOL res;
   DWORD n_process = 256;
-  DWORD *proc_pids;
+  PSYSTEM_PROCESS_INFORMATION spi;
   do
     { /* Enumerate processes */
-      DWORD nbytes = n_process * sizeof (DWORD);
-      proc_pids = (DWORD *) HeapAlloc (GetProcessHeap (), 0, nbytes);
-      if (!proc_pids)
+      DWORD nbytes = n_process * sizeof (SYSTEM_PROCESS_INFORMATION);
+      spi = (PSYSTEM_PROCESS_INFORMATION) HeapAlloc (GetProcessHeap (),
+						     0, nbytes);
+      if (!spi)
 	return NULL;
-      res = EnumProcesses (proc_pids, nbytes, &len);
-      if (res && len < nbytes)
+      status = NtQuerySystemInformation (SystemProcessInformation,
+					 spi, nbytes, &len);
+      if (NT_SUCCESS (status))
 	break;
-      res = FALSE;
-      HeapFree (GetProcessHeap (), 0, proc_pids);
+      HeapFree (GetProcessHeap (), 0, spi);
       n_process *= 2;
     }
-  while (n_process < (1L<<20));
-  if (!res)
+  while (n_process < (1L<<20) && status == STATUS_INFO_LENGTH_MISMATCH);
+  if (!NT_SUCCESS (status))
     return NULL;
-  n_process = len / sizeof (DWORD);
+
+  /* In most cases, it is faster to check the processes in reverse order.
+     To do this, store PIDs into an array. */
+  DWORD *proc_pids = (DWORD *) HeapAlloc (GetProcessHeap (), 0,
+					  n_process * sizeof (DWORD));
+  if (!proc_pids)
+    {
+      HeapFree (GetProcessHeap (), 0, spi);
+      return NULL;
+    }
+  PSYSTEM_PROCESS_INFORMATION p = spi;
+  n_process = 0;
+  while (true)
+    {
+      proc_pids[n_process++] = (DWORD)(intptr_t) p->UniqueProcessId;
+      if (!p->NextEntryOffset)
+	break;
+      p = (PSYSTEM_PROCESS_INFORMATION) ((char *) p + p->NextEntryOffset);
+    }
+  HeapFree (GetProcessHeap (), 0, spi);
 
   for (LONG i = (LONG) n_process - 1; i >= 0; i--)
     {
@@ -1221,7 +1240,6 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 	continue;
 
       /* Retrieve process handles */
-      NTSTATUS status;
       DWORD n_handle = 256;
       PPROCESS_HANDLE_SNAPSHOT_INFORMATION phi;
       do
@@ -1255,8 +1273,8 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 
 	  /* Retrieve handle */
 	  HANDLE h = (HANDLE)(intptr_t) phi->Handles[j].HandleValue;
-	  res = DuplicateHandle (proc, h, GetCurrentProcess (), &h,
-				 FILE_READ_DATA, 0, 0);
+	  BOOL res = DuplicateHandle (proc, h, GetCurrentProcess (), &h,
+				      FILE_READ_DATA, 0, 0);
 	  if (!res)
 	    continue;
 
-- 
2.33.0

