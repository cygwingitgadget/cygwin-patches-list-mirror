Return-Path: <cygwin-patches-return-8873-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89285 invoked by alias); 9 Oct 2017 16:58:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89271 invoked by uid 89); 9 Oct 2017 16:58:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=H*MI:a50a, H*M:a50a, HTo:U*cygwin-patches
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Oct 2017 16:58:28 +0000
X-IPAS-Result: =?us-ascii?q?A2HHAwBQqttZ/+shHKxdHAEBBAEBCgEBhEGBFYN6tEgKEwi?= =?us-ascii?q?BE4QNhH0VAQIBAQEBAQEBA4EQhAJbZVY1AiYCbAgBAbIwgieLIgEBCCiBDoIfh?= =?us-ascii?q?WiIToJHgmEFoTWCLoUwj3iIbocsAkiRKwGDZoE5NYExeIV1H4FpdIlqAQEB?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2017 18:57:59 +0200
Received: from [172.28.41.101]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1e1bNP-00051A-0c; Mon, 09 Oct 2017 18:57:59 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] cygwin: fix potential buffer overflow in small_sprintf
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <499683af-b4f7-a50a-829b-514259c39cc5@ssi-schaefer.com>
Date: Mon, 09 Oct 2017 16:58:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q4/txt/msg00003.txt.bz2

With "%C" format string, argument may convert in up to MB_LEN_MAX bytes.
Relying on sys_wcstombs to add a trailing zero here requires us to
provide a large enough buffer.

* smallprint.c (__small_vsprintf): Use MB_LEN_MAX+1 bufsize for "%C".
---
 winsup/cygwin/smallprint.cc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/smallprint.cc b/winsup/cygwin/smallprint.cc
index 3cec31cce..8553f7002 100644
--- a/winsup/cygwin/smallprint.cc
+++ b/winsup/cygwin/smallprint.cc
@@ -193,8 +193,8 @@ __small_vsprintf (char *dst, const char *fmt, va_list ap)
 		case 'C':
 		  {
 		    WCHAR wc = (WCHAR) va_arg (ap, int);
-		    char buf[4], *c;
-		    sys_wcstombs (buf, 4, &wc, 1);
+		    char buf[MB_LEN_MAX+1] = "", *c;
+		    sys_wcstombs (buf, MB_LEN_MAX+1, &wc, 1);
 		    for (c = buf; *c; ++c)
 		      *dst++ = *c;
 		  }
-- 
2.14.2
