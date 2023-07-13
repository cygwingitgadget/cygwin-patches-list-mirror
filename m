Return-Path: <SRS0=uvj4=C7=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-043.btinternet.com (mailomta11-sa.btinternet.com [213.120.69.17])
	by sourceware.org (Postfix) with ESMTPS id A72353856DFB
	for <cygwin-patches@cygwin.com>; Thu, 13 Jul 2023 11:41:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A72353856DFB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
          by sa-prd-fep-043.btinternet.com with ESMTP
          id <20230713114136.RCUV1396.sa-prd-fep-043.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
          Thu, 13 Jul 2023 12:41:36 +0100
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 64067D310ED32809
X-Originating-IP: [81.129.146.179]
X-OWM-Source-IP: 81.129.146.179 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrfeeggdefhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduvdelrddugeeirddujeelnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddruddvledrudegiedrudejledpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddquddvledqudegiedqudejledrrhgrnhhgvgekuddquddvledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhm
	pdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttddu
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.179) by sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067D310ED32809; Thu, 13 Jul 2023 12:41:36 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 11/11] Cygwin: testsuite: Drop Adminstrator privileges while running tests
Date: Thu, 13 Jul 2023 12:39:04 +0100
Message-Id: <20230713113904.1752-12-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
References: <20230713113904.1752-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Test access05 and symlink03 expect operations to fail which succeed when
we have Adminstrator privileges.

There's perhaps a bit of incoherency here: some XFAILed tests expect to
run as root (so maybe we need the ability to selectively cygdrop?).
---
 .github/workflows/cygwin.yml           | 1 +
 winsup/doc/faq-programming.xml         | 5 +++--
 winsup/testsuite/winsup.api/winsup.exp | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 248a3e4cd..39553d37a 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -73,6 +73,7 @@ jobs:
           automake,
           busybox,
           cocom,
+          cygutils-extra,
           dblatex,
           dejagnu,
           docbook-xml45,
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 15ae6eac4..2c684bb2b 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -697,8 +697,9 @@ Building these programs can be disabled with the <literal>--without-cross-bootst
 option to <literal>configure</literal>.
 </para>
 
-<!-- If you want to run the tests, <literal>dejagnu</literal> and
-     <literal>busybox</literal> are also required. -->
+<!-- If you want to run the tests, <literal>dejagnu</literal>,
+     <literal>busybox</literal> and <literal>cygutils-extra<literal> are also
+     required. -->
 
 <para>
 Building the documentation also requires the <literal>dblatex</literal>,
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index fb3e3816c..111509511 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -64,7 +64,7 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	    }
 	    file mkdir $tmpdir/$tmpfile
 	    set env(PATH) "$runtime_root:$env(PATH)"
-	    ws_spawn "$cygrun $exec $testdll_tmpdir/$tmpfile > $redirect_output"
+	    ws_spawn "cygdrop $cygrun $exec $testdll_tmpdir/$tmpfile > $redirect_output"
 	    file delete -force $tmpdir/$tmpfile
 	    set env(PATH) "$orig_path"
 	    if { $rv } {
-- 
2.39.0

