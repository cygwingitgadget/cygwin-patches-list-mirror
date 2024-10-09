Return-Path: <SRS0=VXfo=RF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 8019B3858D37
	for <cygwin-patches@cygwin.com>; Wed,  9 Oct 2024 05:20:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8019B3858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8019B3858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728451211; cv=none;
	b=ICq5r/JAVajxZYhfH5UDok7wGi1clsmfus540wfeFPQnSy/LZ5UUH+9dRyfWI/T+sSnvcEMXAr9vi7CPOPjGDXNYvfXtzkA1dJMyKuaQrJJGyVvXJ5ILAE3CCy/GB9VaJHJF9a8SmLwU5xhoK8ZORRtQp2I2FISXpGN5XasL/DY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728451211; c=relaxed/simple;
	bh=h+Kx8Fbnbqc0woUWY+MeZgV3h9SGdce8g5i6545F6xg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=sL9rt2+sIbsqc8eHhfG9XOs45nTNgvZfVTAGpGLlDuZSfDLtK1a8tYF6yIfdPStPU/W7Hsy4vd6ZETJk+NTsze2jvjchBKnAZETxUPFe2JYIRBCBmPiSdMbfzjf1Ru/PBMegxLw83Ar9I3PWE66x216xJVe1UpZP0lnlJjLF1Sk=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4995Nb9q052158;
	Tue, 8 Oct 2024 22:23:37 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdFOOHNj; Tue Oct  8 22:23:28 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Mark Liam Brown <brownmarkliam@gmail.com>
Subject: [PATCH] Cygwin: Minor updates to load average calculations
Date: Tue,  8 Oct 2024 22:19:39 -0700
Message-ID: <20241009051950.3170-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Commentary wording adjusted to say ProcessorQueueLength counts threads,
not processes.  Also mention (upcoming) new tool /bin/loadavg.

In counting runnable threads, divide by NumberOfProcessors to model
distributing the threads among all processors.  Otherwise one gets e.g.
PQLs of 20 or more just running a few active X applications.  These PQLs
vary greatly between kernel stats updates every 15ms, so are very clearly
short-term loads.  This change helps reduce jitter in load average
calculations.

At end of load_init(), obtain and discard the first measure of the
counters to deal with the first call always returning error, no data.
Follow this with a short delay so the next measure actually has data to
report.

Some older versions of Windows we still support have a different
location for the '% Processor Time' counter and are missing the
'Processor Queue Length' counter entirely.  Code is changed to support
both possible locations of the former and treat the latter as always
reporting 0.0.

Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 4dc982ddf60b (Cygwin: loadavg: improve debugging of load_init)

---
 winsup/cygwin/loadavg.cc | 55 ++++++++++++++++++++++++++++------------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/loadavg.cc b/winsup/cygwin/loadavg.cc
index 127591a2e..8e82b3cbd 100644
--- a/winsup/cygwin/loadavg.cc
+++ b/winsup/cygwin/loadavg.cc
@@ -16,16 +16,23 @@
   A global load average estimate is maintained in shared memory.  Access to that
   is guarded by a mutex.  This estimate is only updated at most every 5 seconds.
 
-  We attempt to count running and runnable processes, but unlike linux we don't
-  count processes in uninterruptible sleep (blocked on I/O).
+  Responsibility for updating the global load average is distributed among
+  all callers of the getloadavg() syscall.  If that is not consistent enough,
+  the new /bin/loadavg tool has a daemon mode to keep the global load average
+  updated regardless.
+
+  We attempt to count running processes and runnable threads, but unlike
+  linux we don't count threads in uninterruptible sleep (blocked on I/O).
 
   The number of running processes is estimated as (NumberOfProcessors) * (%
-  Processor Time).  The number of runnable processes is estimated as
-  ProcessorQueueLength.
+  Processor Time).  The number of runnable threads is estimated as
+  (ProcessorQueueLength) / (NumberOfProcessors).  The "instantaneous" load
+  estimate is taken to be the sum of those two numbers.
 
   Note that PDH will only return data for '% Processor Time' afer the second
   call to PdhCollectQueryData(), as it's computed over an interval, so the first
-  attempt to estimate load will fail and 0.0 will be returned.
+  attempt to estimate load will fail and 0.0 will be returned.  This nuisance
+  is now worked-around near the end of load_init() below.
 
   We also assume that '% Processor Time' averaged over the interval since the
   last time getloadavg() was called is a good approximation of the instantaneous
@@ -62,31 +69,46 @@ static bool load_init (void)
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
+	/* Older Windows versions we still support use an alternate name */
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
+    /* Older Windows versions we still support sometimes missing this counter */
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
+    Sleep (15); /* let other procs run; multiple yield()s aren't enough */
   }
 
   return initialized;
@@ -101,24 +123,25 @@ static bool get_load (double *load)
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
+  /* Estimate the number of runnable threads using ProcessorQueueLength */
   PDH_FMT_COUNTERVALUE fmtvalue2;
+  fmtvalue2.longValue = 0;
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
 
-- 
2.45.1

