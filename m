Return-Path: <cygwin-patches-return-8090-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 58181 invoked by alias); 31 Mar 2015 17:50:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 58170 invoked by uid 89); 31 Mar 2015 17:50:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2
X-HELO: rgout0203.bt.lon5.cpcloud.co.uk
Received: from rgout0203.bt.lon5.cpcloud.co.uk (HELO rgout0203.bt.lon5.cpcloud.co.uk) (65.20.0.202) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 31 Mar 2015 17:50:43 +0000
X-OWM-Source-IP: 31.51.205.126(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.551ADE70.02EB,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.3.23.150922:17:27.888,ip=31.51.205.126,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, __URI_NO_PATH, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1000_1099, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[126.205.51.31.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_2000_LESS, BODY_SIZE_7000_LESS
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (31.51.205.126) by rgout02.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 550C0835016AC51D; Tue, 31 Mar 2015 18:50:40 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Fix documentation of cygwin_internal()'s return type.
Date: Tue, 31 Mar 2015 17:50:00 -0000
Message-Id: <1427824229-13744-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q1/txt/msg00045.txt.bz2

	* misc-funcs.xml (cygwin_internal): Correct return type.
---
 winsup/doc/ChangeLog      | 4 ++++
 winsup/doc/misc-funcs.xml | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index 814e651..b04210f 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,7 @@
+2015-03-31  Jon TURNEY  <jon.turney@dronecode.org.uk>
+
+	* misc-funcs.xml (cygwin_internal): Correct return type.
+
 2015-03-13  Jon TURNEY  <jon.turney@dronecode.org.uk>
 
 	* Makefile.in (prefix): Define.
diff --git a/winsup/doc/misc-funcs.xml b/winsup/doc/misc-funcs.xml
index 06776d9..b164341 100644
--- a/winsup/doc/misc-funcs.xml
+++ b/winsup/doc/misc-funcs.xml
@@ -34,7 +34,7 @@ much.</para>
 <title>cygwin_internal</title>
 
 <funcsynopsis><funcprototype>
-<funcdef>extern "C" DWORD
+<funcdef>extern "C" uintptr_t
 <function>cygwin_internal</function></funcdef>
 <paramdef>cygwin_getinfo_types <parameter>t</parameter></paramdef>
 <paramdef><parameter>...</parameter></paramdef>
-- 
2.1.4
