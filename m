Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta1015.nifty.com (mta-snd01006.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 45DB73858D33
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 15:21:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 45DB73858D33
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta1015.nifty.com with ESMTP
          id <20230828152113827.WXOR.25674.localhost.localdomain@nifty.com>;
          Tue, 29 Aug 2023 00:21:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v4] Cygwin: Fix segfalt when too many command line args are specified.
Date: Tue, 29 Aug 2023 00:20:59 +0900
Message-Id: <20230828152059.690-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/dcrt0.cc                | 7 ++-----
 winsup/cygwin/local_includes/winsup.h | 4 ++++
 winsup/cygwin/release/3.4.9           | 3 +++
 winsup/cygwin/spawn.cc                | 9 ++++++++-
 winsup/cygwin/sysconf.cc              | 2 +-
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 49b7a44ae..1d8810546 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -978,11 +978,8 @@ dll_crt0_1 (void *)
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
diff --git a/winsup/cygwin/local_includes/winsup.h b/winsup/cygwin/local_includes/winsup.h
index c9788de8f..57bd38c9f 100644
--- a/winsup/cygwin/local_includes/winsup.h
+++ b/winsup/cygwin/local_includes/winsup.h
@@ -73,6 +73,10 @@ uint32_t cygwin_inet_addr (const char *cp);
    application provided path strings we handle. */
 #define NT_MAX_PATH 32768
 
+/* CYG_ARG_MAX is the maximum total length of command line args.
+   The value 2097152 is the default ARG_MAX value in Linux. */
+#define CYG_ARG_MAX 2097152
+
 /* This definition allows to define wide char strings using macros as
    parameters.  See the definition of __CONCAT in newlib's sys/cdefs.h
    and accompanying comment. */
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
index c16fe269a..c4f116728 100644
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
@@ -521,6 +522,12 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  __leave;
 	}
       set (chtype, real_path.iscygexec ());
+      if (iscygwin () && arg_len > (size_t) sysconf (_SC_ARG_MAX))
+	{
+	  set_errno (E2BIG);
+	  res = -1;
+	  __leave;
+	}
       __stdin = in__stdin;
       __stdout = in__stdout;
       record_children ();
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 2db92e4de..7cdfbdb9d 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -485,7 +485,7 @@ static struct
     };
 } sca[] =
 {
-  {cons, {c:ARG_MAX}},			/*   0, _SC_ARG_MAX */
+  {cons, {c:CYG_ARG_MAX}},		/*   0, _SC_ARG_MAX */
   {cons, {c:CHILD_MAX}},		/*   1, _SC_CHILD_MAX */
   {cons, {c:CLOCKS_PER_SEC}},		/*   2, _SC_CLK_TCK */
   {cons, {c:NGROUPS_MAX}},		/*   3, _SC_NGROUPS_MAX */
-- 
2.39.0

