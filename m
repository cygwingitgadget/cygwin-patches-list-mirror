Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-048.btinternet.com (mailomta5-sa.btinternet.com [213.120.69.11])
	by sourceware.org (Postfix) with ESMTPS id DA006385AFA4
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:41:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DA006385AFA4
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-048.btinternet.com with ESMTP
          id <20230713114106.KMUX7361.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:41:06 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED325AA
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtqhertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpedvteevtedtffefhffgkeffkeeuhfelfeetheeihedugfejudffgfeluddvtdffteenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED325AA; Thu, 13 Jul 2023 12:41:06 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 08/11] Cygwin: testsuite: Busy-wait in cancel3 and cancel5
Date: Thu, 13 Jul 2023 12:39:01 +0100
Message-Id: <20230713113904.1752-9-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

These tests async thread cancellation of a thread that doesn't have any
cancellation points.

Unfortunately, since 450f557f the async cancellation silently fails when
the thread is inside the kernel function Sleep(), so it just exits
normally after 10 seconds. (See the commentary in pthread::cancel() in
thread.cc, where it checks if the target thread is inside the kernel,
and silently converts the cancellation into a deferred one)

Work around this by busy-waiting rather than Sleep()ing for 10 seconds.

This is still somewhat fragile: the async cancel could still fail, if it
happens to occur while we're inside the kernel function that time()
calls.

v2:
Do nothing more efficiently
---
 winsup/testsuite/winsup.api/pthread/cancel3.c | 24 ++++++++++++++-----
 winsup/testsuite/winsup.api/pthread/cancel5.c | 24 ++++++++++++++-----
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/winsup/testsuite/winsup.api/pthread/cancel3.c b/winsup/testsui=
te/winsup.api/pthread/cancel3.c
index 832fe2e3f..07feb7c9b 100644
--- a/winsup/testsuite/winsup.api/pthread/cancel3.c
+++ b/winsup/testsuite/winsup.api/pthread/cancel3.c
@@ -75,11 +75,22 @@ mythread(void * arg)
   assert(pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL) =3D=3D 0=
);
=20
   /*
-   * We wait up to 10 seconds, waking every 0.1 seconds,
-   * for a cancelation to be applied to us.
+   * We wait up to 10 seconds for a cancelation to be applied to us.
    */
-  for (bag->count =3D 0; bag->count < 100; bag->count++)
-    Sleep(100);
+  for (bag->count =3D 0; bag->count < 10; bag->count++)
+    {
+      /* Busy wait to avoid Sleep(), since we can't asynchronous cancel in=
side a
+	 kernel function. (This is still somewhat fragile as if the async cancel
+	 can fail if it happens to occur while we're inside the kernel function
+	 that time() calls...)  */
+      time_t start =3D time(NULL);
+      while ((time(NULL) - start) < 1)
+	{
+	  int i;
+	  for (i =3D 0; i < 1E7; i++)
+	    __asm__ volatile ("pause":::);
+	}
+    }
=20
   return result;
 }
@@ -149,10 +160,11 @@ main()
=20
       if (fail)
 	{
-	  fprintf(stderr, "Thread %d: started %d: count %d\n",
+	  fprintf(stderr, "Thread %d: started %d: count %d: result %d \n",
 		  i,
 		  threadbag[i].started,
-		  threadbag[i].count);
+		  threadbag[i].count,
+		  result);
 	}
       failed =3D (failed || fail);
     }
diff --git a/winsup/testsuite/winsup.api/pthread/cancel5.c b/winsup/testsui=
te/winsup.api/pthread/cancel5.c
index 8b7240615..999b3c95c 100644
--- a/winsup/testsuite/winsup.api/pthread/cancel5.c
+++ b/winsup/testsuite/winsup.api/pthread/cancel5.c
@@ -76,11 +76,22 @@ mythread(void * arg)
   assert(pthread_setcanceltype(PTHREAD_CANCEL_ASYNCHRONOUS, NULL) =3D=3D 0=
);=0D
 =0D
   /*=0D
-   * We wait up to 10 seconds, waking every 0.1 seconds,=0D
-   * for a cancelation to be applied to us.=0D
+   * We wait up to 10 seconds for a cancelation to be applied to us.=0D
    */=0D
-  for (bag->count =3D 0; bag->count < 100; bag->count++)=0D
-    Sleep(100);=0D
+  for (bag->count =3D 0; bag->count < 10; bag->count++)=0D
+    {=0D
+      /* Busy wait to avoid Sleep(), since we can't asynchronous cancel in=
side a=0D
+	 kernel function. (This is still somewhat fragile as if the async cancel=
=0D
+	 can fail if it happens to occur while we're inside the kernel function=0D
+	 that time() calls...)  */=0D
+      time_t start =3D time(NULL);=0D
+      while ((time(NULL) - start) < 1)=0D
+	{=0D
+	  int i;=0D
+	  for (i =3D 0; i < 1E7; i++)=0D
+	    __asm__ volatile ("pause":::);=0D
+	}=0D
+    }=0D
 =0D
   return result;=0D
 }=0D
@@ -148,10 +159,11 @@ main()
 =0D
       if (fail)=0D
 	{=0D
-	  fprintf(stderr, "Thread %d: started %d: count %d\n",=0D
+	  fprintf(stderr, "Thread %d: started %d: count %d: result %d\n",=0D
 		  i,=0D
 		  threadbag[i].started,=0D
-		  threadbag[i].count);=0D
+		  threadbag[i].count,=0D
+		  result);=0D
 	}=0D
       failed =3D (failed || fail);=0D
     }=0D
--=20
2.39.0

