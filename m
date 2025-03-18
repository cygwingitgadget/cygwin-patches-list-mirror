Return-Path: <SRS0=VJF9=WF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 3594B3858D29
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 07:54:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3594B3858D29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3594B3858D29
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742284486; cv=none;
	b=dPOXjPsNH7aj61ccx6b4lvK9jGvWMNtqF1vQE/MULD0q0V0wZgT7jxuCWO7BREJwc4yKxGoAdsQ59e8fkgoOdyA6jBNZyTMnoE3RBd7gCxo9m4zs7UOJlN08UZ1SyjiNG/M/0F3qOrTpukUEltFBQ3Ad4cyRBi/9ujYEetzJeKI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742284486; c=relaxed/simple;
	bh=oqTe+UYZxSVK/Zs3xKGSD82rHnS/8RmDMNyce/1sDZo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gZYlJ+osgLnv4iGC4ny5j01hYVOZqFXYC5QnTHgvd+tn25TG7Gwt2Gqrf1rB0Rpa9GdH8/PE0f44ywgeLZpBND573PgjJVQOYHqGfRTPZqg2+clkVNLWO7cm69B3Fg/N5Tu+ym5p4tu58c5fcJnGmvgpFPvHVrJqwEOvUjc8xIQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3594B3858D29
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 52I8064d047391;
	Tue, 18 Mar 2025 01:00:06 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdPfR3ZT; Mon Mar 17 23:59:56 2025
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>,
        Christian Franke <Christian.Franke@t-online.de>
Subject: [PATCH v2] Cygwin: Carry process affinity through to result
Date: Tue, 18 Mar 2025 00:53:57 -0700
Message-ID: <20250318075423.565-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013499.html>
References: <https://cygwin.com/pipermail/cygwin-patches/2025q1/013499.html>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Due to deficient testing, the current code doesn't return a valid result
to users of sched_getaffinity().  The updated code carries the determined
procmask through to the generation of result cpu mask.

Recognize Windows' limitation that if the process is multi-group (i.e.,
has threads in multiple cpu groups) there is no visibility to which
processors in other groups are being used.  One could remedy this by
looping through all the process' threads, but that could be expensive
so is left for future contemplation.  In addition, we'd have to maintain
our own copy of each thread's current group and mask in internal overhead.
(By the way, multi-group processes are only possible on Windows systems
with more than 64 hardware threads.)

A release note for 3.6.0 is included.

Reported-by: Christian Franke <Christian.Franke@t-online.de>
Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257616.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: 641ecb07533e ("Cygwin: Implement sched_[gs]etaffinity()")

---
 winsup/cygwin/release/3.6.0 |  4 ++++
 winsup/cygwin/sched.cc      | 11 +++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/release/3.6.0 b/winsup/cygwin/release/3.6.0
index d48ee114d..ad4a6f5dc 100644
--- a/winsup/cygwin/release/3.6.0
+++ b/winsup/cygwin/release/3.6.0
@@ -132,3 +132,7 @@ Fixes:
 - Fix starving of auxiliary signal return address stack in case signal
   handlers bail out (longjmp/setcontext).
   Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257648.html
+
+- Fix sched_getaffinity(2) to carry determined process affinity all the way
+  through to the returned result.
+  Addresses: https://cygwin.com/pipermail/cygwin/2025-March/257616.html
diff --git a/winsup/cygwin/sched.cc b/winsup/cygwin/sched.cc
index 2f4fbc31a..e15daad26 100644
--- a/winsup/cygwin/sched.cc
+++ b/winsup/cygwin/sched.cc
@@ -587,9 +587,16 @@ __sched_getaffinity_sys (pid_t pid, size_t sizeof_set, cpu_set_t *set)
 	  goto done;
 	}
 
-      KAFFINITY miscmask = groupmask (__get_cpus_per_group ());
+      KAFFINITY fullmask = groupmask (__get_cpus_per_group ());
+      /* if process is multi-group, we don't have processor visibility. */
+      /*TODO We could provide the missing Windows visibility by book-keeping
+        each thread's current group and mask in our thread overhead, updating
+        them on sched_set_thread_affinity() calls. We could then assemble the
+        total mask here by looping through all threads. */
+      if (groupcount > 1)
+	procmask = fullmask;
       for (int i = 0; i < groupcount; i++)
-	setgroup (sizeof_set, set, grouparray[i], miscmask);
+	setgroup (sizeof_set, set, grouparray[i], fullmask & procmask);
     }
   else
     status = ESRCH;
-- 
2.45.1

