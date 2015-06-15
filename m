Return-Path: <cygwin-patches-return-8156-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 112975 invoked by alias); 15 Jun 2015 12:37:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 112894 invoked by uid 89); 15 Jun 2015 12:37:11 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:37:07 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.557EC6EF.008A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_1900_1999, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF6000503A6; Mon, 15 Jun 2015 13:37:03 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/8] winsup/doc: Use fo.xsl to customize PDF generation from DocBook XML
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-5-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00056.txt.bz2

fo.xsl doesn't seem to be used since c2f50c40 switched back from xsltproc to
xmlto

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (cygwin-ug-net/cygwin-ug-net.pdf)
	(cygwin-api/cygwin-api.pdf): Use fo.xsl to customized DocBook
	XML->PDF conversion.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   | 6 ++++++
 winsup/doc/Makefile.in | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 46a7908..a73326a 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,11 @@
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (cygwin-ug-net/cygwin-ug-net.pdf)
+	(cygwin-api/cygwin-api.pdf): Use fo.xsl to customized DocBook
+	XML->PDF conversion.
+
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* cygwin-ug-net.xml: Remove incorrect unused date.
 	* utils.xml : Remove .exe suffix inconsistently added in a few
 	places.  Consistently refer to cross-references outside this file
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index a97545c..2d71728 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -80,13 +80,13 @@ cygwin-ug-net/cygwin-ug-net.html : cygwin-ug-net.xml cygwin.xsl
 	-$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/cygwin.xsl $<
 
 cygwin-ug-net/cygwin-ug-net.pdf : cygwin-ug-net.xml fo.xsl
-	-$(XMLTO) pdf -o cygwin-ug-net/ $<
+	-$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
 
 cygwin-api/cygwin-api.html : cygwin-api.xml cygwin.xsl
 	-$(XMLTO) html -o cygwin-api/ -m $(srcdir)/cygwin.xsl $<
 
 cygwin-api/cygwin-api.pdf : cygwin-api.xml fo.xsl
-	-$(XMLTO) pdf -o cygwin-api/ $<
+	-$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
 
 faq/faq.html : $(FAQ_SOURCES)
 	-$(XMLTO) html -o faq -m $(srcdir)/cygwin.xsl $(srcdir)/faq.xml
-- 
2.1.4
