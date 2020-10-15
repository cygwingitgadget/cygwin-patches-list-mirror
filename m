Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-041.btinternet.com (mailomta10-re.btinternet.com
 [213.120.69.103])
 by sourceware.org (Postfix) with ESMTPS id EFAC23950C06
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 14:37:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EFAC23950C06
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-041.btinternet.com with ESMTP id
 <20201015143714.OOQV30588.re-prd-fep-041.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 15 Oct 2020 15:37:14 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.143.43.37]
X-OWM-Source-IP: 86.143.43.37 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrieefgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegfedrgeefrdefjeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeefrdegfedrfeejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.143.43.37) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC15FB5A73; Thu, 15 Oct 2020 15:37:14 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/3] Remove ccwrap
Date: Thu, 15 Oct 2020 15:36:51 +0100
Message-Id: <20201015143652.56501-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201015143652.56501-1-jon.turney@dronecode.org.uk>
References: <20201015143652.56501-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1201.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Thu, 15 Oct 2020 14:37:25 -0000

---
 winsup/Makefile.common       |  4 +--
 winsup/acinclude.m4          | 16 +++++------
 winsup/c++wrap               |  6 -----
 winsup/ccwrap                | 51 ------------------------------------
 winsup/configure.cygwin      | 10 -------
 winsup/cygserver/Makefile.in |  9 +------
 winsup/cygwin/Makefile.in    | 13 +++------
 winsup/cygwin/gentls_offsets |  2 +-
 winsup/utils/Makefile.in     | 11 +-------
 9 files changed, 16 insertions(+), 106 deletions(-)
 delete mode 100755 winsup/c++wrap
 delete mode 100755 winsup/ccwrap

diff --git a/winsup/Makefile.common b/winsup/Makefile.common
index a04d8e1de..69cac9b43 100644
--- a/winsup/Makefile.common
+++ b/winsup/Makefile.common
@@ -21,8 +21,8 @@ opt=$(filter -O%,${CFLAGS}) $(filter -g%,${CFLAGS})
 override CXXFLAGS:=${filter-out -g%,$(filter-out -O%,${CXXFLAGS})} ${opt}
 
 cflags_common:=-Wall -Wstrict-aliasing -Wwrite-strings -fno-common -pipe -fbuiltin -fmessage-length=0
-COMPILE.cc=c++wrap ${CXXFLAGS} -fno-rtti -fno-exceptions -fno-use-cxa-atexit ${cflags_common}
-COMPILE.c=ccwrap ${CFLAGS} ${cflags_common}
+COMPILE.cc=${CXX} ${INCLUDES} ${CXXFLAGS} -fno-rtti -fno-exceptions -fno-use-cxa-atexit ${cflags_common}
+COMPILE.c=${CC} ${INCLUDES} ${CFLAGS} ${cflags_common}
 
 top_srcdir:=$(call justdir,${winsup_srcdir})
 top_builddir:=$(call justdir,${target_builddir})
diff --git a/winsup/acinclude.m4 b/winsup/acinclude.m4
index 865ef8b5d..5f71871ec 100644
--- a/winsup/acinclude.m4
+++ b/winsup/acinclude.m4
@@ -29,7 +29,6 @@ AC_SUBST(windows_libdir)
 )
 
 AC_DEFUN([AC_CYGWIN_INCLUDES], [
-addto_CPPFLAGS -nostdinc
 : ${ac_cv_prog_CXX:=$CXX}
 : ${ac_cv_prog_CC:=$CC}
 
@@ -56,13 +55,14 @@ else
 	AC_MSG_ERROR([cannot find windows header files])
     fi
 fi
-CC=$ac_cv_prog_CC
-CXX=$ac_cv_prog_CXX
-export CC
-export CXX
-AC_SUBST(windows_headers)
-AC_SUBST(newlib_headers)
-AC_SUBST(cygwin_headers)
+
+INCLUDES="-I${srcdir}/../cygwin -I${target_builddir}/winsup/cygwin"
+INCLUDES="${INCLUDES} -isystem ${cygwin_headers}"
+for h in ${newlib_headers}; do
+    INCLUDES="${INCLUDES} -isystem $h"
+done
+INCLUDES="${INCLUDES} -isystem ${windows_headers}"
+AC_SUBST(INCLUDES)
 ])
 
 AC_DEFUN([AC_CONFIGURE_ARGS], [
diff --git a/winsup/c++wrap b/winsup/c++wrap
deleted file mode 100755
index 987acb8c5..000000000
--- a/winsup/c++wrap
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/usr/bin/perl
-use strict;
-use File::Basename;
-my $pgm = basename($0);
-(my $wrapper = $pgm) =~ s/\+\+/c/o;
-exec $wrapper, '++', @ARGV;
diff --git a/winsup/ccwrap b/winsup/ccwrap
deleted file mode 100755
index 900fc4ae5..000000000
--- a/winsup/ccwrap
+++ /dev/null
@@ -1,51 +0,0 @@
-#!/usr/bin/perl
-use Cwd;
-use strict;
-my $cxx;
-my $ccorcxx;
-if ($ARGV[0] ne '++') {
-    $ccorcxx = 'CC';
-    $cxx = 0;
-} else {
-    shift @ARGV;
-    $ccorcxx = 'CXX';
-    $cxx = 1;
-}
-die "$0: $ccorcxx environment variable does not exist\n" unless exists $ENV{$ccorcxx};
-$ENV{'LANG'} = 'C';
-my @compiler = split ' ', $ENV{$ccorcxx};
-if ("@ARGV" !~ / -nostdinc/o) {
-    my $fd;
-    push @compiler, ($cxx ? '-xc++' : '-xc');
-    if (!open $fd, '-|') {
-	open STDERR, '>&', \*STDOUT;
-	exec @compiler, '/dev/null', '-v', '-E', '-o', '/dev/null' or die "*** error execing $compiler[0] - $!\n";
-    }
-    $compiler[1] =~ s/xc/nostdinc/o;
-    push @compiler, '-nostdinc' if $cxx;
-    push @compiler, '-I' . $_ for split ' ', $ENV{CCWRAP_HEADERS};
-    push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_SYSTEM_HEADERS};
-    my $finding_paths = 0;
-    while (<$fd>) {
-	if (/^\*\*\*/o) {
-	    print;
-	} elsif ($_ eq "#include <...> search starts here:\n") {
-	    $finding_paths = 1;
-	} elsif (!$finding_paths) {
-	    next;
-	} elsif ($_ eq "End of search list.\n") {
-	    last;
-	} elsif (!m%w32api%o) {
-	    chomp;
-	    s/^\s+//;
-	    push @compiler, '-isystem', Cwd::abs_path($_);
-	}
-    }
-    push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_DIRAFTER_HEADERS};
-    close $fd;
-}
-
-push @compiler, @ARGV;
-
-print join(' ', '+', @compiler), "\n" if $ENV{CCWRAP_VERBOSE};
-exec @compiler or die "$0: $compiler[0] failed to execute\n";
diff --git a/winsup/configure.cygwin b/winsup/configure.cygwin
index 06df92211..ff1f749c4 100755
--- a/winsup/configure.cygwin
+++ b/winsup/configure.cygwin
@@ -1,13 +1,3 @@
-addto_CPPFLAGS() {
-    local f
-    for f; do
-	case " $CPPFLAGS " in
-	    *\ $f\ *) ;;
-	    *) CPPFLAGS="$CPPFLAGS $f" ;;
-	esac
-    done
-}
-
 realdirpath() {
     [ -z "$1" ] && return 1
     (cd "$1" 2>/dev/null && pwd)
diff --git a/winsup/cygserver/Makefile.in b/winsup/cygserver/Makefile.in
index 70f38233c..e360d8fd0 100644
--- a/winsup/cygserver/Makefile.in
+++ b/winsup/cygserver/Makefile.in
@@ -11,22 +11,15 @@ target_builddir:=@target_builddir@
 winsup_srcdir:=@winsup_srcdir@
 configure_args=@configure_args@
 
-export CC:=@CC@
-export CXX:=@CXX@
-
 CFLAGS:=@CFLAGS@
 override CXXFLAGS=@CXXFLAGS@
 override CXXFLAGS+=-MMD -Wimplicit-fallthrough=5 -Werror -D__OUTSIDE_CYGWIN__ -DSYSCONFDIR="\"$(sysconfdir)\""
+INCLUDES:=@INCLUDES@
 
 include ${srcdir}/../Makefile.common
 
 cygwin_build:=${target_builddir}/winsup/cygwin
 
-# environment variables used by ccwrap
-export CCWRAP_HEADERS:=$(dir ${srcdir})/cygwin ${cygwin_build}
-export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
-export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
-
 DESTDIR=
 prefix:=${DESTDIR}@prefix@
 exec_prefix:=${DESTDIR}@exec_prefix@
diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 8ab654e9b..01c2f72a3 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -14,19 +14,12 @@ target_builddir:=@target_builddir@
 winsup_srcdir:=@winsup_srcdir@
 configure_args=@configure_args@
 
-export CC:=@CC@
-export CXX:=@CXX@
-
 CFLAGS?=@CFLAGS@
 CXXFLAGS?=@CXXFLAGS@
+INCLUDES?=@INCLUDES@
 
 include ${srcdir}/../Makefile.common
 
-# environment variables used by ccwrap
-export CCWRAP_HEADERS:=. ${srcdir}
-export CCWRAP_SYSTEM_HEADERS:=@cygwin_headers@ @newlib_headers@
-export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
-
 VPATH+=$(srcdir)/regex $(srcdir)/lib $(srcdir)/libc $(srcdir)/math $(srcdir)/tzcode
 
 target_cpu:=@target_cpu@
@@ -788,7 +781,7 @@ src_files := $(foreach dir,$(VPATH),$(find_src_files))
 # second, so version.cc is always older than winver.o
 version.cc: mkvers.sh include/cygwin/version.h winver.rc $(src_files)
 	@echo "Making version.cc and winver.o";\
-	/bin/sh ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) ${CFLAGS} $(addprefix -I,${CCWRAP_SYSTEM_HEADERS} ${CCWRAP_DIRAFTER_HEADERS})
+	/bin/sh ${word 1,$^} ${word 2,$^} ${word 3,$^} $(WINDRES) ${CFLAGS} -I${srcdir}/include
 $(VERSION_OFILES): version.cc
 
 Makefile: ${srcdir}/Makefile.in
@@ -815,7 +808,7 @@ CTAGS:
 	ctags -R --c++-kinds=+p --fields=+iaS --extra=+q \
 	--regex-C++='/EXPORT_ALIAS *\([a-zA-Z0-9_]*, *([a-zA-Z0-9_]*)\)/\1/' \
 	--regex-C++='/__ASMNAME *\("([a-zA-Z0-9_]+)"\)/\1/' \
-	@newlib_headers@ .
+	.
 
 deps:=${wildcard *.d}
 ifneq (,$(deps))
diff --git a/winsup/cygwin/gentls_offsets b/winsup/cygwin/gentls_offsets
index 59080c331..ef78d449a 100755
--- a/winsup/cygwin/gentls_offsets
+++ b/winsup/cygwin/gentls_offsets
@@ -89,7 +89,7 @@ EOF
 close TMP;
 my @avoid_headers = qw'-D_XMMINTRIN_H_INCLUDED -D_ADXINTRIN_H_INCLUDED -D_EMMINTRIN_H_INCLUDED -D_X86INTRIN_H_INCLUDED';
 my @cmd = (@ARGV, @avoid_headers, '-o', "/tmp/$$-1.cc", '-E', "/tmp/$$.cc");
-$ENV{CCWRAP_VERBOSE}=1;
+
 system @cmd;
 system 'g++', "$tgt_opt", '-o', "/tmp/$$.a.out", "/tmp/$$-1.cc" and
 ($? == 127 && system 'c++', "$tgt_opt", '-o', "/tmp/$$.a.out", "/tmp/$$-1.cc") and
diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index 889fdaab3..bd17d6862 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -11,12 +11,10 @@ target_builddir:=@target_builddir@
 winsup_srcdir:=@winsup_srcdir@
 configure_args=@configure_args@
 
-export CC:=@CC@
-export CXX:=@CXX@
-
 CFLAGS_COMMON=-Wimplicit-fallthrough=4 -Werror
 CFLAGS:=@CFLAGS@
 CXXFLAGS:=@CXXFLAGS@
+INCLUDES:=@INCLUDES@
 override CFLAGS+=${CFLAGS_COMMON}
 override CXXFLAGS+=-fno-exceptions -fno-rtti ${CFLAGS_COMMON}
 
@@ -24,13 +22,6 @@ include ${srcdir}/../Makefile.common
 
 cygwin_build:=${target_builddir}/winsup/cygwin
 
-cygwin_headers:=@cygwin_headers@
-
-# environment variables used by ccwrap
-export CCWRAP_HEADERS:=. ${srcdir} $(call justdir,${cygwin_headers})
-export CCWRAP_SYSTEM_HEADERS:=${cygwin_headers} @newlib_headers@
-export CCWRAP_DIRAFTER_HEADERS:=@windows_headers@
-
 WINDOWS_LIBDIR:=@windows_libdir@
 
 prefix:=@prefix@
-- 
2.28.0

