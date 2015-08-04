Return-Path: <cygwin-patches-return-8232-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7582 invoked by alias); 4 Aug 2015 12:36:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 7570 invoked by uid 89); 4 Aug 2015 12:36:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=0.2 required=5.0 tests=AWL,BAYES_20,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2
X-HELO: rgout0502.bt.lon5.cpcloud.co.uk
Received: from rgout0502.bt.lon5.cpcloud.co.uk (HELO rgout0502.bt.lon5.cpcloud.co.uk) (65.20.0.223) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Aug 2015 12:36:52 +0000
X-OWM-Source-IP: 86.141.131.77(GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090205.55C0B1E1.00DD,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2015.7.22.174217:17:27.888,ip=86.141.131.77,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __HTTPS_URI, __URI_NO_WWW, __URI_NO_PATH, __URI_IN_BODY, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[77.131.141.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, RDNS_SUSP, BODY_SIZE_7000_LESS, SINGLE_URI_IN_BODY
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.131.77) by rgout05.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 55A2600D02776C82; Tue, 4 Aug 2015 13:36:46 +0100
From: Jon TURNEY <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon TURNEY <jon.turney@dronecode.org.uk>
Subject: [PATCH] Improve FAQ answer on debugging Cygwin
Date: Tue, 04 Aug 2015 12:36:00 -0000
Message-Id: <1438691794-7396-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2015-q3/txt/msg00014.txt.bz2

Improve FAQ answer on debugging Cygwin to mention the cygwin-debuginfo package
and the gdb command 'set cygwin-exceptions oon'.

2015-08-03  Jon Turney  <jon.turney@dronecode.org.uk>

	* faq-programming.xml: Improve debugging-cygwin answer.

Signed-off-by: Jon TURNEY <jon.turney@dronecode.org.uk>
---
 winsup/doc/ChangeLog           |  4 ++++
 winsup/doc/faq-programming.xml | 26 ++++++++++++++++++++++----
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/ChangeLog b/winsup/doc/ChangeLog
index e3eb26f..9cff0e4 100644
--- a/winsup/doc/ChangeLog
+++ b/winsup/doc/ChangeLog
@@ -1,3 +1,7 @@
+2015-08-03  Jon Turney  <jon.turney@dronecode.org.uk>
+
+	* faq-programming.xml: Improve debugging-cygwin answer.
+
 2015-07-21  Corinna Vinschen  <corinna@vinschen.de>
 
 	* new-features.xml (ov-new2.2): Document sigsetjmp, siglongjmp.
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 491da5d..0c936eb 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -747,14 +747,32 @@ same time. Remove all but one.
 <question><para>I may have found a bug in Cygwin, how can I debug it (the symbols in gdb look funny)?</para></question>
 <answer>
 
-<para>Debugging symbols are stripped from distibuted Cygwin binaries, so any
-symbols that you see in gdb are basically meaningless. It is also a good
+<para>Debugging symbols are stripped from distibuted Cygwin binaries, so to
+debug with <command>gdb</command> you will need to install the
+<package>cygwin-debuginfo</package> package to obtain the debug symbols for
+<filename>cygwin1.dll</filename>
+</para>
+
+<para>
+If your bug causes an exception inside <filename>cygwin1.dll</filename> you will
+need to use the <command>gdb</command> command <userinput>set cygwin-exceptions
+on</userinput> to tell <command>gdb</command> to stop on exceptions inside the
+Cygwin DLL (by default they are ignored, as they may be generated during normal
+operation e.g. when checking a pointer is valid)
+</para>
+
+<para>
+It is also a good
 idea to use the latest code in case the bug has been fixed, so we
 recommend trying the latest snapshot from
-<ulink url="https://cygwin.com/snapshots/"/> or building the DLL from GIT.
+<ulink url="https://cygwin.com/snapshots/"/> or building the DLL from git.
 </para>
+
 <para>To build a debugging version of the Cygwin DLL, you will need to follow
-the instructions at <ulink url="https://cygwin.com/faq/faq.html#faq.programming.building-cygwin"/>. 
+the instructions at <ulink url="https://cygwin.com/faq/faq.html#faq.programming.building-cygwin"/>.
+</para>
+
+<para>
 You can also contact the mailing list for pointers (a simple test case that 
 demonstrates the bug is always welcome).  
 </para>
-- 
2.4.5
