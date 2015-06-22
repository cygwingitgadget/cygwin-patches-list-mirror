Return-Path: <cygwin-patches-return-8202-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 125299 invoked by alias); 22 Jun 2015 14:40:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125289 invoked by uid 89); 22 Jun 2015 14:40:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout02.bt.lon5.cpcloud.co.uk
Received: from rgout02.bt.lon5.cpcloud.co.uk (HELO rgout02.bt.lon5.cpcloud.co.uk) (65.20.0.179) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 14:40:11 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.55881E48.0068,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.153616:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, INFO_TLD, __MAL_TELEKOM_URI, __CP_URI_IN_BODY, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, __URI_NS_NXDOMAIN, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, RDNS_SUSP, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5581A14B00BE5819; Mon, 22 Jun 2015 15:40:07 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/5] winsup/doc: Create info pages from cygwin documentation
Date: Mon, 22 Jun 2015 14:40:00 -0000
Message-Id: <1434983976-3612-2-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00103.txt.bz2

v2:
Updated to use docbook2x-texi not docbook2texi, since source is now docbook XML.
Tweak DocBook XML so info directory entry has a description.

v3:
Use a custom charmap to handle &reg;

v4:
Proper build avoidance
texinfo node references may not contain ':', so provide alternate text for a few
xref targets

2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (install-info, cygwin-ug-net.info)
	(cygwin-api.info): Add.
	* cygwin-ug-net.xml: Add texinfo-node.
	* cygwin-api.xml: Ditto.
	* ntsec.xml (db_home): Add texinfo-node for titles containing a
	':' which are the targets of an xref.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog         |  9 +++++++++
 winsup/doc/Makefile.in       | 26 +++++++++++++++++++++++---
 winsup/doc/cygwin-api.xml    |  3 +++
 winsup/doc/cygwin-ug-net.xml |  3 +++
 winsup/doc/ntsec.xml         | 18 +++++++++++++++---
 5 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 23bd06c..0a23870 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,12 @@
+2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* Makefile.in (install-info, cygwin-ug-net.info)
+	(cygwin-api.info): Add.
+	* cygwin-ug-net.xml: Add texinfo-node.
+	* cygwin-api.xml: Ditto.
+	* ntsec.xml (db_home): Add texinfo-node for titles containing a
+	':' which are the targets of an xref.
+
 2015-06-20  Corinna Vinschen  <corinna@vinschen.de>
 
 	* new-features.xml (ov-new2.1): Add alterante signal stack info.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 0205e67..9f6774b 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -19,6 +19,7 @@ htmldir = @htmldir@
 mandir = @mandir@
 man1dir = $(mandir)/man1
 man3dir = $(mandir)/man3
+infodir:=@infodir@
 
 override INSTALL:=@INSTALL@
 override INSTALL_DATA:=@INSTALL_DATA@
@@ -29,6 +30,7 @@ CC:=@CC@
 CC_FOR_TARGET:=@CC@
 
 XMLTO:=xmlto --skip-validation --with-dblatex
+DOCBOOK2XTEXI:=docbook2x-texi --xinclude --info --utf8trans-map=charmap
 
 include $(srcdir)/../Makefile.common
 -include Makefile.dep
@@ -40,7 +42,8 @@ FAQ_SOURCES:= $(wildcard $(srcdir)/faq*.xml)
 .html.body:
 	$(srcdir)/bodysnatcher.pl $<
 
-.PHONY: all clean install install-all install-pdf install-html install-man
+.PHONY: all clean install install-all install-pdf install-html install-man \
+	info install-info
 
 all: Makefile Makefile.dep \
 	cygwin-ug-net/cygwin-ug-net.html \
@@ -50,7 +53,8 @@ all: Makefile Makefile.dep \
 	cygwin-ug-net/cygwin-ug-net.pdf \
 	cygwin-api/cygwin-api.pdf \
 	utils2man.stamp \
-	api2man.stamp
+	api2man.stamp \
+	cygwin-ug-net.info cygwin-api.info
 
 Makefile: $(srcdir)/Makefile.in
 	/bin/sh ./config.status
@@ -61,10 +65,11 @@ clean:
 	rm -Rf cygwin-api cygwin-ug cygwin-ug-net faq
 	rm -f *.1 utils2man.stamp
 	rm -f *.3 api2man.stamp
+	rm -f *.info* charmap
 
 install: install-all
 
-install-all: install-pdf install-html install-man
+install-all: install-pdf install-html install-man install-info
 
 install-pdf: cygwin-ug-net/cygwin-ug-net.pdf cygwin-api/cygwin-api.pdf
 	@$(MKDIRP) $(DESTDIR)$(docdir)
@@ -84,6 +89,10 @@ install-man: utils2man.stamp api2man.stamp
 	@$(MKDIRP) $(DESTDIR)$(man3dir)
 	$(INSTALL_DATA) *.3 $(DESTDIR)$(man3dir)
 
+install-info: cygwin-ug-net.info cygwin-api.info
+	$(MKDIRP) $(DESTDIR)$(infodir)
+	$(INSTALL_DATA) *.info* $(DESTDIR)$(infodir)
+
 cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) html.xsl
 	-$(XMLTO) html-nochunks -m $(srcdir)/html.xsl $<
 	-@$(MKDIRP) cygwin-ug-net
@@ -101,6 +110,9 @@ utils2man.stamp: $(cygwin-ug-net_SOURCES) man.xsl
 	$(XMLTO) man -m ${srcdir}/man.xsl $<
 	@touch $@
 
+cygwin-ug-net.info: $(cygwin-ug-net_SOURCES) charmap
+	-$(DOCBOOK2XTEXI) $(srcdir)/cygwin-ug-net.xml --string-param output-file=cygwin-ug-net
+
 cygwin-api/cygwin-api.html : $(cygwin-api_SOURCES) html.xsl
 	-$(XMLTO) html -o cygwin-api/ -m $(srcdir)/html.xsl $<
 
@@ -111,6 +123,14 @@ api2man.stamp: $(cygwin-api_SOURCES) man.xsl
 	$(XMLTO) man -m ${srcdir}/man.xsl $<
 	@touch $@
 
+cygwin-api.info: $(cygwin-api_SOURCES) charmap
+	-$(DOCBOOK2XTEXI) $(srcdir)/cygwin-api.xml --string-param output-file=cygwin-api
+
+# this generates a custom charmap for docbook2x-texi which has a mapping for &reg;
+charmap:
+	cp /usr/share/docbook2X/charmaps/texi.charmap charmap
+	echo "ae (R)" >>charmap
+
 faq/faq.html : $(FAQ_SOURCES)
 	-$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
 	-sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
diff --git a/winsup/doc/cygwin-api.xml b/winsup/doc/cygwin-api.xml
index 7b831d9..267c2cb 100644
--- a/winsup/doc/cygwin-api.xml
+++ b/winsup/doc/cygwin-api.xml
@@ -6,6 +6,9 @@
 
   <bookinfo>
     <title>Cygwin API Reference</title>
+    <abstract role="texinfo-node">
+      <para>Cygwin API Reference</para>
+    </abstract>
       <xi:include href="legal.xml"/>
   </bookinfo>
 
diff --git a/winsup/doc/cygwin-ug-net.xml b/winsup/doc/cygwin-ug-net.xml
index f8b40e6..b6a9eef 100644
--- a/winsup/doc/cygwin-ug-net.xml
+++ b/winsup/doc/cygwin-ug-net.xml
@@ -5,6 +5,9 @@
 <book id="cygwin-ug-net" xmlns:xi="http://www.w3.org/2001/XInclude">
   <bookinfo>
     <title>Cygwin User's Guide</title>
+    <abstract role="texinfo-node">
+      <para>Cygwin User's Guide</para>
+    </abstract>
 		<xi:include href="legal.xml"/>
   </bookinfo>
 
diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
index d982867..ae0a119 100644
--- a/winsup/doc/ntsec.xml
+++ b/winsup/doc/ntsec.xml
@@ -1431,7 +1431,11 @@ following sections explain the settings in detail.
 
 </sect4>
 
-<sect4 id="ntsec-mapping-nsswitch-home"><title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home:</literal> setting</title>
+<sect4 id="ntsec-mapping-nsswitch-home">
+  <sectioninfo>
+    <title role="texinfo-node">The <literal>db_home</literal> setting</title>
+  </sectioninfo>
+    <title id="ntsec-mapping-nsswitch-home.title">The <literal>db_home:</literal> setting</title>
 
 <para>
 The <literal>db_home:</literal> setting defines how Cygwin fetches the user's
@@ -1518,7 +1522,11 @@ So by default, Cygwin just sets the home dir to
 
 </sect4>
 
-<sect4 id="ntsec-mapping-nsswitch-shell"><title id="ntsec-mapping-nsswitch-shell.title">The <literal>db_shell:</literal> setting</title>
+<sect4 id="ntsec-mapping-nsswitch-shell">
+  <sectioninfo>
+    <title role="texinfo-node">The <literal>db_shell</literal> setting</title>
+  </sectioninfo>
+  <title id="ntsec-mapping-nsswitch-shell.title">The <literal>db_shell:</literal> setting</title>
 
 <para>
 The <literal>db_shell:</literal> setting defines how Cygwin fetches the user's
@@ -1593,7 +1601,11 @@ As for <literal>db_home:</literal>, the default setting for
 
 </sect4>
 
-<sect4 id="ntsec-mapping-nsswitch-gecos"><title id="ntsec-mapping-nsswitch-gecos.title">The <literal>db_gecos:</literal> setting</title>
+<sect4 id="ntsec-mapping-nsswitch-gecos">
+  <sectioninfo>
+    <title role="texinfo-node">The <literal>db_gecos</literal> setting</title>
+  </sectioninfo>
+  <title id="ntsec-mapping-nsswitch-gecos.title">The <literal>db_gecos:</literal> setting</title>
 
 <para>
 The <literal>db_gecos:</literal> setting defines how to fetch additional
-- 
2.1.4
