Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-046.btinternet.com (mailomta30-sa.btinternet.com
 [213.120.69.36])
 by sourceware.org (Postfix) with ESMTPS id 1862739F501E
 for <cygwin-patches@cygwin.com>; Thu,  5 Nov 2020 19:48:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1862739F501E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.38.7])
 by sa-prd-fep-046.btinternet.com with ESMTP id
 <20201105194831.XAVE28150.sa-prd-fep-046.btinternet.com@sa-prd-rgout-004.btmx-prd.synchronoss.net>;
 Thu, 5 Nov 2020 19:48:31 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9B66119336F28
X-Originating-IP: [86.139.158.14]
X-OWM-Source-IP: 86.139.158.14 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedruddtjedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrudegnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrudegpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.14) by
 sa-prd-rgout-004.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9B66119336F28; Thu, 5 Nov 2020 19:48:31 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 11/11] Ensure temporary directory used by tests exists
Date: Thu,  5 Nov 2020 19:47:48 +0000
Message-Id: <20201105194748.31282-12-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1200.8 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Thu, 05 Nov 2020 19:48:33 -0000

By default, libltp tests will create temporary files in a subdirectory
of /tmp, which will (nowadays) be located relative to the test DLL (by
assuming that it is in /bin).  This will evaluate to the directory
$target_builddir/winsup/tmp, which doesn't exist.

The location used for these temporary files can be explicitly controlled
by setting the TDIRECTORY env var.  Arrange to set that env var to the
/cygdrive path of a tmp subdirectory of the build directory.

Unfortunately, libltp doesn't clean the temporary directory if
TDIRECTORY is set, and some tests assume they are started in a clean
directory, so we need to do that in tcl.
---
 winsup/testsuite/Makefile.in           | 10 ++++++++--
 winsup/testsuite/cygrun.c              |  5 ++++-
 winsup/testsuite/winsup.api/winsup.exp |  4 +++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/winsup/testsuite/Makefile.in b/winsup/testsuite/Makefile.in
index b77961878..3b5a251b2 100644
--- a/winsup/testsuite/Makefile.in
+++ b/winsup/testsuite/Makefile.in
@@ -97,7 +97,8 @@ force:
 install:
 
 clean:
-	-rm -f *.o *.dll *.a *.exp junk *.bak *.base *.exe testsuite/* *.d *.dat
+	-rm -f *.o *.dll *.a *.exp junk *.bak *.base *.exe *.d *.dat
+	-rm -rf testsuite
 
 maintainer-clean realclean: clean
 	@echo "This command is intended for maintainers to use;"
@@ -123,6 +124,11 @@ $(RUNTIME) : $(cygwin_build)/Makefile
 # Set to $(target_alias)/ for cross.
 target_subdir = @target_subdir@
 
+# temporary directory to be used for files created by tests (as an absolute,
+# /cygdrive path, so it can be understood by the test DLL, which will have
+# different mount table)
+tmpdir = $(shell cygpath -ma $(objdir)/testsuite/tmp/ | sed -e 's#^\([A-Z]\):#/cygdrive/\L\1#')
+
 site.exp: ./config.status Makefile
 	@echo "Making a new config file..."
 	-@rm -f ./tmp?
@@ -142,7 +148,7 @@ site.exp: ./config.status Makefile
 # CFLAGS is set even though it's empty to show we reserve the right to set it.
 	@echo "set CFLAGS \"$(ALL_CFLAGS)\"" >> ./tmp0
 	@echo "set MINGW_CXX \"$(MINGW_CXX)\"" >> ./tmp0
-	echo "set tmpdir $(objdir)/testsuite" >> ./tmp0
+	@echo "set tmpdir $(tmpdir)" >> ./tmp0
 	@echo "set ltp_includes \"$(realpath $(libltp_srcdir))/include\"" >> ./tmp0
 	@echo "## All variables above are generated by configure. Do Not Edit ##" >> ./tmp0
 	@cat ./tmp0 > site.exp
diff --git a/winsup/testsuite/cygrun.c b/winsup/testsuite/cygrun.c
index d1f53aad3..65d859d59 100644
--- a/winsup/testsuite/cygrun.c
+++ b/winsup/testsuite/cygrun.c
@@ -25,10 +25,13 @@ main (int argc, char **argv)
 
   if (argc < 2)
     {
-      fprintf (stderr, "Usage: cygrun [program]\n");
+      fprintf (stderr, "Usage: cygrun [program] [tmpdir]\n");
       exit (0);
     }
 
+  if (argc >= 3)
+    SetEnvironmentVariable ("TDIRECTORY", argv[2]);
+
   SetEnvironmentVariable ("CYGWIN_TESTING", "1");
   if ((p = getenv ("CYGWIN")) == NULL || (strstr (p, "ntsec") == NULL))
     {
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index 1550b9445..cd5964d47 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -68,7 +68,9 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	    } else {
 	       set redirect_output /dev/null
 	    }
-	    ws_spawn "$rootme/cygrun ./$base.exe > $redirect_output"
+	    file mkdir $tmpdir/$base
+	    ws_spawn "$rootme/cygrun ./$base.exe $tmpdir/$base > $redirect_output"
+	    file delete -force $tmpdir/$base
 	    if { $rv } {
 		fail "$testcase (execute)"
 		if { $xfail_expected } {
-- 
2.29.0

