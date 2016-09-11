Return-Path: <cygwin-patches-return-8641-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82833 invoked by alias); 11 Sep 2016 15:00:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82784 invoked by uid 89); 11 Sep 2016 15:00:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=D*org.uk, sk:jontur, sk:jon.tur, jon.turney@dronecode.org.uk
X-HELO: rgout0303.bt.lon5.cpcloud.co.uk
Received: from rgout0303.bt.lon5.cpcloud.co.uk (HELO rgout0303.bt.lon5.cpcloud.co.uk) (65.20.0.209) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 11 Sep 2016 15:00:30 +0000
X-OWM-Source-IP: 86.141.129.68 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2016.9.11.120016:17:7.586,ip=86.141.129.68,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __URI_IN_BODY, __HAS_HTML, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_1400_1499, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, NO_URI_FOUND, NO_CTA_URI_FOUND, __URI_NO_PATH, BODY_SIZE_2000_LESS, __FROM_DOMAIN_IN_RCPT, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.141.129.68) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57D1F2710057E3F7; Sun, 11 Sep 2016 16:00:28 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update FAQ answer about setting an early breakpoint
Date: Sun, 11 Sep 2016 15:00:00 -0000
Message-Id: <20160911150018.285288-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00049.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-programming.xml | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index c64ab4a..5234414 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -811,13 +811,22 @@ Guide here: <ulink url="https://cygwin.com/cygwin-ug-net/dll.html"/>.
 </answer></qandaentry>
 
 <qandaentry id="faq.programming.breakpoint">
-<question><para>How can I set a breakpoint at MainCRTStartup?</para></question>
+<question><para>How can I set a breakpoint at mainCRTStartup?</para></question>
 <answer>
 
-<para><emphasis role='bold'>(Please note: This section has not yet been updated for the latest net release.)</emphasis>
+<para>
+  Set a breakpoint in <command>gdb</command> with <command>b *0x401000</command>
+  (for i686), or <command>b *0x100401000</command> (for x86_64).
+</para>
+
+<para>
+  This entrypoint address can be computed as the sum of the ImageBase and
+  AddressOfEntryPoint values given by <command>objdump -p</command>.
 </para>
-<para>Set a breakpoint at *0x401000 in gdb and then run the program in
-question.
+
+<para>
+  Note that the DllMain entrypoints for linked DLLs will have been executed
+  before this breakpoint is hit.
 </para>
 </answer></qandaentry>
 
-- 
2.8.3
