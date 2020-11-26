Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id 341B3385700D
 for <cygwin-patches@cygwin.com>; Thu, 26 Nov 2020 09:56:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 341B3385700D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=mark@maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 0AQ9ubb8074835;
 Thu, 26 Nov 2020 01:56:37 -0800 (PST) (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdbmA5Zz; Thu Nov 26 01:56:36 2020
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: Speed up mkimport
Date: Thu, 26 Nov 2020 01:56:20 -0800
Message-Id: <20201126095620.38808-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Thu, 26 Nov 2020 09:56:42 -0000

Cut mkimport elapsed time in half by forking each iteration of the two
time-consuming loops within.  Only do this if more than one CPU is
present.  In the second loop, combine the two 'objdump' calls into one
system() invocation to avoid a system() invocation per iteration.

---
 winsup/cygwin/mkimport | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/mkimport b/winsup/cygwin/mkimport
index 2b08dfe3d..919dc305b 100755
--- a/winsup/cygwin/mkimport
+++ b/winsup/cygwin/mkimport
@@ -47,6 +47,9 @@ for my $sym (keys %replace) {
     $import{$fn} = $imp_sym;
 }
 
+my $ncpus = `grep -c ^processor /proc/cpuinfo`;
+my $forking = $ncpus > 1; # Decides if loops below should fork() each iteration
+
 for my $f (keys %text) {
     my $imp_sym = delete $import{$f};
     my $glob_sym = $text{$f};
@@ -56,25 +59,30 @@ for my $f (keys %text) {
 	$text{$f} = 0;
     } else {
 	$text{$f} = 1;
-	open my $as_fd, '|-', $as, '-o', "$dir/t-$f", "-";
-	if ($is64bit) {
-	    print $as_fd <<EOF;
+	if ($forking && fork) {
+	    ; # Testing shows sleep here is unneeded. 'as' runs very quickly.
+	} else {
+	    open my $as_fd, '|-', $as, '-o', "$dir/t-$f", "-";
+	    if ($is64bit) {
+		print $as_fd <<EOF;
 	.text
 	.extern	$imp_sym
 	.global	$glob_sym
 $glob_sym:
 	jmp	*$imp_sym(%rip)
 EOF
-	} else {
-	    print $as_fd <<EOF;
+	    } else {
+		print $as_fd <<EOF;
 	.text
 	.extern	$imp_sym
 	.global	$glob_sym
 $glob_sym:
 	jmp	*$imp_sym
 EOF
+	    }
+	    close $as_fd or exit 1;
+	    exit 0 if $forking;
 	}
-	close $as_fd or exit 1;
     }
 }
 
@@ -86,8 +94,18 @@ for my $f (keys %text) {
     if (!$text{$f}) {
 	unlink $f;
     } else {
-	system $objcopy, '-R', '.text', $f and exit 1;
-	system $objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
+	if ($forking && fork) {
+	    # Testing shows parent does need to sleep a short time here,
+	    # otherwise system is inundated with hundreds of objcopy processes
+	    # and the forked perl processes that launched them.
+	    my $delay = 0.01; # NOTE: Slower systems may need to raise this
+	    select(undef, undef, undef, $delay); # Supports fractional seconds
+	} else {
+	    # Do two objcopy calls at once to avoid one system() call overhead
+	    system '(', $objcopy, '-R', '.text', $f, ')', '||',
+		$objcopy, '-R', '.bss', '-R', '.data', "t-$f" and exit 1;
+	    exit 0 if $forking;
+	}
     }
 }
 
-- 
2.29.2

