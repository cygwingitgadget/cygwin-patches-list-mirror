Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0018.nifty.com (mta-snd00002.nifty.com [106.153.226.34])
	by sourceware.org (Postfix) with ESMTPS id 80B7D3858D33
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 13:31:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 80B7D3858D33
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0018.nifty.com with ESMTP
          id <20230828133146666.HNOW.104251.localhost.localdomain@nifty.com>;
          Mon, 28 Aug 2023 22:31:46 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3] Cygwin: Fix segfalt when too many command line args are specified.
Date: Mon, 28 Aug 2023 22:31:27 +0900
Message-Id: <20230828133127.3429-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the number of command line args was not checked for
cygwin process. Due to this, segmentation fault was caused if too
many command line args are specified.
https://cygwin.com/pipermail/cygwin/2023-August/254333.html

Since char *argv[argc + 1] is placed on the stack in dll_crt0_1(),
STATUS_STACK_OVERFLOW occurs if the stack does not have enough
space.

With this patch, char *argv[] is placed in heap instead of stack
and ARG_MAX is increased from 32000 to 2097152 which is default
value of Linux. The argument length is also compared with ARG_MAX
and spawnve() returns E2BIG if it is too long.

Reported-by: Ed Morton
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dcrt0.cc                |  8 +++-----
 winsup/cygwin/include/cygwin/limits.h |  5 ++---
 winsup/cygwin/release/3.4.9           |  3 +++
 winsup/cygwin/spawn.cc                | 10 +++++++++-
 4 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 49b7a44ae..d59bec425 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -978,16 +978,14 @@ dll_crt0_1 (void *)
 	 a change to an element of argv[] it does not affect Cygwin's argv.
 	 Changing the the contents of what argv[n] points to will still
 	 affect Cygwin.  This is similar (but not exactly like) Linux. */
-      char *newargv[__argc + 1];
-      char **nav = newargv;
-      char **oav = __argv;
-      while ((*nav++ = *oav++) != NULL)
-	continue;
+      char **newargv = (char **) malloc ((__argc + 1) * sizeof (char *));
+      memcpy (newargv, __argv, (__argc + 1) * sizeof (char *));
       /* Handle any signals which may have arrived */
       sig_dispatch_pending (false);
       _my_tls.call_signal_handler ();
       _my_tls.incyg--;	/* Not in Cygwin anymore */
       cygwin_exit (user_data->main (__argc, newargv, environ));
+      free (newargv);
     }
   __asm__ ("				\n\
 	.global _cygwin_exit_return	\n\
diff --git a/winsup/cygwin/include/cygwin/limits.h b/winsup/cygwin/include/cygwin/limits.h
index ea3e2836a..0b4eaf734 100644
--- a/winsup/cygwin/include/cygwin/limits.h
+++ b/winsup/cygwin/include/cygwin/limits.h
@@ -13,9 +13,8 @@ details. */
 #define __AIO_MAX 8
 #define __AIO_PRIO_DELTA_MAX 0
 
-/* 32000 is the safe value used for Windows processes when called from
-   Cygwin processes. */
-#define __ARG_MAX 32000
+/* 2097152 is the value which linux uses by default */
+#define __ARG_MAX 2097152
 #define __ATEXIT_MAX 32
 #define __CHILD_MAX 256
 #define __DELAYTIMER_MAX __INT_MAX__
diff --git a/winsup/cygwin/release/3.4.9 b/winsup/cygwin/release/3.4.9
index 2f2da9e13..53c4e5fc8 100644
--- a/winsup/cygwin/release/3.4.9
+++ b/winsup/cygwin/release/3.4.9
@@ -8,3 +8,6 @@ Bug Fixes
 - For the time being, disable creating special files using mknod/mkfifo
   on NFS.
   Addresses: https://cygwin.com/pipermail/cygwin/2023-August/254266.html
+
+- Fix segfault when too many command line args are specified.
+  Addresses: https://cygwin.com/pipermail/cygwin/2023-August/254333.html
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index c16fe269a..682c135b4 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -351,8 +351,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 We need to quote any argument that has whitespace or embedded "'s.  */
 
       int ac;
+      size_t arg_len = 0;
       for (ac = 0; argv[ac]; ac++)
-	/* nothing */;
+	arg_len += strlen (argv[ac]) + 1;
 
       int err;
       const char *ext;
@@ -621,6 +622,13 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
+      if (iscygwin () && arg_len > (size_t) sysconf (_SC_ARG_MAX))
+	{
+	  set_errno (E2BIG);
+	  res = -1;
+	  __leave;
+	}
+
       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
 			       runpath, no_pcon, reset_sendsig, envblock);
-- 
2.39.0

