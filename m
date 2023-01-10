Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-049.btinternet.com (mailomta9-re.btinternet.com [213.120.69.102])
	by sourceware.org (Postfix) with ESMTPS id 78B1A3858000
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 78B1A3858000
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20230110163751.EDTM13495.re-prd-fep-049.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:51 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A4E1
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A4E1; Tue, 10 Jan 2023 16:37:51 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 7/8] Cygwin: testsuite: Drop appending 'ntsec' to CYGWIN in cygrun wrapper
Date: Tue, 10 Jan 2023 16:37:08 +0000
Message-Id: <20230110163709.16265-8-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Don't append 'ntsec' to the CYGWIN env var in the cygrun wrapper. It
doesn't have any effect anymore.
---
 winsup/testsuite/cygrun.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/winsup/testsuite/cygrun.c b/winsup/testsuite/cygrun.c
index 65d859d59..e6c4aa705 100644
--- a/winsup/testsuite/cygrun.c
+++ b/winsup/testsuite/cygrun.c
@@ -33,22 +33,6 @@ main (int argc, char **argv)
     SetEnvironmentVariable ("TDIRECTORY", argv[2]);
 
   SetEnvironmentVariable ("CYGWIN_TESTING", "1");
-  if ((p = getenv ("CYGWIN")) == NULL || (strstr (p, "ntsec") == NULL))
-    {
-      char buf[4096];
-      if (!p)
-	{
-	  p = buf;
-	  p[0] = '\0';
-	}
-      else
-	{
-	  strcpy (buf, p);
-	  strcat (buf, " ");
-	}
-      strcat(buf, "ntsec");
-      SetEnvironmentVariable ("CYGWIN", buf);
-    }
 
   memset (&sa, 0, sizeof (sa));
   memset (&pi, 0, sizeof (pi));
-- 
2.39.0

