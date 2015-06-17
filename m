Return-Path: <cygwin-patches-return-8188-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13952 invoked by alias); 17 Jun 2015 12:37:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13863 invoked by uid 89); 17 Jun 2015 12:37:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0502.bt.lon5.cpcloud.co.uk
Received: from rgout0502.bt.lon5.cpcloud.co.uk (HELO rgout0502.bt.lon5.cpcloud.co.uk) (65.20.0.223) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 12:37:48 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55816A19.0103,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __MAL_TELEKOM_URI, __CP_URI_IN_BODY, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55814C5E00039C71; Wed, 17 Jun 2015 13:37:37 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/5] winsup/doc: Add man.xsl customization stylesheet
Date: Wed, 17 Jun 2015 12:37:00 -0000
Message-Id: <1434544626-2516-6-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00088.txt.bz2

2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>

	* man.xsl: New file.
	* Makefile.in (utils2man.stamp, api2man.stamp): Use it.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |  5 +++++
 winsup/doc/Makefile.in |  8 ++++----
 winsup/doc/man.xsl     | 13 +++++++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)
 create mode 100644 winsup/doc/man.xsl

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 4c464b2..3693516 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,10 @@
 2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* man.xsl: New file.
+	* Makefile.in (utils2man.stamp, api2man.stamp): Use it.
+
+2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (api2man.stamp): Add rules to build and install
 	manpages for cygwin-api.
 
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index f308ab2..60b375a 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -97,8 +97,8 @@ cygwin-ug-net/cygwin-ug-net.html : $(cygwin-ug-net_SOURCES) html.xsl
 cygwin-ug-net/cygwin-ug-net.pdf : $(cygwin-ug-net_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
 
-utils2man.stamp: $(cygwin-ug-net_SOURCES)
-	$(XMLTO) man $<
+utils2man.stamp: $(cygwin-ug-net_SOURCES) man.xsl
+	$(XMLTO) man -m ${srcdir}/man.xsl $<
 	@touch $@
 
 cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) html.xsl
@@ -107,8 +107,8 @@ cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) html.xsl
 cygwin-api/cygwin-api.pdf : $(cygwin-api_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
 
-api2man.stamp: $(cygwin-api_SOURCES)
-	$(XMLTO) man $<
+api2man.stamp: $(cygwin-api_SOURCES) man.xsl
+	$(XMLTO) man -m ${srcdir}/man.xsl $<
 	@touch $@
 
 faq/faq.html : $(FAQ_SOURCES)
diff --git a/winsup/doc/man.xsl b/winsup/doc/man.xsl
new file mode 100644
index 0000000..22e624f
--- /dev/null
+++ b/winsup/doc/man.xsl
@@ -0,0 +1,13 @@
+<?xml version='1.0'?>
+<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>
+
+<!-- don't truncate manpage titles for long function names -->
+<xsl:param name="man.th.title.max.length" select="33" />
+
+<!-- don't moan about missing metadata -->
+<xsl:param name="refentry.meta.get.quietly" select="1" />
+
+<!-- base URL for relative links -->
+<xsl:param name="man.base.url.for.relative.links">https://cygwin.com/cygwin-ug-net/</xsl:param>
+
+</xsl:stylesheet>
-- 
2.1.4
