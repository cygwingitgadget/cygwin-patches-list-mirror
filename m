Return-Path: <SRS0=ItNv=G4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 0A76E4BB1C28
	for <cygwin-patches@cygwin.com>; Fri,  4 Sep 2026 03:59:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0A76E4BB1C28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0A76E4BB1C28
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788494362; cv=none;
	b=GG1qL+zKer1OGXRHC0eohg4QHy1QODqzSC+qVJ2UiZKtEcYUchp+OvW6t1nGx7h8MfFUSIN7uKz4Yi1Bb30ZwBtkD77wCk1419jAal52josWjpgUb7mhVC37ZVDAt8VdwCy2AglbgBFL0sQSGbPdizNRcT0Fhwzc5qD8kmG2Bho=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788494362; c=relaxed/simple;
	bh=UHmSyEysJPT19tOtUhA9dQ3Ge0TbAbRHT0z4wLtlT3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=JHYJJM8rw1EPtQWXdrzSB5gWYrM+YDTzMIshWBtQMzeLr3y2OJ+bXN4gliYeWIH1q6k3+OO1doUedcx7maAGLgZaMAl/HewhYB4OlBDJgrv195GRKbyB67QC3qmUj0jFMjBUIoAD2zgoTUJjCiWRkyoGxDVxxhvRqvv0g0vHRpw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=K9qgfrRc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0A76E4BB1C28
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=K9qgfrRc
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260904035917339.LOOB.17441.HP-Z230@nifty.com>;
          Fri, 4 Sep 2026 12:59:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Takashi Yano <takashi.yano@nift.ne.jp>
Subject: [PATCH] Cygwin: proc: Cache system process information
Date: Fri,  4 Sep 2026 12:58:56 +0900
Message-ID: <20260904035910.1376-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788494357;
 bh=G+bohTlmPyBtFLvetz0pmiwzbKZpVWeF54Wfsjd/gDI=;
 h=From:To:Cc:Subject:Date;
 b=K9qgfrRcbjPu+Wmf+9z473sPoxWJFgOn0Bn+/uIuy6Ahs4rcKpl90cNb/9ho89anNwqDFLtP
 +HDGItyAP9tXD3rrJ6SYE5pOpnTBjdv7eOZcBNAkFYdOwyXcq2f/bxf+wUSrwpDWPtuB1ETY74
 iBUo+ngl8DvOsnWrptBwSippngU8I8gCsaBX+L908f0bO1xXcnjBDOM4pAljKgBHbyHOHvLedM
 RzfUAnsGzrCYYFsdaiCjrslE8b7UT1T+YDnas66SxxDXsqmtnylNl+WWQry+oDrWLw34ltFvYe
 bFLq9Tohv6tCFkdr+O6L1q3aMa6kR7eyOphojbI3yBL7dh7w==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If a process reads /proc/<pid>/stat for multiple PIDs, current code
every time calls NtQuerySystemInformation(SystemProcessInformation).
In addition, the buffer size is estimated by calling that function
with increasing buffer size. This takes 15 - 20 msec. This is looks
short time, however it is not negligible in some situation. If the
number of the process is 100, reading /proc/<pid>/stat takes 1.5 -
2.0 sec. Due to this behaviour, process pane of the btop is very
heavy.

With this patch, system process information is cached per process
for a short time (20 msec) to improve efficiency. Also, the buffer
size needed by NtQuerySystemInformation() is stored in static area,
so that the number of function call is reduced (~1/7). As a result,
the process pane of btop becomes significantly light (takes only
~15 msec for 100 processes).

Signef-off-by: Takashi Yano <takashi.yano@nift.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/process.cc | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 537a4b370..97f3e0a2f 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1524,14 +1524,30 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
 {
   /* This isn't really heavy magic - just go through the processes' threads
      one by one and return a value accordingly.  Errors are silently ignored. */
+  const ULONGLONG cache_time = 20;
+  static NO_COPY muto cache_guard;
   NTSTATUS status;
-  PSYSTEM_PROCESS_INFORMATION p, sp;
-  ULONG n = 0x4000;
+  static PSYSTEM_PROCESS_INFORMATION p = NULL;
+  static ULONGLONG t0 = 0;
+  PSYSTEM_PROCESS_INFORMATION sp;
+  static ULONG last_n = 0x4000;
+  ULONG n;
   int state =' ';
 
+  cache_guard.init ("get_process_state")->acquire ();
+  n = last_n;
+
+  if (GetTickCount64 () - t0 < cache_time && p)
+    goto reuse_query;
+  else if (p)
+    {
+      free (p);
+      p = NULL;
+    }
+
   p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
   if (!p)
-    return state;
+    goto out;
   while (true)
     {
       status = NtQuerySystemInformation (SystemProcessInformation,
@@ -1550,6 +1566,9 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
 		    status, RtlNtStatusToDosError (status));
       goto out;
     }
+  last_n = n;
+  t0 = GetTickCount64 ();
+reuse_query:
   state = 'Z';
   sp = p;
   for (;;)
@@ -1579,7 +1598,7 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
       sp = (PSYSTEM_PROCESS_INFORMATION) ((char *) sp + sp->NextEntryOffset);
     }
 out:
-  free (p);
+  cache_guard.release ();
   return state;
 }
 
-- 
2.51.0

