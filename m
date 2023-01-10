Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-047.btinternet.com (mailomta26-re.btinternet.com [213.120.69.119])
	by sourceware.org (Postfix) with ESMTPS id CACD338582AB
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CACD338582AB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-047.btinternet.com with ESMTP
          id <20230110163741.TCJC20465.re-prd-fep-047.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:41 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A3F4
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtqhertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvteevtedtffefhffgkeffkeeuhfelfeetheeihedugfejudffgfeluddvtdffteenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A3F4; Tue, 10 Jan 2023 16:37:41 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/8] Cygwin: testsuite: 64-bit fixes in pthread testcases
Date: Tue, 10 Jan 2023 16:37:05 +0000
Message-Id: <20230110163709.16265-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1197.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Fix warnings and 64-bit issues in pthread testcases.

See pthread-win32 commit 1183e5ac etc.
---
 winsup/testsuite/winsup.api/pthread/cancel2.c | 10 ++++-----
 winsup/testsuite/winsup.api/pthread/cancel3.c | 10 ++++-----
 winsup/testsuite/winsup.api/pthread/cancel4.c | 10 ++++-----
 winsup/testsuite/winsup.api/pthread/cancel5.c | 12 +++++-----
 .../testsuite/winsup.api/pthread/cleanup2.c   | 10 ++++-----
 .../testsuite/winsup.api/pthread/cleanup3.c   |  8 +++----
 .../testsuite/winsup.api/pthread/condvar2_1.c | 12 +++++-----
 .../testsuite/winsup.api/pthread/condvar3_1.c | 12 +++++-----
 .../testsuite/winsup.api/pthread/condvar3_2.c | 14 ++++++------
 winsup/testsuite/winsup.api/pthread/exit3.c   |  2 +-
 .../testsuite/winsup.api/pthread/inherit1.c   |  4 ++--
 winsup/testsuite/winsup.api/pthread/join1.c   | 10 ++++-----
 winsup/testsuite/winsup.api/pthread/join2.c   |  8 +++----
 winsup/testsuite/winsup.api/pthread/mutex4.c  |  2 +-
 .../testsuite/winsup.api/pthread/priority1.c  |  4 ++--
 .../testsuite/winsup.api/pthread/priority2.c  |  4 ++--
 winsup/testsuite/winsup.api/pthread/rwlock6.c | 22 +++++++++----------
 17 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/winsup/testsuite/winsup.api/pthread/cancel2.c b/winsup/testsui=
te/winsup.api/pthread/cancel2.c
index 14889313e..19902dc0f 100644
--- a/winsup/testsuite/winsup.api/pthread/cancel2.c
+++ b/winsup/testsuite/winsup.api/pthread/cancel2.c
@@ -96,7 +96,7 @@ mythread(void * arg)
       pthread_testcancel();
     }
=20
-  return (void *) result;
+  return (void *) (size_t)result;
 }
=20
 int
@@ -156,17 +156,17 @@ main()
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
       int fail =3D 0;
-      int result =3D 0;
+      void *result =3D 0;
=20
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
-      fail =3D (result !=3D (int) PTHREAD_CANCELED);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
+      fail =3D (result !=3D PTHREAD_CANCELED);
       if (fail)
 	{
 	  fprintf(stderr, "Thread %d: started %d: location %d: cancel type %s\n",
 		  i,
 		  threadbag[i].started,
 		  result,
-		  ((result % 2) =3D=3D 0) ? "ASYNCHRONOUS" : "DEFERRED");
+		  (((int)(size_t)result % 2) =3D=3D 0) ? "ASYNCHRONOUS" : "DEFERRED");
 	}
       failed |=3D fail;
     }
diff --git a/winsup/testsuite/winsup.api/pthread/cancel3.c b/winsup/testsui=
te/winsup.api/pthread/cancel3.c
index 3ac03e4b6..832fe2e3f 100644
--- a/winsup/testsuite/winsup.api/pthread/cancel3.c
+++ b/winsup/testsuite/winsup.api/pthread/cancel3.c
@@ -61,7 +61,7 @@ static bag_t threadbag[NUMTHREADS + 1];
 void *
 mythread(void * arg)
 {
-  int result =3D ((int)PTHREAD_CANCELED + 1);
+  void* result =3D (void*)((int)(size_t)PTHREAD_CANCELED + 1);
   bag_t * bag =3D (bag_t *) arg;
=20
   assert(bag =3D=3D &threadbag[bag->threadnum]);
@@ -81,7 +81,7 @@ mythread(void * arg)
   for (bag->count =3D 0; bag->count < 100; bag->count++)
     Sleep(100);
=20
-  return (void *) result;
+  return result;
 }
=20
 int
@@ -136,16 +136,16 @@ main()
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
       int fail =3D 0;
-      int result =3D 0;
+      void *result =3D 0;
=20
       /*
        * The thread does not contain any cancelation points, so
        * a return value of PTHREAD_CANCELED confirms that async
        * cancelation succeeded.
        */
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
=20
-      fail =3D (result !=3D (int) PTHREAD_CANCELED);
+      fail =3D (result !=3D PTHREAD_CANCELED);
=20
       if (fail)
 	{
diff --git a/winsup/testsuite/winsup.api/pthread/cancel4.c b/winsup/testsui=
te/winsup.api/pthread/cancel4.c
index d6b2ffadf..d8151891b 100644
--- a/winsup/testsuite/winsup.api/pthread/cancel4.c
+++ b/winsup/testsuite/winsup.api/pthread/cancel4.c
@@ -66,7 +66,7 @@ static bag_t threadbag[NUMTHREADS + 1];
 void *
 mythread(void * arg)
 {
-  int result =3D ((int)PTHREAD_CANCELED + 1);
+  void* result =3D (void*)((int)(size_t)PTHREAD_CANCELED + 1);
   bag_t * bag =3D (bag_t *) arg;
=20
   assert(bag =3D=3D &threadbag[bag->threadnum]);
@@ -86,7 +86,7 @@ mythread(void * arg)
   for (bag->count =3D 0; bag->count < 100; bag->count++)
     Sleep(100);
=20
-  return (void *) result;
+  return result;
 }
=20
 int
@@ -141,16 +141,16 @@ main()
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
       int fail =3D 0;
-      int result =3D 0;
+      void* result =3D 0;
=20
       /*
        * The thread does not contain any cancelation points, so
        * a return value of PTHREAD_CANCELED indicates that async
        * cancelation occurred.
        */
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
=20
-      fail =3D (result =3D=3D (int) PTHREAD_CANCELED);
+      fail =3D (result =3D=3D PTHREAD_CANCELED);
=20
       if (fail)
 	{
diff --git a/winsup/testsuite/winsup.api/pthread/cancel5.c b/winsup/testsui=
te/winsup.api/pthread/cancel5.c
index 9dd579543..8b7240615 100644
--- a/winsup/testsuite/winsup.api/pthread/cancel5.c
+++ b/winsup/testsuite/winsup.api/pthread/cancel5.c
@@ -62,7 +62,7 @@ static bag_t threadbag[NUMTHREADS + 1];
 void *=0D
 mythread(void * arg)=0D
 {=0D
-  int result =3D ((int)PTHREAD_CANCELED + 1);=0D
+  void* result =3D (void*)((int)(size_t)PTHREAD_CANCELED + 1);=0D
   bag_t * bag =3D (bag_t *) arg;=0D
 =0D
   assert(bag =3D=3D &threadbag[bag->threadnum]);=0D
@@ -82,7 +82,7 @@ mythread(void * arg)
   for (bag->count =3D 0; bag->count < 100; bag->count++)=0D
     Sleep(100);=0D
 =0D
-  return (void *) result;=0D
+  return result;=0D
 }=0D
 =0D
 int=0D
@@ -96,7 +96,7 @@ main()
     {=0D
       threadbag[i].started =3D 0;=0D
       threadbag[i].threadnum =3D i;=0D
-      assert(pthread_create(&t[i], NULL, mythread, (void *) &threadbag[i])=
 =3D=3D 0);=0D
+      assert(pthread_create(&t[i], NULL, mythread, &threadbag[i]) =3D=3D 0=
);=0D
     }=0D
 =0D
   /*=0D
@@ -135,16 +135,16 @@ main()
   for (i =3D 1; i <=3D NUMTHREADS; i++)=0D
     {=0D
       int fail =3D 0;=0D
-      int result =3D 0;=0D
+      void* result =3D (void*)((int)(size_t)PTHREAD_CANCELED + 1);=0D
 =0D
       /*=0D
        * The thread does not contain any cancelation points, so=0D
        * a return value of PTHREAD_CANCELED confirms that async=0D
        * cancelation succeeded.=0D
        */=0D
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);=0D
+      assert(pthread_join(t[i], &result) =3D=3D 0);=0D
 =0D
-      fail =3D (result !=3D (int) PTHREAD_CANCELED);=0D
+      fail =3D (result !=3D PTHREAD_CANCELED);=0D
 =0D
       if (fail)=0D
 	{=0D
diff --git a/winsup/testsuite/winsup.api/pthread/cleanup2.c b/winsup/testsu=
ite/winsup.api/pthread/cleanup2.c
index bcbaad3a7..75c239a00 100644
--- a/winsup/testsuite/winsup.api/pthread/cleanup2.c
+++ b/winsup/testsuite/winsup.api/pthread/cleanup2.c
@@ -84,7 +84,7 @@ mythread(void * arg)
=20
   pthread_cleanup_pop(1);
=20
-  return (void *) result;
+  return (void *) (size_t) result;
 }
=20
 int
@@ -129,18 +129,18 @@ main()
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
       int fail =3D 0;
-      int result =3D 0;
+      void* result =3D 0;
=20
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
=20
-      fail =3D (result !=3D 0);
+      fail =3D ((int)(size_t)result !=3D 0);
=20
       if (fail)
 	{
 	  fprintf(stderr, "Thread %d: started %d: result: %d\n",
 		  i,
 		  threadbag[i].started,
-		  result);
+		  (int)(size_t)result);
 	}
       failed =3D (failed || fail);
     }
diff --git a/winsup/testsuite/winsup.api/pthread/cleanup3.c b/winsup/testsu=
ite/winsup.api/pthread/cleanup3.c
index f8201faa0..6fea8dc93 100644
--- a/winsup/testsuite/winsup.api/pthread/cleanup3.c
+++ b/winsup/testsuite/winsup.api/pthread/cleanup3.c
@@ -87,7 +87,7 @@ mythread(void * arg)
=20
   pthread_cleanup_pop(0);
=20
-  return (void *) result;
+  return (void *) (size_t)result;
 }
=20
 int
@@ -132,9 +132,9 @@ main()
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
       int fail =3D 0;
-      int result =3D 0;
+      void* result =3D 0;
=20
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
=20
       fail =3D (result !=3D 0);
=20
@@ -143,7 +143,7 @@ main()
 	  fprintf(stderr, "Thread %d: started %d: result: %d\n",
 		  i,
 		  threadbag[i].started,
-		  result);
+		  (int)(size_t)result);
 	}
       failed =3D (failed || fail);
     }
diff --git a/winsup/testsuite/winsup.api/pthread/condvar2_1.c b/winsup/test=
suite/winsup.api/pthread/condvar2_1.c
index da3416203..1aa4fed9a 100644
--- a/winsup/testsuite/winsup.api/pthread/condvar2_1.c
+++ b/winsup/testsuite/winsup.api/pthread/condvar2_1.c
@@ -69,7 +69,7 @@ main()
 {
   int i;
   pthread_t t[NUMTHREADS + 1];
-  int result =3D 0;
+  void* result =3D 0;
   struct timeb currSysTime;
   const DWORD NANOSEC_PER_MILLISEC =3D 1000000;
=20
@@ -89,19 +89,19 @@ main()
=20
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
-      assert(pthread_create(&t[i], NULL, mythread, (void *) i) =3D=3D 0);
+      assert(pthread_create(&t[i], NULL, mythread, (void *)(size_t)i) =3D=
=3D 0);
     }
=20
   assert(pthread_mutex_unlock(&mutex) =3D=3D 0);
=20
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
-      assert(result =3D=3D i);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
+      assert((int)(size_t)result =3D=3D i);
     }
=20
-  result =3D pthread_cond_destroy(&cv);
-  assert(result =3D=3D 0);
+  int result2 =3D pthread_cond_destroy(&cv);
+  assert(result2 =3D=3D 0);
=20
   return 0;
 }
diff --git a/winsup/testsuite/winsup.api/pthread/condvar3_1.c b/winsup/test=
suite/winsup.api/pthread/condvar3_1.c
index b08b04889..a4653ebc8 100644
--- a/winsup/testsuite/winsup.api/pthread/condvar3_1.c
+++ b/winsup/testsuite/winsup.api/pthread/condvar3_1.c
@@ -89,7 +89,7 @@ main()
 {
   int i;
   pthread_t t[NUMTHREADS + 1];
-  int result =3D 0;
+  void* result =3D 0;
   struct timeb currSysTime;
   const DWORD NANOSEC_PER_MILLISEC =3D 1000000;
=20
@@ -110,7 +110,7 @@ main()
=20
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
-      assert(pthread_create(&t[i], NULL, mythread, (void *) i) =3D=3D 0);
+      assert(pthread_create(&t[i], NULL, mythread, (void *)(size_t)i) =3D=
=3D 0);
     }
=20
   do {
@@ -127,8 +127,8 @@ main()
=20
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
-        assert(result =3D=3D i);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
+      assert((int)(size_t)result =3D=3D i);
     }
=20
   printf("awk =3D %d\n", awoken);
@@ -138,8 +138,8 @@ main()
   assert(signaled =3D=3D awoken);
   assert(timedout =3D=3D NUMTHREADS - signaled);
=20
-  result =3D pthread_cond_destroy(&cv);
-  assert(result =3D=3D 0);
+  int result2 =3D pthread_cond_destroy(&cv);
+  assert(result2 =3D=3D 0);
=20
   return 0;
 }
diff --git a/winsup/testsuite/winsup.api/pthread/condvar3_2.c b/winsup/test=
suite/winsup.api/pthread/condvar3_2.c
index 57e7eb439..b08d8e256 100644
--- a/winsup/testsuite/winsup.api/pthread/condvar3_2.c
+++ b/winsup/testsuite/winsup.api/pthread/condvar3_2.c
@@ -66,7 +66,7 @@ mythread(void * arg)
=20
   abstime2.tv_sec =3D abstime.tv_sec;
=20
-  if ((int) arg % 3 =3D=3D 0)
+  if ((int) (size_t)arg % 3 =3D=3D 0)
     {
       abstime2.tv_sec +=3D 2;
     }
@@ -91,7 +91,7 @@ main()
 {
   int i;
   pthread_t t[NUMTHREADS + 1];
-  int result =3D 0;
+  void* result =3D 0;
   struct timeb currSysTime;
   const DWORD NANOSEC_PER_MILLISEC =3D 1000000;
=20
@@ -109,15 +109,15 @@ main()
=20
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
-      assert(pthread_create(&t[i], NULL, mythread, (void *) i) =3D=3D 0);
+      assert(pthread_create(&t[i], NULL, mythread, (void *)(size_t)i) =3D=
=3D 0);
     }
=20
   assert(pthread_mutex_unlock(&mutex) =3D=3D 0);
=20
   for (i =3D 1; i <=3D NUMTHREADS; i++)
     {
-      assert(pthread_join(t[i], (void **) &result) =3D=3D 0);
-	assert(result =3D=3D i);
+      assert(pthread_join(t[i], &result) =3D=3D 0);
+      assert((int)(size_t)result =3D=3D i);
       /*
        * Approximately 2/3rds of the threads are expected to time out.
        * Signal the remainder after some threads have woken up and exited
@@ -132,8 +132,8 @@ main()
=20
   assert(awoken =3D=3D NUMTHREADS - timedout);
=20
-  result =3D pthread_cond_destroy(&cv);
-  assert(result =3D=3D 0);
+  int result2 =3D pthread_cond_destroy(&cv);
+  assert(result2 =3D=3D 0);
=20
   return 0;
 }
diff --git a/winsup/testsuite/winsup.api/pthread/exit3.c b/winsup/testsuite=
/winsup.api/pthread/exit3.c
index 0b6ec31c5..7baf7bb10 100644
--- a/winsup/testsuite/winsup.api/pthread/exit3.c
+++ b/winsup/testsuite/winsup.api/pthread/exit3.c
@@ -24,7 +24,7 @@ main(int argc, char * argv[])
 	/* Create a few threads and then exit. */
 	for (i =3D 0; i < 4; i++)
 	  {
-	    assert(pthread_create(&id[i], NULL, func, (void *) i) =3D=3D 0);
+	    assert(pthread_create(&id[i], NULL, func, (void *)(size_t)i) =3D=3D 0=
);
 	  }
=20
 	Sleep(1000);
diff --git a/winsup/testsuite/winsup.api/pthread/inherit1.c b/winsup/testsu=
ite/winsup.api/pthread/inherit1.c
index a909eb763..545e4596f 100644
--- a/winsup/testsuite/winsup.api/pthread/inherit1.c
+++ b/winsup/testsuite/winsup.api/pthread/inherit1.c
@@ -47,7 +47,7 @@ void * func(void * arg)
   struct sched_param param;
=20
   assert(pthread_getschedparam(pthread_self(), &policy, &param) =3D=3D 0);
-  return (void *) param.sched_priority;
+  return (void *) (size_t)param.sched_priority;
 }
=20
 int
@@ -91,7 +91,7 @@ main()
           assert(pthread_attr_setschedparam(&attr, &param) =3D=3D 0);
           assert(pthread_create(&t, &attr, func, NULL) =3D=3D 0);
           pthread_join(t, &result);
-          assert((int) result =3D=3D mainParam.sched_priority);
+          assert((int)(size_t) result =3D=3D mainParam.sched_priority);
         }
     }
=20
diff --git a/winsup/testsuite/winsup.api/pthread/join1.c b/winsup/testsuite=
/winsup.api/pthread/join1.c
index d74e0c484..8a9d17669 100644
--- a/winsup/testsuite/winsup.api/pthread/join1.c
+++ b/winsup/testsuite/winsup.api/pthread/join1.c
@@ -9,7 +9,7 @@
 void *
 func(void * arg)
 {
-    int i =3D (int) arg;
+  int i =3D (int)(size_t)arg;
=20
     Sleep(i * 500);
=20
@@ -24,12 +24,12 @@ main(int argc, char * argv[])
 {
 	pthread_t id[4];
 	int i;
-	int result;
+	void* result =3D (void*)-1;
=20
 	/* Create a few threads and then exit. */
 	for (i =3D 0; i < 4; i++)
 	  {
-	    assert(pthread_create(&id[i], NULL, func, (void *) i) =3D=3D 0);
+	    assert(pthread_create(&id[i], NULL, func, (void *)(size_t)i) =3D=3D 0=
);
 	  }
=20
 	/* Some threads will finish before they are joined, some after. */
@@ -37,9 +37,9 @@ main(int argc, char * argv[])
=20
 	for (i =3D 0; i < 4; i++)
 	  {
-	    assert(pthread_join(id[i], (void **) &result) =3D=3D 0);
+	    assert(pthread_join(id[i], &result) =3D=3D 0);
 #if ! defined (__MINGW32__) || defined (__MSVCRT__)
-	    assert(result =3D=3D i);
+	    assert((int)(size_t)result =3D=3D i);
 #else
 # warning pthread_join not fully supported in this configuration.
 	    assert(result =3D=3D 0);
diff --git a/winsup/testsuite/winsup.api/pthread/join2.c b/winsup/testsuite=
/winsup.api/pthread/join2.c
index cdc8ca2d9..9a8de4619 100644
--- a/winsup/testsuite/winsup.api/pthread/join2.c
+++ b/winsup/testsuite/winsup.api/pthread/join2.c
@@ -18,21 +18,21 @@ main(int argc, char * argv[])
 {
 	pthread_t id[4];
 	int i;
-	int result;
+	void* result =3D (void*)-1;
=20
 	/* Create a few threads and then exit. */
 	for (i =3D 0; i < 4; i++)
 	  {
-	    assert(pthread_create(&id[i], NULL, func, (void *) i) =3D=3D 0);
+	    assert(pthread_create(&id[i], NULL, func, (void *)(size_t)i) =3D=3D 0=
);
 	  }
=20
 	for (i =3D 0; i < 4; i++)
 	  {
-	    assert(pthread_join(id[i], (void **) &result) =3D=3D 0);
+	    assert(pthread_join(id[i], &result) =3D=3D 0);
 #if ! defined (__MINGW32__) || defined (__MSVCRT__)
 	    /* CRTDLL _beginthread doesn't support return value, so
 	       the assertion is guaranteed to fail. */
-	    assert(result =3D=3D i);
+	    assert((int)(size_t)result =3D=3D i);
 #endif
 	  }
=20
diff --git a/winsup/testsuite/winsup.api/pthread/mutex4.c b/winsup/testsuit=
e/winsup.api/pthread/mutex4.c
index 8a983fee9..f4d31adb5 100644
--- a/winsup/testsuite/winsup.api/pthread/mutex4.c
+++ b/winsup/testsuite/winsup.api/pthread/mutex4.c
@@ -17,7 +17,7 @@ static pthread_mutex_t mutex1;
=20=20
 void * unlocker(void * arg)
 {
-  int expectedResult =3D (int) arg;
+  int expectedResult =3D (int)(size_t)arg;
=20
   wasHere++;
   assert(pthread_mutex_unlock(&mutex1) =3D=3D expectedResult);
diff --git a/winsup/testsuite/winsup.api/pthread/priority1.c b/winsup/tests=
uite/winsup.api/pthread/priority1.c
index a31102895..b740b997f 100644
--- a/winsup/testsuite/winsup.api/pthread/priority1.c
+++ b/winsup/testsuite/winsup.api/pthread/priority1.c
@@ -48,7 +48,7 @@ void * func(void * arg)
=20
   assert(pthread_getschedparam(pthread_self(), &policy, &param) =3D=3D 0);
   assert(policy =3D=3D SCHED_OTHER);
-  return (void *) param.sched_priority;
+  return (void *)(size_t)param.sched_priority;
 }
=20=20
 int
@@ -71,7 +71,7 @@ main()
       assert(pthread_attr_setschedparam(&attr, &param) =3D=3D 0);
       assert(pthread_create(&t, &attr, func, NULL) =3D=3D 0);
       pthread_join(t, &result);
-      assert((int) result =3D=3D param.sched_priority);
+      assert((int)(size_t) result =3D=3D param.sched_priority);
     }
=20
   return 0;
diff --git a/winsup/testsuite/winsup.api/pthread/priority2.c b/winsup/tests=
uite/winsup.api/pthread/priority2.c
index 4dcf3859f..d2d0b0695 100644
--- a/winsup/testsuite/winsup.api/pthread/priority2.c
+++ b/winsup/testsuite/winsup.api/pthread/priority2.c
@@ -52,7 +52,7 @@ void * func(void * arg)
   assert(pthread_getschedparam(pthread_self(), &policy, &param) =3D=3D 0);
   assert(pthread_mutex_unlock(&startMx) =3D=3D 0);
   assert(policy =3D=3D SCHED_OTHER);
-  return (void *) param.sched_priority;
+  return (void *) (size_t)param.sched_priority;
 }
=20=20
 int
@@ -73,7 +73,7 @@ main()
       assert(pthread_setschedparam(t, SCHED_OTHER, &param) =3D=3D 0);
       assert(pthread_mutex_unlock(&startMx) =3D=3D 0);
       pthread_join(t, &result);
-      assert((int) result =3D=3D param.sched_priority);
+      assert((int)(size_t)result =3D=3D param.sched_priority);
     }
=20
   return 0;
diff --git a/winsup/testsuite/winsup.api/pthread/rwlock6.c b/winsup/testsui=
te/winsup.api/pthread/rwlock6.c
index d5f2320d0..870b7c264 100644
--- a/winsup/testsuite/winsup.api/pthread/rwlock6.c
+++ b/winsup/testsuite/winsup.api/pthread/rwlock6.c
@@ -25,7 +25,7 @@ void * wrfunc(void * arg)
   ba =3D bankAccount;
   assert(pthread_rwlock_unlock(&rwlock1) =3D=3D 0);
=20
-  return ((void *) ba);
+  return ((void *)(size_t)ba);
 }
=20
 void * rdfunc(void * arg)
@@ -36,7 +36,7 @@ void * rdfunc(void * arg)
   ba =3D bankAccount;
   assert(pthread_rwlock_unlock(&rwlock1) =3D=3D 0);
=20
-  return ((void *) ba);
+  return ((void *)(size_t)ba);
 }
=20
 int
@@ -45,9 +45,9 @@ main()
   pthread_t wrt1;
   pthread_t wrt2;
   pthread_t rdt;
-  int wr1Result =3D 0;
-  int wr2Result =3D 0;
-  int rdResult =3D 0;
+  void* wr1Result =3D 0;
+  void* wr2Result =3D 0;
+  void* rdResult =3D 0;
=20
   bankAccount =3D 0;
=20
@@ -57,13 +57,13 @@ main()
   Sleep(500);
   assert(pthread_create(&wrt2, NULL, wrfunc, NULL) =3D=3D 0);
=20
-  assert(pthread_join(wrt1, (void **) &wr1Result) =3D=3D 0);
-  assert(pthread_join(rdt, (void **) &rdResult) =3D=3D 0);
-  assert(pthread_join(wrt2, (void **) &wr2Result) =3D=3D 0);
+  assert(pthread_join(wrt1, &wr1Result) =3D=3D 0);
+  assert(pthread_join(rdt, &rdResult) =3D=3D 0);
+  assert(pthread_join(wrt2, &wr2Result) =3D=3D 0);
=20
-  assert(wr1Result =3D=3D 10);
-  assert(rdResult =3D=3D 20);
-  assert(wr2Result =3D=3D 20);
+  assert((int)(size_t)wr1Result =3D=3D 10);
+  assert((int)(size_t)rdResult =3D=3D 20);
+  assert((int)(size_t)wr2Result =3D=3D 20);
=20
   return 0;
 }
--=20
2.39.0

