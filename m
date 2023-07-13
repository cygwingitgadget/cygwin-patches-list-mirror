Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta22-sa.btinternet.com [213.120.69.28])
	by sourceware.org (Postfix) with ESMTPS id 7F304385C017
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:41:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7F304385C017
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20230713114116.FQEE29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:41:16 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED3264A
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED3264A; Thu, 13 Jul 2023 12:41:16 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 09/11] Cygwin: testsuite: Fix a buffer overflow in symlink01
Date: Thu, 13 Jul 2023 12:39:02 +0100
Message-Id: <20230713113904.1752-10-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_NUMSUBJECT,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

See ltp commit 44d51c3f
---
 winsup/testsuite/winsup.api/ltp/symlink01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/testsuite/winsup.api/ltp/symlink01.c b/winsup/testsuite/winsup.api/ltp/symlink01.c
index 54a24b87f..186a85b4e 100644
--- a/winsup/testsuite/winsup.api/ltp/symlink01.c
+++ b/winsup/testsuite/winsup.api/ltp/symlink01.c
@@ -488,7 +488,7 @@ time_t a_time_value = 100;
 const char  *TCID = NULL;
 char  *Selectedtests = NULL;		/* Name (tcid) of selected test cases */
 char test_msg[BUFMAX];
-char full_path[PATH_MAX+1];
+char full_path[PATH_MAX+1+1]; /* Add one for '\0' and another to exceed the PATH_MAX limit, see creat_path_max() */
 extern int Tst_count;
 extern char *TESTDIR;
 extern char *strrchr();
-- 
2.39.0

