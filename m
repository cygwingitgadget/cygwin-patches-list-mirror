Return-Path: <SRS0=fe21=DF=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-045.btinternet.com (mailomta17-sa.btinternet.com [213.120.69.23])
	by sourceware.org (Postfix) with ESMTPS id 32E9E3858436
	for <cygwin-patches@cygwin.com>; Wed, 19 Jul 2023 12:41:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 32E9E3858436
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.38.5])
          by sa-prd-fep-045.btinternet.com with ESMTP
          id <20230719124158.GIJO29451.sa-prd-fep-045.btinternet.com@sa-prd-rgout-002.btmx-prd.synchronoss.net>;
          Wed, 19 Jul 2023 13:41:58 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64AECEEE00C7CDE3
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrgeekgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-002.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64AECEEE00C7CDE3; Wed, 19 Jul 2023 13:41:57 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: testsuite: Drop setting TDIRECTORY
Date: Wed, 19 Jul 2023 13:41:41 +0100
Message-Id: <20230719124142.10310-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
References: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Drop setting TDIRECTORY, just use /tmp in the 'test installation' now
that we have it.

This effectively reverts f3ed5f2fe029d74372aca68b18936e164ff47cf7

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/testsuite/Makefile.am           | 8 --------
 winsup/testsuite/cygrun.c              | 5 +----
 winsup/testsuite/winsup.api/winsup.exp | 4 +---
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 60111a0aa..9159a1be8 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -334,17 +334,9 @@ DEJATOOL = winsup
 RUNTESTFLAGS_1 = -v
 RUNTESTFLAGS = $(RUNTESTFLAGS_$(V))
 
-# a temporary directory, to be used for files created by tests
-tmpdir = $(abspath $(builddir)/tmp/)
-# the same temporary directory, as an absolute, /cygdrive path (so it can be
-# understood by the test DLL, which will have a different mount table)
-testdll_tmpdir = $(shell cygpath -ma $(tmpdir) | sed -e 's#^\([A-Z]\):#/cygdrive/\L\1#')
-
 site-extra.exp: ../config.status Makefile
 	@rm -f ./tmp0
 	@echo "set runtime_root \"`pwd`/testinst/bin\"" >> ./tmp0
-	@echo "set tmpdir $(tmpdir)" >> ./tmp0
-	@echo "set testdll_tmpdir $(testdll_tmpdir)" >> ./tmp0
 	@echo "set cygrun \"`pwd`/mingw/cygrun\"" >> ./tmp0
 	@mv ./tmp0 site-extra.exp
 
diff --git a/winsup/testsuite/cygrun.c b/winsup/testsuite/cygrun.c
index 925b5513f..d8de7d158 100644
--- a/winsup/testsuite/cygrun.c
+++ b/winsup/testsuite/cygrun.c
@@ -26,13 +26,10 @@ main (int argc, char **argv)
 
   if (argc < 2)
     {
-      fprintf (stderr, "Usage: cygrun [program] [tmpdir]\n");
+      fprintf (stderr, "Usage: cygrun [program]\n");
       exit (0);
     }
 
-  if (argc >= 3)
-    SetEnvironmentVariable ("TDIRECTORY", argv[2]);
-
   SetEnvironmentVariable ("CYGWIN_TESTING", "1");
 
   memset (&sa, 0, sizeof (sa));
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index 111509511..76455a97c 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -62,10 +62,8 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	    } else {
 	       set redirect_output /dev/null
 	    }
-	    file mkdir $tmpdir/$tmpfile
 	    set env(PATH) "$runtime_root:$env(PATH)"
-	    ws_spawn "cygdrop $cygrun $exec $testdll_tmpdir/$tmpfile > $redirect_output"
-	    file delete -force $tmpdir/$tmpfile
+	    ws_spawn "cygdrop $cygrun $exec > $redirect_output"
 	    set env(PATH) "$orig_path"
 	    if { $rv } {
 		fail "$testcase"
-- 
2.39.0

