Return-Path: <cygwin-patches-return-8688-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 126683 invoked by alias); 30 Jan 2017 15:37:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 125687 invoked by uid 89); 30 Jan 2017 15:37:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.5 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=jon.turney@dronecode.org.uk, U*jon.turney, jonturneydronecodeorguk, D*dronecode.org.uk
X-HELO: rgout03.bt.lon5.cpcloud.co.uk
Received: from rgout0305.bt.lon5.cpcloud.co.uk (HELO rgout03.bt.lon5.cpcloud.co.uk) (65.20.0.211) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 30 Jan 2017 15:37:38 +0000
X-OWM-Source-IP: 86.166.190.63 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=8/50,refid=2.7.2:2016.12.21.193617:17:8.707,ip=,rules=NO_URI_FOUND, NO_CTA_URI_FOUND, NO_MESSAGE_ID, TO_MALFORMED, NO_URI_HTTPS
Received: from localhost.localdomain (86.166.190.63) by rgout03.bt.lon5.cpcloud.co.uk (9.0.019.13-1) (authenticated as jonturney@btinternet.com)        id 58482CCA04C2AB23; Mon, 30 Jan 2017 15:37:36 +0000
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH] Fix cygcheck -p's handling of '+'
Date: Mon, 30 Jan 2017 15:37:00 -0000
Message-Id: <20170130153720.209696-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2017-q1/txt/msg00029.txt.bz2

The form data sent to the server should be application/x-www-form-urlencoded

This replaces spaces with '+' before being RFC 11738 encoded, so a literal
'+' must be %-encoded also.

See https://cygwin.com/ml/cygwin/2014-01/msg00287.html et seq.

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/utils/cygcheck.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/utils/cygcheck.cc b/winsup/utils/cygcheck.cc
index d1e27b7..e745b20 100644
--- a/winsup/utils/cygcheck.cc
+++ b/winsup/utils/cygcheck.cc
@@ -2009,8 +2009,8 @@ check_keys ()
   return 0;
 }
 
-/* RFC1738 says that these do not need to be escaped.  */
-static const char safe_chars[] = "$-_.+!*'(),";
+/* These do not need to be escaped in application/x-www-form-urlencoded */
+static const char safe_chars[] = "$-_.!*'(),";
 
 /* the URL to query.  */
 static const char base_url[] =
-- 
2.8.3
