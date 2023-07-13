Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta5-sa.btinternet.com [213.120.69.11])
	by sourceware.org (Postfix) with ESMTPS id DFD523857352
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:40:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DFD523857352
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230713114024.XYDR9056.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:40:24 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED3219D
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED3219D; Thu, 13 Jul 2023 12:40:24 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 04/11] Cygwin: testsuite: Skip devdsp test when no audio devices present
Date: Thu, 13 Jul 2023 12:38:57 +0100
Message-Id: <20230713113904.1752-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

---
 winsup/testsuite/Makefile.am         |  3 +++
 winsup/testsuite/winsup.api/devdsp.c | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 11332eda2..60111a0aa 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -325,6 +325,9 @@ AM_CPPFLAGS = -I$(srcdir)/libltp/include
 AM_LDFLAGS = $(LDFLAGS_FOR_TESTDLL)
 LDADD = $(builddir)/libltp.a $(builddir)/../cygwin/binmode.o $(LDADD_FOR_TESTDLL)
 
+# additional flags for specific test executables
+winsup_api_devdsp_LDADD = -lwinmm $(LDADD)
+
 DEJATOOL = winsup
 
 # Add '-v' to RUNTESTFLAGS if V=1
diff --git a/winsup/testsuite/winsup.api/devdsp.c b/winsup/testsuite/winsup.api/devdsp.c
index 6c8850a74..0ac76f085 100644
--- a/winsup/testsuite/winsup.api/devdsp.c
+++ b/winsup/testsuite/winsup.api/devdsp.c
@@ -27,6 +27,8 @@ details. */
 #include <errno.h>
 #include "test.h" /* use libltp framework */
 
+#include <windows.h>
+
 /* Controls if a child can open the device after the parent */
 #define CHILD_EXPECT 0 /* 0 or 1 */
 
@@ -59,6 +61,7 @@ void playwavtest (void);
 void syncwithchild (pid_t pid, int expected_exit_status);
 void cleanup (void);
 void dup_test (void);
+void devcheck (void);
 
 static int expect_child_failure = 0;
 
@@ -77,6 +80,7 @@ int
 main (int argc, char *argv[])
 {
   /*  tst_brkm(TBROK, cleanup, "see if it breaks all right"); */
+  devcheck ();
   ioctltest ();
   playbacktest ();
   recordingtest ();
@@ -91,6 +95,17 @@ main (int argc, char *argv[])
   return 0;
 }
 
+/* skip test if we don't have any audio devices*/
+void
+devcheck (void)
+{
+  if ((waveInGetNumDevs() == 0) || (waveOutGetNumDevs() == 0))
+    {
+      tst_resm (TINFO, "Skipping, no audio devices present");
+      exit(0);
+    }
+}
+
 /* test some extra ioctls */
 void
 ioctltest (void)
-- 
2.39.0

