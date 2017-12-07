Return-Path: <cygwin-patches-return-8960-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17974 invoked by alias); 7 Dec 2017 12:16:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 17964 invoked by uid 89); 7 Dec 2017 12:16:58 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=emphasis, para, HTo:U*cygwin-patches
X-HELO: rgout0806.bt.lon5.cpcloud.co.uk
Received: from rgout0806.bt.lon5.cpcloud.co.uk (HELO rgout0806.bt.lon5.cpcloud.co.uk) (65.20.0.153) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 07 Dec 2017 12:16:48 +0000
X-OWM-Source-IP: 86.179.113.49 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2017.12.7.115716:17:7.944,ip=,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __URI_NO_WWW, __CP_URI_IN_BODY, __URI_IN_BODY, __URI_NOT_IMG, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_P1, __MIME_TEXT_ONLY, __URI_NS, HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, __FROM_DOMAIN_IN_RCPT, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, __MIME_TEXT_P, BODY_SIZE_7000_LESS, URI_WITH_PATH_ONLY
Received: from localhost.localdomain (86.179.113.49) by rgout08.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 5A1377BF018EC9E8; Thu, 7 Dec 2017 12:16:45 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] cygwin: Improve discussion of linker library ordering in faq-programming
Date: Thu, 07 Dec 2017 12:16:00 -0000
Message-Id: <20171207121634.13836-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q4/txt/msg00090.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-programming.xml | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index c0ddd7902..65bfed97e 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -876,10 +876,45 @@ example, single-stepping from these signals may not work as expected.
 <para>A common error is to put the library on the command line before
 the thing that needs things from it.
 </para>
+
 <para>This is wrong <literal>gcc -lstdc++ hello.cc</literal>.
 This is right <literal>gcc hello.cc -lstdc++</literal>.
 </para>
-</answer></qandaentry>
+
+<para>
+  The first command above (usually) works on Linux, because:
+  <itemizedlist mark="bullet">
+    <listitem>A DT_NEEDED tag for libstdc++ is added when the library name is seen.</listitem>
+    <listitem>The executable has unresolved symbols, which can be found in libstdc++.</listitem>
+    <listitem>When executed, the ELF loader resolves those symbols.</listitem>
+  </itemizedlist>
+</para>
+
+<para>
+  Note that this won't work if the linker flags <literal>--as-needed</literal>
+  or <literal>--no-undefined</literal> are used, or if the library being linked
+  with is a static library.
+</para>
+
+<para>
+  PE/COFF executables work very differently, and the dynamic library which
+  provides a symbol must be fully resolved <emphasis>at link time</emphasis>
+  (so the library which provides a symbol must follow a reference to it).
+</para>
+
+<para>
+  See point 3 in <xref linkend="faq.programming.unix-gui"></xref> for more
+  discussion of how this affects plugins.
+</para>
+
+<para>
+  This also has consequences for how weak symbols are resolved. See <ulink
+  url="https://cygwin.com/ml/cygwin/2010-04/msg00281.html"></ulink> for more
+  discussion of that.
+</para>
+
+</answer>
+</qandaentry>
 
 <qandaentry id="faq.programming.stat64">
 <question><para>Why do I get an error using <literal>struct stat64</literal>?</para></question>
-- 
2.15.1
