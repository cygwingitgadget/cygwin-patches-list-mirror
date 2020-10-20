Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-041.btinternet.com (mailomta27-sa.btinternet.com
 [213.120.69.33])
 by sourceware.org (Postfix) with ESMTPS id 220AA39450F1
 for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2020 13:43:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 220AA39450F1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-041.btinternet.com with ESMTP id
 <20201020134336.ZJS4255.sa-prd-fep-041.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 20 Oct 2020 14:43:36 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE16F22C48; Tue, 20 Oct 2020 14:43:36 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/6] Remove nostdlib Makefile variable
Date: Tue, 20 Oct 2020 14:43:02 +0100
Message-Id: <20201020134304.11281-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1201.2 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Tue, 20 Oct 2020 13:43:40 -0000

It's used in one place, and it's value is unconditional.
---
 winsup/Makefile.common    | 2 --
 winsup/cygwin/Makefile.in | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/winsup/Makefile.common b/winsup/Makefile.common
index 69cac9b43..3141bd111 100644
--- a/winsup/Makefile.common
+++ b/winsup/Makefile.common
@@ -30,8 +30,6 @@ top_builddir:=$(call justdir,${target_builddir})
 cygwin_build:=${target_builddir}/winsup/cygwin
 newlib_build:=${target_builddir}/newlib
 
-nostdlib:=-nostdlib
-
 VPATH:=${srcdir}
 
 .SUFFIXES:
diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 9d05b17b3..0dca13fab 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -679,7 +679,7 @@ $(LDSCRIPT): $(LDSCRIPT).in
 $(TEST_DLL_NAME): $(LDSCRIPT) dllfixdbg $(DLL_OFILES) $(LIBSERVER) $(LIBC) $(LIBM) $(API_VER) Makefile $(VERSION_OFILES)
 	$(CXX) $(CXXFLAGS) \
 	-mno-use-libstdc-wrappers \
-	-Wl,--gc-sections $(nostdlib) -Wl,-T$(firstword $^) -static \
+	-Wl,--gc-sections -nostdlib -Wl,-T$(firstword $^) -static \
 	-Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o $@ \
 	-e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) $(VERSION_OFILES) \
 	$(MALLOC_OBJ) $(LIBSERVER) $(LIBM) $(LIBC) \
-- 
2.28.0

