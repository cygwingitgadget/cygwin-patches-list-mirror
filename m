Return-Path: <cygwin-patches-return-8383-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121002 invoked by alias); 10 Mar 2016 08:35:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120984 invoked by uid 89); 10 Mar 2016 08:35:18 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_50,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=SAMPLES, 189, H*r:ip*192.168.1.100, Hx-spam-relays-external:!192.168.1.100!
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-SHA encrypted) ESMTPS; Thu, 10 Mar 2016 08:35:15 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id u2A8Yisd066128	for <cygwin-patches@cygwin.com>; Thu, 10 Mar 2016 00:34:44 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "[192.168.1.100]" via SMTP by m0.truegem.net, id smtpdkeW8Z5; Thu Mar 10 00:34:39 2016
Subject: Re: [PATCH] Support profiling of multi-threaded apps.
To: cygwin-patches@cygwin.com
References: <56DFE128.6080308@maxrnd.com> <20160309224400.GA13258@calimero.vinschen.de> <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <56E131C6.5080008@maxrnd.com>
Date: Thu, 10 Mar 2016 08:35:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:42.0) Gecko/20100101 Firefox/42.0 SeaMonkey/2.39
MIME-Version: 1.0
In-Reply-To: <Pine.BSF.4.63.1603091646490.69685@m0.truegem.net>
Content-Type: multipart/mixed; boundary="------------060203060003050509080908"
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00089.txt.bz2

This is a multi-part message in MIME format.
--------------060203060003050509080908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 1579

This is Version 4 incorporating review comments of Version 3.  This is just the 
code patch; a separate doc patch is forthcoming.

Change log relative to winsup/cygwin:

         * include/sys/cygwin.h: Add CW_CYGHEAP_PROFTHR_ALL.
         * cygheap.cc (cygheap_profthr_all): New C-callable function that
         runs cygheap's threadlist handing each pthread's thread handle in
         turn to profthr_byhandle().
         * external.cc (cygwin_internal): Add case CW_CYGHEAP_PROFTHR_ALL.
         * gmon.c (_mcleanup): Add support for multiple simultaneous
         gmon.out* files named via environment variable GMON_OUT_PREFIX.
         * gmon.h (struct gmonparam): Make state decl volatile.
         * mcount.c (_MCOUNT_DECL): Change stores into gmonparam.state to use
         Interlocked operations. Add #include "winsup.h", update commentary.
         * profil.c (profthr_byhandle): New function abstracting out the
         updating of profile counters based on a thread handle.
         (profthr_func): Update to call profthr_byhandle() to sample the main
         thread then call cygheap_profthr_all() indirectly through
         cygwin_internal(CW_CYGHEAP_PROFTHR_ALL) to sample all other threads.
         (profile_off): Zero targthr to indicate profiling was turned off.
         (profile_on): Fix handle leak on failure path.
         (profile_child): New callback func to restart profiling in child
         process after a fork if the parent was being profiled.
         (profile_ctl): Call pthread_atfork() to set profile_child callback.

Thank you,

..mark

--------------060203060003050509080908
Content-Type: text/plain; charset=UTF-8;
 name="0001-Support-profiling-of-multi-threaded-apps.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Support-profiling-of-multi-threaded-apps.patch"
Content-length: 13012

From e65fb126be97090f92e9ee919a87116feaaffa49 Mon Sep 17 00:00:00 2001
From: Mark Geisert <mark@maxrnd.com>
Date: Fri, 19 Feb 2016 22:58:31 -0800
Subject: [PATCH] Support profiling of multi-threaded apps.

This patch set modifies Cygwin's profiling support to sample PC values
of all an app's threads, not just the main thread. There is no change
to how profiling is requested: just compile and link the app with "-pg"
as usual. The profiling info is dumped into file gmon.out as always.

A new facility enabled via the environment variable GMON_OUT_PREFIX.
This facility is intended to match an undocumented Linux glibc feature.
Exporting the variable with a non-empty value such as "foo" causes the
profiling info to go to a file named foo.$pid instead of the default.
With that, both resulting processes of a fork() can have their profiling
data captured in separate files. gprof already knows how to accumulate
data from multiple files if they all pertain to the same app.

There is no change to the normal Cygwin execution paths if profiling is
not enabled. And when it is enabled, only the one profiling thread per
profiled app is doing more work than it used to.
---
 winsup/cygwin/cygheap.cc           | 12 ++++++
 winsup/cygwin/external.cc          | 11 +++++
 winsup/cygwin/gmon.c               | 81 +++++++++++++++--------------------
 winsup/cygwin/gmon.h               |  2 +-
 winsup/cygwin/include/sys/cygwin.h |  2 +
 winsup/cygwin/mcount.c             | 12 +++---
 winsup/cygwin/profil.c             | 86 +++++++++++++++++++++++++++++---------
 7 files changed, 133 insertions(+), 73 deletions(-)

diff --git a/winsup/cygwin/cygheap.cc b/winsup/cygwin/cygheap.cc
index 6493485..4932cf0 100644
--- a/winsup/cygwin/cygheap.cc
+++ b/winsup/cygwin/cygheap.cc
@@ -744,3 +744,15 @@ init_cygheap::find_tls (int sig, bool& issig_wait)
     WaitForSingleObject (t->mutex, INFINITE);
   return t;
 }
+
+/* Called from profil.c to sample all non-main thread PC values for profiling */
+extern "C" void
+cygheap_profthr_all (void (*profthr_byhandle) (HANDLE))
+{
+  for (uint32_t ix = 0; ix < nthreads; ix++)
+    {
+      _cygtls *tls = cygheap->threadlist[ix].thread;
+      if (tls->tid)
+	profthr_byhandle (tls->tid->win32_obj_id);
+    }
+}
diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index e379df1..02335eb 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -702,6 +702,17 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	}
 	break;
 
+      case CW_CYGHEAP_PROFTHR_ALL:
+	{
+	  typedef void (*func_t) (HANDLE);
+	  extern void cygheap_profthr_all (func_t);
+
+	  func_t profthr_byhandle = va_arg(arg, func_t);
+	  cygheap_profthr_all (profthr_byhandle);
+	  res = 0;
+	}
+	break;
+
       default:
 	set_errno (ENOSYS);
     }
diff --git a/winsup/cygwin/gmon.c b/winsup/cygwin/gmon.c
index 96b1189..eef4a5a 100644
--- a/winsup/cygwin/gmon.c
+++ b/winsup/cygwin/gmon.c
@@ -151,7 +151,6 @@ void _mcleanup (void);
 void
 _mcleanup(void)
 {
-	static char gmon_out[] = "gmon.out";
 	int fd;
 	int hz;
 	int fromindex;
@@ -161,7 +160,8 @@ _mcleanup(void)
 	struct rawarc rawarc;
 	struct gmonparam *p = &_gmonparam;
 	struct gmonhdr gmonhdr, *hdr;
-	const char *proffile;
+	char *filename = (char *) "gmon.out";
+	char *prefix;
 #ifdef DEBUG
 	int log, len;
 	char dbuf[200];
@@ -173,58 +173,43 @@ _mcleanup(void)
 	hz = PROF_HZ;
 	moncontrol(0);
 
-#ifdef nope
-	if ((profdir = getenv("PROFDIR")) != NULL) {
-		extern char *__progname;
-		char *s, *t, *limit;
-		pid_t pid;
-		long divisor;
-
-		/* If PROFDIR contains a null value, no profiling
-		   output is produced */
-		if (*profdir == '\0') {
-			return;
-		}
-
-		limit = buf + sizeof buf - 1 - 10 - 1 -
-		    strlen(__progname) - 1;
-		t = buf;
-		s = profdir;
-		while((*t = *s) != '\0' && t < limit) {
-			t++;
-			s++;
-		}
-		*t++ = '/';
-
-		/*
-		 * Copy and convert pid from a pid_t to a string.  For
-		 * best performance, divisor should be initialized to
-		 * the largest power of 10 less than PID_MAX.
-		 */
-		pid = getpid();
-		divisor=10000;
-		while (divisor > pid) divisor /= 10;	/* skip leading zeros */
-		do {
-			*t++ = (pid/divisor) + '0';
+	/* We copy an undocumented glibc feature: customizing the profiler's
+	   output file name somewhat, depending on the env var GMON_OUT_PREFIX.
+	   if GMON_OUT_PREFIX is unspecified, the file's name is "gmon.out".
+
+	   if GMON_OUT_PREFIX is specified with at least one character, the
+	   file's name is computed as "$GMON_OUT_PREFIX.$pid".
+
+	   if GMON_OUT_PREFIX is specified but contains no characters, the
+	   file's name is computed as "gmon.out.$pid".  Cygwin-specific.
+	*/
+	if ((prefix = getenv("GMON_OUT_PREFIX")) != NULL) {
+		char *buf;
+		long divisor = 1000*1000*1000; // covers positive pid_t values
+		pid_t pid = getpid();
+		size_t len = strlen(prefix);
+
+		if (len == 0)
+			len = strlen(prefix = filename);
+		buf = alloca(len + 13);// allow for '.', 10-digit pid, NUL, +1
+
+		memcpy(buf, prefix, len);
+		buf[len++] = '.';
+
+		while (divisor > pid)   // skip leading zeroes
+			divisor /= 10;
+		do {                    // convert pid to digits and store 'em
+			buf[len++] = (pid / divisor) + '0';
 			pid %= divisor;
 		} while (divisor /= 10);
-		*t++ = '.';
-
-		s = __progname;
-		while ((*t++ = *s++) != '\0')
-			;
 
-		proffile = buf;
-	} else {
-		proffile = gmon_out;
+		buf[len] = '\0';
+		filename = buf;
 	}
-#else
-	proffile = gmon_out;
-#endif
 
-	fd = open(proffile , O_CREAT|O_TRUNC|O_WRONLY|O_BINARY, 0666);
+	fd = open(filename, O_CREAT|O_TRUNC|O_WRONLY|O_BINARY, 0666);
 	if (fd < 0) {
-		perror( proffile );
+		perror(filename);
 		return;
 	}
 #ifdef DEBUG
diff --git a/winsup/cygwin/gmon.h b/winsup/cygwin/gmon.h
index 0932ed9..b0fb479 100644
--- a/winsup/cygwin/gmon.h
+++ b/winsup/cygwin/gmon.h
@@ -153,7 +153,7 @@ struct rawarc {
  * The profiling data structures are housed in this structure.
  */
 struct gmonparam {
-	int		state;
+	volatile int	state;
 	u_short		*kcount;
 	size_t		kcountsize;
 	u_short		*froms;
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index 5b7da58..8c7128c 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -160,6 +160,7 @@ typedef enum
     CW_GETNSS_PWD_SRC,
     CW_GETNSS_GRP_SRC,
     CW_EXCEPTION_RECORD_FROM_SIGINFO_T,
+    CW_CYGHEAP_PROFTHR_ALL,
   } cygwin_getinfo_types;
 
 #define CW_LOCK_PINFO CW_LOCK_PINFO
@@ -221,6 +222,7 @@ typedef enum
 #define CW_GETNSS_PWD_SRC CW_GETNSS_PWD_SRC
 #define CW_GETNSS_GRP_SRC CW_GETNSS_GRP_SRC
 #define CW_EXCEPTION_RECORD_FROM_SIGINFO_T CW_EXCEPTION_RECORD_FROM_SIGINFO_T
+#define CW_CYGHEAP_PROFTHR_ALL CW_CYGHEAP_PROFTHR_ALL
 
 /* Token type for CW_SET_EXTERNAL_TOKEN */
 enum
diff --git a/winsup/cygwin/mcount.c b/winsup/cygwin/mcount.c
index fad6728..6111b35 100644
--- a/winsup/cygwin/mcount.c
+++ b/winsup/cygwin/mcount.c
@@ -41,6 +41,7 @@ static char rcsid[] = "$OpenBSD: mcount.c,v 1.6 1997/07/23 21:11:27 kstailey Exp
 #endif
 #include <sys/types.h>
 #include "gmon.h"
+#include "winsup.h"
 
 /*
  * mcount is called on entry to each function compiled with the profiling
@@ -70,11 +71,12 @@ _MCOUNT_DECL (size_t frompc, size_t selfpc)
 	p = &_gmonparam;
 	/*
 	 * check that we are profiling
-	 * and that we aren't recursively invoked.
+	 * and that we aren't recursively invoked by this thread
+	 * or entered anew by any other thread.
 	 */
-	if (p->state != GMON_PROF_ON)
+	if (InterlockedCompareExchange (
+		    &p->state, GMON_PROF_BUSY, GMON_PROF_ON) != GMON_PROF_ON)
 		return;
-	p->state = GMON_PROF_BUSY;
 	/*
 	 * check that frompcindex is a reasonable pc value.
 	 * for example:	signal catchers get called from the stack,
@@ -162,10 +164,10 @@ _MCOUNT_DECL (size_t frompc, size_t selfpc)
 		}
 	}
 done:
-	p->state = GMON_PROF_ON;
+	InterlockedExchange (&p->state, GMON_PROF_ON);
 	return;
 overflow:
-	p->state = GMON_PROF_ERROR;
+	InterlockedExchange (&p->state, GMON_PROF_ERROR);
 	return;
 }
 
diff --git a/winsup/cygwin/profil.c b/winsup/cygwin/profil.c
index eb41c08..2d7d6e3 100644
--- a/winsup/cygwin/profil.c
+++ b/winsup/cygwin/profil.c
@@ -18,9 +18,10 @@
 #endif
 #include <windows.h>
 #include <stdio.h>
+#include <sys/cygwin.h>
 #include <sys/types.h>
 #include <errno.h>
-#include <math.h>
+#include <pthread.h>
 #include "profil.h"
 
 #define SLEEPTIME (1000 / PROF_HZ)
@@ -65,25 +66,42 @@ print_prof (struct profinfo *p)
 }
 #endif
 
-/* Everytime we wake up use the main thread pc to hash into the cell in the
-   profile buffer ARG. */
+/* Every time we wake up sample the main thread's pc to hash into the cell
+   in the profile buffer ARG.  Then all other pthreads' pc's are sampled.  */
 
-static void CALLBACK profthr_func (LPVOID);
+static void
+profthr_byhandle (HANDLE thr)
+{
+  size_t pc;
+
+  /* Sample the pc of the thread indicated by thr; bail if anything amiss. */
+  if (thr == INVALID_HANDLE_VALUE)
+    return;
+  pc = get_thrpc (thr);
+  if (pc == -1)
+    return;
+
+  /* Code assumes there's only one profinfo in play: the static prof above. */
+  if (pc >= prof.lowpc && pc < prof.highpc)
+    {
+      size_t idx = PROFIDX (pc, prof.lowpc, prof.scale);
+      prof.counter[idx]++;
+    }
+}
 
 static void CALLBACK
 profthr_func (LPVOID arg)
 {
   struct profinfo *p = (struct profinfo *) arg;
-  size_t pc, idx;
 
   for (;;)
     {
-      pc = (size_t) get_thrpc (p->targthr);
-      if (pc >= p->lowpc && pc < p->highpc)
-	{
-	  idx = PROFIDX (pc, p->lowpc, p->scale);
-	  p->counter[idx]++;
-	}
+      /* Record profiling sample for main thread. */
+      profthr_byhandle (p->targthr);
+
+      /* Record profiling samples for other pthreads, if any. */
+      cygwin_internal (CW_CYGHEAP_PROFTHR_ALL, profthr_byhandle);
+
 #if 0
       print_prof (p);
 #endif
@@ -106,6 +124,7 @@ profile_off (struct profinfo *p)
     }
   if (p->targthr)
     CloseHandle (p->targthr);
+  p->targthr = 0;
   return 0;
 }
 
@@ -121,6 +140,7 @@ profile_on (struct profinfo *p)
 			GetCurrentProcess (), &p->targthr, 0, FALSE,
 			DUPLICATE_SAME_ACCESS))
     {
+      p->targthr = 0;
       errno = ESRCH;
       return -1;
     }
@@ -129,7 +149,7 @@ profile_on (struct profinfo *p)
 
   if (!p->quitevt)
     {
-      CloseHandle (p->quitevt);
+      CloseHandle (p->targthr);
       p->targthr = 0;
       errno = EAGAIN;
       return -1;
@@ -148,8 +168,8 @@ profile_on (struct profinfo *p)
     }
 
   /* Set profiler thread priority to highest to be sure that it gets the
-     processor as soon it request it (i.e. when the Sleep terminate) to get
-     the next data out of the profile. */
+     processor as soon it requests it (i.e. when the Sleep terminates) to get
+     the next data sample as quickly as possible. */
 
   SetThreadPriority (p->profthr, THREAD_PRIORITY_TIME_CRITICAL);
 
@@ -157,16 +177,41 @@ profile_on (struct profinfo *p)
 }
 
 /*
- * start or stop profiling
+ * Restart profiling in child after fork.
  *
- * profiling goes into the SAMPLES buffer of size SIZE (which is treated
- * as an array of u_shorts of size size/2)
+ * The profiling control info in prof needs to be selectively updated.
+ * Items counter, lowpc, highpc, and scale are correct as-is.  But items
+ * targthr, profthr, and quitevt need updating because these copied HANDLE
+ * values are only valid in parent process.  We also zero out the sample
+ * buffer so that samples aren't double-counted if multiple gmon.out files
+ * are aggregated.  We calculate buffer's size from other data in prof.
+ */
+static void
+profile_child (void)
+{
+  /* Bail if this was a fork after profiling turned off or was never on. */
+  if (!prof.targthr)
+    return;
+
+  /* Figure out how big the sample buffer is and zero it out. */
+  size_t size = PROFIDX (prof.highpc, prof.lowpc, prof.scale) << 1;
+  memset ((char *) prof.counter, 0, size);
+
+  /* Replace stale HANDLEs in prof and create profiling thread. */
+  profile_on (&prof);
+}
+
+/*
+ * Start or stop profiling.
  *
- * each bin represents a range of pc addresses from OFFSET.  The number
+ * Profiling data goes into the SAMPLES buffer of size SIZE (which is treated
+ * as an array of u_shorts of size SIZE/2).
+ *
+ * Each bin represents a range of pc addresses from OFFSET.  The number
  * of pc addresses in a bin depends on SCALE.  (A scale of 65536 maps
  * each bin to two addresses, A scale of 32768 maps each bin to 4 addresses,
  * a scale of 1 maps each bin to 128k addreses).  Scale may be 1 - 65536,
- * or zero to turn off profiling
+ * or zero to turn off profiling.
  */
 int
 profile_ctl (struct profinfo * p, char *samples, size_t size,
@@ -191,6 +236,9 @@ profile_ctl (struct profinfo * p, char *samples, size_t size,
       prof.highpc = PROFADDR (maxbin, offset, scale);
       prof.scale = scale;
 
+      /* Set up callback to restart profiling in child after fork. */
+      pthread_atfork (NULL, NULL, profile_child);
+
       return profile_on (p);
     }
   return 0;
-- 
2.7.0


--------------060203060003050509080908--
