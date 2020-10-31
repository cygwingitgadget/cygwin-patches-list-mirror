Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta25-re.btinternet.com
 [213.120.69.118])
 by sourceware.org (Postfix) with ESMTPS id C27DF3842422
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:08:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C27DF3842422
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20201031150849.RRAA30806.re-prd-fep-045.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sat, 31 Oct 2020 15:08:49 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9BDD0183B938A
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0183B938A; Sat, 31 Oct 2020 15:08:49 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/7] Remove autoconf variable DLL_NAME
Date: Sat, 31 Oct 2020 15:08:17 +0000
Message-Id: <20201031150821.18041-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
References: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:08:52 -0000

Remove autoconf variable DLL_NAME, which has a constant value which is
only used in one place.
---
 winsup/cygwin/Makefile.in  | 4 ++--
 winsup/cygwin/configure.ac | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index cb9924b3a..89e1b7567 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -102,8 +102,8 @@ RUNTESTFLAGS =
 # native rebuilding issues (we don't want the build tools to see a partially
 # built cygwin.dll and attempt to use it instead of the old one).
 
-DLL_NAME:=@DLL_NAME@
-TEST_DLL_NAME:=${patsubst %1.dll,%0.dll,@DLL_NAME@}
+DLL_NAME:=cygwin1.dll
+TEST_DLL_NAME:=${patsubst %1.dll,%0.dll,$(DLL_NAME)}
 TEST_LIB_NAME:=libcygwin0.a
 STATIC_LIB_NAME:=libcygwin_s.a
 DIN_FILE=@DIN_FILE@ common.din
diff --git a/winsup/cygwin/configure.ac b/winsup/cygwin/configure.ac
index aafc4d925..658247099 100644
--- a/winsup/cygwin/configure.ac
+++ b/winsup/cygwin/configure.ac
@@ -61,14 +61,12 @@ esac
 
 case "$target_cpu" in
    i?86)
-		DLL_NAME="cygwin1.dll"
 		DLL_ENTRY="_dll_entry@12"
 		DEF_DLL_ENTRY="dll_entry@12"
 		DIN_FILE="i686.din"
 		TLSOFFSETS_H="tlsoffsets.h"
 		;;
    x86_64)
-		DLL_NAME="cygwin1.dll"
 		DLL_ENTRY="dll_entry"
 		DEF_DLL_ENTRY="dll_entry"
 		DIN_FILE="x86_64.din"
@@ -78,7 +76,6 @@ case "$target_cpu" in
 esac
 
 AC_CONFIGURE_ARGS
-AC_SUBST(DLL_NAME)
 AC_SUBST(DLL_ENTRY)
 AC_SUBST(DEF_DLL_ENTRY)
 AC_SUBST(DIN_FILE)
-- 
2.29.0

