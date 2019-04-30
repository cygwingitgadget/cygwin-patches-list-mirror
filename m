Return-Path: <cygwin-patches-return-9390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 74039 invoked by alias); 30 Apr 2019 07:09:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 74030 invoked by uid 89); 30 Apr 2019 07:09:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE,SPF_PASS autolearn=ham version=3.3.1 spammy=H*r:4.77, transfer
X-HELO: atfriesa01.ssi-schaefer.com
Received: from atfriesa01.ssi-schaefer.com (HELO atfriesa01.ssi-schaefer.com) (193.186.16.100) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 30 Apr 2019 07:09:16 +0000
Received: from samail03.wamas.com (HELO mailhost.salomon.at) ([172.28.33.235])  by atfriesa01.ssi-schaefer.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Apr 2019 09:09:13 +0200
Received: from [172.28.42.244]	by mailhost.salomon.at with esmtp (Exim 4.77)	(envelope-from <michael.haubenwallner@ssi-schaefer.com>)	id 1hLMt7-0000r7-Aq; Tue, 30 Apr 2019 09:09:13 +0200
From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Subject: [PATCH 1/2] Cygwin: fork: Always pause child after fixups.
To: cygwin-patches@cygwin.com
Cc: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
References: <20190412175825.GD4248@calimero.vinschen.de>
Openpgp: preference=signencrypt
Message-ID: <dfd73eac-c2ad-8d5a-557f-23dbff3db67a@ssi-schaefer.com>
Date: Tue, 30 Apr 2019 07:09:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412175825.GD4248@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-SW-Source: 2019-q2/txt/msg00097.txt.bz2

Pause the child process after performing fork fixups even if there were
no dynamically loaded dlls with extra data/bss transfers to wait for.
This allows the parent process to cancel the current fork call even if
the child process was successfully initialized already.

This is a preparation for when the parent does remember the child no
earlier than after successful child initialization.
---
 winsup/cygwin/fork.cc | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 7e1c08990..59b13806c 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -180,13 +180,10 @@ frok::child (volatile char * volatile here)
 
   cygheap->fdtab.fixup_after_fork (hParent);
 
-  /* If we haven't dynamically loaded any dlls, just signal the parent.
-     Otherwise, tell the parent that we've loaded all the dlls
-     and wait for the parent to fill in the loaded dlls' data/bss. */
-  if (!load_dlls)
-    sync_with_parent ("performed fork fixup", false);
-  else
-    sync_with_parent ("loaded dlls", true);
+  /* Signal that we have successfully initialized, so the parent can
+     - transfer data/bss for dynamically loaded dlls (if any), or
+     - terminate the current fork call even if the child is initialized. */
+  sync_with_parent ("performed fork fixups and dynamic dll loading", true);
 
   init_console_handler (myself->ctty > 0);
   ForceCloseHandle1 (fork_info->forker_finished, forker_finished);
@@ -477,7 +474,8 @@ frok::parent (volatile char * volatile stack_here)
 	}
     }
 
-  /* Start thread, and then wait for it to reload dlls.  */
+  /* Start the child up, and then wait for it to
+     perform fork fixups and dynamic dll loading (if any). */
   resume_child (forker_finished);
   if (!ch.sync (child->pid, hchild, FORK_WAIT_TIMEOUT))
     {
@@ -508,10 +506,11 @@ frok::parent (volatile char * volatile stack_here)
 	      goto cleanup;
 	    }
 	}
-      /* Start the child up again. */
-      resume_child (forker_finished);
     }
 
+  /* Finally start the child up. */
+  resume_child (forker_finished);
+
   ForceCloseHandle (forker_finished);
   forker_finished = NULL;
 
-- 
2.19.2
