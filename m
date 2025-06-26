Return-Path: <SRS0=NNDi=ZJ=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id C123E385B52C
	for <cygwin-patches@cygwin.com>; Thu, 26 Jun 2025 10:59:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C123E385B52C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C123E385B52C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750935587; cv=none;
	b=sWyTdeEmz4B+1+3/Bbu1HDB2iasrVVhwG4KUcX2AZM3CL61dk9jojdZObWnKc3zZfKnBWuAOdQoN6JxFNbiu8v9pLb8EJef/Wuz1ZW+gNEs5owCMFesNBKLI4sxc3KJ5CblAyG2GKC5jiKQ0IM5R6Bheey2uN/bM6zzyMhhlpS0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750935587; c=relaxed/simple;
	bh=QSkF207teFx7LAiHBD5Yur3Xo21i8ZaaKZka2SsNpVQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=K84qJNTpTP3MnVArPf28iIi12p6rGffRphA8ky/JFFQ7mTfpMfG/vE+NTOuwe089oHaBf5Oy/TCJDRVE6Q1tBE5QJwy/CLsMuyMWHAbG1WGQZtx2Jgp6ytdvv7rlM2DXJDtdJKSfCUlHSHUMAx9YLvL0AVnHeWIepyHvCHD8q9k=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C123E385B52C
Authentication-Results: btinternet.com; none
X-SNCR-Rigid: 67D89D9E0ACA9E94
X-Originating-IP: [86.139.167.63]
X-OWM-Source-IP: 86.139.167.63
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepleeitdejhfdtveekheeugeffgeevfedtjeejveefhfeiffefkedtvdetheehieejnecukfhppeekiedrudefledrudeijedrieefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplhhotggrlhhhohhsthdrlhhotggrlhguohhmrghinhdpihhnvghtpeekiedrudefledrudeijedrieefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduieejqdeifedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvghtrdgtohhmpdhgvghokffrpefiuedpoffvtefjohhsthepsghtphhrughrghhotddtkedpnhgspghrtghpthhtohepvddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrtghpthhtohepjhhonhdr
	thhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukh
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from localhost.localdomain (86.139.167.63) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 67D89D9E0ACA9E94; Thu, 26 Jun 2025 11:59:46 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Cygwin: doc: Install FAQ as well
Date: Thu, 26 Jun 2025 11:59:23 +0100
Message-ID: <20250626105925.29521-2-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
References: <20250626105925.29521-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Just install the FAQ, so we can deploy the FAQ with it's matching CSS from
the install directory.

There will be a separate change to the cygwin packaging to avoid
including the FAQ in the cygwin-doc package. (I guess we'd rather people
go online for that, to ensure they have the latest version?)

Also, add matching uninstall rules.
---
 winsup/doc/Makefile.am | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/Makefile.am b/winsup/doc/Makefile.am
index 650e0c924..4ea7e99a7 100644
--- a/winsup/doc/Makefile.am
+++ b/winsup/doc/Makefile.am
@@ -48,7 +48,7 @@ clean-local:
 	rm -f *.5
 	rm -f *.info* charmap
 
-install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
+install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html faq/faq.html
 	@$(MKDIR_P) $(DESTDIR)$(htmldir)/cygwin-ug-net
 	$(INSTALL_DATA) cygwin-ug-net/*.html $(DESTDIR)$(htmldir)/cygwin-ug-net
 	(cd $(DESTDIR)$(htmldir)/cygwin-ug-net && ln -f cygwin-ug-net.html index.html)
@@ -57,6 +57,10 @@ install-html-local: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
 	(cd $(DESTDIR)$(htmldir)/cygwin-api && ln -f cygwin-api.html index.html)
 	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/cygwin-api
+	@$(MKDIR_P) $(DESTDIR)$(htmldir)/faq
+	$(INSTALL_DATA) faq/faq.html $(DESTDIR)$(htmldir)/faq
+	(cd $(DESTDIR)$(htmldir)/faq && ln -f faq.html index.html)
+	$(INSTALL_DATA) $(srcdir)/docbook.css $(DESTDIR)$(htmldir)/faq
 
 install-extra-man: api2man.stamp intro2man.stamp utils2man.stamp
 	@$(MKDIR_P) $(DESTDIR)$(man1dir)
@@ -100,6 +104,9 @@ uninstall-html:
 	done ;
 	rm -f $(DESTDIR)$(htmldir)/cygwin-api/index.html
 	rm -f $(DESTDIR)$(htmldir)/cygwin-api/docbook.css
+	rm -f $(DESTDIR)$(htmldir)/faq/faq.html
+	rm -f $(DESTDIR)$(htmldir)/faq/index.html
+	rm -f $(DESTDIR)$(htmldir)/faq/docbook.css
 
 uninstall-info:
 	for i in *.info* ; do \
-- 
2.45.1

