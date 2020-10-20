Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-042.btinternet.com (mailomta5-sa.btinternet.com
 [213.120.69.11])
 by sourceware.org (Postfix) with ESMTPS id 9053239450E1
 for <cygwin-patches@cygwin.com>; Tue, 20 Oct 2020 13:43:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9053239450E1
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from sa-prd-rgout-003.btmx-prd.synchronoss.net ([10.2.38.6])
 by sa-prd-fep-042.btinternet.com with ESMTP id
 <20201020134333.SHL4736.sa-prd-fep-042.btinternet.com@sa-prd-rgout-003.btmx-prd.synchronoss.net>;
 Tue, 20 Oct 2020 14:43:33 +0100
Authentication-Results: btinternet.com; none
X-Originating-IP: [86.139.158.27]
X-OWM-Source-IP: 86.139.158.27 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrjeefgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepueeiueejheefuddvfefgheefhedvffettddvgeetjeelhffhteekieeggeetgeelnecuffhomhgrihhnpehmrghkvghfihhlvgdrihhnnecukfhppeekiedrudefledrudehkedrvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudehkedrvdejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.158.27) by
 sa-prd-rgout-003.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9AFBE16F22BE1; Tue, 20 Oct 2020 14:43:33 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/6] gendef generates sigfe.s and cygwin.def
Date: Tue, 20 Oct 2020 14:43:01 +0100
Message-Id: <20201020134304.11281-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
References: <20201020134304.11281-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1201.0 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Tue, 20 Oct 2020 13:43:45 -0000

Express that gendef generates sigfe.s and cygwin.def in a slightly less
nutty way.
---
 winsup/cygwin/Makefile.in | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index a56a311b8..9d05b17b3 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -785,16 +785,13 @@ $(VERSION_OFILES): version.cc
 Makefile: ${srcdir}/Makefile.in
 	/bin/sh ./config.status
 
-$(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
+$(DEF_FILE) sigfe.s: gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
 	$(word 1,$^) --cpu=${target_cpu} --output-def=$@  --tlsoffsets=$(word 2,$^) $(wordlist 3,99,$^)
 
 $(srcdir)/$(TLSOFFSETS_H): gentls_offsets cygtls.h
 	$^ $@ $(target_cpu) $(COMPILE.cc) -c || rm $@
 
 sigfe.s: $(DEF_FILE)
-	@[ -s $@ ] || \
-	{ rm -f $(DEF_FILE); $(MAKE) -s -j1 $(DEF_FILE); }; \
-	[ -s $@ ] && touch $@
 
 sigfe.o: sigfe.s $(srcdir)/$(TLSOFFSETS_H)
 	$(CC) ${CFLAGS} -c -o $@ $<
-- 
2.28.0

