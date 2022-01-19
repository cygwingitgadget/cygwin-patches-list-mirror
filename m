Return-Path: <jon.turney@dronecode.org.uk>
Received: from sa-prd-fep-048.btinternet.com (mailomta2-sa.btinternet.com
 [213.120.69.8])
 by sourceware.org (Postfix) with ESMTPS id 7A740385783B
 for <cygwin-patches@cygwin.com>; Wed, 19 Jan 2022 13:16:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7A740385783B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none)
 header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=dronecode.org.uk
Received: from sa-prd-rgout-001.btmx-prd.synchronoss.net ([10.2.38.4])
 by sa-prd-fep-048.btinternet.com with ESMTP id
 <20220119131603.BFNR22188.sa-prd-fep-048.btinternet.com@sa-prd-rgout-001.btmx-prd.synchronoss.net>;
 Wed, 19 Jan 2022 13:16:03 +0000
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 613006A912DF4665
X-Originating-IP: [81.129.146.209]
X-OWM-Source-IP: 81.129.146.209 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudehgdegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenucenucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepfeeiudevhefgffffueeuheelfeegveefvdffleejfeehudetleetledvteethfdvnecukfhppeekuddruddvledrudegiedrvddtleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehlohgtrghlhhhoshhtrdhlohgtrghlughomhgrihhnpdhinhgvthepkedurdduvdelrddugeeirddvtdelpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (81.129.146.209) by
 sa-prd-rgout-001.btmx-prd.synchronoss.net (5.8.716.04) (authenticated as
 jonturney@btinternet.com)
 id 613006A912DF4665; Wed, 19 Jan 2022 13:16:03 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 3/4] Cygwin: silence xsltproc when writing chunked html
Date: Wed, 19 Jan 2022 13:15:20 +0000
Message-Id: <20220119131521.51616-4-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
References: <20220119131521.51616-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1198.3 required=5.0 tests=BAYES_00, FORGED_SPF_HELO,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_PASS, SPF_NONE,
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
X-List-Received-Date: Wed, 19 Jan 2022 13:16:07 -0000

Unless make is invoked with V=1, have xmlto pass the parameter
'chunk.quietly=1' to xsltproc to suppress repeated "Writing foo.html for
sect1(foo)" output from the chunker.xsl stylesheet.
---
 winsup/doc/Makefile.am | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index 57b74341a..fb3ab711c 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -19,6 +19,8 @@ htmldir = $(datarootdir)/doc
 XMLTO=@XMLTO@ --skip-validation --with-dblatex
 XMLTO_DBLATEX_QUIET_=-p '-q'
 XMLTO_DBLATEX_QUIET=$(XMLTO_DBLATEX_QUIET_$(V))
+XMLTO_HTML_CHUNK_QUIET_=--stringparam chunk.quietly=1
+XMLTO_HTML_CHUNK_QUIET=$(XMLTO_HTML_CHUNK_QUIET_$(V))
 
 DOCBOOK2XTEXI=@DOCBOOK2XTEXI@ --xinclude --info --utf8trans-map=charmap
 
@@ -117,7 +119,7 @@ cygwin-ug-net/cygwin-ug-net-nochunks.html.gz: $(cygwin-ug-net_SOURCES) html.xsl
 	$(AM_V_at)gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
 
 cygwin-ug-net/cygwin-ug-net.html: $(cygwin-ug-net_SOURCES) html.xsl
-	$(AM_V_GEN)$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/html.xsl $<
+	$(AM_V_GEN)$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/html.xsl $(XMLTO_HTML_CHUNK_QUIET) $<
 
 cygwin-ug-net/cygwin-ug-net.pdf: $(cygwin-ug-net_SOURCES) fo.xsl
 	$(AM_V_GEN)$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $(XMLTO_DBLATEX_QUIET) $<
@@ -130,7 +132,7 @@ cygwin-ug-net.info: $(cygwin-ug-net_SOURCES) charmap
 	$(AM_V_GEN)$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net
 
 cygwin-api/cygwin-api.html: $(cygwin-api_SOURCES) html.xsl
-	$(AM_V_GEN)$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $<
+	$(AM_V_GEN)$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $(XMLTO_HTML_CHUNK_QUIET) $<
 
 cygwin-api/cygwin-api.pdf: $(cygwin-api_SOURCES) fo.xsl
 	$(AM_V_GEN)$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $(XMLTO_DBLATEX_QUIET) $<
@@ -153,7 +155,7 @@ intro2man.stamp: intro.xml man.xsl
 	@touch $@
 
 faq/faq.html: $(faq_SOURCES) html.xsl
-	$(AM_V_GEN)$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
+	$(AM_V_GEN)$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(XMLTO_HTML_CHUNK_QUIET) $(srcdir)/faq.xml
 	@sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
 
 # faq body is not installed, but is intended to be deployed to website, where it
-- 
2.34.1

