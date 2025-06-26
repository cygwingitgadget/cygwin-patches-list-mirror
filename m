Return-Path: <SRS0=NNDi=ZJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id AA359385B52D
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 10:59:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AA359385B52D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AA359385B52D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750935591; cv=none;
	b=e1zGXEUCMt0853Ag1A+le6GcNAMkebJcWjJZ7VrpsJt3HqgTvn9GyM/UDYgjRC4xl+IKh4va076Vnf0qsjjjFq261SfIXOw0g1EzdG+YC5OM+Xv4gxSCLVjCIujBcX0Y0SZEvvjVCDo6pTKCeluUgAcmxwKHboVEhIl3deRN0PE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750935591; c=relaxed/simple;
	bh=+T3gvEme2EUQJ5ZoQOIHgtd/TPPSDuLXEpvz1QV/07M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZoO0oop15Dj0NzmPGmiues9fIAvhl+8Z4KVmsWcib4Xy1ZMR/PTGltnb7tk/X0PHICEl0w8XtggWY2/ZBYk7u2Xpy/ejBNZKHnb2vFl5PWcXYaUs6Lf4QoqF3qjJdMU9XInSZ/oPSG+7Zn2n+n+dCli4KKNUXje1ep6vcCURaPI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AA359385B52D
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89D9E0ACA9EDF
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtkedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdr
	thhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.63) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D9E0ACA9EDF; Thu, 26 Jun 2025 11:59:51 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 2/2] Cygwin: doc: Install miscellaneous website files
Date: Thu, 26 Jun 2025 11:59:24 +0100
Message-ID: <20250626105925.29521-3-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
References: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This gives us a full set of the built documentation files in the install
directory, which can then be appropriately filtered for packaging or
deploying to website, as required.

Again, there will be a separate change to the cygwin packaging to avoid
including theses files in the cygwin-doc package.

Also, add matching uninstall rules.
---
 winsup/doc/Makefile.am | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index 4ea7e99a7..394c43596 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -48,10 +48,11 @@ clean-local:
 	rm -f *.5
 	rm -f *.info* charmap
 
-install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html faq/faq.html
+install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html.gz cygwin-api/cygwin-api.html faq/faq.html
 	@$(MKDIR_P) $(DESTDIR)$(htmldir)/cygwin-ug-net
 	$(INSTALL_DATA) cygwin-ug-net/*.html $(DESTDIR)$(htmldir)/cygwin-ug-net
 	(cd $(DESTDIR)$(htmldir)/cygwin-ug-net && ln -f cygwin-ug-net.html index.html)
+	$(INSTALL_DATA) cygwin-ug-net/cygwin-ug-net-nochunks.html.gz $(DESTDIR)$(htmldir)/cygwin-ug-net
 	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/cygwin-ug-net
 	@$(MKDIR_P) $(DESTDIR)$(htmldir)/cygwin-api
 	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
@@ -59,6 +60,7 @@ install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/cygwin-api
 	@$(MKDIR_P) $(DESTDIR)$(htmldir)/faq
 	$(INSTALL_DATA) faq/faq.html $(DESTDIR)$(htmldir)/faq
+	$(INSTALL_DATA) faq/faq.body $(DESTDIR)$(htmldir)/faq
 	(cd $(DESTDIR)$(htmldir)/faq && ln -f faq.html index.html)
 	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/faq
 
@@ -98,6 +100,7 @@ uninstall-html:
 	    rm -f $(DESTDIR)$(htmldir)/$$i ; \
 	done ;
 	rm -f $(DESTDIR)$(htmldir)/cygwin-ug-net/index.html
+	rm -f $(DESTDIR)$(htmldir)/cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
 	rm -f $(DESTDIR)$(htmldir)/cygwin-ug-net/docbook.css
 	for i in cygwin-api/*.html ; do \
 	    rm -f $(DESTDIR)$(htmldir)/$$i ; \
@@ -105,6 +108,7 @@ uninstall-html:
 	rm -f $(DESTDIR)$(htmldir)/cygwin-api/index.html
 	rm -f $(DESTDIR)$(htmldir)/cygwin-api/docbook.css
 	rm -f $(DESTDIR)$(htmldir)/faq/faq.html
+	rm -f $(DESTDIR)$(htmldir)/faq/faq.body
 	rm -f $(DESTDIR)$(htmldir)/faq/index.html
 	rm -f $(DESTDIR)$(htmldir)/faq/docbook.css
 
@@ -119,7 +123,7 @@ uninstall-etc:
 
 uninstall-hook: uninstall-extra-man uninstall-html uninstall-info uninstall-etc
 
-# nochunks ug html is not installed, but will be deployed to website
+# nochunks ug html is not packaged, but will be deployed to website
 cygwin-ug-net/cygwin-ug-net-nochunks.html.gz: $(cygwin-ug-net_SOURCES) html.xsl
 	$(AM_V_GEN)$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
 	@$(MKDIR_P) cygwin-ug-net
@@ -167,7 +171,7 @@ faq/faq.html: $(faq_SOURCES) html.xsl
 	$(AM_V_GEN)$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(XMLTO_HTML_CHUNK_QUIET) $(srcdir)/faq.xml
 	@sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
 
-# faq body is not installed, but is intended to be deployed to website, where it
+# faq body is not packaged, but is intended to be deployed to website, where it
 # can be SSI included in a framing page
 faq/faq.body: faq/faq.html
 	$(AM_V_GEN)$(srcdir)/bodysnatcher.pl $<
-- 
2.45.1

