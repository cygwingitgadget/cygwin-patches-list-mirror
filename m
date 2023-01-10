Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-045.btinternet.com (mailomta28-re.btinternet.com [213.120.69.121])
	by sourceware.org (Postfix) with ESMTPS id 0360138493DA
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0360138493DA
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-045.btinternet.com with ESMTP
          id <20230110163748.ZARG10658.re-prd-fep-045.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:48 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A47C
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A47C; Tue, 10 Jan 2023 16:37:48 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/8] Cygwin: testsuite: Update pthread tests for default SCHED_FIFO
Date: Tue, 10 Jan 2023 16:37:07 +0000
Message-Id: <20230110163709.16265-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Update for default (and only) thread scheduler policy is SCHED_FIFO.
---
 winsup/testsuite/winsup.api/pthread/inherit1.c  | 8 ++++----
 winsup/testsuite/winsup.api/pthread/priority1.c | 6 +++---
 winsup/testsuite/winsup.api/pthread/priority2.c | 8 ++++----
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/winsup/testsuite/winsup.api/pthread/inherit1.c b/winsup/testsuite/winsup.api/pthread/inherit1.c
index 545e4596f..16c3f534b 100644
--- a/winsup/testsuite/winsup.api/pthread/inherit1.c
+++ b/winsup/testsuite/winsup.api/pthread/inherit1.c
@@ -65,8 +65,8 @@ main()
   int policy;
   int inheritsched = -1;
 
-  assert((maxPrio = sched_get_priority_max(SCHED_OTHER)) != -1);
-  assert((minPrio = sched_get_priority_min(SCHED_OTHER)) != -1);
+  assert((maxPrio = sched_get_priority_max(SCHED_FIFO)) != -1);
+  assert((minPrio = sched_get_priority_min(SCHED_FIFO)) != -1);
 
   assert(pthread_attr_init(&attr) == 0);
   assert(pthread_attr_setinheritsched(&attr, PTHREAD_INHERIT_SCHED) == 0);
@@ -78,9 +78,9 @@ main()
       mainParam.sched_priority = prio;
 
       /* Change the main thread priority */
-      assert(pthread_setschedparam(mainThread, SCHED_OTHER, &mainParam) == 0);
+      assert(pthread_setschedparam(mainThread, SCHED_FIFO, &mainParam) == 0);
       assert(pthread_getschedparam(mainThread, &policy, &mainParam) == 0);
-      assert(policy == SCHED_OTHER);
+      assert(policy == SCHED_FIFO);
       assert(mainParam.sched_priority == prio);
 
       for (param.sched_priority = prio;
diff --git a/winsup/testsuite/winsup.api/pthread/priority1.c b/winsup/testsuite/winsup.api/pthread/priority1.c
index b740b997f..a1e8d051d 100644
--- a/winsup/testsuite/winsup.api/pthread/priority1.c
+++ b/winsup/testsuite/winsup.api/pthread/priority1.c
@@ -47,7 +47,7 @@ void * func(void * arg)
   struct sched_param param;
 
   assert(pthread_getschedparam(pthread_self(), &policy, &param) == 0);
-  assert(policy == SCHED_OTHER);
+  assert(policy == SCHED_FIFO);
   return (void *)(size_t)param.sched_priority;
 }
  
@@ -58,8 +58,8 @@ main()
   pthread_attr_t attr;
   void * result = NULL;
   struct sched_param param;
-  int maxPrio = sched_get_priority_max(SCHED_OTHER);
-  int minPrio = sched_get_priority_min(SCHED_OTHER);
+  int maxPrio = sched_get_priority_max(SCHED_FIFO);
+  int minPrio = sched_get_priority_min(SCHED_FIFO);
 
   assert(pthread_attr_init(&attr) == 0);
   assert(pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED) == 0);
diff --git a/winsup/testsuite/winsup.api/pthread/priority2.c b/winsup/testsuite/winsup.api/pthread/priority2.c
index d2d0b0695..0534e7ba1 100644
--- a/winsup/testsuite/winsup.api/pthread/priority2.c
+++ b/winsup/testsuite/winsup.api/pthread/priority2.c
@@ -51,7 +51,7 @@ void * func(void * arg)
   assert(pthread_mutex_lock(&startMx) == 0);
   assert(pthread_getschedparam(pthread_self(), &policy, &param) == 0);
   assert(pthread_mutex_unlock(&startMx) == 0);
-  assert(policy == SCHED_OTHER);
+  assert(policy == SCHED_FIFO);
   return (void *) (size_t)param.sched_priority;
 }
  
@@ -61,8 +61,8 @@ main()
   pthread_t t;
   void * result = NULL;
   struct sched_param param;
-  int maxPrio = sched_get_priority_max(SCHED_OTHER);
-  int minPrio = sched_get_priority_min(SCHED_OTHER);
+  int maxPrio = sched_get_priority_max(SCHED_FIFO);
+  int minPrio = sched_get_priority_min(SCHED_FIFO);
 
   for (param.sched_priority = minPrio;
        param.sched_priority <= maxPrio;
@@ -70,7 +70,7 @@ main()
     {
       assert(pthread_mutex_lock(&startMx) == 0);
       assert(pthread_create(&t, NULL, func, NULL) == 0);
-      assert(pthread_setschedparam(t, SCHED_OTHER, &param) == 0);
+      assert(pthread_setschedparam(t, SCHED_FIFO, &param) == 0);
       assert(pthread_mutex_unlock(&startMx) == 0);
       pthread_join(t, &result);
       assert((int)(size_t)result == param.sched_priority);
-- 
2.39.0

