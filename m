Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-047.btinternet.com (mailomta28-re.btinternet.com [213.120.69.121])
	by sourceware.org (Postfix) with ESMTPS id 3094D385B525
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3094D385B525
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20230110163744.TCJI20465.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:44 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A42F
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A42F; Tue, 10 Jan 2023 16:37:44 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/8] Cygwin: testsuite: Update mutex tests for changed default mutex type
Date: Tue, 10 Jan 2023 16:37:06 +0000
Message-Id: <20230110163709.16265-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Default mutex type is PTHREAD_MUTEX_NORMAL.

Attempting to unlock an unowned mutex of that type is specified as
undefined behaviour, not returning EPERM.

mutex7e verfies that attempting to unlock an unowned mutex of type
PTHREAD_MUTEX_ERRORCHECK returns EPERM.
---
 winsup/testsuite/winsup.api/pthread/mutex5.c  | 2 +-
 winsup/testsuite/winsup.api/pthread/mutex7.c  | 3 +--
 winsup/testsuite/winsup.api/pthread/mutex7d.c | 3 +--
 winsup/testsuite/winsup.api/pthread/mutex7n.c | 1 -
 4 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/winsup/testsuite/winsup.api/pthread/mutex5.c b/winsup/testsuite/winsup.api/pthread/mutex5.c
index 7029da12f..6d24275f1 100644
--- a/winsup/testsuite/winsup.api/pthread/mutex5.c
+++ b/winsup/testsuite/winsup.api/pthread/mutex5.c
@@ -23,7 +23,7 @@ main()
     {
       assert(pthread_mutexattr_init(&mxAttr) == 0);
       assert(pthread_mutexattr_gettype(&mxAttr, &mxType) == 0);
-      assert(mxType == PTHREAD_MUTEX_ERRORCHECK);
+      assert(mxType == PTHREAD_MUTEX_NORMAL);
     }
 
   return 0;
diff --git a/winsup/testsuite/winsup.api/pthread/mutex7.c b/winsup/testsuite/winsup.api/pthread/mutex7.c
index d2c9f8bee..6acb12317 100644
--- a/winsup/testsuite/winsup.api/pthread/mutex7.c
+++ b/winsup/testsuite/winsup.api/pthread/mutex7.c
@@ -2,7 +2,7 @@
  * mutex7.c
  *
  * Test the default (type not set) mutex type.
- * Should be the same as PTHREAD_MUTEX_ERRORCHECK.
+ * Should be the same as PTHREAD_MUTEX_NORMAL.
  * Thread locks then trylocks mutex (attempted recursive lock).
  * The thread should lock first time and EBUSY second time.
  *
@@ -25,7 +25,6 @@ void * locker(void * arg)
   assert(pthread_mutex_trylock(&mutex) == EBUSY);
   lockCount++;
   assert(pthread_mutex_unlock(&mutex) == 0);
-  assert(pthread_mutex_unlock(&mutex) == EPERM);
 
   return 0;
 }
diff --git a/winsup/testsuite/winsup.api/pthread/mutex7d.c b/winsup/testsuite/winsup.api/pthread/mutex7d.c
index 906d0f043..98b74fc5b 100644
--- a/winsup/testsuite/winsup.api/pthread/mutex7d.c
+++ b/winsup/testsuite/winsup.api/pthread/mutex7d.c
@@ -2,7 +2,7 @@
  * mutex7d.c
  *
  * Test the default (type not set) mutex type.
- * Should be the same as PTHREAD_MUTEX_ERRORCHECK.
+ * Should be the same as PTHREAD_MUTEX_NORMAL.
  * Thread locks then trylocks mutex (attempted recursive lock).
  * The thread should lock first time and EBUSY second time.
  *
@@ -25,7 +25,6 @@ void * locker(void * arg)
   assert(pthread_mutex_trylock(&mutex) == EBUSY);
   lockCount++;
   assert(pthread_mutex_unlock(&mutex) == 0);
-  assert(pthread_mutex_unlock(&mutex) == EPERM);
 
   return 0;
 }
diff --git a/winsup/testsuite/winsup.api/pthread/mutex7n.c b/winsup/testsuite/winsup.api/pthread/mutex7n.c
index e9a36fec0..a04792b61 100644
--- a/winsup/testsuite/winsup.api/pthread/mutex7n.c
+++ b/winsup/testsuite/winsup.api/pthread/mutex7n.c
@@ -29,7 +29,6 @@ void * locker(void * arg)
   assert(pthread_mutex_trylock(&mutex) == EBUSY);
   lockCount++;
   assert(pthread_mutex_unlock(&mutex) == 0);
-  assert(pthread_mutex_unlock(&mutex) == EPERM);
 
   return (void *) 555;
 }
-- 
2.39.0

