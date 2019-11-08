Return-Path: <cygwin-patches-return-9812-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39563 invoked by alias); 8 Nov 2019 00:13:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39554 invoked by uid 89); 8 Nov 2019 00:13:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-20.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_NUMSUBJECT autolearn=ham version=3.3.1 spammy=sk:cygwin_, HX-Languages-Length:1161, HContent-Transfer-Encoding:8bit
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 00:13:49 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id xA80DlCQ083701;	Thu, 7 Nov 2019 16:13:47 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpdOPBlQt; Thu Nov  7 16:13:43 2019
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] Cygwin: Raise dumpstack frame limit to 32
Date: Fri, 08 Nov 2019 00:13:00 -0000
Message-Id: <20191108001334.2878-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q4/txt/msg00083.txt.bz2

Create a #define for the limit and raise it from 16 to 32.
---
 winsup/cygwin/exceptions.cc | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 132fea427..3e7d7275c 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -42,6 +42,7 @@ details. */
 
 #define CALL_HANDLER_RETRY_OUTER 10
 #define CALL_HANDLER_RETRY_INNER 10
+#define DUMPSTACK_FRAME_LIMIT    32
 
 PWCHAR debugger_command;
 extern uint8_t _sigbe;
@@ -382,7 +383,7 @@ cygwin_exception::dumpstack ()
 #else
       small_printf ("Stack trace:\r\nFrame     Function  Args\r\n");
 #endif
-      for (i = 0; i < 16 && thestack++; i++)
+      for (i = 0; i < DUMPSTACK_FRAME_LIMIT && thestack++; i++)
 	{
 	  small_printf (_AFMT "  " _AFMT, thestack.sf.AddrFrame.Offset,
 			thestack.sf.AddrPC.Offset);
@@ -392,7 +393,8 @@ cygwin_exception::dumpstack ()
 	  small_printf (")\r\n");
 	}
       small_printf ("End of stack trace%s\n",
-		    i == 16 ? " (more stack frames may be present)" : "");
+		    i == DUMPSTACK_FRAME_LIMIT ?
+		        " (more stack frames may be present)" : "");
       if (h)
 	NtClose (h);
     }
-- 
2.21.0
