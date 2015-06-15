Return-Path: <cygwin-patches-return-8159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 114677 invoked by alias); 15 Jun 2015 12:37:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 114444 invoked by uid 89); 15 Jun 2015 12:37:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.4 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 12:37:19 +0000
X-OWM-Source-IP: 86.141.128.210(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090202.557EC6FE.001F,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.6.15.101816:17:27.888,ip=86.141.128.210,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1600_1699, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[210.128.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, REFERENCES
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.128.210) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 557EACF600050609; Mon, 15 Jun 2015 13:37:17 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH 8/8] winsup/doc: Fix an issue with parallel make
Date: Mon, 15 Jun 2015 12:37:00 -0000
Message-Id: <1434371793-3980-9-git-send-email-jon.turney@dronecode.org.uk>
In-Reply-To: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q2/txt/msg00060.txt.bz2

The cygwin-ug-net-nochunks.html.gz target does not ensure that the
cygwin-ug-net/ directory exists, so it can fail if run on it's own, or if the
cygwin-ug-net/cygwin-ug-net.html target has not yet created it in a parallel
make.

2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>

	* Makefile.in (cygwin-ug-net/cygwin-ug-net-nochunks.html.gz):
	Ensure cygwin-ug-net directory exists.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog   | 5 +++++
 winsup/doc/Makefile.in | 1 +
 2 files changed, 6 insertions(+)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 341374f..ae78313 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,5 +1,10 @@
 2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
 
+	* Makefile.in (cygwin-ug-net/cygwin-ug-net-nochunks.html.gz):
+	Ensure cygwin-ug-net directory exists.
+
+2015-06-12  Jon Turney  <jon.turney@dronecode.org.uk>
+
 	* Makefile.in (install-man, utils2man.stamp): Add rules to build
 	and install manpages for utils.
 
diff --git a/winsup/doc/Makefile.in b/winsup/doc/Makefile.in
index bb2ad36..899c407 100644
--- a/winsup/doc/Makefile.in
+++ b/winsup/doc/Makefile.in
@@ -81,6 +81,7 @@ install-man: utils2man.stamp
 
 cygwin-ug-net/cygwin-ug-net-nochunks.html.gz : $(cygwin-ug-net_SOURCES) cygwin.xsl
 	-$(XMLTO) html-nochunks -m $(srcdir)/cygwin.xsl $<
+	-@$(MKDIRP) cygwin-ug-net
 	-cp cygwin-ug-net.html cygwin-ug-net/cygwin-ug-net-nochunks.html
 	-rm -f cygwin-ug-net/cygwin-ug-net-nochunks.html.gz
 	-gzip cygwin-ug-net/cygwin-ug-net-nochunks.html
-- 
2.1.4
