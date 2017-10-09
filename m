Return-Path: <cygwin-patches-return-8874-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 89757 invoked by alias); 9 Oct 2017 16:58:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89734 invoked by uid 89); 9 Oct 2017 16:58:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-24.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 09 Oct 2017 16:58:31 +0000
X-IPAS-Result: =?us-ascii?q?A2HHAwBQqttZ/+shHKxdHAEBBAEBCgEBhEGBFYN6tEgKEwi?= =?us-ascii?q?BE4QNhH0VAQIBAQEBAQEBA4EQhAJbZVY1AiYCbAgBAbIwgieLIgEBAQcogQ6CH?= =?us-ascii?q?4VoiE6CR4JhBYoLiR6ODIIuhTCPeIhuhywCkXMBg2aBOTWBMXiFeByBaXSJagE?= =?us-ascii?q?BAQ?=
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2017 18:58:24 +0200
Received: from [172.28.41.101]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1e1bNo-00051V-3v; Mon, 09 Oct 2017 18:58:24 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH] cygwin: fix potential buffer overflow in fork
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Message-ID: <1b4e1413-fa59-a954-f839-507abce7df11@ssi-schaefer.com>
Date: Mon, 09 Oct 2017 16:58:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2017-q4/txt/msg00004.txt.bz2

When fork fails, we can use "%s" now with system_sprintf for the errmsg
rather than a (potentially too small) buffer for the format string.

* fork.cc (fork): Use "%s" with system_printf now.
---
 winsup/cygwin/fork.cc | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 73a72f530..bcbef12d8 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -618,13 +618,8 @@ fork ()
       if (!grouped.errmsg)
 	syscall_printf ("fork failed - child pid %d, errno %d", grouped.child_pid, grouped.this_errno);
       else
-	{
-	  char buf[strlen (grouped.errmsg) + sizeof ("child %d - , errno 4294967295  ")];
-	  strcpy (buf, "child %d - ");
-	  strcat (buf, grouped.errmsg);
-	  strcat (buf, ", errno %d");
-	  system_printf (buf, grouped.child_pid, grouped.this_errno);
-	}
+	system_printf ("child %d - %s, errno %d", grouped.child_pid,
+		       grouped.errmsg, grouped.this_errno);
 
       set_errno (grouped.this_errno);
     }
-- 
2.14.2
