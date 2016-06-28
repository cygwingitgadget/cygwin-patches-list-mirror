Return-Path: <cygwin-patches-return-8587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35181 invoked by alias); 28 Jun 2016 12:40:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35165 invoked by uid 89); 28 Jun 2016 12:40:03 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.1 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW autolearn=no version=3.3.2 spammy=Hx-spam-relays-external:CriticalPath, H*RU:CriticalPath, HX-CTCH-RefID:1,fgs, HX-CTCH-RefID:0.000,reip
X-HELO: rgout0406.bt.lon5.cpcloud.co.uk
Received: from rgout0406.bt.lon5.cpcloud.co.uk (HELO rgout0406.bt.lon5.cpcloud.co.uk) (65.20.0.219) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 28 Jun 2016 12:39:48 +0000
X-OWM-Source-IP: 86.160.189.61 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-CTCH-RefID: str=0001.0A090206.57727012.00B6,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.6.28.113318:17:27.888,ip=86.160.189.61,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __SUBJ_ALPHA_END, __PHISH_SUBJ_PHRASE3, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __ANY_URI, __URI_NO_WWW, BODYTEXTP_SIZE_3000_LESS, BODY_SIZE_2000_2999, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[61.189.160.86.fur], HTML_00_01, HTML_00_10, BODY_SIZE_5000_LESS, RDNS_SUSP_GENERIC, MULTIPLE_RCPTS_RND, RDNS_SUSP, BODY_SIZE_7000_LESS, NO_URI_HTTPS, LEGITIMATE_NEGATE
X-CTCH-Spam: Unknown
Received: from localhost.localdomain (86.160.189.61) by rgout04.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 0000000000349425; Tue, 28 Jun 2016 13:39:46 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update FAQ listing required packages for building Cygwin
Date: Tue, 28 Jun 2016 12:40:00 -0000
Message-Id: <20160628123927.6904-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q2/txt/msg00062.txt.bz2

docbook2X is now required for building documentation
libiconv differences between x86_64 and x86 no longer exist

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/faq-programming.xml | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index 3aa773a..1f595f8 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -680,17 +680,16 @@ rewriting the runtime library in question from specs...
 
 <para>First, you need to make sure you have the necessary build tools
 installed; you at least need <literal>gcc-g++</literal>, <literal>make</literal>,
-<literal>perl</literal>, <literal>cocom</literal>, <literal>gettext</literal>, <literal>gettext-devel</literal>,
-and <literal>zlib-devel</literal>.
-Building for 32-bit Cygwin also requires <literal>libiconv</literal>,
-<literal>mingw64-i686-gcc-g++</literal>, <literal>mingw64-i686-zlib</literal>,
-and <literal>mingw64-x86_64-gcc-core</literal>.
-Building for 64-bit Cygwin also requires <literal>libiconv-devel</literal>,
-<literal>mingw64-x86_64-gcc-g++</literal>, and
+<literal>perl</literal>, <literal>cocom</literal>, <literal>gettext-devel</literal>,
+<literal>libiconv-devel</literal> and <literal>zlib-devel</literal>.
+Building for 32-bit Cygwin also requires
+<literal>mingw64-i686-gcc-g++</literal> and <literal>mingw64-i686-zlib</literal>.
+Building for 64-bit Cygwin also requires
+<literal>mingw64-x86_64-gcc-g++</literal> and
 <literal>mingw64-x86_64-zlib</literal>.
 If you want to run the tests, <literal>dejagnu</literal> is also required.
 Normally, building ignores any errors in building the documentation,
-which requires the <literal>dblatex</literal>,
+which requires the <literal>dblatex</literal>, <literal>docbook2X</literal>,
 <literal>docbook-xml45</literal>, <literal>docbook-xsl</literal>, and
 <literal>xmlto</literal> packages.  For more information on building the
 documentation, see the README included in the <literal>cygwin-doc</literal> package.
-- 
2.8.3
