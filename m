Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-049.btinternet.com (mailomta24-re.btinternet.com
 [213.120.69.117])
 by sourceware.org (Postfix) with ESMTPS id BFDC83842411
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:09:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BFDC83842411
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-049.btinternet.com with ESMTP id
 <20201031150903.MQVO31866.re-prd-fep-049.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sat, 31 Oct 2020 15:09:03 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9BDD0183B94C5
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0183B94C5; Sat, 31 Oct 2020 15:09:02 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/7] Remove rules for building libcygwin_s.a
Date: Sat, 31 Oct 2020 15:08:20 +0000
Message-Id: <20201031150821.18041-7-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
References: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.6 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KHOP_HELO_FCRDNS,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:09:05 -0000

Untouched since added in 66a83f3e, and described as 'non-working'.
---
 winsup/cygwin/Makefile.in | 13 --------
 winsup/cygwin/mkstatic    | 63 ---------------------------------------
 2 files changed, 76 deletions(-)
 delete mode 100755 winsup/cygwin/mkstatic

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index c3aa7a186..0add2320b 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -105,7 +105,6 @@ RUNTESTFLAGS =
 DLL_NAME:=cygwin1.dll
 TEST_DLL_NAME:=${patsubst %1.dll,%0.dll,$(DLL_NAME)}
 TEST_LIB_NAME:=libcygwin0.a
-STATIC_LIB_NAME:=libcygwin_s.a
 DIN_FILE=@DIN_FILE@ common.din
 DEF_FILE:=cygwin.def
 TLSOFFSETS_H:=@TLSOFFSETS_H@
@@ -413,15 +412,6 @@ DLL_OFILES:= \
 	$(MATH_OFILES) \
 	$(TZCODE_OFILES)
 
-EXCLUDE_STATIC_OFILES:=$(addprefix --exclude=,\
-	cygtls.o \
-	dcrt0.o \
-	exceptions.o \
-	fork.o \
-	signal.o \
-	spawn.o \
-)
-
 VERSION_OFILES:=version.o winver.o
 
 ifeq ($(target_cpu),x86_64)
@@ -675,9 +665,6 @@ $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC) $(LIB
 $(LIB_NAME): $(DEF_FILE) $(LIBCOS) | $(TEST_DLL_NAME)
 	${srcdir}/mkimport ${toolopts} ${NEW_FUNCTIONS} $@ cygdll.a $(wordlist 2,99,$^)
 
-${STATIC_LIB_NAME}: mkstatic ${TEST_DLL_NAME}
-	perl -d $< -x ${EXCLUDE_STATIC_OFILES} --library=${LIBC} --library=${LIBM} --ar=${AR} $@ cygwin.map
-
 # Rule to make stub library used by testsuite
 # dependency set to $(LIB_NAME) to accommodate make -j2.
 $(TEST_LIB_NAME): $(LIB_NAME)
diff --git a/winsup/cygwin/mkstatic b/winsup/cygwin/mkstatic
deleted file mode 100755
index 1a488f80c..000000000
--- a/winsup/cygwin/mkstatic
+++ /dev/null
@@ -1,63 +0,0 @@
-#!/usr/bin/perl
-use strict;
-use Cwd;
-use Getopt::Long;
-use File::Temp qw/tempdir/;
-use File::Basename;
-
-sub xsystem(@);
-
-my @exclude = ();
-my @library = ();
-my $ar;
-our $x;
-GetOptions('exclude=s'=>\@exclude, 'library=s'=>\@library, 'ar=s'=>\$ar, 'x!'=>\$x);
-
-die "$0: must specify --ar\n" unless defined $ar;
-my $lib = shift or die "$0: missing lib argument\nusage: $0 lib [map-file]\n";
-$lib = Cwd::abs_path($lib);
-
-my %excludes = map {($_, 1)} @exclude;
-my $libraries = join('|', map {quotemeta} @library);
-
-my %sources = ();
-while (<>) {
-    my ($source, $file, $absfile);
-    if (m%^($libraries)\(([^)]*)\)%o) {
-	$source = $1;
-	$absfile = $file = $2;
-    } elsif (/^LOAD\s+(.*\.o)$/o) {
-	$source = '.';
-	$file = $1;
-	$absfile = Cwd::abs_path($file);
-    } else {
-	next;
-    }
-    push @{$sources{$source}}, $absfile unless $excludes{$file} || $excludes{$source};
-}
-
-my $here = getcwd();
-my $dir = tempdir(CLEANUP=>1);
-chdir $dir;
-my @files = ();
-for (sort keys %sources) {
-    if ($_ eq '.') {
-	xsystem '/bin/cp', '-a', @{$sources{$_}}, '.';
-    } else {
-	xsystem $ar, 'x',  $_, @{$sources{$_}}, '.';
-    }
-    push @files, map {basename($_)} @{$sources{$_}};
-}
-
-unlink $lib;
-xsystem $ar, 'crs', $lib, sort @files;
-exit 0;
-
-sub xsystem(@) {
-    print join(' ', 'x', @_), "\n" if $x;
-    system(@_) == 0 or die "$0: $_[0] $_[1] $_[2]... exited with non-zero status\n";
-}
-
-END {
-    chdir '/tmp';	# Allow $dir directory removal on Windows
-}
-- 
2.29.0

