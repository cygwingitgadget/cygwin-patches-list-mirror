Return-Path: <SRS0=REvR=DV=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta26-sa.btinternet.com [213.120.69.32])
	by sourceware.org (Postfix) with ESMTPS id E0D573858C2D
	for <cygwin-patches@cygwin.com>; Fri,  4 Aug 2023 12:47:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E0D573858C2D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230804124742.LNDV9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Fri, 4 Aug 2023 13:47:42 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64C837300077D1CF
X-Originating-IP: [86.139.167.52]
X-OWM-Source-IP: 86.139.167.52 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrkeeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkeeirddufeelrdduieejrdehvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddufeelrdduieejrdehvddpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekiedqudefledqudeijedqhedvrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgv
	ohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.52) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814.02) (authenticated as jonturney@btinternet.com)
        id 64C837300077D1CF; Fri, 4 Aug 2023 13:47:42 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/4] Cygwin: testsuite: Add '-notimeout' option to cygrun
Date: Fri,  4 Aug 2023 13:47:20 +0100
Message-Id: <20230804124723.9236-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
References: <20230804124723.9236-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Add '-notimeout' option for cygrun.  This is very useful when using it
to run a test standalone and under a debugger.

Also: warn about excess arguments
---
 winsup/testsuite/cygrun.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/winsup/testsuite/cygrun.c b/winsup/testsuite/cygrun.c
index d8de7d158..450201342 100644
--- a/winsup/testsuite/cygrun.c
+++ b/winsup/testsuite/cygrun.c
@@ -23,24 +23,42 @@ main (int argc, char **argv)
   DWORD res;
   DWORD ec = 1;
   char *p;
+  DWORD timeout = 60 * 1000;
 
   if (argc < 2)
     {
       fprintf (stderr, "Usage: cygrun [program]\n");
-      exit (0);
+      exit (1);
+    }
+
+  int i;
+  for (i = 1; i < argc; ++i)
+    {
+      if (strcmp (argv[i], "-notimeout") == 0)
+	timeout = INFINITE;
+      else
+	break;
+    }
+
+  char *command = argv[i];
+
+  if (i < (argc-1))
+    {
+      fprintf (stderr, "cygrun: excess arguments\n");
+      exit (1);
     }
 
   SetEnvironmentVariable ("CYGWIN_TESTING", "1");
 
   memset (&sa, 0, sizeof (sa));
   memset (&pi, 0, sizeof (pi));
-  if (!CreateProcess (0, argv[1], 0, 0, 1, 0, 0, 0, &sa, &pi))
+  if (!CreateProcess (0, command, 0, 0, 1, 0, 0, 0, &sa, &pi))
     {
-      fprintf (stderr, "CreateProcess %s failed\n", argv[1]);
+      fprintf (stderr, "CreateProcess %s failed\n", command);
       exit (1);
     }
 
-  res = WaitForSingleObject (pi.hProcess, 60 * 1000);
+  res = WaitForSingleObject (pi.hProcess, timeout);
 
   if (res == WAIT_TIMEOUT)
     {
-- 
2.39.0

