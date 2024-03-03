Return-Path: <SRS0=DLLh=KJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1013.nifty.com (mta-snd01009.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 70D993858C55
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 11:38:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 70D993858C55
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 70D993858C55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709465917; cv=none;
	b=NLR+NxaKDW5yUr7VsGz9L03DeN6T6+5k0q8haW12K2a9DyjjDSg1y6EOsrHjhUWjS+G6Ye9TgE/3kx++yyphxeVh9a6BbADK6WvlF93TXfxaDjJRNmMlrxwJHX5C+askeFABHvCkQBxYj1HMfCnasoTmk+OVjhG19D5S78NX8eo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709465917; c=relaxed/simple;
	bh=QsHQwR1ANecl6/jXhDbR59J58KxGdWPmDM735AmL7ek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n6Mh9FGXLAY98kz6sjnDeVkpqPpytBoMw2g5Zaur/WR40IqKOlVm1SnPVrsajw+4RUPsxaOzyaaS0QkLwMXGZ9qyPVode7vQQGfrqn7g83JNQ0AltFAE98jWTGGbTYRX5LsqQxbxpaC8ZmoHJ5E7WVTo1i9J0kSILqBRABLMK9k=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1013.nifty.com with ESMTP
          id <20240303113833262.BIPU.71349.localhost.localdomain@nifty.com>;
          Sun, 3 Mar 2024 20:38:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Alisa,
	Sireneva,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pipe: Give up to use query_hdl for non-cygwin apps.
Date: Sun,  3 Mar 2024 20:38:09 +0900
Message-ID: <20240303113818.1484-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Non-cygwin app may call ReadFile() for empty pipe, which makes
NtQueryObject() for ObjectNameInformation block in fhandler_pipe::
get_query_hdl_per_process. Therefore, stop to try to get query_hdl
for non-cygwin apps.

Addresses: https://github.com/msys2/msys2-runtime/issues/202

Fixes: b531d6b06eeb ("Cygwin: pipe: Introduce temporary query_hdl.")
Reported-by: Alisa Sireneva, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 62 ++++++++++------------------------
 winsup/cygwin/release/3.5.2    |  4 +++
 2 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 1a97108b5..bdc2e6a37 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -1197,53 +1197,29 @@ HANDLE
 fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 					  OBJECT_NAME_INFORMATION *ntfn)
 {
-  NTSTATUS status;
-  ULONG len;
-  DWORD n_process = 256;
-  PSYSTEM_PROCESS_INFORMATION spi;
-  do
-    { /* Enumerate processes */
-      DWORD nbytes = n_process * sizeof (SYSTEM_PROCESS_INFORMATION);
-      spi = (PSYSTEM_PROCESS_INFORMATION) HeapAlloc (GetProcessHeap (),
-						     0, nbytes);
-      if (!spi)
-	return NULL;
-      status = NtQuerySystemInformation (SystemProcessInformation,
-					 spi, nbytes, &len);
-      if (NT_SUCCESS (status))
-	break;
-      HeapFree (GetProcessHeap (), 0, spi);
-      n_process *= 2;
-    }
-  while (n_process < (1L<<20) && status == STATUS_INFO_LENGTH_MISMATCH);
-  if (!NT_SUCCESS (status))
-    return NULL;
+  winpids pids ((DWORD) 0);
 
-  /* In most cases, it is faster to check the processes in reverse order.
-     To do this, store PIDs into an array. */
-  DWORD *proc_pids = (DWORD *) HeapAlloc (GetProcessHeap (), 0,
-					  n_process * sizeof (DWORD));
-  if (!proc_pids)
+  /* In most cases, it is faster to check the processes in reverse order. */
+  for (LONG i = (LONG) pids.npids - 1; i >= 0; i--)
     {
-      HeapFree (GetProcessHeap (), 0, spi);
-      return NULL;
-    }
-  PSYSTEM_PROCESS_INFORMATION p = spi;
-  n_process = 0;
-  while (true)
-    {
-      proc_pids[n_process++] = (DWORD)(intptr_t) p->UniqueProcessId;
-      if (!p->NextEntryOffset)
-	break;
-      p = (PSYSTEM_PROCESS_INFORMATION) ((char *) p + p->NextEntryOffset);
-    }
-  HeapFree (GetProcessHeap (), 0, spi);
+      NTSTATUS status;
+      ULONG len;
+
+      /* Non-cygwin app may call ReadFile() for empty pipe, which makes
+	NtQueryObject() for ObjectNameInformation block. Therefore, stop
+	to try to get query_hdl for non-cygwin apps. */
+      _pinfo *p = pids[i];
+      if (!p)
+	continue;
+      pid_t cygpid;
+      if (!(cygpid = cygwin_pid (p->dwProcessId)))
+	continue;
+      if (ISSTATE (p, PID_NOTCYGWIN))
+	continue;
 
-  for (LONG i = (LONG) n_process - 1; i >= 0; i--)
-    {
       HANDLE proc = OpenProcess (PROCESS_DUP_HANDLE
 				 | PROCESS_QUERY_INFORMATION,
-				 0, proc_pids[i]);
+				 0, p->dwProcessId);
       if (!proc)
 	continue;
 
@@ -1307,7 +1283,6 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 	      query_hdl_proc = proc;
 	      query_hdl_value = (HANDLE)(intptr_t) phi->Handles[j].HandleValue;
 	      HeapFree (GetProcessHeap (), 0, phi);
-	      HeapFree (GetProcessHeap (), 0, proc_pids);
 	      return h;
 	    }
 close_handle:
@@ -1317,6 +1292,5 @@ close_handle:
 close_proc:
       CloseHandle (proc);
     }
-  HeapFree (GetProcessHeap (), 0, proc_pids);
   return NULL;
 }
diff --git a/winsup/cygwin/release/3.5.2 b/winsup/cygwin/release/3.5.2
index 7d8df9489..efd30b64a 100644
--- a/winsup/cygwin/release/3.5.2
+++ b/winsup/cygwin/release/3.5.2
@@ -5,3 +5,7 @@ Fixes:
   is already unmapped due to race condition. To avoid this issue,
   shared console memory will be kept mapped if it belongs to CTTY.
   Addresses:  https://cygwin.com/pipermail/cygwin/2024-February/255561.html
+
+- Fix a problem that select() call for write-side of a pipe possibly
+  hangs with non-cygwin reader.
+  Addresses: https://github.com/msys2/msys2-runtime/issues/202
-- 
2.43.0

