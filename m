Return-Path: <jon.turney@dronecode.org.uk>
Received: from re-prd-fep-045.btinternet.com (mailomta12-re.btinternet.com
 [213.120.69.105])
 by sourceware.org (Postfix) with ESMTPS id 03BDE384240F
 for <cygwin-patches@cygwin.com>; Sat, 31 Oct 2020 15:08:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 03BDE384240F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=jon.turney@dronecode.org.uk
Received: from re-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.54.4])
 by re-prd-fep-045.btinternet.com with ESMTP id
 <20201031150841.RQZQ30806.re-prd-fep-045.btinternet.com@re-prd-rgout-001.btmx-prd.synchronoss.net>;
 Sat, 31 Oct 2020 15:08:41 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 5ED9BDD0183B92C2
X-Originating-IP: [86.140.194.67]
X-OWM-Source-IP: 86.140.194.67 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedujedrleejgdejfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekiedrudegtddrudelgedrieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudegtddrudelgedrieejpdhmrghilhhfrhhomhepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqedprhgtphhtthhopeeotgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomheqpdhrtghpthhtohepoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqe
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.140.194.67) by
 re-prd-rgout-001.btmx-prd.synchronoss.net (5.8.340) (authenticated as
 jonturney@btinternet.com)
 id 5ED9BDD0183B92C2; Sat, 31 Oct 2020 15:08:41 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/7] Remove intro2man.stamp on clean
Date: Sat, 31 Oct 2020 15:08:15 +0000
Message-Id: <20201031150821.18041-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
References: <20201031150821.18041-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.7 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
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
X-List-Received-Date: Sat, 31 Oct 2020 15:08:43 -0000

---
 winsup/doc/Makefile.in | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index bcf0c1fb2..cb46a91cf 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -61,8 +61,9 @@ clean:
 	rm -f Makefile.dep
 	rm -f *.html *.html.gz
 	rm -Rf cygwin-api cygwin-ug cygwin-ug-net faq
-	rm -f *.1 utils2man.stamp
-	rm -f *.3 api2man.stamp
+	rm -f api2man.stamp intro2man.stamp utils2man.stamp
+	rm -f *.1
+	rm -f *.3
 	rm -f *.info* charmap
 
 install: install-all
-- 
2.29.0

