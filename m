Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-042.btinternet.com (mailomta18-sa.btinternet.com [213.120.69.24])
	by sourceware.org (Postfix) with ESMTPS id 4D9923858C1F
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:40:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4D9923858C1F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20230713113958.BMXX20040.sa-prd-fep-042.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:39:58 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED31F81
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED31F81; Thu, 13 Jul 2023 12:39:58 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 02/11] Cygwin: testsuite: Add a simple timeout mechanism
Date: Thu, 13 Jul 2023 12:38:55 +0100
Message-Id: <20230713113904.1752-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Astonishingly, we don't have this already, so tests which hang just stop
the testsuite dead in it's tracks...
---
 winsup/testsuite/cygrun.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/winsup/testsuite/cygrun.c b/winsup/testsuite/cygrun.c
index e6c4aa705..925b5513f 100644
--- a/winsup/testsuite/cygrun.c
+++ b/winsup/testsuite/cygrun.c
@@ -20,6 +20,7 @@ main (int argc, char **argv)
 {
   STARTUPINFO sa;
   PROCESS_INFORMATION pi;
+  DWORD res;
   DWORD ec = 1;
   char *p;
 
@@ -42,9 +43,21 @@ main (int argc, char **argv)
       exit (1);
     }
 
-  WaitForSingleObject (pi.hProcess, INFINITE);
+  res = WaitForSingleObject (pi.hProcess, 60 * 1000);
 
-  GetExitCodeProcess (pi.hProcess, &ec);
+  if (res == WAIT_TIMEOUT)
+    {
+      char cmd[1024];
+      // there is no simple API to kill a Windows process tree
+      sprintf(cmd, "taskkill /f /t /pid %lu", GetProcessId(pi.hProcess));
+      system(cmd);
+      fprintf (stderr, "Timeout\n");
+      ec = 124;
+    }
+  else
+    {
+      GetExitCodeProcess (pi.hProcess, &ec);
+    }
 
   CloseHandle (pi.hProcess);
   CloseHandle (pi.hThread);
-- 
2.39.0

