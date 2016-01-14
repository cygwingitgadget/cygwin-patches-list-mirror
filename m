Return-Path: <cygwin-patches-return-8294-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75469 invoked by alias); 14 Jan 2016 18:05:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75457 invoked by uid 89); 14 Jan 2016 18:05:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.2 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=purely, jon.turney@dronecode.org.uk, jonturneydronecodeorguk, Guide
X-HELO: rgout0304.bt.lon5.cpcloud.co.uk
Received: from rgout0304.bt.lon5.cpcloud.co.uk (HELO rgout0304.bt.lon5.cpcloud.co.uk) (65.20.0.210) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 14 Jan 2016 18:05:47 +0000
X-OWM-Source-IP: 86.141.131.231 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090204.5697E378.009E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.1.13.105717:17:27.888,ip=86.141.131.231,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __HAS_HTML, HTML_NO_HTTP, BODY_SIZE_1500_1599, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, SXL_IP_DYNAMIC[231.131.141.86.fur], BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, BODY_SIZE_2000_LESS, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_FOUND, NO_URI_HTTPS, NO_CTA_URI_FOUND
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.141.131.231) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 568E39A300D9A49D; Thu, 14 Jan 2016 18:05:44 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update FAQ question and answer about gdb and signals
Date: Thu, 14 Jan 2016 18:05:00 -0000
Message-Id: <1452794719-6124-1-git-send-email-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q1/txt/msg00000.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-programming.xml | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index af6102a..7f1ffd9 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -859,15 +859,22 @@ on using <literal>strace</literal>, see the Cygwin User's Guide.
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.gdb-signals">
-<question><para>Why doesn't gdb handle signals?</para></question>
+<question><para>How does gdb handle signals?</para></question>
 <answer>
 
-<para>Unfortunately, there is only minimal signal handling support in gdb
-currently.  Signal handling only works with Windows-type signals.
-SIGINT may work, SIGFPE may work, SIGSEGV definitely does.  You cannot
-'stop', 'print' or 'nopass' signals like SIGUSR1 or SIGHUP to the
-process being debugged.
+<para>
+gdb maps known Windows exceptions to signals such as SIGSEGV, SIGFPE, SIGTRAP,
+SIGINT and SIGILL.  Other Windows exceptions are passed on to the handler (if
+any), and reported as an unknown signal if an unhandled (second chance)
+exception occurs.
 </para>
+
+<para>
+There is also an experimental feature to notify gdb of purely Cygwin signals
+like SIGABRT, SIGHUP or SIGUSR1.  This currently has some known problems, for
+example, single-stepping from these signals may not work as expected.
+</para>
+
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.linker">
-- 
2.6.2
