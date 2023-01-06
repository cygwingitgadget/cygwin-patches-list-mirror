Return-Path: <SRS0=/FVG=5D=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-047.btinternet.com (mailomta6-sa.btinternet.com [213.120.69.12])
	by sourceware.org (Postfix) with ESMTPS id 940213858D33
	for <cygwin-patches@cygwin.com>; Fri,  6 Jan 2023 14:38:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 940213858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-047.btinternet.com with ESMTP
          id <20230106143842.RQIX13453.sa-prd-fep-047.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 6 Jan 2023 14:38:42 +0000
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 613942904AFEB98A
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgdeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpefggfekvdfffedujeelgfefveegieelteekudeuudfgfeefjeeiudekkefgvdffffenucffohhmrghinhepughinhdrihhtnecukfhppeekuddrudehfedrleekrddvgeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekuddrudehfedrleekrddvgeeipdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 613942904AFEB98A; Fri, 6 Jan 2023 14:38:42 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: Run testsuite against the just-built DLL
Date: Fri,  6 Jan 2023 14:38:23 +0000
Message-Id: <20230106143823.53627-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221221161834.45553-1-jon.turney@dronecode.org.uk>
References: <20221221161834.45553-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.8 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Since 4e7817498efc, we're just running the tests against the installed
DLL.  We're arranging to put the build directory on the path, but since
it doesn't contain cygwin1.dll (since it's built with a different name
and renamed on installation), that doesn't have any effect.

Arrange to place the just-built DLL into a directory which the testsuite
can place on it's path (while running the test, but not while compiling
it).

Also fix any remaining references to cygwin0.dll in testsuite,
documentation and comments.

Fixes: 4e7817498efc ("Cygwin: Makefile: Drop all the "test dll" considerations")
---

Notes:
    This flips a couple of tests from passing to failing, since they try to
    use system(), which doesn't work, because there is no /usr/bin/bash in
    the Cygwin 'installation' at testsuite/runtime/.
    
    I think perhaps the best solution long-term is to remove all these
    fragile hacks to try to run the testsuite on top of an existing Cygwin,
    and instead the CI should save the result of 'make install' in an
    archive, and a job should unpack that and run the testsuite on it...

 winsup/cygwin/Makefile.am               | 8 +++++---
 winsup/cygwin/scripts/analyze_sigfe     | 2 +-
 winsup/testsuite/Makefile.am            | 3 ++-
 winsup/testsuite/README                 | 9 +++------
 winsup/testsuite/config/default.exp     | 2 +-
 winsup/testsuite/winsup.api/cygload.exp | 2 +-
 winsup/testsuite/winsup.api/winsup.exp  | 8 +++++---
 7 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/winsup/cygwin/Makefile.am b/winsup/cygwin/Makefile.am
index 2faa867f9..125358b4b 100644
--- a/winsup/cygwin/Makefile.am
+++ b/winsup/cygwin/Makefile.am
@@ -577,9 +577,9 @@ LIBSERVER = $(cygserver_blddir)/libcygserver.a
 $(LIBSERVER):
 	$(MAKE) -C $(cygserver_blddir) libcygserver.a
 
-# We build as cygwin0.dll and rename at install time to overcome native
+# We build as new-cygwin1.dll and rename at install time to overcome native
 # rebuilding issues (we don't want the build tools to see a partially built
-# cygwin.dll and attempt to use it instead of the old one).
+# cygwin1.dll and attempt to use it instead of the old one).
 
 # linker script
 LDSCRIPT=cygwin.sc
@@ -601,6 +601,8 @@ $(NEW_DLL_NAME): $(LDSCRIPT) libdll.a $(VERSION_OFILES) $(LIBSERVER)\
 	$(newlib_build)/libm.a \
 	$(newlib_build)/libc.a \
 	-lgcc -lkernel32 -lntdll -Wl,-Map,cygwin.map
+	@$(MKDIR_P) ${target_builddir}/winsup/testsuite/runtime/
+	$(AM_V_at)$(INSTALL_PROGRAM) $(NEW_DLL_NAME) ${target_builddir}/winsup/testsuite/runtime/$(DLL_NAME)
 
 # cygwin import library
 toolopts=--cpu=@target_cpu@ --ar=@AR@ --as=@AS@ --nm=@NM@ --objcopy=@OBJCOPY@
@@ -712,7 +714,7 @@ install-ldif:
 uninstall-hook: uninstall-headers uninstall-ldif uninstall-libs
 
 uninstall-libs:
-	rm -f $(DESTDIR)$(bindir)/cygwin1.dll
+	rm -f $(DESTDIR)$(bindir)/$(DLL_NAME)
 	rm -f $(DESTDIR)$(toollibdir)/libg.a
 
 uninstall-headers:
diff --git a/winsup/cygwin/scripts/analyze_sigfe b/winsup/cygwin/scripts/analyze_sigfe
index 8704eea48..f6bda2355 100755
--- a/winsup/cygwin/scripts/analyze_sigfe
+++ b/winsup/cygwin/scripts/analyze_sigfe
@@ -9,7 +9,7 @@
 # This will do a crude test to see if the (NO)?SIGFE stuff is used properly
 # in cygwin.din.  It is not perfect so do not use it to do a wholesale replacement.
 #
-# Input is the output of 'objdump --disassemble --demangle cygwin0.dll'.
+# Input is the output of 'objdump --disassemble --demangle new-cygwin1.dll'.
 #
 use strict;
 use vars qw'$v';
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index ac68934d0..a7b435c46 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -45,7 +45,8 @@ testdll_tmpdir = $(shell cygpath -ma $(tmpdir) | sed -e 's#^\([A-Z]\):#/cygdrive
 
 site-extra.exp: ../config.status Makefile
 	@rm -f ./tmp0
-	@echo "set runtime_root \"`pwd`/../cygwin\"" >> ./tmp0
+	@echo "set runtime_root \"`pwd`/runtime\"" >> ./tmp0
+	@echo "set libdir \"`pwd`/../cygwin\"" >> ./tmp0
 	@echo "set CC \"$(CC)\"" >> ./tmp0
 	@echo "set CFLAGS \"\"" >> ./tmp0
 	@echo "set MINGW_CXX \"$(MINGW_CXX)\"" >> ./tmp0
diff --git a/winsup/testsuite/README b/winsup/testsuite/README
index 2f6749bb8..c22b06594 100644
--- a/winsup/testsuite/README
+++ b/winsup/testsuite/README
@@ -2,10 +2,9 @@
 
 Here are some notes about adding and using this testsuite.
 
-First, all the programs are linked with libcygwin0.a, which is just
-like libcygwin.a, except that it wants cygwin0.dll, not
-cygwin1.dll.  The testsuite adds the winsup build directory to the
-PATH so that cygwin0.dll can be found by windows during testing.
+The testsuite adds a directory containing the just built cygwin1.dll to the PATH
+(during the run step) so that it can be found by the Windows loader during
+testing.
 
 Because we'll probably run into complaints about using two DLLs, we
 run cygrun.exe for each test.  All this does is run the test with
@@ -36,5 +35,3 @@ Cross-checking is not supported.
 
 To test a subset of the test-suite, use
 $ make check CYGWIN_TESTSUITE_TESTS=regexp
-
-
diff --git a/winsup/testsuite/config/default.exp b/winsup/testsuite/config/default.exp
index 7ef16ee6a..ad91caa03 100644
--- a/winsup/testsuite/config/default.exp
+++ b/winsup/testsuite/config/default.exp
@@ -1,7 +1,7 @@
 proc winsup_version {} {
     global env
     global runtime_root
-    clone_output "\n[exec grep -a ^%%% $runtime_root/cygwin0.dll]\n"
+    clone_output "\n[exec grep -a ^%%% $runtime_root/cygwin1.dll]\n"
     if { [info exists env(CYGWIN)] } {
         clone_output "CYGWIN=$env(CYGWIN)\n"
     } else {
diff --git a/winsup/testsuite/winsup.api/cygload.exp b/winsup/testsuite/winsup.api/cygload.exp
index 8ba8249bb..e378820ad 100644
--- a/winsup/testsuite/winsup.api/cygload.exp
+++ b/winsup/testsuite/winsup.api/cygload.exp
@@ -32,7 +32,7 @@ if { $rv != {0 {}} } {
         set redirect_output /dev/null
     }
     set windows_runtime_root [exec cygpath -m $runtime_root]
-    ws_spawn "./mingw-cygload.exe -cygwin $windows_runtime_root/cygwin0.dll > $redirect_output"
+    ws_spawn "./mingw-cygload.exe -cygwin $windows_runtime_root/cygwin1.dll > $redirect_output"
     if { $rv != {0 {}} } {
         verbose -log "cygload: $rv"
         fail "cygload (execute)"
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index f755c82d9..e81ead304 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -14,9 +14,9 @@ set ltp_libs "$ltp_libs"
 set add_includes $ltp_includes
 set add_libs $ltp_libs
 
-set test_filter ""
+set orig_path "$env(PATH)"
 
-set env(PATH) "$runtime_root:$env(PATH)"
+set test_filter ""
 
 if { [info exists env(CYGWIN_TESTSUITE_TESTS)] } {
     set test_filter "$env(CYGWIN_TESTSUITE_TESTS)"
@@ -61,7 +61,7 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
     if [ file exists "$srcdir/$subdir/$basename.exp" ] then {
 	source "$srcdir/$subdir/$basename.exp"
     } else {
-	ws_spawn "$CC -nodefaultlibs -mwin32 $CFLAGS $src $add_includes $add_libs $runtime_root/binmode.o -lgcc $runtime_root/libcygwin.a -lkernel32 -luser32 -o $base.exe"
+	ws_spawn "$CC -nodefaultlibs -mwin32 $CFLAGS $src $add_includes $add_libs $libdir/binmode.o -lgcc $libdir/libcygwin.a -lkernel32 -luser32 -o $base.exe"
 	if { $rv } {
 	    fail "$testcase (compile)"
 	} else {
@@ -71,8 +71,10 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
 	       set redirect_output /dev/null
 	    }
 	    file mkdir $tmpdir/$base
+	    set env(PATH) "$runtime_root:$env(PATH)"
 	    ws_spawn "$cygrun ./$base.exe $testdll_tmpdir/$base > $redirect_output"
 	    file delete -force $tmpdir/$base
+	    set env(PATH) "$orig_path"
 	    if { $rv } {
 		fail "$testcase (execute)"
 		if { $xfail_expected } {
-- 
2.39.0

