Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-042.btinternet.com (mailomta10-sa.btinternet.com [213.120.69.16])
	by sourceware.org (Postfix) with ESMTPS id AA8C9385842D
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:41:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA8C9385842D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-042.btinternet.com with ESMTP
          id <20230713114127.BNED20040.sa-prd-fep-042.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:41:27 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED32737
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED32737; Thu, 13 Jul 2023 12:41:27 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 10/11] Cygwin: testsuite: Minor fixes to umask03
Date: Thu, 13 Jul 2023 12:39:03 +0100
Message-Id: <20230713113904.1752-11-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

See ltp commits f32691e7, 923b23ff and b846e7bb
---
 winsup/testsuite/winsup.api/ltp/umask03.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/winsup/testsuite/winsup.api/ltp/umask03.c b/winsup/testsuite/winsup.api/ltp/umask03.c
index 341da7507..84d2f089d 100644
--- a/winsup/testsuite/winsup.api/ltp/umask03.c
+++ b/winsup/testsuite/winsup.api/ltp/umask03.c
@@ -19,7 +19,7 @@
 
 /*
  * NAME
- *	umask01.c
+ *	umask03.c
  *
  * DESCRIPTION
  *	Check that umask changes the mask, and that the previous
@@ -30,7 +30,7 @@
  *	corresponds to the previous value set.
  *
  * USAGE:  <for command-line>
- *		umask01 [-c n] [-i n] [-I x] [-P x] [-t]
+ *		umask03 [-c n] [-i n] [-I x] [-P x] [-t]
  *		where,  -c n : Run n copies concurrently.
  *			-i n : Execute test n times.
  *			-I x : Execute test for x seconds.
@@ -51,7 +51,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
-const char *TCID = "umask01";
+const char *TCID = "umask03";
 int TST_TOTAL = 1;
 extern int Tst_count;
 
@@ -68,6 +68,7 @@ main(int argc, char **argv)
 	
 	struct stat statbuf;
 	unsigned mskval = 0000;
+	int failcnt = 0;
 	int fildes, i;
 	unsigned low9mode;
 
@@ -99,12 +100,13 @@ main(int argc, char **argv)
 				} else {
 					low9mode = statbuf.st_mode & 0777;
 					if (low9mode != (~mskval & 0777)) {
-						tst_brkm(TBROK, cleanup,
-							 "got %0 expected %o"
-							 "mask didnot take",
+						tst_resm(TBROK,
+							 "got mode %o expected %o "
+							 "mask %o did not take",
 							 low9mode,
-							 (~mskval & 0777));
-						/*NOTREACHED*/
+							 (~mskval & 0777),
+							 mskval);
+						failcnt++;
 					} else {
 						tst_resm(TPASS, "Test "
 							"condition: %d, umask: "
@@ -114,6 +116,9 @@ main(int argc, char **argv)
 			}
 			close(fildes);
 		}
+		if (!failcnt)
+			tst_resm(TPASS, "umask correctly returns the "
+					"previous value for all masks");
 	}
 	cleanup();
 	/*NOTREACHED*/
-- 
2.39.0

