Return-Path: <cygwin-patches-return-8184-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11382 invoked by alias); 17 Jun 2015 12:37:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11289 invoked by uid 89); 17 Jun 2015 12:37:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0505.bt.lon5.cpcloud.co.uk
Received: from rgout0505.bt.lon5.cpcloud.co.uk (HELO rgout0505.bt.lon5.cpcloud.co.uk) (65.20.0.226) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 12:37:29 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55816A06.014B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __MAL_TELEKOM_URI, __CP_URI_IN_BODY, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55814C5E00039A3E; Wed, 17 Jun 2015 13:37:18 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/5] winsup/doc: Rename cygwin.xsl as html.xsl
Date: Wed, 17 Jun 2015 12:37:00 -0000
Message-Id: <1434544626-2516-2-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00085.txt.bz2

For clarity, rename cygwin.xsl as html.xsl, because that's what it is

2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>

	* html.xsl: Renamed from cygwin.xsl.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog                |  4 ++++
 winsup/doc/Makefile.in              | 14 +++++++-------
 winsup/doc/{cygwin.xsl => html.xsl} |  2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)
 rename winsup/doc/{cygwin.xsl => html.xsl} (95%)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 02bf22e..453de70 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,7 @@
+2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* html.xsl: Renamed from cygwin.xsl.
+
 2015-06-17  Corinna Vinschen  <corinna@vinschen.de>
 
 	* new-features.xml (ov-new): Rename from ov-new1.7.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 14b4588..c9e32c8 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -79,15 +79,15 @@ install-man: utils2man.stamp
 	@$(MKDIRP) $(DESTDIR)$(man1dir)
 	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
 
-cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) cygwin.xsl
-	-$(XMLTO) html-nochunks -m $(srcdir)/cygwin.xsl $<
+cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) html.xsl
+	-$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
 	-@$(MKDIRP) cygwin-ug-net
 	-cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
 	-rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
 	-gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
 
-cygwin-ug-net/cygwin-ug-net.html : $(cygwin-ug-net_SOURCES) cygwin.xsl
-	-$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/cygwin.xsl $<
+cygwin-ug-net/cygwin-ug-net.html : $(cygwin-ug-net_SOURCES) html.xsl
+	-$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/html.xsl $<
 
 cygwin-ug-net/cygwin-ug-net.pdf : $(cygwin-ug-net_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
@@ -96,14 +96,14 @@ utils2man.stamp: $(cygwin-ug-net_SOURCES)
 	$(XMLTO) man $<
 	@touch $@
 
-cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) cygwin.xsl
-	-$(XMLTO) html -o cygwin-api/ -m $(srcdir)/cygwin.xsl $<
+cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) html.xsl
+	-$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $<
 
 cygwin-api/cygwin-api.pdf : $(cygwin-api_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
 
 faq/faq.html : $(FAQ_SOURCES)
-	-$(XMLTO) html -o faq -m $(srcdir)/cygwin.xsl $(srcdir)/faq.xml
+	-$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
 	-sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
 
 Makefile.dep: cygwin-ug-net.xml cygwin-api.xml
diff --git a/winsup/doc/cygwin.xsl b/winsup/doc/html.xsl
similarity index 95%
rename from winsup/doc/cygwin.xsl
rename to winsup/doc/html.xsl
index df12555..2b02ea8 100644
--- a/winsup/doc/cygwin.xsl
+++ b/winsup/doc/html.xsl
@@ -3,7 +3,7 @@
                 xmlns:fo="http://www.w3.org/1999/XSL/Format"
                 version='1.0'>
 
-<xsl:param name="chunker.output.doctype-public" 
+<xsl:param name="chunker.output.doctype-public"
   select="'-//W3C//DTD HTML 4.01 Transitional//EN'" />
 <xsl:param name="html.stylesheet" select="'docbook.css'"/>
 <xsl:param name="use.id.as.filename" select="1" />
-- 
2.1.4
