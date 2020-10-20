Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-044.btinternet.com (mailomta30-sa.btinternet.com
 [213.120.69.36])
 by sourceware.org (Postfix) with ESMTPS id F01CB39450E5
 for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2020 13:43:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org F01CB39450E5
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-044.btinternet.com with ESMTP id
 <20201020134331.TOZ4347.sa-prd-fep-044.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 20 Oct 2020 14:43:31 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE16F22B61; Tue, 20 Oct 2020 14:43:30 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/6] Drop cygwin version.o from cygserver
Date: Tue, 20 Oct 2020 14:43:00 +0100
Message-Id: <20201020134304.11281-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
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
X-List-Received-Date: Tue, 20 Oct 2020 13:43:33 -0000

The data it contains isn't referenced since 9e9bc3a4.
---
 winsup/cygserver/Makefile.in | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/winsup/cygserver/Makefile.in b/winsup/cygserver/Makefile.in
index e360d8fd0..7b250dd68 100644
--- a/winsup/cygserver/Makefile.in
+++ b/winsup/cygserver/Makefile.in
@@ -41,8 +41,6 @@ OBJS:=	cygserver.o client.o process.o msg.o sem.o shm.o threaded_queue.o \
 	sysv_msg.o sysv_sem.o sysv_shm.o setpwd.o pwdgrp.o
 LIBOBJS:=${patsubst %.o,lib%.o,$(OBJS)}
 
-CYGWIN_OBJS:=$(cygwin_build)/version.o
-
 CYGWIN_LIB:=$(cygwin_build)/libcygwin.a
 
 all: cygserver.exe
@@ -62,7 +60,7 @@ libclean:
 
 fullclean: clean libclean
 
-cygserver.exe: $(CYGWIN_LIB) $(OBJS) $(CYGWIN_OBJS)
+cygserver.exe: $(CYGWIN_LIB) $(OBJS)
 	$(CXX) -o $@ ${wordlist 2,999,$^} -static -static-libgcc -B$(cygwin_build) -lntdll
 
 $(cygwin_build)/%.o:
-- 
2.28.0

