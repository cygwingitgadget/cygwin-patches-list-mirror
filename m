Return-Path: <cygwin-patches-return-8186-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13207 invoked by alias); 17 Jun 2015 12:37:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 13049 invoked by uid 89); 17 Jun 2015 12:37:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0505.bt.lon5.cpcloud.co.uk
Received: from rgout0505.bt.lon5.cpcloud.co.uk (HELO rgout0505.bt.lon5.cpcloud.co.uk) (65.20.0.226) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 12:37:42 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55816A14.01B5,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.94516:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55814C5E00039BF8; Wed, 17 Jun 2015 13:37:33 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/5] winsup/doc: Make and install cygwin-api function manpages
Date: Wed, 17 Jun 2015 12:37:00 -0000
Message-Id: <1434544626-2516-5-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00087.txt.bz2

Use 'xmlto man' to make manpages for utils

This will generate multiple .1 files as an output, but we don't know what they
will be called, so use a timestamp for build avoidance

2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (api2man.stamp): Add rules to build and install
	manpages for cygwin-api.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |  5 +++++
 winsup/doc/Makefile.in | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index ddee4e9..4c464b2 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,10 @@
 2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (api2man.stamp): Add rules to build and install
+	manpages for cygwin-api.
+
+2015-06-17  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* cygwin-api.xml: Move introductory paragraph here.
 	* logon-funcs.xml: Convert from using a sect2 element to using a
 	refentry element for each function.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index c9e32c8..f308ab2 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -18,6 +18,7 @@ docdir = @docdir@
 htmldir = @htmldir@
 mandir = @mandir@
 man1dir = $(mandir)/man1
+man3dir = $(mandir)/man3
 
 override INSTALL:=@INSTALL@
 override INSTALL_DATA:=@INSTALL_DATA@
@@ -48,7 +49,8 @@ all: Makefile Makefile.dep \
 	faq/faq.body faq/faq.html \
 	cygwin-ug-net/cygwin-ug-net.pdf \
 	cygwin-api/cygwin-api.pdf \
-	utils2man.stamp
+	utils2man.stamp \
+	api2man.stamp
 
 Makefile: $(srcdir)/Makefile.in
 	/bin/sh ./config.status
@@ -58,6 +60,7 @@ clean:
 	rm -f *.html *.html.gz
 	rm -Rf cygwin-api cygwin-ug cygwin-ug-net faq
 	rm -f *.1 utils2man.stamp
+	rm -f *.3 api2man.stamp
 
 install: install-all
 
@@ -75,9 +78,11 @@ install-html: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
 	$(INSTALL_DATA) cygwin-api/cygwin-api.html $(DESTDIR)$(htmldir)/cygwin-api/index.html
 
-install-man: utils2man.stamp
+install-man: utils2man.stamp api2man.stamp
 	@$(MKDIRP) $(DESTDIR)$(man1dir)
 	$(INSTALL_DATA) *.1 $(DESTDIR)$(man1dir)
+	@$(MKDIRP) $(DESTDIR)$(man1dir)
+	$(INSTALL_DATA) *.3 $(DESTDIR)$(man3dir)
 
 cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) html.xsl
 	-$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
@@ -102,6 +107,10 @@ cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) html.xsl
 cygwin-api/cygwin-api.pdf : $(cygwin-api_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
 
+api2man.stamp: $(cygwin-api_SOURCES)
+	$(XMLTO) man $<
+	@touch $@
+
 faq/faq.html : $(FAQ_SOURCES)
 	-$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
 	-sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
-- 
2.1.4
