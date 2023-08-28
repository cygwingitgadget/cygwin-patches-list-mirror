Return-Path: <SRS0=JFVn=EN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0017.nifty.com (mta-snd00005.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 6BB683858D28
	for <cygwin-patches@cygwin.com>; Mon, 28 Aug 2023 09:46:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6BB683858D28
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain by dmta0017.nifty.com with ESMTP
          id <20230828094620237.NDUE.104452.localhost.localdomain@nifty.com>;
          Mon, 28 Aug 2023 18:46:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Ed Morton <mortoneccc@comcast.net>
Subject: [PATCH v2] Cygwin: spawn: Fix segfalt when too many command line args are specified.
Date: Mon, 28 Aug 2023 18:46:05 +0900
Message-Id: <20230828094605.2405-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the number of command line args was not checked for
cygwin process. Due to this, segmentation fault was caused if too
many command line args are specified.
https://cygwin.com/pipermail/cygwin/2023-August/254333.html

Since char *argv[argc + 1] is placed on the stack in dll_crt0_1(),
STATUS_STACK_OVERFLOW occurs if the stack does not have enough
space.

With this patch, the total length of the arguments and the size of
argv[] is restricted to 1/4 of total stack size for the process, and
spawnve() returns E2BIG if the size exceeds the limit.

Reported-by: Ed Morton <mortoneccc@comcast.net>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/release/3.4.9 |  3 +++
 winsup/cygwin/spawn.cc      | 43 ++++++++++++++++++++++++++++++++++++-
 winsup/cygwin/sysconf.cc    |  9 +++++++-
 3 files changed, 53 insertions(+), 2 deletions(-)

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
index 32ba5b377..06b62cd42 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -273,6 +273,29 @@ extern "C" void __posix_spawn_sem_release (void *sem, int error);
 
 extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
 
+static size_t
+get_stack_size (const WCHAR *filename)
+{
+  HANDLE h;
+  h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
+		   NULL, OPEN_EXISTING, 0, NULL);
+  char buf[1024];
+  DWORD n;
+  ReadFile (h, buf, sizeof (buf), &n, 0);
+  CloseHandle (h);
+  IMAGE_NT_HEADERS32 *p = (IMAGE_NT_HEADERS32 *) memmem (buf, n, "PE\0\0", 4);
+  if (!p)
+    return 0;
+  if ((char *) &p->OptionalHeader.SizeOfStackCommit > buf + n)
+    return 0; /* buf[] is not enough */
+  if (p->OptionalHeader.Magic == IMAGE_NT_OPTIONAL_HDR32_MAGIC)
+    return p->OptionalHeader.SizeOfStackReserve;
+  IMAGE_NT_HEADERS64 *p64 = (IMAGE_NT_HEADERS64 *) p;
+  if ((char *) &p64->OptionalHeader.SizeOfStackCommit > buf + n)
+    return 0; /* buf[] is not enough */
+  return p64->OptionalHeader.SizeOfStackReserve;
+}
+
 int
 child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 			  const char *const envp[], int mode,
@@ -340,8 +363,9 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	 We need to quote any argument that has whitespace or embedded "'s.  */
 
       int ac;
+      size_t arg_len = 0;
       for (ac = 0; argv[ac]; ac++)
-	/* nothing */;
+	arg_len += strlen (argv[ac]) + 1;
 
       int err;
       const char *ext;
@@ -610,6 +634,23 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	    }
 	}
 
+      if (iscygwin ())
+	{
+	  size_t child_stack_size = get_stack_size (runpath);
+	  /* char *argv[] will be placed on the stack in dll_crt0_1(), so
+	     restrict total argument length and the size of argv[] to 1/4
+	     of total stack size. */
+	  arg_len = max (arg_len, sizeof (char *) * ac);
+	  bool too_many_args = child_stack_size ?
+	    arg_len > child_stack_size / 4 : ac >= MAXWINCMDLEN;
+	  if (too_many_args)
+	    {
+	      set_errno (E2BIG);
+	      res = -1;
+	      __leave;
+	    }
+	}
+
       bool no_pcon = mode != _P_OVERLAY && mode != _P_WAIT;
       term_spawn_worker.setup (iscygwin (), handle (fileno_stdin, false),
 			       runpath, no_pcon, reset_sendsig, envblock);
diff --git a/winsup/cygwin/sysconf.cc b/winsup/cygwin/sysconf.cc
index 2db92e4de..6cb2aecd0 100644
--- a/winsup/cygwin/sysconf.cc
+++ b/winsup/cygwin/sysconf.cc
@@ -21,6 +21,13 @@ details. */
 #include "cpuid.h"
 #include "clock.h"
 
+#define DEFAULT_STACKGUARD (wincap.def_guard_page_size() + wincap.page_size ())
+static long
+get_arg_max (int in)
+{
+  return (long) (get_rlimit_stack () + DEFAULT_STACKGUARD) / 4;
+}
+
 static long
 get_page_size (int in)
 {
@@ -485,7 +492,7 @@ static struct
     };
 } sca[] =
 {
-  {cons, {c:ARG_MAX}},			/*   0, _SC_ARG_MAX */
+  {func, {f:get_arg_max}},		/*   0, _SC_ARG_MAX */
   {cons, {c:CHILD_MAX}},		/*   1, _SC_CHILD_MAX */
   {cons, {c:CLOCKS_PER_SEC}},		/*   2, _SC_CLK_TCK */
   {cons, {c:NGROUPS_MAX}},		/*   3, _SC_NGROUPS_MAX */
-- 
2.39.0

