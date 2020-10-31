Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-046.btinternet.com (mailomta17-re.btinternet.com
 [213.120.69.110])
 by sourceware.org (Postfix) with ESMTPS id 2D7BF3842411
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:09:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2D7BF3842411
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-046.btinternet.com with ESMTP id
 <20201031150908.QUEC13971.re-prd-fep-046.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sat, 31 Oct 2020 15:09:08 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9BDD0183B9540
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
 id 5ED9BDD0183B9540; Sat, 31 Oct 2020 15:09:08 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 7/7] Drop passing '-c' compiler flag into gentls_offsets
Date: Sat, 31 Oct 2020 15:08:21 +0000
Message-Id: <20201031150821.18041-8-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
References: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1199.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, KHOP_HELO_FCRDNS,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:09:11 -0000

That script appends a '-E', since we only use $(CC) to preprocess, and
thus adding '-c' is having no effect.
---
 winsup/cygwin/Makefile.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
index 0add2320b..ec5d1efed 100644
--- a/winsup/cygwin/Makefile.in
+++ b/winsup/cygwin/Makefile.in
@@ -761,7 +761,7 @@ $(DEF_FILE): gendef $(srcdir)/$(TLSOFFSETS_H) $(DIN_FILE)
 	$(word 1,$^) --cpu=${target_cpu} --output-def=$@  --tlsoffsets=$(word 2,$^) $(wordlist 3,99,$^)
 
 $(srcdir)/$(TLSOFFSETS_H): gentls_offsets cygtls.h
-	$^ $@ $(target_cpu) $(COMPILE.cc) -c || rm $@
+	$^ $@ $(target_cpu) $(COMPILE.cc) || rm $@
 
 sigfe.s: $(DEF_FILE)
 	@[ -s $@ ] || \
-- 
2.29.0

