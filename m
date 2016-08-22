Return-Path: <cygwin-patches-return-8613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90998 invoked by alias); 22 Aug 2016 18:09:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 90948 invoked by uid 89); 22 Aug 2016 18:09:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=no version=3.3.2 spammy=H*RU:CriticalPath, Hx-spam-relays-external:CriticalPath, IEEE, *attr
X-HELO: rgout0303.bt.lon5.cpcloud.co.uk
Received: from rgout0303.bt.lon5.cpcloud.co.uk (HELO rgout0303.bt.lon5.cpcloud.co.uk) (65.20.0.209) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Aug 2016 18:09:29 +0000
X-OWM-Source-IP: 86.166.190.87 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.8.22.175416:17:27.888,ip=86.166.190.87,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __CC_NAME, __CC_NAME_DIFF_FROM_ACC, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __FROM_DOMAIN_IN_ANY_CC1, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __URI_NO_MAILTO, __CP_URI_IN_BODY, __URI_IN_BODY, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[87.190.166.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, __FROM_DOMAIN_IN_RCPT, RDNS_SUSP, IN_REP_TO, REFERENCES, MSG_THREAD, __CC_REAL_NAMES, MULTIPLE_REAL_RCPTS, LEGITIMATE_SIGNS, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.166.190.87) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 57BB330F0001EF70; Mon, 22 Aug 2016 19:09:24 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Add pthread_getname_np and pthread_setname_np
Date: Mon, 22 Aug 2016 18:09:00 -0000
Message-Id: <20160822180848.351616-2-jon.turney@dronecode.org.uk>
In-Reply-To: <20160822180848.351616-1-jon.turney@dronecode.org.uk>
References: <20160822180848.351616-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00021.txt.bz2

This patch adds pthread_getname_np and pthread_setname_np.

These were added to glibc in 2.12[1] and are also present in some form on
NetBSD and several UNIXes.

The code is based on NetBSD's implementation with changes to better match
Linux behaviour.

Implementation quirks:

* pthread_setname_np with a NULL pointer segfaults (as linux)

* pthread_setname_np returns ERANGE for names longer than 16 characters (as
linux)

* pthread_getname_np with a NULL pointer returns EFAULT (as linux)

* pthread_getname_np with a buffer length of less than 16 returns ERANGE (as
linux)

* pthread_getname_np truncates the thread name to fit the buffer length.
This guarantees success even when the default thread name is longer than 16
characters, but means there is no way to discover the actual length of the
thread name. (Linux always truncates the thread name to 16 characters)

* Changing program_invocation_short_name changes the default thread name (on
linux, it has no effect on the default thread name)

I'll leave it up to you to decide if any of these matter.

This is implemented via class pthread_attr to make it easier to add
pthread_attr_[gs]etname_np (present in NetBSD and some UNIXes) should it
ever be added to Linux (or we decide we want it anyway).

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS
---
 winsup/cygwin/common.din               |  2 ++
 winsup/cygwin/include/cygwin/version.h |  3 +-
 winsup/cygwin/include/pthread.h        |  2 ++
 winsup/cygwin/release/2.6.0            |  1 +
 winsup/cygwin/thread.cc                | 64 +++++++++++++++++++++++++++++++++-
 winsup/cygwin/thread.h                 |  1 +
 winsup/doc/new-features.xml            |  4 +++
 winsup/doc/posix.xml                   |  2 ++
 8 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index d54b70a..8f7a282 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1046,6 +1046,7 @@ pthread_exit SIGFE
 pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
 pthread_getcpuclockid SIGFE
+pthread_getname_np SIGFE
 pthread_getschedparam SIGFE
 pthread_getsequence_np SIGFE
 pthread_getspecific SIGFE
@@ -1086,6 +1087,7 @@ pthread_self SIGFE
 pthread_setcancelstate SIGFE
 pthread_setcanceltype SIGFE
 pthread_setconcurrency SIGFE
+pthread_setname_np SIGFE
 pthread_setschedparam SIGFE
 pthread_setschedprio SIGFE
 pthread_setspecific SIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 2782c32..a1b8a62 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -467,12 +467,13 @@ details. */
        strtoull_l, wcstod_l, wcstof_l, wcstol_l, wcstold_l, wcstoll_l,
        wcstoul_l, wcstoull_l.
   302: Export nl_langinfo_l.
+  303: Export pthread_getname_np, pthread_setname_np.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 302
+#define CYGWIN_VERSION_API_MINOR 303
 
 /* There is also a compatibity version number associated with the shared memory
    regions.  It is incremented when incompatible changes are made to the shared
diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthread.h
index 609eac2..47ee6bd 100644
--- a/winsup/cygwin/include/pthread.h
+++ b/winsup/cygwin/include/pthread.h
@@ -222,6 +222,8 @@ void pthread_testcancel (void);
 
 #if __GNU_VISIBLE
 int pthread_getattr_np (pthread_t, pthread_attr_t *);
+int pthread_getname_np (pthread_t, char *, size_t) __attribute__((nonnull(2)));
+int pthread_setname_np (pthread_t, const char *) __attribute__((nonnull(2)));
 int pthread_sigqueue (pthread_t *, int, const union sigval);
 int pthread_yield (void);
 #endif
diff --git a/winsup/cygwin/release/2.6.0 b/winsup/cygwin/release/2.6.0
index 3f64577..8255450 100644
--- a/winsup/cygwin/release/2.6.0
+++ b/winsup/cygwin/release/2.6.0
@@ -20,6 +20,7 @@ What's new:
 - locale(1) now supports a -i/--input option to fetch the current input
   locale (this is basically equivalent to the current keyboard layout setting).
 
+- New API: pthread_getname_np, pthread_setname_np.
 
 What changed:
 -------------
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index 4414785..fac801b 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1106,7 +1106,7 @@ pthread::resume ()
 pthread_attr::pthread_attr ():verifyable_object (PTHREAD_ATTR_MAGIC),
 joinable (PTHREAD_CREATE_JOINABLE), contentionscope (PTHREAD_SCOPE_PROCESS),
 inheritsched (PTHREAD_INHERIT_SCHED), stackaddr (NULL), stacksize (0),
-guardsize (wincap.def_guard_page_size ())
+guardsize (wincap.def_guard_page_size ()), name (NULL)
 {
   schedparam.sched_priority = 0;
 }
@@ -2576,6 +2576,68 @@ pthread_getattr_np (pthread_t thread, pthread_attr_t *attr)
   return 0;
 }
 
+#define NAMELEN 16
+
+extern "C" int
+pthread_getname_np (pthread_t thread, char *buf, size_t buflen)
+{
+  char *name;
+
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  if (!thread->attr.name)
+    name = program_invocation_short_name;
+  else
+    name = thread->attr.name;
+
+  /* Return ERANGE if the provided buffer is less than NAMELEN.  Truncate and
+     zero-terminate the name to fit in buf.  This means we always return
+     something if the buffer is NAMELEN or larger, but there is no way to tell
+     if we have the whole name. */
+  if (buflen < NAMELEN)
+    return ERANGE;
+
+  int ret = 0;
+  __try
+    {
+      strlcpy (buf, name, buflen);
+    }
+  __except (NO_ERROR)
+    {
+      ret = EFAULT;
+    }
+  __endtry
+
+  return ret;
+}
+
+extern "C" int
+pthread_setname_np (pthread_t thread, const char *name)
+{
+  char *oldname, *cp;
+
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  if (strlen (name) > NAMELEN)
+    return ERANGE;
+
+  cp = strdup (name);
+  if (!cp)
+    return ENOMEM;
+
+  oldname = thread->attr.name;
+  thread->attr.name = cp;
+
+  if (oldname)
+    free (oldname);
+
+  return 0;
+}
+
+#undef NAMELEN
+
 /* provided for source level compatability.
    See http://www.opengroup.org/onlinepubs/007908799/xsh/pthread_getconcurrency.html
 */
diff --git a/winsup/cygwin/thread.h b/winsup/cygwin/thread.h
index 5d51913..48fb6fb 100644
--- a/winsup/cygwin/thread.h
+++ b/winsup/cygwin/thread.h
@@ -240,6 +240,7 @@ public:
   void *stackaddr;
   size_t stacksize;
   size_t guardsize;
+  char *name;
 
   pthread_attr ();
   ~pthread_attr ();
diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
index e3c4ded..7e39316 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -64,6 +64,10 @@ Support AzureAD accounts.
 "nobody" account support for WinFSP.
 </para></listitem>
 
+<listitem><para>
+New API: pthread_getname_np, pthread_setname_np.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 8d86a12..babf115 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1337,6 +1337,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
     pow10l
     ppoll
     pthread_getattr_np
+    pthread_getname_np
+    pthread_setname_np
     pthread_sigqueue
     ptsname_r
     putwc_unlocked
-- 
2.8.3
