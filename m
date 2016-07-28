Return-Path: <cygwin-patches-return-8604-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 128656 invoked by alias); 28 Jul 2016 11:44:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127673 invoked by uid 89); 28 Jul 2016 11:44:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.2 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2 spammy=cp, sk:wwwope, sk:www.ope, xsh
X-HELO: rgout03.bt.lon5.cpcloud.co.uk
Received: from rgout03.bt.lon5.cpcloud.co.uk (HELO rgout03.bt.lon5.cpcloud.co.uk) (65.20.0.180) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 28 Jul 2016 11:44:45 +0000
X-OWM-Source-IP: 86.179.112.245 (GB)
X-OWM-Env-Sender: jonturney@btinternet.com
X-Junkmail-Premium-Raw: score=27/50,refid=2.7.2:2016.7.28.103916:17:27.888,ip=86.179.112.245,rules=__HAS_FROM, __TO_MALFORMED_2, __TO_NO_NAME, __HAS_CC_HDR, __HAS_MSGID, __SANE_MSGID, __HAS_X_MAILER, __IN_REP_TO, __REFERENCES, __ANY_URI, __HTTPS_URI, __URI_WITH_PATH, URI_ENDS_IN_HTML, __CP_URI_IN_BODY, __URI_IN_BODY, __MIME_TEXT_ONLY, RDNS_GENERIC_POOLED, __URI_NS, SXL_IP_DYNAMIC[245.112.179.86.fur], HTML_00_01, HTML_00_10, RDNS_SUSP_GENERIC, __SINGLE_URI_TEXT, SINGLE_URI_IN_BODY, MULTIPLE_RCPTS_RND, RDNS_SUSP, IN_REP_TO, REFERENCES, MSG_THREAD, LEGITIMATE_NEGATE
Received: from localhost.localdomain (86.179.112.245) by rgout03.bt.lon5.cpcloud.co.uk (8.6.122.06) (authenticated as jonturney@btinternet.com)        id 5799EA7C0000E186; Thu, 28 Jul 2016 12:44:43 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 1/2] Add pthread_getname_np and pthread_setname_np
Date: Thu, 28 Jul 2016 11:44:00 -0000
Message-Id: <20160728114341.1728-2-jon.turney@dronecode.org.uk>
In-Reply-To: <20160728114341.1728-1-jon.turney@dronecode.org.uk>
References: <20160728114341.1728-1-jon.turney@dronecode.org.uk>
X-SW-Source: 2016-q3/txt/msg00012.txt.bz2

This patch adds pthread_getname_np and pthread_setname_np.

These were added to glibc in 2.12[1] and are also present in some form on
NetBSD and several UNIXes.

The code is based on NetBSD's implementation with changes to better match
Linux behaviour.

Implementation quirks:

* pthread_setname_np with a NULL pointer segfaults (as linux)

* pthread_setname_np accepts names longer than 16 characters (linux returns
ERANGE)

* pthread_getname_np with a NULL pointer returns EFAULT (as linux)

* pthread_getname_np with a buffer length of less than 16 returns ERANGE (as
linux)

* pthread_getname_np truncates the thread name to fit the buffer length.
This guarantees success even when the default thread name is longer than 16
characters, but means there is no way to discover the actual length of the
thread name. (Linux always truncates the thread name to 16 characters)

* Changing program_invocation_short_name changes the default thread name.

I'll leave it up to you to decide any of these matter.

This is implemented via class pthread_attr to make it easier to add
pthread_attr_[gs]etname_np (present in NetBSD and some UNIXes) should it
ever be added to Linux (or we decide we want it anyway).

[1] https://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS;h=d55a844d4ec06d164cb786c6c9f403a9672a674d;hb=e28c88707ef0529593fccedf1a94c3fce3df0ef3

Signed-off-by: Jon Turney <jon.turney@dronecode.org.uk>
---
 winsup/cygwin/common.din               |  2 ++
 winsup/cygwin/include/cygwin/version.h |  3 +-
 winsup/cygwin/include/pthread.h        |  2 ++
 winsup/cygwin/release/2.6.0            |  4 +++
 winsup/cygwin/thread.cc                | 61 +++++++++++++++++++++++++++++++++-
 winsup/cygwin/thread.h                 |  1 +
 winsup/doc/new-features.xml            | 12 +++++++
 winsup/doc/posix.xml                   |  2 ++
 8 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 winsup/cygwin/release/2.6.0

diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
index d8df00e..1ebba2b 100644
--- a/winsup/cygwin/common.din
+++ b/winsup/cygwin/common.din
@@ -1014,6 +1014,7 @@ pthread_exit SIGFE
 pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
 pthread_getcpuclockid SIGFE
+pthread_getname_np SIGFE
 pthread_getschedparam SIGFE
 pthread_getsequence_np SIGFE
 pthread_getspecific SIGFE
@@ -1054,6 +1055,7 @@ pthread_self SIGFE
 pthread_setcancelstate SIGFE
 pthread_setcanceltype SIGFE
 pthread_setconcurrency SIGFE
+pthread_setname_np SIGFE
 pthread_setschedparam SIGFE
 pthread_setschedprio SIGFE
 pthread_setspecific SIGFE
diff --git a/winsup/cygwin/include/cygwin/version.h b/winsup/cygwin/include/cygwin/version.h
index 1f5bf72..d403f0e 100644
--- a/winsup/cygwin/include/cygwin/version.h
+++ b/winsup/cygwin/include/cygwin/version.h
@@ -454,12 +454,13 @@ details. */
        nexttowardf, nexttowardl, pow10l, powl, remainderl, remquol, roundl,
        scalbl, scalblnl, scalbnl, sincosl, sinhl, sinl, tanhl, tanl,
        tgammal, truncl.
+  298: Export pthread_getname_np, pthread_setname_np.
 
   Note that we forgot to bump the api for ualarm, strtoll, strtoull,
   sigaltstack, sethostname. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 297
+#define CYGWIN_VERSION_API_MINOR 298
 
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
new file mode 100644
index 0000000..5f9f4db
--- /dev/null
+++ b/winsup/cygwin/release/2.6.0
@@ -0,0 +1,4 @@
+What's new:
+-----------
+
+- New API: pthread_getname_np, pthread_setname_np, scandirat.
diff --git a/winsup/cygwin/thread.cc b/winsup/cygwin/thread.cc
index d9271fc..e41e0c1 100644
--- a/winsup/cygwin/thread.cc
+++ b/winsup/cygwin/thread.cc
@@ -1099,7 +1099,7 @@ pthread::resume ()
 pthread_attr::pthread_attr ():verifyable_object (PTHREAD_ATTR_MAGIC),
 joinable (PTHREAD_CREATE_JOINABLE), contentionscope (PTHREAD_SCOPE_PROCESS),
 inheritsched (PTHREAD_INHERIT_SCHED), stackaddr (NULL), stacksize (0),
-guardsize (wincap.def_guard_page_size ())
+guardsize (wincap.def_guard_page_size ()), name (NULL)
 {
   schedparam.sched_priority = 0;
 }
@@ -2569,6 +2569,65 @@ pthread_getattr_np (pthread_t thread, pthread_attr_t *attr)
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
+  // Return ERANGE if the provided buffer is less than NAMELEN.  Truncate and
+  // zero-terminate the name to fit in buf.  This means we always return
+  // something if the buffer is NAMELEN or larger, but there is no way to tell
+  // if we have the whole name.
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
+#undef NAMELEN
+
+extern "C" int
+pthread_setname_np (pthread_t thread, const char *name)
+{
+  char *oldname, *cp;
+
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  cp = strdup(name);
+  if (!cp)
+    return ENOMEM;
+
+  oldname = thread->attr.name;
+  thread->attr.name = cp;
+
+  if (oldname)
+    free(oldname);
+
+  return 0;
+}
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
index 9d428e2..c9b9bee 100644
--- a/winsup/doc/new-features.xml
+++ b/winsup/doc/new-features.xml
@@ -4,6 +4,18 @@
 
 <sect1 id="ov-new"><title>What's new and what changed in Cygwin</title>
 
+<sect2 id="ov-new2.6"><title>What's new and what changed in 2.6</title>
+
+<itemizedlist mark="bullet">
+
+<listitem><para>
+New API: pthread_getname_np, pthread_setname_np.
+</para></listitem>
+
+</itemizedlist>
+
+<sect2>
+
 <sect2 id="ov-new2.5"><title>What's new and what changed in 2.5</title>
 
 <itemizedlist mark="bullet">
diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
index 83fa768..d502e30 100644
--- a/winsup/doc/posix.xml
+++ b/winsup/doc/posix.xml
@@ -1291,6 +1291,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008).</para>
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
