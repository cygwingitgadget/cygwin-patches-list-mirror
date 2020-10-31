Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-044.btinternet.com (mailomta25-re.btinternet.com
 [213.120.69.118])
 by sourceware.org (Postfix) with ESMTPS id B26323842428
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:08:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B26323842428
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-044.btinternet.com with ESMTP id
 <20201031150854.TPTW29010.re-prd-fep-044.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sat, 31 Oct 2020 15:08:54 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9BDD0183B93E5
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0183B93E5; Sat, 31 Oct 2020 15:08:53 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/7] Drop autoconf variable all_host
Date: Sat, 31 Oct 2020 15:08:18 +0000
Message-Id: <20201031150821.18041-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
References: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.4 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KHOP_HELO_FCRDNS,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:08:56 -0000

The autoconf variable all_host is used to make building of the stub
library used by the testsuite conditional on not cross-compiling.

Make it unconditional, so we will notice if it's broken when
cross-compiling.
---
 winsup/cygserver/configure.ac | 11 -----------
 winsup/cygwin/Makefile.in     | 10 ++--------
 winsup/cygwin/configure.ac    | 11 -----------
 3 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/winsup/cygserver/configure.ac b/winsup/cygserver/configure.ac
index 4ff784e47..e1b29debf 100644
--- a/winsup/cygserver/configure.ac
+++ b/winsup/cygserver/configure.ac
@@ -27,17 +27,6 @@ AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
-case "$with_cross_host" in
-  ""|*cygwin*)
-    all_host="all_host"
-    ;;
-  *)
-    all_host=
-    ;;
-esac
-
-AC_SUBST(all_host)
-
 AC_CHECK_TOOL(AR, ar, ar)
 AC_CHECK_TOOL(AS, as, as)
 AC_CHECK_TOOL(RANLIB, ranlib, ranlib)
diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 89e1b7567..9b07d9833 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -572,17 +572,11 @@ exec_CFLAGS:=-fno-builtin-execve
 fhandler_proc_CFLAGS+=-DUSERNAME="\"$(USER)\"" -DHOSTNAME="\"$(HOSTNAME)\""
 fhandler_proc_CFLAGS+=-DGCC_VERSION="\"`$(CC) -v 2>&1 | tail -n 1`\""
 
-.PHONY: all force dll_ofiles install all_target all_host \
+.PHONY: all force dll_ofiles install \
 	install install-libs install-headers \
 	clean distclean realclean maintainer-clean
 
-all_host=@all_host@
-
-all: all_target $(all_host)
-
-all_target: $(TARGET_LIBS)
-
-all_host: $(TEST_LIB_NAME)
+all: $(TARGET_LIBS) $(TEST_LIB_NAME)
 
 force:
 
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index 658247099..cf9bbaba1 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -29,17 +29,6 @@ AC_LANG(C++)
 
 AC_CYGWIN_INCLUDES
 
-case "$with_cross_host" in
-  ""|*cygwin*)
-    all_host="all_host"
-    ;;
-  *)
-    all_host=
-    ;;
-esac
-
-AC_SUBST(all_host)
-
 AC_CHECK_TOOL(AR, ar, ar)
 AC_CHECK_TOOL(AS, as, as)
 AC_CHECK_TOOL(DLLTOOL, dlltool, dlltool)
-- 
2.29.0

