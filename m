Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta30-sa.btinternet.com [213.120.69.36])
	by sourceware.org (Postfix) with ESMTPS id 4F6B83856DDA
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:41:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4F6B83856DDA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20230713114058.FQDF29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:40:58 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED324C6
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED324C6; Thu, 13 Jul 2023 12:40:58 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 07/11] Cygwin: testsuite: Fix for limited thread priority values
Date: Thu, 13 Jul 2023 12:39:00 +0100
Message-Id: <20230713113904.1752-8-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since commit 4b51e4c1, we return the actual thread priority, not what we
originally stored in the thread attributes.

Windows only supports 7 thread priority levels, which we map onto the 32
required by POSIX.  So, only a subset of values will be returned exactly
by by pthread_getschedparam() after pthread_setschedparam().

Adjust tests priority1, priority2 and inherit1 so they only check for
round-tripping priority values which can be exactly represented.

For CI, this needs to handle process priority class "below normal
priority" as well.

Also check that the ranmge of priority values is at least 32, as
required by POSIX.
---
 .../testsuite/winsup.api/pthread/inherit1.c   | 21 +++++++++++++++-
 .../testsuite/winsup.api/pthread/priority1.c  | 24 +++++++++++++++++--
 .../testsuite/winsup.api/pthread/priority2.c  | 22 +++++++++++++++--
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/winsup/testsuite/winsup.api/pthread/inherit1.c b/winsup/testsuite/winsup.api/pthread/inherit1.c
index 16c3f534b..f036462aa 100644
--- a/winsup/testsuite/winsup.api/pthread/inherit1.c
+++ b/winsup/testsuite/winsup.api/pthread/inherit1.c
@@ -50,6 +50,23 @@ void * func(void * arg)
   return (void *) (size_t)param.sched_priority;
 }
 
+// Windows only supports 7 thread priority levels, which we map onto the 32
+// required by POSIX.  The exact mapping also depends on the overall process
+// priority class. So only a subset of values will be returned exactly by
+// pthread_getschedparam() after pthread_setschedparam().
+int doable_pri(int pri)
+{
+  switch (GetPriorityClass(GetCurrentProcess()))
+    {
+    case BELOW_NORMAL_PRIORITY_CLASS:
+      return (pri == 2) || (pri ==  8) || (pri == 10) || (pri == 12) || (pri == 14) || (pri == 16) || (pri == 30);
+    case NORMAL_PRIORITY_CLASS:
+      return (pri == 2) || (pri == 12) || (pri == 14) || (pri == 16) || (pri == 18) || (pri == 20) || (pri == 30);
+    }
+
+  return TRUE;
+}
+
 int
 main()
 {
@@ -81,7 +98,9 @@ main()
       assert(pthread_setschedparam(mainThread, SCHED_FIFO, &mainParam) == 0);
       assert(pthread_getschedparam(mainThread, &policy, &mainParam) == 0);
       assert(policy == SCHED_FIFO);
-      assert(mainParam.sched_priority == prio);
+
+      if (doable_pri(prio))
+        assert(mainParam.sched_priority == prio);
 
       for (param.sched_priority = prio;
            param.sched_priority <= maxPrio;
diff --git a/winsup/testsuite/winsup.api/pthread/priority1.c b/winsup/testsuite/winsup.api/pthread/priority1.c
index a1e8d051d..135f77d76 100644
--- a/winsup/testsuite/winsup.api/pthread/priority1.c
+++ b/winsup/testsuite/winsup.api/pthread/priority1.c
@@ -50,7 +50,24 @@ void * func(void * arg)
   assert(policy == SCHED_FIFO);
   return (void *)(size_t)param.sched_priority;
 }
- 
+
+// Windows only supports 7 thread priority levels, which we map onto the 32
+// required by POSIX.  The exact mapping also depends on the overall process
+// priority class. So only a subset of values will be returned exactly by
+// pthread_getschedparam() after pthread_setschedparam().
+int doable_pri(int pri)
+{
+  switch (GetPriorityClass(GetCurrentProcess()))
+    {
+    case BELOW_NORMAL_PRIORITY_CLASS:
+      return (pri == 2) || (pri ==  8) || (pri == 10) || (pri == 12) || (pri == 14) || (pri == 16) || (pri == 30);
+    case NORMAL_PRIORITY_CLASS:
+      return (pri == 2) || (pri == 12) || (pri == 14) || (pri == 16) || (pri == 18) || (pri == 20) || (pri == 30);
+    }
+
+  return TRUE;
+}
+
 int
 main()
 {
@@ -61,6 +78,8 @@ main()
   int maxPrio = sched_get_priority_max(SCHED_FIFO);
   int minPrio = sched_get_priority_min(SCHED_FIFO);
 
+  assert((maxPrio - minPrio) >= 31);
+
   assert(pthread_attr_init(&attr) == 0);
   assert(pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) == 0);
 
@@ -71,7 +90,8 @@ main()
       assert(pthread_attr_setschedparam(&attr, &param) == 0);
       assert(pthread_create(&t, &attr, func, NULL) == 0);
       pthread_join(t, &result);
-      assert((int)(size_t) result == param.sched_priority);
+      if (doable_pri(param.sched_priority))
+	assert((int)(size_t) result == param.sched_priority);
     }
 
   return 0;
diff --git a/winsup/testsuite/winsup.api/pthread/priority2.c b/winsup/testsuite/winsup.api/pthread/priority2.c
index 0534e7ba1..f084efadf 100644
--- a/winsup/testsuite/winsup.api/pthread/priority2.c
+++ b/winsup/testsuite/winsup.api/pthread/priority2.c
@@ -54,7 +54,24 @@ void * func(void * arg)
   assert(policy == SCHED_FIFO);
   return (void *) (size_t)param.sched_priority;
 }
- 
+
+// Windows only supports 7 thread priority levels, which we map onto the 32
+// required by POSIX.  The exact mapping also depends on the overall process
+// priority class. So only a subset of values will be returned exactly by
+// pthread_getschedparam() after pthread_setschedparam().
+int doable_pri(int pri)
+{
+  switch (GetPriorityClass(GetCurrentProcess()))
+    {
+    case BELOW_NORMAL_PRIORITY_CLASS:
+      return (pri == 2) || (pri ==  8) || (pri == 10) || (pri == 12) || (pri == 14) || (pri == 16) || (pri == 30);
+    case NORMAL_PRIORITY_CLASS:
+      return (pri == 2) || (pri == 12) || (pri == 14) || (pri == 16) || (pri == 18) || (pri == 20) || (pri == 30);
+    }
+
+  return TRUE;
+}
+
 int
 main()
 {
@@ -73,7 +90,8 @@ main()
       assert(pthread_setschedparam(t, SCHED_FIFO, &param) == 0);
       assert(pthread_mutex_unlock(&startMx) == 0);
       pthread_join(t, &result);
-      assert((int)(size_t)result == param.sched_priority);
+      if (doable_pri(param.sched_priority))
+	assert((int)(size_t)result == param.sched_priority);
     }
 
   return 0;
-- 
2.39.0

