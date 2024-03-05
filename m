Return-Path: <SRS0=ZRpm=KL=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1007.nifty.com (mta-snd01009.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id CA0D93858D20
	for <cygwin-patches@cygwin.com>; Tue,  5 Mar 2024 14:48:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA0D93858D20
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CA0D93858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709650135; cv=none;
	b=sroQZcY4aNBqEJkHHzTOR8Aw3ekLyAxHwLBXOqLVyCNupkrSrwc2nVQg5lKv/kOejwtu3BkGxNjHh5y9VxWUKJmjiE5yC9OsVdUkjYPXqKa931BJUaCA4MLVvFhQKyr4c02W3zE6vPvvGvN+erbJ1Lz41PSjDG06jbg7bS5YpX4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709650135; c=relaxed/simple;
	bh=+aSYNJthYQF1PjNGDCVnsVwovS0kqx9cPTsX/IV3Q9o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WdtmGJQ4ABJsl8HrEB0bP6OzU9owyssLRJqwsyGU/8Foel5bh+VJ8AxBXq/Uq+K9h3Phjy0HX7VAIh5HO/bH54napKLqhj7zkDRQvlSjvYdVrpDMLaP1TbFhw7cV6C8UtjIboHSkEJ5sSD4xhCfLDOXbQ0OmO0ABcaLqWaLxC+E=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta1007.nifty.com with ESMTP
          id <20240305144850464.HMJC.5813.localhost.localdomain@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 5 Mar 2024 23:48:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v3] Cygwin: pipe: Give up to use query_hdl for non-cygwin apps.
Date: Tue,  5 Mar 2024 23:48:27 +0900
Message-ID: <20240305144836.1675-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Non-cygwin app may call ReadFile() for empty pipe, which makes
NtQueryObject() for ObjectNameInformation block in fhandler_pipe::
get_query_hdl_per_process. Therefore, do not to try to get query_hdl
for non-cygwin apps.

Addresses: https://github.com/msys2/msys2-runtime/issues/202

Fixes: b531d6b06eeb ("Cygwin: pipe: Introduce temporary query_hdl.")
Reported-by: Alisa Sireneva, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 57 ++++++++--------------------------
 winsup/cygwin/release/3.5.2    |  4 +++
 2 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 1a97108b5..dc3086494 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -1197,53 +1197,24 @@ HANDLE
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
+	NtQueryObject() for ObjectNameInformation block. Therefore, do
+	not try to get query_hdl for non-cygwin apps. */
+      _pinfo *p = pids[i];
+      if (!p || ISSTATE (p, PID_NOTCYGWIN))
+	continue;
 
-  for (LONG i = (LONG) n_process - 1; i >= 0; i--)
-    {
       HANDLE proc = OpenProcess (PROCESS_DUP_HANDLE
 				 | PROCESS_QUERY_INFORMATION,
-				 0, proc_pids[i]);
+				 0, p->dwProcessId);
       if (!proc)
 	continue;
 
@@ -1307,7 +1278,6 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 	      query_hdl_proc = proc;
 	      query_hdl_value = (HANDLE)(intptr_t) phi->Handles[j].HandleValue;
 	      HeapFree (GetProcessHeap (), 0, phi);
-	      HeapFree (GetProcessHeap (), 0, proc_pids);
 	      return h;
 	    }
 close_handle:
@@ -1317,6 +1287,5 @@ close_handle:
 close_proc:
       CloseHandle (proc);
     }
-  HeapFree (GetProcessHeap (), 0, proc_pids);
   return NULL;
 }
diff --git a/winsup/cygwin/release/3.5.2 b/winsup/cygwin/release/3.5.2
index fd3c768de..e6782c1c0 100644
--- a/winsup/cygwin/release/3.5.2
+++ b/winsup/cygwin/release/3.5.2
@@ -9,3 +9,7 @@ Fixes:
 - Fix a race issue between console open() and close() which is caused
   by state mismatch between con.owner and console attaching state.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-March/255575.html
+
+- Fix a problem that select() call for write-side of a pipe possibly
+  hangs with non-cygwin reader.
+  Addresses: https://github.com/msys2/msys2-runtime/issues/202
-- 
2.43.0

