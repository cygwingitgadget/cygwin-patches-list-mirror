Return-Path: <SRS0=POwK=DH=dronecode.org.uk=jon.turney@sourceware.org>
Received: from sa-prd-fep-049.btinternet.com (mailomta30-sa.btinternet.com [213.120.69.36])
	by sourceware.org (Postfix) with ESMTPS id 6FB063858409
	for <cygwin-patches@cygwin.com>; Fri, 21 Jul 2023 12:30:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FB063858409
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
          by sa-prd-fep-049.btinternet.com with ESMTP
          id <20230721123001.SBEM27949.sa-prd-fep-049.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
          Fri, 21 Jul 2023 13:30:01 +0100
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 64067FEB0FC12AE8
X-Originating-IP: [86.140.193.83]
X-OWM-Source-IP: 86.140.193.83 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedviedrhedvgdeglecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeevjefgheevgedvvdevleefffeuveekhfegudefueethefgveekvedtkedvjedvieenucffohhmrghinhepmhgrthhrihigrdhtrghrghgvthdptgihghifihhnrdgtohhmnecukfhppeekiedrudegtddrudelfedrkeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudelfedrkeefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddugedtqdduleefqdekfedrrhgrnhhgvgekiedqudegtddrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghu
	shgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepshgrqdhprhguqdhrghhouhhtqddttdef
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.193.83) by sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.814) (authenticated as jonturney@btinternet.com)
        id 64067FEB0FC12AE8; Fri, 21 Jul 2023 13:30:01 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Cygwin: testsuite: Drop using DejaGnu to run tests
Date: Fri, 21 Jul 2023 13:29:39 +0100
Message-Id: <20230721122939.1807-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

A more sophisticated (and modern) test harness would probably be useful,
but switching to Automake's built-in test harness gets us parallel test
execution, colourization of failures, simplifies matters, seems adequate
for the current testuite, and means we don't need to write any icky Tcl.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 .github/workflows/cygwin.yml               |  2 +-
 winsup/configure.ac                        |  2 +-
 winsup/doc/faq-programming.xml             |  5 +-
 winsup/testsuite/Makefile.am               | 27 ++++----
 winsup/testsuite/README                    | 22 +++----
 winsup/testsuite/config/default.exp        | 13 ----
 winsup/testsuite/cygrun.sh                 | 17 +++++
 winsup/testsuite/winsup.api/cygload.exp    | 30 ---------
 winsup/testsuite/winsup.api/known_bugs.tcl |  4 --
 winsup/testsuite/winsup.api/winsup.exp     | 74 ----------------------
 10 files changed, 47 insertions(+), 149 deletions(-)
 delete mode 100644 winsup/testsuite/config/default.exp
 create mode 100755 winsup/testsuite/cygrun.sh
 delete mode 100644 winsup/testsuite/winsup.api/cygload.exp
 delete mode 100644 winsup/testsuite/winsup.api/known_bugs.tcl
 delete mode 100644 winsup/testsuite/winsup.api/winsup.exp

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 39553d37a..5b96a5ee1 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -119,5 +119,5 @@ jobs:
         export MAKEFLAGS=-j$(nproc) &&
         cd build &&
         (export PATH=${{ matrix.target }}/winsup/testsuite/testinst/bin:${PATH} && cmd /c $(cygpath -wa ${{ matrix.target }}/winsup/cygserver/cygserver) &) &&
-        (cd ${{ matrix.target }}/winsup; make check || true)
+        (cd ${{ matrix.target }}/winsup; make check AM_COLOR_TESTS=always || true)
       shell: C:\cygwin\bin\bash.exe --noprofile --norc -eo pipefail '{0}'
diff --git a/winsup/configure.ac b/winsup/configure.ac
index 13fce0da6..9b9b59dbc 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -12,7 +12,7 @@ AC_PREREQ([2.59])
 AC_INIT([Cygwin],[0],[cygwin@cygwin.com],[cygwin],[https://cygwin.com])
 AC_CONFIG_AUX_DIR(..)
 AC_CANONICAL_TARGET
-AM_INIT_AUTOMAKE([dejagnu foreign no-define no-dist subdir-objects -Wall -Wno-portability -Wno-extra-portability])
+AM_INIT_AUTOMAKE([foreign no-define no-dist subdir-objects -Wall -Wno-portability -Wno-extra-portability])
 AM_SILENT_RULES([yes])
 
 realdirpath() {
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 2c684bb2b..ba00dfea5 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -697,9 +697,8 @@ Building these programs can be disabled with the <literal>--without-cross-bootst
 option to <literal>configure</literal>.
 </para>
 
-<!-- If you want to run the tests, <literal>dejagnu</literal>,
-     <literal>busybox</literal> and <literal>cygutils-extra<literal> are also
-     required. -->
+<!-- If you want to run the tests <literal>busybox</literal> and
+     <literal>cygutils-extra<literal> are also required. -->
 
 <para>
 Building the documentation also requires the <literal>dblatex</literal>,
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 9159a1be8..d16805b4d 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -328,19 +328,23 @@ LDADD = $(builddir)/libltp.a $(builddir)/../cygwin/binmode.o $(LDADD_FOR_TESTDLL
 # additional flags for specific test executables
 winsup_api_devdsp_LDADD = -lwinmm $(LDADD)
 
-DEJATOOL = winsup
+# all tests
+TESTS = $(check_PROGRAMS) \
+	mingw/cygload
 
-# Add '-v' to RUNTESTFLAGS if V=1
-RUNTESTFLAGS_1 = -v
-RUNTESTFLAGS = $(RUNTESTFLAGS_$(V))
+# expected fail tests
+XFAIL_TESTS = \
+	winsup.api/ltp/setgroups01 \
+	winsup.api/ltp/setuid02 \
+	winsup.api/ltp/ulimit01 \
+	winsup.api/ltp/unlink08 \
+	winsup.api/samples/sample-fail
 
-site-extra.exp: ../config.status Makefile
-	@rm -f ./tmp0
-	@echo "set runtime_root \"`pwd`/testinst/bin\"" >> ./tmp0
-	@echo "set cygrun \"`pwd`/mingw/cygrun\"" >> ./tmp0
-	@mv ./tmp0 site-extra.exp
+# cygrun.sh test-runner script, and variables used by it:
+LOG_COMPILER = $(srcdir)/cygrun.sh
 
-EXTRA_DEJAGNU_SITE_CONFIG = site-extra.exp
+export runtime_root=$(abs_builddir)/testinst/bin
+export cygrun=$(builddir)/mingw/cygrun
 
 # Set up things in the Cygwin 'installation' at testsuite/testinst/ to provide
 # things which tests need to work
@@ -369,7 +373,8 @@ check-local:
 check_programs: $(check_PROGRAMS)
 
 clean-local:
-	rm -f *.log *.exe *.exp *.bak *.stackdump winsup.sum
+	rm -f *.stackdump
+	rm -rf tmp
 
 if CROSS_BOOTSTRAP
 SUBDIRS = mingw
diff --git a/winsup/testsuite/README b/winsup/testsuite/README
index 363ebb9e8..ff2df4119 100644
--- a/winsup/testsuite/README
+++ b/winsup/testsuite/README
@@ -1,5 +1,3 @@
-1999-12-23  DJ Delorie  <dj@cygnus.com>
-
 Here are some notes about adding and using this testsuite.
 
 The testsuite adds a directory containing the just built cygwin1.dll to the PATH
@@ -20,18 +18,18 @@ The testsuite/winsup.api subdirectory is for testing the API to
 cygwin1.dll ONLY.  Create other subdirs under testsuite/ for other
 classes of testing.
 
-Tests in winsup.api/*.c or winsup.api/*/*.c (only one subdirectory
-level is allowed) either run, and exit(0) or they fail.
-Either abort or exit with a non-zero code to indicate failure.  Don't
-print anything to the screen if you can avoid it (except for failure
-reasons, of course).  One .c file per test, no compile options are
-allowed (we're testing the api, not the compiler).
+Tests under winsup.api/ either run successfully and exit(0), exit(77) to
+indicate a skipped test, or any other exit status to indicate a failure.
+
+Don't print anything to the screen if you can avoid it (except for failure
+reasons, of course).  One .c file per test, no compile options are allowed
+(we're testing the api, not the compiler).
 
-Tests whose filename is mentioned in known-bugs.tcl will be *expected*
-to fail, and will "fail" if they compile, run, and return zero.
+Tests whose filename is mentioned in XFAIL_TESTS are expected to fail,
+effectively reversing the result of those.
 
 "make check" will only work if you run it *on* an NT machine.
 Cross-checking is not supported.
 
-To test a subset of the test-suite, use
-$ make check CYGWIN_TESTSUITE_TESTS=regexp
+To run selected tests, use e.g:
+$ make check TESTS="winsup.api/ltp/umask03 winsup.api/ltp/stat06"
diff --git a/winsup/testsuite/config/default.exp b/winsup/testsuite/config/default.exp
deleted file mode 100644
index ad91caa03..000000000
--- a/winsup/testsuite/config/default.exp
+++ /dev/null
@@ -1,13 +0,0 @@
-proc winsup_version {} {
-    global env
-    global runtime_root
-    clone_output "\n[exec grep -a ^%%% $runtime_root/cygwin1.dll]\n"
-    if { [info exists env(CYGWIN)] } {
-        clone_output "CYGWIN=$env(CYGWIN)\n"
-    } else {
-        clone_output "CYGWIN=\n"
-    }
-}
-
-proc winsup_exit {} {
-}
diff --git a/winsup/testsuite/cygrun.sh b/winsup/testsuite/cygrun.sh
new file mode 100755
index 000000000..c82c1872b
--- /dev/null
+++ b/winsup/testsuite/cygrun.sh
@@ -0,0 +1,17 @@
+#!/bin/dash
+#
+# test driver to run $1 in the appropriate environment
+#
+
+# $1 = test executable to run
+exe=$1
+
+export PATH="$runtime_root:${PATH}"
+
+if [ "$1" = "./mingw/cygload" ]
+then
+    windows_runtime_root=$(cygpath -m $runtime_root)
+    $exe -v -cygwin $windows_runtime_root/cygwin1.dll
+else
+    cygdrop $cygrun $exe
+fi
diff --git a/winsup/testsuite/winsup.api/cygload.exp b/winsup/testsuite/winsup.api/cygload.exp
deleted file mode 100644
index 724cb01cc..000000000
--- a/winsup/testsuite/winsup.api/cygload.exp
+++ /dev/null
@@ -1,30 +0,0 @@
-source "site.exp"
-
-if { ! [isnative] } {
-    verbose "skipping cygload because it's not native \"$target_triplet\" != \"$build_triplet\""
-    return
-}
-
-proc ws_spawn {cmd args} {
-    global rv
-    verbose "running $cmd\n"
-    set rv {}
-    # First item in rv is the return code, second item is the message
-    lappend rv [catch "exec $cmd" message] $message
-    verbose send "catchCode = $rv\n"
-}
-
-if { $verbose } {
-    set redirect_output "./mingw-cygwin.log"
-} else {
-    set redirect_output /dev/null
-}
-
-set windows_runtime_root [exec cygpath -m $runtime_root]
-ws_spawn "./mingw/cygload.exe -cygwin $windows_runtime_root/cygwin1.dll > $redirect_output"
-if { $rv != {0 {}} } {
-    verbose -log "cygload: $rv"
-    fail "cygload"
-} else {
-    pass "cygload"
-}
diff --git a/winsup/testsuite/winsup.api/known_bugs.tcl b/winsup/testsuite/winsup.api/known_bugs.tcl
deleted file mode 100644
index 4f13c90e0..000000000
--- a/winsup/testsuite/winsup.api/known_bugs.tcl
+++ /dev/null
@@ -1,4 +0,0 @@
-set xfail_list [list \
-    setgroups01 setuid02 \
-    ulimit01 unlink08 \
-    sample-fail sample-miscompile]
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
deleted file mode 100644
index 76455a97c..000000000
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ /dev/null
@@ -1,74 +0,0 @@
-source "site.exp"
-source "$srcdir/winsup.api/known_bugs.tcl"
-
-if { ! [isnative] } {
-    verbose "skipping winsup.api because it's not native"
-    return
-}
-
-set rv ""
-
-set orig_path "$env(PATH)"
-
-set test_filter ""
-
-if { [info exists env(CYGWIN_TESTSUITE_TESTS)] } {
-    set test_filter "$env(CYGWIN_TESTSUITE_TESTS)"
-}
-
-proc ws_spawn {cmd} {
-    global rv
-    verbose "running $cmd\n"
-    try {
-	set msg [exec -ignorestderr {*}$cmd "2>@1"]
-	set rv 0
-    } trap CHILDSTATUS {results options} {
-	verbose "returned $::errorCode\n"
-	set msg $results
-	set rv 1
-    }
-    verbose -log "$msg"
-    return $rv
-}
-
-verbose "Filter: $test_filter"
-
-foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc,c}]] {
-    if { $test_filter != "" && ! [regexp $test_filter $src] } {
-	verbose -log "Skipping $src"
-	continue
-    }
-
-    regsub "^$srcdir/$subdir/" $src "" testcase
-    regsub ".c$" $testcase "" base
-    regsub ".*/" $base "" basename
-    regsub "/" $base "-" tmpfile
-
-    set exec "./winsup.api/$base.exe"
-
-    if { [lsearch -exact $xfail_list $basename] >= 0 } {
-        set xfail_expected 1
-	setup_xfail "*-*-*"
-    } else {
-        set xfail_expected 0
-	clear_xfail
-    }
-
-    if [ file exists "$srcdir/$subdir/$basename.exp" ] then {
-	source "$srcdir/$subdir/$basename.exp"
-    } else {
-	    if { $verbose } {
-	       set redirect_output "./$tmpfile.log"
-	    } else {
-	       set redirect_output /dev/null
-	    }
-	    set env(PATH) "$runtime_root:$env(PATH)"
-	    ws_spawn "cygdrop $cygrun $exec > $redirect_output"
-	    set env(PATH) "$orig_path"
-	    if { $rv } {
-		fail "$testcase"
-	    } else {
-		pass "$testcase"
-	    }
-    }
-}
-- 
2.39.0

