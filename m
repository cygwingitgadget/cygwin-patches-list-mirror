Return-Path: <SRS0=ItNv=G4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 5EFB84BAE7EB
	for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2026 01:25:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5EFB84BAE7EB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5EFB84BAE7EB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788485107; cv=none;
	b=walMoPpfKndYOl+BwosFKei44EVDSNFHQ8l2ejaJ/GXNMZcWE7cp7eM5ypW+t/lsAv2QajIzH0Sv4jga7MIZp48s78NM8Cgt84puGW3FETrtxg/ark1dPI6QzHXF5+qXZxFB+c8suT1BjubVkJTObGF3WMhxt8xLVUoDB8fpfO4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788485107; c=relaxed/simple;
	bh=6g+I4aZ8V1JA6xGO4ofIXOLa6wExSivbOrK+7HtBwDc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=OwH5Y0kyIF6W7CPRIPiytwnw3xinj2t69VIBvyYMfJdGP4HxnHZ7tfr5cvg+37VmCL5s2m3Nt12gJDJjsX36px1LsHu4BfEkGbJeaoiERT0lmfXeKDGX/1Oj/o+AQamcIg8LdKFvOZ8SIz48imOhTYJGuguW/OCwv6CW8kb3z2A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NgxFu5iC
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EFB84BAE7EB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=NgxFu5iC
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260904012503950.IDDI.60338.HP-Z230@nifty.com>;
          Fri, 4 Sep 2026 10:25:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: proc: Provides correct number of thread rather than 0
Date: Fri,  4 Sep 2026 10:24:44 +0900
Message-ID: <20260904012457.466-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788485104;
 bh=gjFnUQxuyJj50dXQKQ2jszEaYz0xjpZxajz1Wehfmh0=;
 h=From:To:Cc:Subject:Date;
 b=NgxFu5iChVYc8J9MlWcIPRV1tr7cbc+VSvuihfeTl8bDpwqaPsMmNPSChpPk3QBM8b2BzZRB
 ZnPnPnqVlPDBseSzC3hwg1K7951mR4uto60RpQ40p00VY1TgC1B/G50gT6lYb9xXdHbb9KrYBW
 RMTeJMLyi8UnkLNkUB5H1Jo0aI7ptyiZ4hGqB8lOQMGymu19OUsc9S5wL+zBCC9XaFy6Q6mJvJ
 J0dlhQoZIu9NjW6WcoYU0cZUEporFLqc45patbjsCbp4IrTpJh5yElIXRELlQgTAsbPOUwHbW7
 L0tYUBLtTlPjCW9ydijkQ23D0d3JHg4mTx8q4JeZccsSs1Fw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,KAM_NUMSUBJECT,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, /proc/<pid>/stat always reports 0 as the number of thread.
However, get_process_state() does know the thread count for the
process, so expose that value in /proc/<pid>/stat. Additionally, add
a "Threads:" entry to /proc/<pid>/status.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/proc.cc    |  4 ++--
 winsup/cygwin/fhandler/process.cc | 18 ++++++++++++------
 winsup/cygwin/release/3.7.0       |  3 +++
 3 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
index f1cd468fc..12a43afe2 100644
--- a/winsup/cygwin/fhandler/proc.cc
+++ b/winsup/cygwin/fhandler/proc.cc
@@ -437,12 +437,12 @@ format_proc_version (void *, char *&destbuf)
 static off_t
 format_proc_loadavg (void *, char *&destbuf)
 {
-  extern int get_process_state (DWORD dwProcessId);
+  extern int get_process_state (DWORD dwProcessId, DWORD *num_threads);
   unsigned int running = 0;
   winpids pids ((DWORD) 0);
 
   for (unsigned i = 0; i < pids.npids; i++)
-    switch (get_process_state (pids[i]->dwProcessId)) {
+    switch (get_process_state (pids[i]->dwProcessId, NULL)) {
       case 'O':
       case 'R':
 	running++;
diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index e00cae58d..537a4b370 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -81,7 +81,7 @@ static const virt_tab_t process_tab[] =
 
 static const int PROCESS_LINK_COUNT =
   (sizeof (process_tab) / sizeof (virt_tab_t)) - 1;
-int get_process_state (DWORD dwProcessId);
+int get_process_state (DWORD dwProcessId, DWORD *num_threads);
 static bool get_mem_values (DWORD dwProcessId, size_t &vmsize, size_t &vmrss,
 			    size_t &vmtext, size_t &vmdata, size_t &vmlib,
 			    size_t &vmshare);
@@ -1121,6 +1121,7 @@ format_process_stat (void *data, char *&destbuf)
 {
   _pinfo *p = (_pinfo *) data;
   char cmd[NAME_MAX + 1];
+  DWORD num_threads = 0;
   int state = 'R';
   unsigned long fault_count = 0UL,
 		vmsize = 0UL, vmrss = 0UL, vmmaxrss = 0UL;
@@ -1155,7 +1156,7 @@ format_process_stat (void *data, char *&destbuf)
   else if (p->process_state & PID_STOPPED)
     state = 'T';
   else
-    state = get_process_state (p->dwProcessId);
+    state = get_process_state (p->dwProcessId, &num_threads);
 
   int nice = 0, prio = 0;
 
@@ -1241,14 +1242,14 @@ format_process_stat (void *data, char *&destbuf)
 				   "%d %d %d %d "
 				   "%d %u %lu %lu %u %u "
 				   "%U %U %U %U "
-				   "%d %d %d %d "
+				   "%d %d %u %d "
 				   "%U "
 				   "%lu %ld %lu\n",
 			  p->pid, cmd, state,
 			  p->ppid, p->pgid, p->sid, tty_nr,
 			  -1, 0, fault_count, fault_count, 0, 0,
 			  utime, stime, utime, stime,
-			  prio, nice, 0, 0,
+			  prio, nice, num_threads, 0,
 			  start_time,
 			  vmsize, vmrss, vmmaxrss
 			  );
@@ -1259,6 +1260,7 @@ format_process_status (void *data, char *&destbuf)
 {
   _pinfo *p = (_pinfo *) data;
   char cmd[NAME_MAX + 1];
+  DWORD num_threads = 0;
   int state = 'R';
   const char *state_str = "unknown";
   size_t vmsize = 0, vmrss = 0, vmdata = 0, vmlib = 0, vmtext = 0, vmshare = 0;
@@ -1281,7 +1283,7 @@ format_process_status (void *data, char *&destbuf)
   else if (p->process_state & PID_STOPPED)
     state = 'T';
   else
-    state = get_process_state (p->dwProcessId);
+    state = get_process_state (p->dwProcessId, &num_threads);
   switch (state)
     {
     case 'O':
@@ -1327,6 +1329,7 @@ format_process_status (void *data, char *&destbuf)
 				   "VmStk:\t%8lu kB\n"
 				   "VmExe:\t%8lu kB\n"
 				   "VmLib:\t%8lu kB\n"
+				   "Threads:\t%u\n"
 				   "SigPnd:\t%016lx\n"
 				   "SigBlk:\t%016lx\n"
 				   "SigIgn:\t%016lx\n",
@@ -1340,6 +1343,7 @@ format_process_status (void *data, char *&destbuf)
 			  vmsize * kb_per_page, 0UL, vmrss * kb_per_page,
 			  vmdata * kb_per_page, 0UL, vmtext * kb_per_page,
 			  vmlib * kb_per_page,
+			  num_threads,
 			  pnd, blk, ign
 			  );
 }
@@ -1516,7 +1520,7 @@ format_process_mountinfo (void *data, char *&destbuf)
 }
 
 int
-get_process_state (DWORD dwProcessId)
+get_process_state (DWORD dwProcessId, DWORD *num_threads)
 {
   /* This isn't really heavy magic - just go through the processes' threads
      one by one and return a value accordingly.  Errors are silently ignored. */
@@ -1554,6 +1558,8 @@ get_process_state (DWORD dwProcessId)
 	{
 	  SYSTEM_THREADS *st;
 	  st = &sp->Threads[0];
+	  if (num_threads)
+	    *num_threads = sp->NumberOfThreads;
 	  state = 'S';
 	  for (unsigned i = 0; i < sp->NumberOfThreads; i++)
 	    {
diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
index 3f6a0ecd7..831c8d189 100644
--- a/winsup/cygwin/release/3.7.0
+++ b/winsup/cygwin/release/3.7.0
@@ -26,6 +26,9 @@ What's new:
   runs on a pty rather than on the console device originating from the pseudo
   console.
 
+- Expose the number of threads in the process in /proc/<pid>/stat and
+  /proc/<pid>/status.
+
 Fixes:
 ------
 
-- 
2.51.0

