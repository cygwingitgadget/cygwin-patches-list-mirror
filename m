Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-044.btinternet.com (mailomta19-sa.btinternet.com [213.120.69.25])
	by sourceware.org (Postfix) with ESMTPS id DAF6A3855587
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:40:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DAF6A3855587
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-044.btinternet.com with ESMTP
          id <20230713114048.SEHD11931.sa-prd-fep-044.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:40:48 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED323B3
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED323B3; Thu, 13 Jul 2023 12:40:48 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 06/11] Cygwin: testsuite: Also check direct call in systemcall
Date: Thu, 13 Jul 2023 12:38:59 +0100
Message-Id: <20230713113904.1752-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Check direct call to system(), as well as one in a subprocess.

(This is a lot easier to debug when it's completely broken by the
environment the test is running in)
---
 winsup/testsuite/winsup.api/systemcall.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/testsuite/winsup.api/systemcall.c b/winsup/testsuite/winsup.api/systemcall.c
index d10c9825c..74bd6f870 100644
--- a/winsup/testsuite/winsup.api/systemcall.c
+++ b/winsup/testsuite/winsup.api/systemcall.c
@@ -26,6 +26,14 @@ main (int argc, char **argv)
       fprintf (stderr, "couldn't redirect stdout to /dev/null, fd %d - %s\n", fd, strerror (errno));
       exit (1);
     }
+
+  n = system ("ls");
+  if (n != 0)
+    {
+      fprintf (stderr, "system() (in parent) call returned %x\n", n);
+      exit (1);
+    }
+
   if (pipe (fds))
     {
       fprintf (stderr, "pipe call failed - %s\n", strerror (errno));
@@ -61,7 +69,7 @@ main (int argc, char **argv)
     }
   if (n != 0)
     {
-      fprintf (stderr, "system() call returned %x\n", n);
+      fprintf (stderr, "system() (in child) call returned %x\n", n);
       exit (1);
     }
   exit (0);
-- 
2.39.0

