Return-Path: <cygwin-patches-return-8793-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89870 invoked by alias); 21 Jun 2017 18:36:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86222 invoked by uid 89); 21 Jun 2017 18:36:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-22.3 required=5.0 tests=AWL,BAYES_40,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=authorization, organisation, Settings, HX-Junkmail-Premium-Raw:__HAS_X_MAILER
X-HELO: rgout04.bt.lon5.cpcloud.co.uk
Received: from rgout04.bt.lon5.cpcloud.co.uk (HELO rgout04.bt.lon5.cpcloud.co.uk) (65.20.0.181) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Jun 2017 18:36:01 +0000
X-OWM-Source-IP: 86.158.32.120 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=7/50,refid=2.7.2:2017.6.21.180916:17:7.944,ip=,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __SUBJ_ALPHA_END, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __FROM_DOMAIN_IN_ANY_CC1, __PHISH_SPEAR_PASSWORD_1, __HAS_HTML, HTML_NO_HTTP, BODY_SIZE_1300_1399, BODYTEXTP_SIZE_3000_LESS, __MIME_TEXT_P1, __MIME_TEXT_ONLY, BODY_SIZE_5000_LESS, __FROM_DOMAIN_IN_RCPT, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, NO_URI_FOUND, NO_CTA_URI_FOUND, BODY_SIZE_2000_LESS, __MIME_TEXT_P, NO_URI_HTTPS, BODY_SIZE_7000_LESS
Received: from localhost.localdomain (86.158.32.120) by rgout04.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58482DA2149E3DB7; Wed, 21 Jun 2017 19:35:58 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Update documentation of cygwin setup proxy configuration details
Date: Wed, 21 Jun 2017 18:36:00 -0000
Message-Id: <20170621183545.211512-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q2/txt/msg00064.txt.bz2

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/doc/setup-net.xml | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/winsup/doc/setup-net.xml b/winsup/doc/setup-net.xml
index 211bbed69..82b1e0dc9 100644
--- a/winsup/doc/setup-net.xml
+++ b/winsup/doc/setup-net.xml
@@ -132,14 +132,11 @@ or in case you need to reinstall a package.
 
 <sect2 id="setup-connection"><title>Connection Method</title>
 <para>
-The <literal>Direct Connection</literal> method of downloading will 
-directly download the packages, while the IE5 method will leverage your 
-IE5 cache for performance. If your organisation uses a proxy server or
-auto-configuration scripts, the IE5 method also uses these settings.
-If you have a proxy server, you can manually type it into 
-the <literal>Use Proxy</literal> section. Unfortunately, 
-<command>setup.exe</command> does not currently support password
-authorization for proxy servers.
+The <literal>Direct Connection</literal> method of downloading will
+directly connect.  If your system is configured to use a proxy server or
+auto-configuration scripts, the <literal>Use System Proxy Settings</literal>
+method uses those settings.  Alternatively, you can manually enter proxy
+settings into the <literal>Use HTTP/FTP Proxy</literal> section.
 </para>
 </sect2>
 
-- 
2.12.3
