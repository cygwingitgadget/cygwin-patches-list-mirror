Return-Path: <cygwin-patches-return-8206-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128661 invoked by alias); 22 Jun 2015 14:40:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 128645 invoked by uid 89); 22 Jun 2015 14:40:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0204.bt.lon5.cpcloud.co.uk
Received: from rgout0204.bt.lon5.cpcloud.co.uk (HELO rgout0204.bt.lon5.cpcloud.co.uk) (65.20.0.203) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jun 2015 14:40:49 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.55881E6F.003A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.17.153616:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, URI_ENDS_IN_HTML, __URI_NO_WWW, __URI_NO_PATH, __LINES_OF_YELLING, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1800_1899, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5581A14B00BE5DF6; Mon, 22 Jun 2015 15:40:46 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 5/5] winsup/doc: Update ancient README about building documentation
Date: Mon, 22 Jun 2015 14:40:00 -0000
Message-Id: <1434983976-3612-6-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434983976-3612-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00107.txt.bz2

Update list of pre-requisites, everything else is obsolete.

Future work: Ensure that the list of pre-requisites in FAQ 6.21 "How do I build
Cygwin" remains synchronized with this list.

2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>

	* README: Update.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog |  4 ++++
 winsup/doc/README    | 23 ++---------------------
 2 files changed, 6 insertions(+), 21 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 77985b8..841bbe2 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,9 @@
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* README: Update.
+
+2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (FAQ_SOURCES): Remove and generate with xidepend.
 
 2015-06-22  Jon Turney  <jon.turney@dronecode.org.uk>
diff --git a/winsup/doc/README b/winsup/doc/README
index fe1adbd..24970f8 100644
--- a/winsup/doc/README
+++ b/winsup/doc/README
@@ -1,28 +1,9 @@
-The cygwin-doc source files are kept in CVS. Please see
-https://cygwin.com/cvs.html for more information.
+ADDITIONAL BUILD REQUIREMENTS FOR DOCUMENTATION
 
-BUILD REQUIREMENTS:
-
-bash
-bzip2
-coreutils
-cygwin
 dblatex
 docbook-xml45
 docbook-xsl
+docbook2x-texi
 gzip
-make
 texinfo
-perl
 xmlto
-
-OTHER NOTES:
-
-You may use docbook2X to convert the DocBook files into info pages.
-I have not been able to get a working docbook2X installation on Cygwin,
-so currently I convert the files on a machine running GNU/Linux.
-
-A few handmade files (cygwin.texi, intro.3, etc.) are found in the
-cygwin-doc-x.y-z-src.tar.bz2 package. It also contains the utilities for
-building the cygwin-doc-x.y-z "binary" package--simply run each step in
-the cygwin-doc-x.y-z.sh script.
-- 
2.1.4
