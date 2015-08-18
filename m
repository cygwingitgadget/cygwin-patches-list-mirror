Return-Path: <cygwin-patches-return-8240-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95510 invoked by alias); 18 Aug 2015 16:25:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95337 invoked by uid 89); 18 Aug 2015 16:25:41 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout06.bt.lon5.cpcloud.co.uk
Received: from rgout06.bt.lon5.cpcloud.co.uk (HELO rgout06.bt.lon5.cpcloud.co.uk) (65.20.0.183) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 18 Aug 2015 16:25:39 +0000
X-OWM-Source-IP: 86.179.113.234 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090202.55D35C81.0064,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.7.31.111516:17:27.888,ip=86.179.113.234,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __MAL_TELEKOM_URI, __URI_NO_WWW, __CP_URI_IN_BODY, __URI_IN_BODY, BODY_SIZE_1500_1599, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[234.113.179.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS, SINGLE_URI_IN_BODY
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.179.113.234) by rgout06.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55B9007602364818; Tue, 18 Aug 2015 17:25:37 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Add Lavasoft Web Companion to BLODA list.
Date: Tue, 18 Aug 2015 16:25:00 -0000
Message-Id: <1439915118-5692-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q3/txt/msg00022.txt.bz2

2015-08-18  Jon Turney  <jon.turney@dronecode.org.uk>

	* faq-using.xml (faq.using.bloda): Add Lavasoft Web Companion to
	BLODA list.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog     | 5 +++++
 winsup/doc/faq-using.xml | 1 +
 2 files changed, 6 insertions(+)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 9cff0e4..02061ff 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,8 @@
+2015-08-18  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* faq-using.xml (faq.using.bloda): Add Lavasoft Web Companion to
+	BLODA list.
+
 2015-08-03  Jon Turney  <jon.turney@dronecode.org.uk>
 
 	* faq-programming.xml: Improve debugging-cygwin answer.
diff --git a/winsup/doc/faq-using.xml b/winsup/doc/faq-using.xml
index 372888f..87ec112 100644
--- a/winsup/doc/faq-using.xml
+++ b/winsup/doc/faq-using.xml
@@ -1274,6 +1274,7 @@ behaviour which affect the operation of other programs, such as Cygwin.
 <listitem><para>Credant Guardian Shield</para></listitem>
 <listitem><para>AVAST (disable FILESYSTEM and BEHAVIOR realtime shields)</para></listitem>
 <listitem><para>Citrix Metaframe Presentation Server/XenApp (see <ulink url="http://support.citrix.com/article/CTX107825">Citrix Support page</ulink>)</para></listitem>
+<listitem><para>Lavasoft Web Companion</para></listitem>
 </itemizedlist></para>
 <para>Sometimes these problems can be worked around, by temporarily or partially
 disabling the offending software.  For instance, it may be possible to disable
-- 
2.4.5
