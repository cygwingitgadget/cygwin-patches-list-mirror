Return-Path: <cygwin-patches-return-8157-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113678 invoked by alias); 15 Jun 2015 12:37:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113563 invoked by uid 89); 15 Jun 2015 12:37:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:37:14 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.557EC6FA.0034,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_3000_3999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF60005056C; Mon, 15 Jun 2015 13:37:14 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 7/8] winsup/doc: Make and install manpages for utils
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-8-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00058.txt.bz2

Use 'xmlto man' to make manpages for utils
(docbook2x-man could also be used, but since we already use xmlto...)

This will generate multiple .1 files as an output, but we don't know what they
will be called, so use a timestamp file for build avoidance when the
dependencies haven't changed.

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (install-man, utils2man.stamp): Add rules to build
	and install manpages for utils.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |  5 +++++
 winsup/doc/Makefile.in | 18 +++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 7d33752..341374f 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,10 @@
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (install-man, utils2man.stamp): Add rules to build
+	and install manpages for utils.
+
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* xidepend: Write a Makefile fragment defining variables
 	containing all the XIncluded sources, rather than a dependency on
 	those sources.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 79a050a..bb2ad36 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -16,6 +16,8 @@ prefix:=@prefix@
 datarootdir:=@datarootdir@
 docdir = @docdir@
 htmldir = @htmldir@
+mandir = @mandir@
+man1dir = $(mandir)/man1
 
 override INSTALL:=@INSTALL@
 override INSTALL_DATA:=@INSTALL_DATA@
@@ -37,7 +39,7 @@ FAQ_SOURCES:= $(wildcard $(srcdir)/faq*.xml)
 .html.body:
 	$(srcdir)/bodysnatcher.pl $<
 
-.PHONY: all clean install install-all install-pdf install-html
+.PHONY: all clean install install-all install-pdf install-html install-man
 
 all: Makefile Makefile.dep \
 	cygwin-ug-net/cygwin-ug-net.html \
@@ -45,7 +47,8 @@ all: Makefile Makefile.dep \
 	cygwin-api/cygwin-api.html \
 	faq/faq.body faq/faq.html \
 	cygwin-ug-net/cygwin-ug-net.pdf \
-	cygwin-api/cygwin-api.pdf
+	cygwin-api/cygwin-api.pdf \
+	utils2man.stamp
 
 Makefile: $(srcdir)/Makefile.in
 	/bin/sh ./config.status
@@ -54,10 +57,11 @@ clean:
 	rm -f Makefile.dep
 	rm -f *.html *.html.gz
 	rm -Rf cygwin-api cygwin-ug cygwin-ug-net faq
+	rm -f *.1 utils2man.stamp
 
 install: install-all
 
-install-all: install-pdf install-html
+install-all: install-pdf install-html install-man
 
 install-pdf: cygwin-ug-net/cygwin-ug-net.pdf cygwin-api/cygwin-api.pdf
 	@$(MKDIRP) $(DESTDIR)$(docdir)
@@ -71,6 +75,10 @@ install-html: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
 	$(INSTALL_DATA) cygwin-api/cygwin-api.html $(DESTDIR)$(htmldir)/cygwin-api/index.html
 
+install-man: utils2man.stamp
+	@$(MKDIRP) $(DESTDIR)$(man1dir)
+	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
+
 cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) cygwin.xsl
 	-$(XMLTO) html-nochunks -m $(srcdir)/cygwin.xsl $<
 	-cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
@@ -83,6 +91,10 @@ cygwin-ug-net/cygwin-ug-net.html : $(cygwin-ug-net_SOURCES) cygwin.xsl
 cygwin-ug-net/cygwin-ug-net.pdf : $(cygwin-ug-net_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
 
+utils2man.stamp: $(cygwin-ug-net_SOURCES)
+	$(XMLTO) man $<
+	@touch $@
+
 cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) cygwin.xsl
 	-$(XMLTO) html -o cygwin-api/ -m $(srcdir)/cygwin.xsl $<
 
-- 
2.1.4
