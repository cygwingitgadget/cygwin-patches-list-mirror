Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B4F834BA2E26; Mon, 30 Mar 2026 14:41:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B4F834BA2E26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774881675;
	bh=wRTl2Jm40ao8bo8Oz1tbfSbGlNOmcBr+lKTkcO/Wc20=;
	h=From:To:Subject:Date:From;
	b=ugwxbBc7DukKMUpbgs15J4SlUFWfwggn5i4guOpNm1CqiT+xHlCQONwoOUAgTYGwu
	 Ye5bN5JdLiRf5UJvubhxPimpGzlGlhJn9/DItIed+MquvnLsLlpqgeQAAuT/FoUi+w
	 iB4lHinAn7pKOY569zZLITbkOUvSG+zD3prSKbqE=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id BD56CA80610; Mon, 30 Mar 2026 16:41:13 +0200 (CEST)
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: add _Fork() system call per POSIX.1-2024
Date: Mon, 30 Mar 2026 16:41:13 +0200
Message-ID: <20260330144113.1636278-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cygwin-patches.cygwin.com>

From: Corinna Vinschen <corinna@vinschen.de>

The _Fork() function shall be equivalent to fork(), except that fork
handlers established by means of the pthread_atfork() function shall
not be called and _Fork() shall be async-signal-safe.  Our fork()
already is async-signal-safe, so just make sure the pthread_atfork()
handlers are not called.

Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
---
 newlib/libc/include/sys/unistd.h       |  3 ++
 winsup/cygwin/cygwin.din               |  1 +
 winsup/cygwin/fork.cc                  | 40 ++++++++++++++++++++------
 winsup/cygwin/include/cygwin/version.h |  3 +-
 winsup/cygwin/local_includes/sigproc.h | 13 +++++++--
 winsup/cygwin/release/3.7.0            |  1 +
 6 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/unistd.h
index 4cf9f0636276..d1c9126e53ab 100644
--- a/newlib/libc/include/sys/unistd.h
+++ b/newlib/libc/include/sys/unistd.h
@@ -96,6 +96,9 @@ int	fchownat (int __dirfd, const char *__path, uid_t __owner, gid_t __group, int
 int	fexecve (int __fd, char * const __argv[], char * const __envp[]);
 #endif
 pid_t   fork (void);
+#if __POSIX_VISIBLE >= 202405
+pid_t   _Fork (void);
+#endif
 long    fpathconf (int __fd, int __name);
 int     fsync (int __fd);
 #if __POSIX_VISIBLE >= 199309
diff --git a/winsup/cygwin/cygwin.din b/winsup/cygwin/cygwin.din
index 7709a0653eb9..76477bb4aec2 100644
--- a/winsup/cygwin/cygwin.din
+++ b/winsup/cygwin/cygwin.din
@@ -147,6 +147,7 @@ __xpg_strerror_r SIGFE
 _dll_crt0 NOSIGFE
 _Exit SIGFE
 _exit SIGFE
+_Fork SIGFE
 _feinitialise NOSIGFE
 _fscanf_r SIGFE
 _get_osfhandle SIGFE
diff --git a/winsup/cygwin/fork.cc b/winsup/cygwin/fork.cc
index 48e8b7557d00..82ad3aaf0899 100644
--- a/winsup/cygwin/fork.cc
+++ b/winsup/cygwin/fork.cc
@@ -31,7 +31,7 @@ details. */
 /* FIXME: Once things stabilize, bump up to a few minutes.  */
 #define FORK_WAIT_TIMEOUT (300 * 1000)     /* 300 seconds */
 
-static int dofork (void **proc, bool *with_forkables);
+static int dofork (void **proc, bool is__Fork, bool *with_forkables);
 class frok
 {
   frok (bool *forkables)
@@ -47,7 +47,7 @@ class frok
   int parent (volatile char * volatile here);
   int child (volatile char * volatile here);
   bool error (const char *fmt, ...);
-  friend int dofork (void **proc, bool *with_forkables);
+  friend int dofork (void **, bool, bool *);
 };
 
 static void
@@ -201,7 +201,6 @@ frok::child (volatile char * volatile here)
   CloseHandle (hParent);
   hParent = NULL;
   cygwin_finished_initializing = true;
-  pthread::atforkchild ();
   return 0;
 }
 
@@ -609,15 +608,33 @@ extern "C" int
 fork ()
 {
   bool with_forkables = false; /* do not force hardlinks on first try */
-  int res = dofork (NULL, &with_forkables);
+  int res = dofork (NULL, false, &with_forkables);
   if (res >= 0)
     return res;
   if (with_forkables)
     return res; /* no need for second try when already enabled */
   with_forkables = true; /* enable hardlinks for second try */
-  return dofork (NULL, &with_forkables);
+  return dofork (NULL, false, &with_forkables);
 }
 
+/* POSIX.1-2024:
+
+    The _Fork() function shall be equivalent to fork(), except that fork
+    handlers established by means of the pthread_atfork() function shall
+    not be called and _Fork() shall be async-signal-safe.  Our fork()
+    already is async-signal-safe. */
+extern "C" int
+_Fork ()
+{
+  bool with_forkables = false; /* do not force hardlinks on first try */
+  int res = dofork (NULL, true, &with_forkables);
+  if (res >= 0)
+    return res;
+  if (with_forkables)
+    return res; /* no need for second try when already enabled */
+  with_forkables = true; /* enable hardlinks for second try */
+  return dofork (NULL, true, &with_forkables);
+}
 
 /* __posix_spawn_fork is called from newlib's posix_spawn implementation.
    The original code in newlib has been taken from FreeBSD, and the core
@@ -628,17 +645,17 @@ extern "C" int
 __posix_spawn_fork (void **proc)
 {
   bool with_forkables = false; /* do not force hardlinks on first try */
-  int res = dofork (proc, &with_forkables);
+  int res = dofork (proc, false, &with_forkables);
   if (res >= 0)
     return res;
   if (with_forkables)
     return res; /* no need for second try when already enabled */
   with_forkables = true; /* enable hardlinks for second try */
-  return dofork (proc, &with_forkables);
+  return dofork (proc, false, &with_forkables);
 }
 
 static int
-dofork (void **proc, bool *with_forkables)
+dofork (void **proc, bool is__Fork, bool *with_forkables)
 {
   frok grouped (with_forkables);
 
@@ -659,7 +676,7 @@ dofork (void **proc, bool *with_forkables)
     }
 
   {
-    hold_everything held_everything (ischild);
+    hold_everything held_everything (ischild, is__Fork);
     /* This tmp_pathbuf constructor is required here because the below setjmp
        magic will otherwise not restore the original buffer count values in
        the thread-local storage.  A process forking too deeply will run into
@@ -695,6 +712,11 @@ dofork (void **proc, bool *with_forkables)
     else
       {
 	res = grouped.child (stackp);
+	/* So far pthread::atforkchild() was called as last function
+	   from inside frok::child().  Move the call here, so we don't have
+	   to propagate the is__Fork variable to frok::child(). */
+	if (!is__Fork)
+	  pthread::atforkchild ();
 	__in_forkee = FORKED;
 	ischild = true;	/* might have been reset by fork mem copy */
       }
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index ef552ffcba9c..695477bec265 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -500,12 +500,13 @@ details. */
        acl_is_trivial_np, acl_set_fd_np, acl_set_link_np, acl_strip_np.
   359: Export wrappers for C++14 and C++17 new and delete overloads.
   360: Add RLIMIT_NPROC.
+  361: Export _Fork.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 360
+#define CYGWIN_VERSION_API_MINOR 361
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/local_includes/sigproc.h b/winsup/cygwin/local_includes/sigproc.h
index ce7263338f0a..bf4096c68503 100644
--- a/winsup/cygwin/local_includes/sigproc.h
+++ b/winsup/cygwin/local_includes/sigproc.h
@@ -131,7 +131,8 @@ class lock_pthread
 {
   bool bother;
 public:
-  lock_pthread (): bother (1)
+  lock_pthread (): bother (1) {}
+  void prepare ()
   {
     pthread::atforkprepare ();
   }
@@ -165,7 +166,15 @@ class hold_everything
   lock_process process;
 
 public:
-  hold_everything (bool& x): ischild (x) {}
+  hold_everything (bool& x, bool is__Fork): ischild (x)
+  {
+    /* POSIX.1-2024: _Fork() does not call any handler established
+		     by pthread_atfork(). */
+    if (is__Fork)
+      pthread.dont_bother ();
+    else
+      pthread.prepare ();
+  }
   operator int () const {return signals;}
 
   ~hold_everything()
diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
index 4736fd17c3f4..d5b63b0586a9 100644
--- a/winsup/cygwin/release/3.7.0
+++ b/winsup/cygwin/release/3.7.0
@@ -11,3 +11,4 @@ What's new:
 - Improved support for soft and hard limits in setrlimit(2), support
   RLIMIT_NPROC.
 
+- New API: _Fork.
-- 
2.53.0

