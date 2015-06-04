Return-Path: <cygwin-patches-return-8143-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 108881 invoked by alias); 4 Jun 2015 19:55:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108856 invoked by uid 89); 4 Jun 2015 19:55:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0506.bt.lon5.cpcloud.co.uk
Received: from rgout0506.bt.lon5.cpcloud.co.uk (HELO rgout0506.bt.lon5.cpcloud.co.uk) (65.20.0.227) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 04 Jun 2015 19:55:54 +0000
X-OWM-Source-IP: 31.51.205.195(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.5570AD47.0036,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.4.142115:17:27.888,ip=31.51.205.195,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODY_SIZE_1900_1999, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[195.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.195) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55702DEA001E1DFF; Thu, 4 Jun 2015 20:55:43 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] winsup/doc: Remove ancient unused Makefile rules to make documentation tarball
Date: Thu, 04 Jun 2015 19:55:00 -0000
Message-Id: <1433447744-17688-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00044.txt.bz2

This used to be used by cygwin-doc to make a tarball which would be used with a
ssh script to run docbook tools on a linux host since they weren't available on
Cygwin or something crazy like that...

2015-06-04  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in: Remove ancient unused rules to make a documentation
	tarball.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   |  5 +++++
 winsup/doc/Makefile.in | 11 -----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 0c961fa..05d78a8 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,8 @@
+2015-06-04  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* Makefile.in: Remove ancient unused rules to make a documentation
+	tarball.
+
 2015-06-01  Jon Turney  <jon.turney@dronecode.org.uk>
 
 	* ov-ex-unix.xml: Remove unhelpful mention of and inaccurate size
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 8bf86f7..396d9bc 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -92,17 +92,6 @@ faq/faq.html : $(FAQ_SOURCES)
 	-$(XMLTO) html -o faq -m $(srcdir)/cygwin.xsl $(srcdir)/faq.xml
 	-sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
 
-TBFILES = cygwin-ug-net.dvi cygwin-ug-net.rtf cygwin-ug-net.ps \
-	  cygwin-ug-net.pdf cygwin-ug-net.xml \
-	  cygwin-api.dvi cygwin-api.rtf cygwin-api.ps \
-	  cygwin-api.pdf cygwin-api.xml
-TBDIRS = cygwin-ug-net cygwin-api
-TBDEPS = cygwin-ug-net/cygwin-ug-net.html cygwin-api/cygwin-api.html
-
-tarball : cygwin-docs.tar.bz2
-cygwin-docs.tar.bz2 : $(TBFILES) $(TBDEPS)
-	find $(TBFILES) $(TBDIRS) \! -type d | sort | tar -T - -cf -  | bzip2 > cygwin-docs.tar.bz2
-
 Makefile.dep: cygwin-ug-net.xml cygwin-api.xml
 	cd $(srcdir) && ./xidepend $^ > "${CURDIR}/$@"
 
-- 
2.1.4
