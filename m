Return-Path: <cygwin-patches-return-8205-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128191 invoked by alias); 22 Jun 2015 14:40:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128181 invoked by uid 89); 22 Jun 2015 14:40:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0207.bt.lon5.cpcloud.co.uk
Received: from rgout0207.bt.lon5.cpcloud.co.uk (HELO rgout0207.bt.lon5.cpcloud.co.uk) (65.20.0.206) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 14:40:41 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090203.55881E69.0010,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.153616:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1600_1699, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5581A14B00BE5D12; Mon, 22 Jun 2015 15:40:40 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 4/5] winsup/doc: Use xidepend to generate the source list for FAQ targets as well
Date: Mon, 22 Jun 2015 14:40:00 -0000
Message-Id: <1434983976-3612-5-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00106.txt.bz2

2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (FAQ_SOURCES): Remove and generate with xidepend.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   | 4 ++++
 winsup/doc/Makefile.in | 6 ++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index ca3bac6..77985b8 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,9 @@
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (FAQ_SOURCES): Remove and generate with xidepend.
+
+2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* utils.xml: Remove 'Usage' prefix from synopses.
 
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index e215580..7cdc72c 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -35,8 +35,6 @@ DOCBOOK2XTEXI:=docbook2x-texi --xinclude --info --utf8trans-map=charmap
 include $(srcdir)/../Makefile.common
 -include Makefile.dep
 
-FAQ_SOURCES:= $(wildcard $(srcdir)/faq*.xml)
-
 .SUFFIXES: .html .body
 
 .html.body:
@@ -137,9 +135,9 @@ intro2man.stamp: intro.xml man.xsl
 	@echo ".so intro.1" >cygwin.1
 	@touch $@
 
-faq/faq.html : $(FAQ_SOURCES)
+faq/faq.html : $(faq_SOURCES)
 	-$(XMLTO) html -o faq -m $(srcdir)/html.xsl $(srcdir)/faq.xml
 	-sed -i 's;<a name="id[mp][0-9]*"></a>;;g' faq/faq.html
 
-Makefile.dep: cygwin-ug-net.xml cygwin-api.xml
+Makefile.dep: cygwin-ug-net.xml cygwin-api.xml faq.xml
 	cd $(srcdir) && ./xidepend $^ > "${CURDIR}/$@"
-- 
2.1.4
