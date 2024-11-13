Return-Path: <SRS0=g8FB=SI=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 8D7E73858D20
	for <cygwin-patches@cygwin.com>; Wed, 13 Nov 2024 06:03:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D7E73858D20
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D7E73858D20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731477843; cv=none;
	b=vWXuLppC1KCe2/yDHFiUg6B092xgelc81OkaqPqbnIMIWtV3/dwgm20zwbhuHC7lxJ83xfmCpbF0wj39magFqjA1k6ukCT49bqMyBTG1aPegwd1U3z51bU8jI1WDM+RYY9HsV7xZWT6TQMrO0Ru027rTlLMtF6km/W8YL9vBwYU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731477843; c=relaxed/simple;
	bh=mtAKmYNK+9GK4RHzefJgGtN8dHYQqA2zLPoN49VmTJs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GunX8ZzCmwgsJcMJqOBlfEfk5+NBjr8puuvBROxN2m3UJ1HhF9rGHiGNjOu41c5Wb3oA4qTY5m5D7FI+ZywWuwMV5W9GJ/q1rCsTA1HzeXFcvULVZwW417DLs5QD9qk5eiXGmN07yhbD8/CAN06IdImEiImbNqeM9H+/Sez9X5M=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4AD672wj081416;
	Tue, 12 Nov 2024 22:07:02 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdtewICZ; Tue Nov 12 22:07:01 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Mark Liam Brown <brownmarkliam@gmail.com>
Subject: [PATCH v2] Cygwin: Minor updates to load average calculations
Date: Tue, 12 Nov 2024 22:03:46 -0800
Message-ID: <20241113060354.2185-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Commentary wording adjusted to say ProcessorQueueLength counts threads,
not processes.  Also mention (upcoming) new tool /bin/loadavg.  The
release note for Cygwin 3.5.5 is updated.

In counting runnable threads, divide by NumberOfProcessors to model
distributing the threads among all processors.  Otherwise one gets e.g.
PQLs of 20 or more just running a few lively X applications.  These PQLs
vary greatly between kernel stats updates every 16ms, so are very clearly
short-term loads.  This change helps reduce jitter in load average
calculations.

At end of load_init(), obtain and discard the first measure of the
counters to deal with the first call always returning error, no data.
Follow this with a short delay so the next measure actually has data to
report.

At least one older version of Windows, i.e. Win10 Pro 21H1, has a different
name/location for the '% Processor Time' counter and is missing the
'Processor Queue Length' counter entirely.  Code is changed to support
both possible locations of the former and treat the latter as always
reporting 0.0.

Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: de7f13aa9ace (Cygwin: loadavg: improve debugging of load_init)

---
 winsup/cygwin/loadavg.cc    | 70 ++++++++++++++++++++++++++-----------
 winsup/cygwin/release/3.5.5 |  3 ++
 2 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
index 127591a2e..37da077fb 100644
--- a/winsup/cygwin/loadavg.cc
+++ b/winsup/cygwin/loadavg.cc
@@ -16,16 +16,26 @@
   A global load average estimate is maintained in shared memory.  Access to that
   is guarded by a mutex.  This estimate is only updated at most every 5 seconds.
 
-  We attempt to count running and runnable processes, but unlike linux we don't
-  count processes in uninterruptible sleep (blocked on I/O).
-
-  The number of running processes is estimated as (NumberOfProcessors) * (%
-  Processor Time).  The number of runnable processes is estimated as
-  ProcessorQueueLength.
+  Responsibility for updating the global load average is distributed among
+  all callers of the getloadavg() syscall.  If the user finds that that is not
+  consistent enough (e.g., 'uptime' reporting nonsense load averages), they can
+  use the new /bin/loadavg tool, which has a daemon mode to keep the global
+  load average updated consistently.
+
+  We attempt to count running processes and runnable threads, but unlike
+  linux we don't count threads in uninterruptible sleep (blocked on I/O).
+
+  The number of running processes is estimated as
+    (NumberOfProcessors) * (% Processor Time).
+  The number of runnable threads is estimated as
+    (ProcessorQueueLength) / (NumberOfProcessors).
+  The "instantaneous" load estimate is taken to be the sum of the results of
+  those two expressions.
 
   Note that PDH will only return data for '% Processor Time' afer the second
   call to PdhCollectQueryData(), as it's computed over an interval, so the first
-  attempt to estimate load will fail and 0.0 will be returned.
+  attempt to estimate load will fail and 0.0 will be returned.  (This nuisance
+  is now worked-around near the end of load_init() below.)
 
   We also assume that '% Processor Time' averaged over the interval since the
   last time getloadavg() was called is a good approximation of the instantaneous
@@ -62,31 +72,48 @@ static bool load_init (void)
 	debug_printf ("PdhOpenQueryW, status %y", status);
 	return false;
       }
+
     status = PdhAddEnglishCounterW (query,
 				    L"\\Processor(_Total)\\% Processor Time",
 				    0, &counter1);
     if (status != STATUS_SUCCESS)
       {
 	debug_printf ("PdhAddEnglishCounterW(time), status %y", status);
-	return false;
+
+	/* Windows 10 Pro 21H1, and maybe others, use an alternate name */
+	status = PdhAddEnglishCounterW (query,
+			L"\\Processor Information(_Total)\\% Processor Time",
+			0, &counter1);
+	if (status != STATUS_SUCCESS)
+	  {
+	    debug_printf ("PdhAddEnglishCounterW(alt time), status %y", status);
+	    return false;
+	  }
       }
+
+    /* Windows 10 Pro 21H1, and maybe others, are missing this counter */
     status = PdhAddEnglishCounterW (query,
 				    L"\\System\\Processor Queue Length",
 				    0, &counter2);
-
     if (status != STATUS_SUCCESS)
       {
 	debug_printf ("PdhAddEnglishCounterW(queue length), status %y", status);
-	return false;
+	; /* don't return false, just use zero later in calculations */
       }
 
     mutex = CreateMutex(&sec_all_nih, FALSE, "cyg.loadavg.mutex");
     if (!mutex) {
-      debug_printf("opening loadavg mutexfailed\n");
+      debug_printf("opening loadavg mutex failed\n");
       return false;
     }
 
     initialized = true;
+
+    /* obtain+discard first sample now; avoids PDH_INVALID_DATA in get_load */
+    (void) PdhCollectQueryData (query); /* i.o.w. take the error here */
+
+    /* Delay a short time so PdhCQD in caller will have data to collect */
+    Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */
   }
 
   return initialized;
@@ -101,24 +128,25 @@ static bool get_load (double *load)
   if (ret != ERROR_SUCCESS)
     return false;
 
-  /* Estimate the number of running processes as (NumberOfProcessors) * (%
-     Processor Time) */
+  /* Estimate the number of running processes as
+     (NumberOfProcessors) * (% Processor Time) */
   PDH_FMT_COUNTERVALUE fmtvalue1;
   ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
   if (ret != ERROR_SUCCESS)
     return false;
-
   double running = fmtvalue1.doubleValue * wincap.cpu_count () / 100;
 
-  /* Estimate the number of runnable processes using ProcessorQueueLength */
-  PDH_FMT_COUNTERVALUE fmtvalue2;
+  /* Estimate the number of runnable threads as
+     (ProcessorQueueLength) / (NumberOfProcessors) */
+  PDH_FMT_COUNTERVALUE fmtvalue2 = { 0 };
   ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
   if (ret != ERROR_SUCCESS)
-    return false;
+    ; /* don't return false, just treat as if zero was read */
 
-  LONG rql = fmtvalue2.longValue;
+  /* Divide the runnable thread count among NumberOfProcessors */
+  double rql = (double) fmtvalue2.longValue / (double) wincap.cpu_count ();
 
-  *load = rql + running;
+  *load = running + rql;
   return true;
 }
 
@@ -147,8 +175,8 @@ void loadavginfo::update_loadavg ()
   if (!get_load (&active_tasks))
     return;
 
-  /* Don't recalculate the load average if less than 5 seconds has elapsed since
-     the last time it was calculated */
+  /* Don't recalculate the load average if less than 5 seconds has elapsed
+     since the last time it was calculated */
   time_t curr_time = time (NULL);
   int delta_time = curr_time - last_time;
   if (delta_time < 5) {
diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index 2ca4572db..a83ea7d8a 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -33,3 +33,6 @@ Fixes:
 
 - Fix type of pthread_sigqueue() first parameter to match Linux.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-September/256439.html
+
+- Minor updates to load average calculations
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
-- 
2.45.1

