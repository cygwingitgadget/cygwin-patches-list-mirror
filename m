Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-047.btinternet.com (mailomta18-sa.btinternet.com
 [213.120.69.24])
 by sourceware.org (Postfix) with ESMTPS id 6F23F3857829
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 13:16:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 6F23F3857829
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-047.btinternet.com with ESMTP id
 <20220119131606.UHAI16049.sa-prd-fep-047.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Wed, 19 Jan 2022 13:16:06 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A912DF46DD
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.209) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613006A912DF46DD; Wed, 19 Jan 2022 13:16:06 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/4] Cygwin: silence xsltproc when writing manpages
Date: Wed, 19 Jan 2022 13:15:21 +0000
Message-Id: <20220119131521.51616-5-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_PASS, SPF_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 19 Jan 2022 13:16:10 -0000

Unless make is invoked with V=1, have xmlto pass the parameter
'man.output.quietly=1' to xsltproc to suppress "Note: Writing foo.N"
output from the manpages stylesheet.
---
 winsup/doc/Makefile.am | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index fb3ab711c..650e0c924 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -21,6 +21,8 @@ XMLTO_DBLATEX_QUIET_=-p '-q'
 XMLTO_DBLATEX_QUIET=$(XMLTO_DBLATEX_QUIET_$(V))
 XMLTO_HTML_CHUNK_QUIET_=--stringparam chunk.quietly=1
 XMLTO_HTML_CHUNK_QUIET=$(XMLTO_HTML_CHUNK_QUIET_$(V))
+XMLTO_MAN_QUIET_=--stringparam man.output.quietly=1
+XMLTO_MAN_QUIET=$(XMLTO_MAN_QUIET_$(V))
 
 DOCBOOK2XTEXI=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap
 
@@ -125,7 +127,7 @@ cygwin-ug-net/cygwin-ug-net.pdf: $(cygwin-ug-net_SOURCES) fo.xsl
 	$(AM_V_GEN)$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $(XMLTO_DBLATEX_QUIET) $<
 
 utils2man.stamp: $(cygwin-ug-net_SOURCES) man.xsl
-	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $<
+	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $(XMLTO_MAN_QUIET) $<
 	@touch $@
 
 cygwin-ug-net.info: $(cygwin-ug-net_SOURCES) charmap
@@ -138,7 +140,7 @@ cygwin-api/cygwin-api.pdf: $(cygwin-api_SOURCES) fo.xsl
 	$(AM_V_GEN)$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $(XMLTO_DBLATEX_QUIET) $<
 
 api2man.stamp: $(cygwin-api_SOURCES) man.xsl
-	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $<
+	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $(XMLTO_MAN_QUIET) $<
 	@touch $@
 
 cygwin-api.info: $(cygwin-api_SOURCES) charmap
@@ -150,7 +152,7 @@ charmap:
 	$(AM_V_at)echo "ae (R)" >>charmap
 
 intro2man.stamp: intro.xml man.xsl
-	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $<
+	$(AM_V_GEN)$(XMLTO) man -m $(srcdir)/man.xsl $(XMLTO_MAN_QUIET) $<
 	@echo ".so intro.1" >cygwin.1
 	@touch $@
 
-- 
2.34.1

