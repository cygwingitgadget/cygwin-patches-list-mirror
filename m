Return-Path: <SRS0=5WD9=G6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 07B5E4BB8F61
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 11:11:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 07B5E4BB8F61
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 07B5E4BB8F61
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788693075; cv=none;
	b=tter9FBj7Dj7VVwkjrrteFIRQrXAIYqRI0pXWPrjgwIgZTl2sIElX2sQHzVji0I4BBaBJLry9Vq03CeWlFI1r+pMuncnXM2v+uX41Cqpfs4sYLWxNVnWQe13jaTSmt3iMXeIt3g0cjOolsbZ47UZXRDQ6TZcjfTbTpGfVBNTJOc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788693075; c=relaxed/simple;
	bh=de2BHvBWFeMaw0EIe3x9POJhmEIHVLjLNpH77Ld77kw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=pbijhE1a30X3lnZqZiIgrHQAuKhdE+ek1ziaAhwUUKAax4/EuMw/6YmOBxOCCu0ZlWdQJl5NuAFOAbGTwrg+jDIRYWpl0+fPDe/y/SGL1Seb79cVLr5ANFUL2IZ8uuIoK1pxQcnPImisMWIDuW74PDWp7t7OeywUweZgMkX7dTE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PEUKDiAw
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 07B5E4BB8F61
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=PEUKDiAw
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260906111111011.SSAK.117312.HP-Z230@nifty.com>;
          Sun, 6 Sep 2026 20:11:11 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: proc: Cache system process information
Date: Sun,  6 Sep 2026 20:10:54 +0900
Message-ID: <20260906111103.102115-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1788693071;
 bh=O4NSKlzLXxlH0PtunO8rqxVswK6in/j2D17XVnlNLs4=;
 h=From:To:Cc:Subject:Date;
 b=PEUKDiAw9ahfQEEy2p9uJoH1AKKrW/iouLwpaOnQ9ShaIvLQPY6YwS4RWicQtkshPCLwpa5Z
 tx78W5FPVuGxry/lLljI5VK/NISvkOEyY/hDagGusJUshVsbsHmF80wZabCwLd29KH2Mvgugd1
 uGub0J0il5X4HF/VZWlquQTHUycjT3urKpHyhE/qZeCwWSiKawjgJ+152xaT7mIoUCRlTQYJEE
 ylVxQP1ZAk88/qYK4Lk1uU7jztC9nRfOgEZFgtVpbmB4vGRqNvnoF8pYnycvwkdoaU7VntR7Ib
 jasd2GPlQ9O5Cd25UJTc3r+cdUDE/OpYoPJZVoX11UbgIA0Q==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

If a process reads /proc/<pid>/stat for multiple PIDs, current code
every time calls NtQuerySystemInformation(SystemProcessInformation).
In addition, the buffer size is estimated by calling that function
with increasing buffer size. This takes 15 - 20 msec. This looks
short time, however it is not negligible in some situation. If the
number of processes is 100, reading /proc/<pid>/stat takes 1.5 - 2.0
sec. Due to this behaviour, process pane of the btop is very heavy.

With this patch, system process information is cached per process
for a short time (20 msec) to improve efficiency. The buffer is
allocated first time when the corresponding /proc file system is
read, and held until process exits. If the buffer size needed by
NtQuerySystemInformation() is increased, the buffer will be re-
allocated, however never freed. The buffer pointer and the buffer
size are stored in the static area, so that the number of the
function call is reduced much. As a result, the process pane of
btop becomes significantly light. It takes only ~15 msec for 100
processes.

Fixes: 9ba913a56dd6 ("* fhandler_process.cc (process_listing): Add 'stat' and 'statm'.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Mark Geisert <mark@maxrnd.com>
---
 winsup/cygwin/fhandler/process.cc | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
index 537a4b370..404668661 100644
--- a/winsup/cygwin/fhandler/process.cc
+++ b/winsup/cygwin/fhandler/process.cc
@@ -1524,14 +1524,24 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
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
+  static ULONG n = 0x4000;
   int state =' ';
 
-  p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
+  cache_guard.init ("get_process_state")->acquire ();
+
+  if (GetTickCount64 () - t0 < cache_time && p)
+    goto reuse_query;
+
+  if (!p)
+    p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
   if (!p)
-    return state;
+    goto out;
   while (true)
     {
       status = NtQuerySystemInformation (SystemProcessInformation,
@@ -1550,6 +1560,8 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
 		    status, RtlNtStatusToDosError (status));
       goto out;
     }
+  t0 = GetTickCount64 ();
+reuse_query:
   state = 'Z';
   sp = p;
   for (;;)
@@ -1579,7 +1591,7 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
       sp = (PSYSTEM_PROCESS_INFORMATION) ((char *) sp + sp->NextEntryOffset);
     }
 out:
-  free (p);
+  cache_guard.release ();
   return state;
 }
 
-- 
2.51.0

