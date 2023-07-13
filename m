Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta27-sa.btinternet.com [213.120.69.33])
	by sourceware.org (Postfix) with ESMTPS id D144D3857011
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:40:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D144D3857011
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230713114037.XYEP9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:40:37 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED322B3
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefhgfekfeetheduleehjedvveduvdejjeeftdehieekgfeltdffkeetieduueeileenucffohhmrghinheptgihghifihhnrdgtohhmnecukfhppeekuddruddvledrudegiedrudejleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirddujeelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeduqdduvdelqddugeeiqddujeelrdhrrghnghgvkeduqdduvdelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhu
	rhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehsrgdqphhrugdqrhhgohhuthdqtddtud
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED322B3; Thu, 13 Jul 2023 12:40:36 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 05/11] Cygwin: testsuite: Just log result of second open of /dev/dsp
Date: Thu, 13 Jul 2023 12:38:58 +0100
Message-Id: <20230713113904.1752-6-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Do not rate successful second open of /dev/dsp as an error, just log the
result.

Based on this patch by Gerd Spalink:

https://cygwin.com/pipermail/cygwin-patches/2004q3/004848.html
---
 winsup/testsuite/winsup.api/devdsp.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/winsup/testsuite/winsup.api/devdsp.c b/winsup/testsuite/winsup.api/devdsp.c
index 0ac76f085..de3ccfa19 100644
--- a/winsup/testsuite/winsup.api/devdsp.c
+++ b/winsup/testsuite/winsup.api/devdsp.c
@@ -170,15 +170,11 @@ playbacktest (void)
 		strerror (errno));
     }
   audio2 = open ("/dev/dsp", O_WRONLY);
+  tst_resm (TINFO, "Second open /dev/dsp W %s ",
+	    audio2 >= 0 ? "WORKS" : "DOESN'T WORK");
   if (audio2 >= 0)
     {
-      tst_brkm (TFAIL, cleanup,
-		"Second open /dev/dsp W succeeded, but is expected to fail");
-    }
-  else if (errno != EBUSY)
-    {
-      tst_brkm (TFAIL, cleanup, "Expected EBUSY here, exit: %s",
-		strerror (errno));
+      close (audio2);
     }
   for (rate = 0; rate < sizeof (rates) / sizeof (int); rate++)
     for (k = 0; k < sizeof (sblut) / sizeof (struct sb); k++)
@@ -209,15 +205,11 @@ recordingtest (void)
 		strerror (errno));
     }
   audio2 = open ("/dev/dsp", O_RDONLY);
+  tst_resm (TINFO, "Second open /dev/dsp R %s",
+	    audio2 >= 0 ? "WORKS" : "DOESN'T WORK");
   if (audio2 >= 0)
     {
-      tst_brkm (TFAIL, cleanup,
-		"Second open /dev/dsp R succeeded, but is expected to fail");
-    }
-  else if (errno != EBUSY)
-    {
-      tst_brkm (TFAIL, cleanup, "Expected EBUSY here, exit: %s",
-		strerror (errno));
+      close (audio2);
     }
   for (rate = 0; rate < sizeof (rates) / sizeof (int); rate++)
     for (k = 0; k < sizeof (sblut) / sizeof (struct sb); k++)
-- 
2.39.0

