Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-042.btinternet.com (mailomta28-re.btinternet.com
 [213.120.69.121])
 by sourceware.org (Postfix) with ESMTPS id 28D093947403
 for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2020 14:37:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 28D093947403
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-002.btmx-prd.synchronoss.net ([10.2.54.5])
 by re-prd-fep-042.btinternet.com with ESMTP id
 <20201015143712.GFIW13627.re-prd-fep-042.btinternet.com@re-prd-rgout-002.btmx-prd.synchronoss.net>;
 Thu, 15 Oct 2020 15:37:12 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.143.43.37]
X-OWM-Source-IP: 86.143.43.37 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrieefgdejkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegfedrgeefrdefjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkeeirddugeefrdegfedrfeejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.143.43.37) by
 re-prd-rgout-002.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9C0CC15FB5A46; Thu, 15 Oct 2020 15:37:12 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/3] Stop using c++wrap for MinGW-compiled utilities
Date: Thu, 15 Oct 2020 15:36:50 +0100
Message-Id: <20201015143652.56501-2-jon.turney@dronecode.org.uk>
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
X-List-Received-Date: Thu, 15 Oct 2020 14:37:15 -0000

Stop using c++wrap for MinGW-compiled utilities.

(Partially reverts 96079146)
---
 winsup/ccwrap            | 9 ++-------
 winsup/utils/Makefile.in | 6 +-----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/winsup/ccwrap b/winsup/ccwrap
index 0c6a17020..900fc4ae5 100755
--- a/winsup/ccwrap
+++ b/winsup/ccwrap
@@ -26,11 +26,6 @@ if ("@ARGV" !~ / -nostdinc/o) {
     push @compiler, '-I' . $_ for split ' ', $ENV{CCWRAP_HEADERS};
     push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_SYSTEM_HEADERS};
     my $finding_paths = 0;
-    my $mingw_compiler = $compiler[0] =~ /mingw/o;
-    my @dirafters;
-    for my $d (split ' ', $ENV{CCWRAP_DIRAFTER_HEADERS}) {
-	push @dirafters, '-isystem', $d if !$mingw_compiler || $d !~ /w32api/o;
-    }
     while (<$fd>) {
 	if (/^\*\*\*/o) {
 	    print;
@@ -40,13 +35,13 @@ if ("@ARGV" !~ / -nostdinc/o) {
 	    next;
 	} elsif ($_ eq "End of search list.\n") {
 	    last;
-	} elsif (!@dirafters || !m%w32api|mingw.*/include%o) {
+	} elsif (!m%w32api%o) {
 	    chomp;
 	    s/^\s+//;
 	    push @compiler, '-isystem', Cwd::abs_path($_);
 	}
     }
-    push @compiler, @dirafters;
+    push @compiler, '-isystem', $_ for split ' ', $ENV{CCWRAP_DIRAFTER_HEADERS};
     close $fd;
 }
 
diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
index c3297c6c1..889fdaab3 100644
--- a/winsup/utils/Makefile.in
+++ b/winsup/utils/Makefile.in
@@ -140,12 +140,8 @@ check: testsuite.exe ; $(<D)/$(<F)
 # the rest of this file contains generic rules
 
 # how to compile a MinGW object
-${MINGW_OBJS}: override CXX:=${MINGW_CXX}
-${MINGW_OBJS}: CCWRAP_HEADERS:=${srcdir}
-${MINGW_OBJS}: CCWRAP_SYSTEM_HEADERS:=
-# ${MINGW_OBJS}: CCWRAP_DIRAFTER_HEADERS:=
 $(MINGW_OBJS): %.o: %.cc
-	c++wrap -c -o $@ ${CXXFLAGS} $(MINGW_CXXFLAGS) $<
+	${MINGW_CXX} -c -o $@ ${CXXFLAGS} $(MINGW_CXXFLAGS) $<
 
 # how to link a MinGW binary
 $(MINGW_BINS): %.exe: %.o
-- 
2.28.0

