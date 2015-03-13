Return-Path: <cygwin-patches-return-8072-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46843 invoked by alias); 13 Mar 2015 14:26:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 46829 invoked by uid 89); 13 Mar 2015 14:26:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.1 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout0405.bt.lon5.cpcloud.co.uk
Received: from rgout0405.bt.lon5.cpcloud.co.uk (HELO rgout0405.bt.lon5.cpcloud.co.uk) (65.20.0.218) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 13 Mar 2015 14:26:03 +0000
X-OWM-Source-IP: 31.51.206.246(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.5502F378.01A9,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.12.95719:17:27.888,ip=31.51.206.246,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1000_1099, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[246.206.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.206.246) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5500B5D60034E7E5; Fri, 13 Mar 2015 14:25:47 +0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Fix winsup/doc to install into prefix
Date: Fri, 13 Mar 2015 14:26:00 -0000
Message-Id: <1426256744-4184-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00027.txt.bz2

By default, docdir and htmldir are defined in terms of prefix, so make sure to
define it, so their values are prefix-relative.

Without this, 'make install' installs the documentation into /share/doc/ unless
configured otherwise.

	* Makefile.in (prefix): Define.
---
 winsup/doc/ChangeLog   | 4 ++++
 winsup/doc/Makefile.in | 1 +
 2 files changed, 5 insertions(+)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index aefb41e..814e651 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,7 @@
+2015-03-13  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
+	* Makefile.in (prefix): Define.
+
 2015-03-12  Corinna Vinschen  <corinna@vinschen.de>
 
 	* ntsec.xml (ntsec-mapping-nsswitch-desc): Fix typo.
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index 55fd850..5b2f0ed 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -12,6 +12,7 @@ SHELL = @SHELL@
 srcdir = @srcdir@
 VPATH = @srcdir@
 
+prefix:=@prefix@
 datarootdir:=@datarootdir@
 docdir = @docdir@
 htmldir = @htmldir@
-- 
2.1.4
