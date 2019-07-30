Return-Path: <cygwin-patches-return-9535-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27108 invoked by alias); 30 Jul 2019 15:25:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26972 invoked by uid 89); 30 Jul 2019 15:25:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=UD:cygwin.com, cygwincom, cygwin.com
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Jul 2019 15:25:00 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2019 17:24:57 +0200
Received: from [172.28.42.244] (helo=wamas.com)	by mailhost.salomon.at with smtp (Exim 4.77)	(envelope-from <haubi@wamas.com>)	id 1hsTzl-0002ui-IR; Tue, 30 Jul 2019 17:24:57 +0200
Received: with nullmailer 2.2;	Tue, 30 Jul 2019 15:24:57 -0000
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
To: cygwin-patches@cygwin.com
Cc: michael.haubenwallner@ssi-schaefer.com
Subject: [PATCH 2/2] Cygwin: fork: Attach child not before success.
Date: Tue, 30 Jul 2019 15:25:00 -0000
Message-Id: <20190730152256.22873-3-michael.haubenwallner@ssi-schaefer.com>
In-Reply-To: <20190730152256.22873-1-michael.haubenwallner@ssi-schaefer.com>
References: <20190730152256.22873-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SW-Source: 2019-q3/txt/msg00055.txt.bz2

Do not attach to the child before it was successfully initialized, or we
would need more sophisticated cleanup on child initialization failure,
like suppressing SIGCHILD delivery with multiple threads ("waitproc")
involved.

Improves "Cygwin: fork: Remember child not before success.",
commit f03ea8e1c57bd5cea83f6cd47fa02870bdfeb1c5, which leads to fork
problems if cygserver is running:

https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
---
 winsup/cygwin/fork.cc | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 59b13806c..c6ba8cf65 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -416,11 +416,11 @@ frok::parent (volatile char * volatile stack_here)
      it in afterwards.  This requires more bookkeeping than I like, though,
      so we'll just do it the easy way.  So, terminate any child process if
      we can't actually record the pid in the internal table. */
-  if (!child.remember (false))
+  if (!child.remember_without_attach (false))
     {
       this_errno = EAGAIN;
 #ifdef DEBUGGING0
-      error ("child remember failed");
+      error ("child remember_without_attach failed");
 #endif
       goto cleanup;
     }
@@ -508,6 +508,15 @@ frok::parent (volatile char * volatile stack_here)
 	}
     }
 
+  if (!child.reattach ())
+    {
+      this_errno = EAGAIN;
+#ifdef DEBUGGING0
+      error ("child reattach failed");
+#endif
+      goto cleanup;
+    }
+
   /* Finally start the child up. */
   resume_child (forker_finished);
 
-- 
2.21.0
