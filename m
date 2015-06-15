Return-Path: <cygwin-patches-return-8158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 113733 invoked by alias); 15 Jun 2015 12:37:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 113625 invoked by uid 89); 15 Jun 2015 12:37:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:37:12 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.557EC6F6.0094,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_4000_4999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF6000504D3; Mon, 15 Jun 2015 13:37:10 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 6/8] winsup/doc: Make it easier to extend xidepend to more targets
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-7-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00059.txt.bz2

Change xidepend to create a variable containing all the XIncluded sources, which
can be used as a dependency, rather than writing the dependency target itself.

Future work: Makefile.dep should depend on xidepend, but xidepend should not be
passed to itself.

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* xidepend: Write a Makefile fragment defining variables
	containing all the XIncluded sources, rather than a dependency on
	those sources.
	* Makefile.in: Use that variable to express the dependency.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |  7 +++++++
 winsup/doc/Makefile.in | 15 +++++++--------
 winsup/doc/xidepend    |  2 +-
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 7b15a5d..7d33752 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,12 @@
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* xidepend: Write a Makefile fragment defining variables
+	containing all the XIncluded sources, rather than a dependency on
+	those sources.
+	* Makefile.in: Use that variable to express the dependency.
+
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (XMLTO): Switch from dblatex to fop.
 	* utils.xml : Convert from using a sect2 to using a refentry for
 	each utility program.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index bcc32e4..79a050a 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -28,6 +28,7 @@ CC_FOR_TARGET:=@CC@
 XMLTO:=xmlto --skip-validation --with-fop
 
 include $(srcdir)/../Makefile.common
+-include Makefile.dep
 
 FAQ_SOURCES:= $(wildcard $(srcdir)/faq*.xml)
 
@@ -61,7 +62,7 @@ install-all: install-pdf install-html
 install-pdf: cygwin-ug-net/cygwin-ug-net.pdf cygwin-api/cygwin-api.pdf
 	@$(MKDIRP) $(DESTDIR)$(docdir)
 	$(INSTALL_DATA) $^ $(DESTDIR)$(docdir)
-	
+
 install-html: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	@$(MKDIRP) $(DESTDIR)$(htmldir)/cygwin-ug-net
 	$(INSTALL_DATA) cygwin-ug-net/*.html $(DESTDIR)$(htmldir)/cygwin-ug-net
@@ -70,22 +71,22 @@ install-html: cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
 	$(INSTALL_DATA) cygwin-api/*.html $(DESTDIR)$(htmldir)/cygwin-api
 	$(INSTALL_DATA) cygwin-api/cygwin-api.html $(DESTDIR)$(htmldir)/cygwin-api/index.html
 
-cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : cygwin-ug-net.xml
+cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) cygwin.xsl
 	-$(XMLTO) html-nochunks -m $(srcdir)/cygwin.xsl $<
 	-cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
 	-rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
 	-gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
 
-cygwin-ug-net/cygwin-ug-net.html : cygwin-ug-net.xml cygwin.xsl
+cygwin-ug-net/cygwin-ug-net.html : $(cygwin-ug-net_SOURCES) cygwin.xsl
 	-$(XMLTO) html -o cygwin-ug-net/ -m $(srcdir)/cygwin.xsl $<
 
-cygwin-ug-net/cygwin-ug-net.pdf : cygwin-ug-net.xml fo.xsl
+cygwin-ug-net/cygwin-ug-net.pdf : $(cygwin-ug-net_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-ug-net/ -m $(srcdir)/fo.xsl $<
 
-cygwin-api/cygwin-api.html : cygwin-api.xml cygwin.xsl
+cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) cygwin.xsl
 	-$(XMLTO) html -o cygwin-api/ -m $(srcdir)/cygwin.xsl $<
 
-cygwin-api/cygwin-api.pdf : cygwin-api.xml fo.xsl
+cygwin-api/cygwin-api.pdf : $(cygwin-api_SOURCES) fo.xsl
 	-$(XMLTO) pdf -o cygwin-api/ -m $(srcdir)/fo.xsl $<
 
 faq/faq.html : $(FAQ_SOURCES)
@@ -94,5 +95,3 @@ faq/faq.html : $(FAQ_SOURCES)
 
 Makefile.dep: cygwin-ug-net.xml cygwin-api.xml
 	cd $(srcdir) && ./xidepend $^ > "${CURDIR}/$@"
-
--include Makefile.dep
diff --git a/winsup/doc/xidepend b/winsup/doc/xidepend
index f476620..cc04f4a 100755
--- a/winsup/doc/xidepend
+++ b/winsup/doc/xidepend
@@ -16,7 +16,7 @@ do
 	then
 		# This file uses XIncludes.  Let's chase its deps recursively.
 		base=`basename "$f" .xml`
-		if [ $subproc -eq 0 ] ; then echo -n "$base/$base.html $base/$base.pdf:" ; fi
+		if [ $subproc -eq 0 ] ; then echo -n "${base}_SOURCES=${f}" ; fi
 
 		deps=`grep 'xi:include.*href' "$f" | cut -f2 -d\" | tr '\n' ' '`
 		echo -n " $deps"
-- 
2.1.4
