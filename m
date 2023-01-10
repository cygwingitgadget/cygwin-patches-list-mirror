Return-Path: <SRS0=Pl6r=5H=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-043.btinternet.com (mailomta10-re.btinternet.com [213.120.69.103])
	by sourceware.org (Postfix) with ESMTPS id A1EBE3857007
	for <cygwin-patches@cygwin.com>; Tue, 10 Jan 2023 16:37:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A1EBE3857007
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from re-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.54.6])
          by re-prd-fep-043.btinternet.com with ESMTP
          id <20230110163738.XMPP21016.re-prd-fep-043.btinternet.com@re-prd-rgout-003.btmx-prd.synchronoss.net>;
          Tue, 10 Jan 2023 16:37:38 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 61A69BAC3ED8A374
X-Originating-IP: [81.153.98.246]
X-OWM-Source-IP: 81.153.98.246 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeliedtjefhtdevkeehueegffegveeftdejjeevfefhiefffeektddvteehheeijeenucfkphepkedurdduheefrdelkedrvdegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduheefrdelkedrvdegiedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedvpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhk
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.153.98.246) by re-prd-rgout-003.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as jonturney@btinternet.com)
        id 61A69BAC3ED8A374; Tue, 10 Jan 2023 16:37:38 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/8] Cygwin: testsuite: Build testcases using automake
Date: Tue, 10 Jan 2023 16:37:03 +0000
Message-Id: <20230110163709.16265-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
References: <20230110163709.16265-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1197.7 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Build all the testcase executables directly using automake, rather than
passing the compiler information into DejaGnu to have it build them.

(This means you get build avoidance for these executables, so they only
get built once, rather than every time you run the test, and makes it
much easier to run them in isolatation against the installed Cygwin,
which is really nice to have when trying to fix broken tests...)

Rename the 'cygrun' subdirectory to 'mingw', and build all the testsuite
MinGW executables there.

Drop sample-miscompile.c (testing that compile failure is detected is
perhaps useful, but not here...)
---
 winsup/configure.ac                           |   2 +-
 winsup/testsuite/Makefile.am                  | 307 +++++++++++++++++-
 winsup/testsuite/README                       |   2 +-
 .../testsuite/{cygrun => mingw}/Makefile.am   |  11 +-
 winsup/testsuite/winsup.api/cygload.exp       |  32 +-
 .../winsup.api/samples/sample-miscompile.c    |   1 -
 winsup/testsuite/winsup.api/winsup.exp        |  37 +--
 7 files changed, 325 insertions(+), 67 deletions(-)
 rename winsup/testsuite/{cygrun => mingw}/Makefile.am (58%)
 delete mode 100644 winsup/testsuite/winsup.api/samples/sample-miscompile.c

diff --git a/winsup/configure.ac b/winsup/configure.ac
index 7a2121dae..b155cabe4 100644
--- a/winsup/configure.ac
+++ b/winsup/configure.ac
@@ -126,7 +126,7 @@ AC_CONFIG_FILES([
     utils/Makefile
     utils/mingw/Makefile
     testsuite/Makefile
-    testsuite/cygrun/Makefile
+    testsuite/mingw/Makefile
 ])
 
 AC_OUTPUT
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index a2fa34811..7853d98e8 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -31,6 +31,300 @@ libltp_a_SOURCES = \
 	libltp/lib/tst_tmpdir.c \
 	libltp/lib/write_log.c
 
+check_PROGRAMS = \
+	winsup.api/checksignal \
+	winsup.api/crlf \
+	winsup.api/devdsp \
+	winsup.api/devzero \
+	winsup.api/iospeed \
+	winsup.api/mmaptest01 \
+	winsup.api/mmaptest02 \
+	winsup.api/mmaptest03 \
+	winsup.api/mmaptest04 \
+	winsup.api/msgtest \
+	winsup.api/nullgetcwd \
+	winsup.api/resethand \
+	winsup.api/semtest \
+	winsup.api/shmtest \
+	winsup.api/sigchld \
+	winsup.api/signal-into-win32-api \
+	winsup.api/systemcall \
+	winsup.api/user_malloc \
+	winsup.api/waitpid \
+	winsup.api/ltp/access01 \
+	winsup.api/ltp/access03 \
+	winsup.api/ltp/access04 \
+	winsup.api/ltp/access05 \
+	winsup.api/ltp/alarm01 \
+	winsup.api/ltp/alarm02 \
+	winsup.api/ltp/alarm03 \
+	winsup.api/ltp/alarm07 \
+	winsup.api/ltp/asyncio02 \
+	winsup.api/ltp/chdir02 \
+	winsup.api/ltp/chdir04 \
+	winsup.api/ltp/chmod01 \
+	winsup.api/ltp/chmod02 \
+	winsup.api/ltp/chown01 \
+	winsup.api/ltp/close01 \
+	winsup.api/ltp/close02 \
+	winsup.api/ltp/close08 \
+	winsup.api/ltp/creat01 \
+	winsup.api/ltp/creat03 \
+	winsup.api/ltp/creat09 \
+	winsup.api/ltp/dup01 \
+	winsup.api/ltp/dup02 \
+	winsup.api/ltp/dup03 \
+	winsup.api/ltp/dup04 \
+	winsup.api/ltp/dup05 \
+	winsup.api/ltp/execl01 \
+	winsup.api/ltp/execle01 \
+	winsup.api/ltp/execlp01 \
+	winsup.api/ltp/execv01 \
+	winsup.api/ltp/execve01 \
+	winsup.api/ltp/execvp01 \
+	winsup.api/ltp/exit01 \
+	winsup.api/ltp/exit02 \
+	winsup.api/ltp/fchdir01 \
+	winsup.api/ltp/fchdir02 \
+	winsup.api/ltp/fchmod01 \
+	winsup.api/ltp/fchown01 \
+	winsup.api/ltp/fcntl02 \
+	winsup.api/ltp/fcntl03 \
+	winsup.api/ltp/fcntl04 \
+	winsup.api/ltp/fcntl05 \
+	winsup.api/ltp/fcntl07 \
+	winsup.api/ltp/fcntl07B \
+	winsup.api/ltp/fcntl08 \
+	winsup.api/ltp/fcntl09 \
+	winsup.api/ltp/fcntl10 \
+	winsup.api/ltp/fork01 \
+	winsup.api/ltp/fork02 \
+	winsup.api/ltp/fork03 \
+	winsup.api/ltp/fork04 \
+	winsup.api/ltp/fork06 \
+	winsup.api/ltp/fork07 \
+	winsup.api/ltp/fork09 \
+	winsup.api/ltp/fork10 \
+	winsup.api/ltp/fork11 \
+	winsup.api/ltp/fpathconf01 \
+	winsup.api/ltp/fstat01 \
+	winsup.api/ltp/fstat02 \
+	winsup.api/ltp/fstat03 \
+	winsup.api/ltp/fstat04 \
+	winsup.api/ltp/fsync01 \
+	winsup.api/ltp/ftruncate01 \
+	winsup.api/ltp/ftruncate02 \
+	winsup.api/ltp/ftruncate03 \
+	winsup.api/ltp/getegid01 \
+	winsup.api/ltp/geteuid01 \
+	winsup.api/ltp/getgid01 \
+	winsup.api/ltp/getgid02 \
+	winsup.api/ltp/getgid03 \
+	winsup.api/ltp/getgroups01 \
+	winsup.api/ltp/getgroups02 \
+	winsup.api/ltp/gethostid01 \
+	winsup.api/ltp/gethostname01 \
+	winsup.api/ltp/getpgid01 \
+	winsup.api/ltp/getpgid02 \
+	winsup.api/ltp/getpgrp01 \
+	winsup.api/ltp/getpid01 \
+	winsup.api/ltp/getpid02 \
+	winsup.api/ltp/getppid01 \
+	winsup.api/ltp/getppid02 \
+	winsup.api/ltp/getuid01 \
+	winsup.api/ltp/getuid02 \
+	winsup.api/ltp/getuid03 \
+	winsup.api/ltp/kill01 \
+	winsup.api/ltp/kill02 \
+	winsup.api/ltp/kill03 \
+	winsup.api/ltp/kill04 \
+	winsup.api/ltp/kill09 \
+	winsup.api/ltp/link02 \
+	winsup.api/ltp/link03 \
+	winsup.api/ltp/link04 \
+	winsup.api/ltp/link05 \
+	winsup.api/ltp/lseek01 \
+	winsup.api/ltp/lseek02 \
+	winsup.api/ltp/lseek03 \
+	winsup.api/ltp/lseek04 \
+	winsup.api/ltp/lseek05 \
+	winsup.api/ltp/lseek06 \
+	winsup.api/ltp/lseek07 \
+	winsup.api/ltp/lseek08 \
+	winsup.api/ltp/lseek09 \
+	winsup.api/ltp/lseek10 \
+	winsup.api/ltp/lstat02 \
+	winsup.api/ltp/mkdir01 \
+	winsup.api/ltp/mkdir08 \
+	winsup.api/ltp/mknod01 \
+	winsup.api/ltp/mmap001 \
+	winsup.api/ltp/mmap02 \
+	winsup.api/ltp/mmap03 \
+	winsup.api/ltp/mmap04 \
+	winsup.api/ltp/mmap05 \
+	winsup.api/ltp/mmap06 \
+	winsup.api/ltp/mmap07 \
+	winsup.api/ltp/mmap08 \
+	winsup.api/ltp/munmap01 \
+	winsup.api/ltp/munmap02 \
+	winsup.api/ltp/nice05 \
+	winsup.api/ltp/open02 \
+	winsup.api/ltp/open03 \
+	winsup.api/ltp/pathconf01 \
+	winsup.api/ltp/pause01 \
+	winsup.api/ltp/pipe01 \
+	winsup.api/ltp/pipe08 \
+	winsup.api/ltp/pipe09 \
+	winsup.api/ltp/pipe10 \
+	winsup.api/ltp/pipe11 \
+	winsup.api/ltp/poll01 \
+	winsup.api/ltp/read01 \
+	winsup.api/ltp/read04 \
+	winsup.api/ltp/readdir01 \
+	winsup.api/ltp/readlink01 \
+	winsup.api/ltp/readlink02 \
+	winsup.api/ltp/readlink03 \
+	winsup.api/ltp/rename01 \
+	winsup.api/ltp/rename02 \
+	winsup.api/ltp/rename08 \
+	winsup.api/ltp/rename10 \
+	winsup.api/ltp/rmdir01 \
+	winsup.api/ltp/rmdir04 \
+	winsup.api/ltp/rmdir05 \
+	winsup.api/ltp/sbrk01 \
+	winsup.api/ltp/select01 \
+	winsup.api/ltp/select02 \
+	winsup.api/ltp/select03 \
+	winsup.api/ltp/setgid01 \
+	winsup.api/ltp/setgroups01 \
+	winsup.api/ltp/setpgid01 \
+	winsup.api/ltp/setregid01 \
+	winsup.api/ltp/setreuid01 \
+	winsup.api/ltp/setuid01 \
+	winsup.api/ltp/setuid02 \
+	winsup.api/ltp/signal03 \
+	winsup.api/ltp/stat01 \
+	winsup.api/ltp/stat02 \
+	winsup.api/ltp/stat03 \
+	winsup.api/ltp/stat05 \
+	winsup.api/ltp/stat06 \
+	winsup.api/ltp/symlink01 \
+	winsup.api/ltp/symlink02 \
+	winsup.api/ltp/symlink03 \
+	winsup.api/ltp/symlink04 \
+	winsup.api/ltp/symlink05 \
+	winsup.api/ltp/sync01 \
+	winsup.api/ltp/sync02 \
+	winsup.api/ltp/time01 \
+	winsup.api/ltp/time02 \
+	winsup.api/ltp/times01 \
+	winsup.api/ltp/times02 \
+	winsup.api/ltp/times03 \
+	winsup.api/ltp/truncate01 \
+	winsup.api/ltp/truncate02 \
+	winsup.api/ltp/umask01 \
+	winsup.api/ltp/umask02 \
+	winsup.api/ltp/umask03 \
+	winsup.api/ltp/uname01 \
+	winsup.api/ltp/unlink05 \
+	winsup.api/ltp/unlink06 \
+	winsup.api/ltp/unlink07 \
+	winsup.api/ltp/unlink08 \
+	winsup.api/ltp/vfork01 \
+	winsup.api/ltp/wait02 \
+	winsup.api/ltp/wait401 \
+	winsup.api/ltp/wait402 \
+	winsup.api/ltp/write01 \
+	winsup.api/ltp/write02 \
+	winsup.api/ltp/write03 \
+	winsup.api/pthread/cancel1 \
+	winsup.api/pthread/cancel10 \
+	winsup.api/pthread/cancel11 \
+	winsup.api/pthread/cancel12 \
+	winsup.api/pthread/cancel2 \
+	winsup.api/pthread/cancel3 \
+	winsup.api/pthread/cancel4 \
+	winsup.api/pthread/cancel5 \
+	winsup.api/pthread/cancel6 \
+	winsup.api/pthread/cancel7 \
+	winsup.api/pthread/cancel8 \
+	winsup.api/pthread/cancel9 \
+	winsup.api/pthread/cleanup2 \
+	winsup.api/pthread/cleanup3 \
+	winsup.api/pthread/condvar1 \
+	winsup.api/pthread/condvar2 \
+	winsup.api/pthread/condvar2_1 \
+	winsup.api/pthread/condvar3 \
+	winsup.api/pthread/condvar3_1 \
+	winsup.api/pthread/condvar3_2 \
+	winsup.api/pthread/condvar3_3 \
+	winsup.api/pthread/condvar4 \
+	winsup.api/pthread/condvar5 \
+	winsup.api/pthread/condvar6 \
+	winsup.api/pthread/condvar7 \
+	winsup.api/pthread/condvar8 \
+	winsup.api/pthread/condvar9 \
+	winsup.api/pthread/count1 \
+	winsup.api/pthread/create1 \
+	winsup.api/pthread/create2 \
+	winsup.api/pthread/equal1 \
+	winsup.api/pthread/exit1 \
+	winsup.api/pthread/exit2 \
+	winsup.api/pthread/exit3 \
+	winsup.api/pthread/inherit1 \
+	winsup.api/pthread/join0 \
+	winsup.api/pthread/join1 \
+	winsup.api/pthread/join2 \
+	winsup.api/pthread/mainthreadexits \
+	winsup.api/pthread/mutex1 \
+	winsup.api/pthread/mutex1d \
+	winsup.api/pthread/mutex1e \
+	winsup.api/pthread/mutex1n \
+	winsup.api/pthread/mutex1r \
+	winsup.api/pthread/mutex2 \
+	winsup.api/pthread/mutex3 \
+	winsup.api/pthread/mutex4 \
+	winsup.api/pthread/mutex5 \
+	winsup.api/pthread/mutex6d \
+	winsup.api/pthread/mutex6e \
+	winsup.api/pthread/mutex6n \
+	winsup.api/pthread/mutex6r \
+	winsup.api/pthread/mutex7 \
+	winsup.api/pthread/mutex7d \
+	winsup.api/pthread/mutex7e \
+	winsup.api/pthread/mutex7n \
+	winsup.api/pthread/mutex7r \
+	winsup.api/pthread/mutex8e \
+	winsup.api/pthread/mutex8n \
+	winsup.api/pthread/mutex8r \
+	winsup.api/pthread/once1 \
+	winsup.api/pthread/priority1 \
+	winsup.api/pthread/priority2 \
+	winsup.api/pthread/rwlock1 \
+	winsup.api/pthread/rwlock2 \
+	winsup.api/pthread/rwlock3 \
+	winsup.api/pthread/rwlock4 \
+	winsup.api/pthread/rwlock5 \
+	winsup.api/pthread/rwlock6 \
+	winsup.api/pthread/rwlock7 \
+	winsup.api/pthread/self1 \
+	winsup.api/pthread/self2 \
+	winsup.api/pthread/threadidafterfork \
+	winsup.api/pthread/tsd1 \
+	winsup.api/samples/sample-fail \
+	winsup.api/samples/sample-pass
+# winsup.api/ltp/ulimit01 is omitted as we don't have <ulimit.h>
+
+# flags for linking against the just built implib
+# TODO: use -nostdinc and to-be-installed headers as well?
+LDFLAGS_FOR_TESTDLL = -nodefaultlibs
+LDADD_FOR_TESTDLL = $(builddir)/../cygwin/libcygwin.a -lgcc -lkernel32 -luser32
+
+# flags for test executables
+AM_CPPFLAGS = -I$(srcdir)/libltp/include
+AM_LDFLAGS = $(LDFLAGS_FOR_TESTDLL)
+LDADD = $(builddir)/libltp.a $(builddir)/../cygwin/binmode.o $(LDADD_FOR_TESTDLL)
+
 DEJATOOL = winsup
 
 # Add '-v' to RUNTESTFLAGS if V=1
@@ -46,22 +340,19 @@ testdll_tmpdir = $(shell cygpath -ma $(tmpdir) | sed -e 's#^\([A-Z]\):#/cygdrive
 site-extra.exp: ../config.status Makefile
 	@rm -f ./tmp0
 	@echo "set runtime_root \"`pwd`/runtime\"" >> ./tmp0
-	@echo "set libdir \"`pwd`/../cygwin\"" >> ./tmp0
-	@echo "set CC \"$(CC)\"" >> ./tmp0
-	@echo "set CFLAGS \"\"" >> ./tmp0
-	@echo "set MINGW_CXX \"$(MINGW_CXX)\"" >> ./tmp0
 	@echo "set tmpdir $(tmpdir)" >> ./tmp0
 	@echo "set testdll_tmpdir $(testdll_tmpdir)" >> ./tmp0
-	@echo "set ltp_includes \"$(srcdir)/libltp/include\"" >> ./tmp0
-	@echo "set ltp_libs \"`pwd`/libltp.a\"" >> ./tmp0
-	@echo "set cygrun \"`pwd`/cygrun/cygrun\"" >> ./tmp0
+	@echo "set cygrun \"`pwd`/mingw/cygrun\"" >> ./tmp0
 	@mv ./tmp0 site-extra.exp
 
 EXTRA_DEJAGNU_SITE_CONFIG = site-extra.exp
 
+# target to build all the programs needed by check, without running check
+check_programs: $(check_PROGRAMS)
+
 clean-local:
 	rm -f *.log *.exe *.exp *.bak *.stackdump winsup.sum
 
 if CROSS_BOOTSTRAP
-SUBDIRS = cygrun
+SUBDIRS = mingw
 endif
diff --git a/winsup/testsuite/README b/winsup/testsuite/README
index c22b06594..363ebb9e8 100644
--- a/winsup/testsuite/README
+++ b/winsup/testsuite/README
@@ -21,7 +21,7 @@ cygwin1.dll ONLY.  Create other subdirs under testsuite/ for other
 classes of testing.
 
 Tests in winsup.api/*.c or winsup.api/*/*.c (only one subdirectory
-level is allowed) either compile, run, and exit(0) or they fail.
+level is allowed) either run, and exit(0) or they fail.
 Either abort or exit with a non-zero code to indicate failure.  Don't
 print anything to the screen if you can avoid it (except for failure
 reasons, of course).  One .c file per test, no compile options are
diff --git a/winsup/testsuite/cygrun/Makefile.am b/winsup/testsuite/mingw/Makefile.am
similarity index 58%
rename from winsup/testsuite/cygrun/Makefile.am
rename to winsup/testsuite/mingw/Makefile.am
index bdbd8f705..772e73405 100644
--- a/winsup/testsuite/cygrun/Makefile.am
+++ b/winsup/testsuite/mingw/Makefile.am
@@ -1,4 +1,4 @@
-# Makefile.am for Cygwin the testsuite wrapper cygrun.
+# Makefile.am for Cygwin testsuite MINGW executables
 #
 # This file is part of Cygwin.
 #
@@ -8,14 +8,19 @@
 
 # This makefile requires GNU make.
 
-# This is built with the MinGW compiler, so is in a separate Makefile here
+# These are built with the MinGW compiler, so are in a separate Makefile here
 # because it's tricky with Automake to use different compilers for the same
 # language in the same Makefile.
 
 override CC = @MINGW_CC@
+override CXX = @MINGW_CXX@
 AM_CPPFLAGS =
 
-noinst_PROGRAMS = cygrun
+noinst_PROGRAMS = cygrun cygload
 
 cygrun_SOURCES = \
 	../cygrun.c
+
+cygload_SOURCES = \
+	../winsup.api/cygload.cc
+cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup
diff --git a/winsup/testsuite/winsup.api/cygload.exp b/winsup/testsuite/winsup.api/cygload.exp
index e378820ad..724cb01cc 100644
--- a/winsup/testsuite/winsup.api/cygload.exp
+++ b/winsup/testsuite/winsup.api/cygload.exp
@@ -14,33 +14,17 @@ proc ws_spawn {cmd args} {
     verbose send "catchCode = $rv\n"
 }
 
-if { [string match "i686" $target_alias] } {
-    set entrypoint "_cygloadCRTStartup@0"
+if { $verbose } {
+    set redirect_output "./mingw-cygwin.log"
 } else {
-    set entrypoint "cygloadCRTStartup"
+    set redirect_output /dev/null
 }
 
-ws_spawn "$MINGW_CXX $srcdir/$subdir/cygload.cc -o mingw-cygload.exe -static -Wl,-e,$entrypoint"
-
+set windows_runtime_root [exec cygpath -m $runtime_root]
+ws_spawn "./mingw/cygload.exe -cygwin $windows_runtime_root/cygwin1.dll > $redirect_output"
 if { $rv != {0 {}} } {
-    verbose -log "$rv"
-    fail "cygload (compile)"
+    verbose -log "cygload: $rv"
+    fail "cygload"
 } else {
-    if { $verbose } {
-        set redirect_output "./mingw-cygwin.log"
-    } else {
-        set redirect_output /dev/null
-    }
-    set windows_runtime_root [exec cygpath -m $runtime_root]
-    ws_spawn "./mingw-cygload.exe -cygwin $windows_runtime_root/cygwin1.dll > $redirect_output"
-    if { $rv != {0 {}} } {
-        verbose -log "cygload: $rv"
-        fail "cygload (execute)"
-    } else {
-        pass "cygload"
-    }
-    catch { file delete "mingw-cygload.exe" } err
-    if { $err != "" } {
-        note "error deleting mingw-cygload.exe: $err"
-    }
+    pass "cygload"
 }
diff --git a/winsup/testsuite/winsup.api/samples/sample-miscompile.c b/winsup/testsuite/winsup.api/samples/sample-miscompile.c
deleted file mode 100644
index bc0d21d2e..000000000
--- a/winsup/testsuite/winsup.api/samples/sample-miscompile.c
+++ /dev/null
@@ -1 +0,0 @@
-foo bar grill
diff --git a/winsup/testsuite/winsup.api/winsup.exp b/winsup/testsuite/winsup.api/winsup.exp
index e81ead304..fb3e3816c 100644
--- a/winsup/testsuite/winsup.api/winsup.exp
+++ b/winsup/testsuite/winsup.api/winsup.exp
@@ -8,12 +8,6 @@ if { ! [isnative] } {
 
 set rv ""
 
-set ltp_includes "-I$ltp_includes"
-set ltp_libs "$ltp_libs"
-
-set add_includes $ltp_includes
-set add_libs $ltp_libs
-
 set orig_path "$env(PATH)"
 
 set test_filter ""
@@ -48,7 +42,9 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
     regsub "^$srcdir/$subdir/" $src "" testcase
     regsub ".c$" $testcase "" base
     regsub ".*/" $base "" basename
-    regsub "/" $base "-" base
+    regsub "/" $base "-" tmpfile
+
+    set exec "./winsup.api/$base.exe"
 
     if { [lsearch -exact $xfail_list $basename] >= 0 } {
         set xfail_expected 1
@@ -61,37 +57,20 @@ foreach src [lsort [glob -nocomplain $srcdir/$subdir/*.c $srcdir/$subdir/*/*.{cc
     if [ file exists "$srcdir/$subdir/$basename.exp" ] then {
 	source "$srcdir/$subdir/$basename.exp"
     } else {
-	ws_spawn "$CC -nodefaultlibs -mwin32 $CFLAGS $src $add_includes $add_libs $libdir/binmode.o -lgcc $libdir/libcygwin.a -lkernel32 -luser32 -o $base.exe"
-	if { $rv } {
-	    fail "$testcase (compile)"
-	} else {
 	    if { $verbose } {
-	       set redirect_output "./$base.log"
+	       set redirect_output "./$tmpfile.log"
 	    } else {
 	       set redirect_output /dev/null
 	    }
-	    file mkdir $tmpdir/$base
+	    file mkdir $tmpdir/$tmpfile
 	    set env(PATH) "$runtime_root:$env(PATH)"
-	    ws_spawn "$cygrun ./$base.exe $testdll_tmpdir/$base > $redirect_output"
-	    file delete -force $tmpdir/$base
+	    ws_spawn "$cygrun $exec $testdll_tmpdir/$tmpfile > $redirect_output"
+	    file delete -force $tmpdir/$tmpfile
 	    set env(PATH) "$orig_path"
 	    if { $rv } {
-		fail "$testcase (execute)"
-		if { $xfail_expected } {
-		    catch { file delete "$base.exe" } err
-		    if { $err != "" } {
-			note "error deleting $base.exe: $err"
-		    }
-		}
+		fail "$testcase"
 	    } else {
 		pass "$testcase"
-		if { ! $xfail_expected } {
-		    catch { file delete "$base.exe" } err
-		    if { $err != "" } {
-			note "error deleting $base.exe: $err"
-		    }
-		}
 	    }
-	}
     }
 }
-- 
2.39.0

