Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta8-sa.btinternet.com
 [213.120.69.14])
 by sourceware.org (Postfix) with ESMTPS id CF58939F501E
 for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2020 19:48:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CF58939F501E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201105194826.XAUW28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 5 Nov 2020 19:48:26 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B66119336E9D
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B66119336E9D; Thu, 5 Nov 2020 19:48:26 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 09/11] Check exit code of a test, rather than stdout
Date: Thu,  5 Nov 2020 19:47:46 +0000
Message-Id: <20201105194748.31282-10-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Thu, 05 Nov 2020 19:48:28 -0000

In winsup.exp, don't consider a command failed if it produced any output
(e.g. if the compiler produced warnings).  Instead check the exit code.
---
 winsup/testsuite/winsup.api/winsup.exp | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index 639096267..1550b9445 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -20,11 +20,19 @@ if { [info exists env(CYGWIN_TESTSUITE_TESTS)] } {
     set test_filter "$env(CYGWIN_TESTSUITE_TESTS)"
 }
 
-proc ws_spawn {cmd args} {
+proc ws_spawn {cmd} {
     global rv
     verbose "running $cmd\n"
-    catch "exec $cmd" rv
-    verbose send "catchCode = $rv\n"
+    try {
+	set msg [exec -ignorestderr {*}$cmd "2>@1"]
+	set rv 0
+    } trap CHILDSTATUS {results options} {
+	verbose "returned $::errorCode\n"
+	set msg $results
+	set rv 1
+    }
+    verbose -log "$msg"
+    return $rv
 }
 
 verbose "Filter: $test_filter"
@@ -52,8 +60,7 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	source "$srcdir/$subdir/$basename.exp"
     } else {
 	ws_spawn "$CC -nodefaultlibs -mwin32 $CFLAGS $src $add_includes $add_libs $runtime_root/binmode.o -lgcc $runtime_root/libcygwin0.a -lkernel32 -luser32 -o $base.exe"
-	if { $rv != "" } {
-	    verbose -log "$rv"
+	if { $rv } {
 	    fail "$testcase (compile)"
 	} else {
 	    if { $verbose } {
@@ -62,8 +69,7 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	       set redirect_output /dev/null
 	    }
 	    ws_spawn "$rootme/cygrun ./$base.exe > $redirect_output"
-	    if { $rv != "" } {
-		verbose -log "$testcase: $rv"
+	    if { $rv } {
 		fail "$testcase (execute)"
 		if { $xfail_expected } {
 		    catch { file delete "$base.exe" } err
-- 
2.29.0

