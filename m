Return-Path: <cygwin-patches-return-8153-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 111954 invoked by alias); 15 Jun 2015 12:37:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 111916 invoked by uid 89); 15 Jun 2015 12:37:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.1 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:36:58 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.557EC6E6.004C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, __STOCK_PHRASE_25, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1200_1299, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF600050220; Mon, 15 Jun 2015 13:36:54 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/8] winsup/doc: Remove tarball target from .PHONY
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-2-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00054.txt.bz2

Left over after 4885352e.

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (.PHONY): Remove tarball target.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   | 4 ++++
 winsup/doc/Makefile.in | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 05d78a8..aa45e3d 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,7 @@
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* Makefile.in (.PHONY): Remove tarball target.
+
 2015-06-04  Jon Turney  <jon.turney@dronecode.org.uk>
 
 	* Makefile.in: Remove ancient unused rules to make a documentation
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 396d9bc..a97545c 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -36,7 +36,7 @@ FAQ_SOURCES:= $(wildcard $(srcdir)/faq*.xml)
 .html.body:
 	$(srcdir)/bodysnatcher.pl $<
 
-.PHONY: all clean install install-all install-pdf install-html tarball
+.PHONY: all clean install install-all install-pdf install-html
 
 all: Makefile Makefile.dep \
 	cygwin-ug-net/cygwin-ug-net.html \
-- 
2.1.4
