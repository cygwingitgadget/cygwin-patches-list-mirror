Return-Path: <cygwin-patches-return-7599-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28677 invoked by alias); 24 Feb 2012 03:38:30 -0000
Received: (qmail 28666 invoked by uid 22791); 24 Feb 2012 03:38:28 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 24 Feb 2012 03:38:14 +0000
Received: by iaeh11 with SMTP id h11so3098528iae.2        for <cygwin-patches@cygwin.com>; Thu, 23 Feb 2012 19:38:14 -0800 (PST)
Received-SPF: pass (google.com: domain of yselkowitz@gmail.com designates 10.43.51.135 as permitted sender) client-ip=10.43.51.135;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of yselkowitz@gmail.com designates 10.43.51.135 as permitted sender) smtp.mail=yselkowitz@gmail.com; dkim=pass header.i=yselkowitz@gmail.com
Received: from mr.google.com ([10.43.51.135])        by 10.43.51.135 with SMTP id vi7mr535196icb.5.1330054694203 (num_hops = 1);        Thu, 23 Feb 2012 19:38:14 -0800 (PST)
Received: by 10.43.51.135 with SMTP id vi7mr442121icb.5.1330054694161;        Thu, 23 Feb 2012 19:38:14 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id b6sm520211igj.7.2012.02.23.19.38.12        (version=SSLv3 cipher=OTHER);        Thu, 23 Feb 2012 19:38:13 -0800 (PST)
Message-ID: <1330054695.6828.15.camel@YAAKOV04>
Subject: [PATCH] Add pthread_getname_np, pthread_setname_np
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Fri, 24 Feb 2012 03:38:00 -0000
Content-Type: multipart/mixed; boundary="=-ucTwx4wK8jHAb2vS70Pm"
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00022.txt.bz2


--=-ucTwx4wK8jHAb2vS70Pm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1069

This patchset adds pthread_getname_np and pthread_setname_np.  These
were added to glibc in 2.12[1] and are also present in some form on
NetBSD and several UNIXes.  IIUC recent versions of GDB can benefit from
this support.

The code is based on NetBSD's implementation with changes to better
match Linux behaviour.  It does differ from Linux in two points:

* The thread name is not affected by changing __progname (or
program_invocation_short_name on Linux).  I used the latter because it
is cheaper than the pinfo->progname dance (e.g. in
format_process_stat()).

* pthread_setname_np(thr, NULL) segfaults on Linux (and NetBSD), but our
snprintf is apparently more robust and treats it as an empty string.

I'll leave it up to you to decide if either of these matter.

I implemented this via class pthread_attr to make it easier to add
pthread_attr_[gs]etname_np (present in NetBSD and some UNIXes) should it
ever be added to Linux (or we decide we want it anyway).

Patches and test code attached.


Yaakov

[1] http://sourceware.org/git/?p=glibc.git;a=blob;f=NEWS

--=-ucTwx4wK8jHAb2vS70Pm
Content-Disposition: attachment; filename="cygwin-pthread_getname_np.patch"
Content-Type: text/x-patch; name="cygwin-pthread_getname_np.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 6313

2012-02-??  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (pthread_getname_np): Export.
	(pthread_setname_np): Export.
	* posix.sgml (std-gnu): Add pthread_getname_np and pthread_setname_np.
	* thread.cc (pthread_attr::pthread_attr): Initialize name element.
	(pthread_getname_np): New function.
	(pthread_setname_np): New function.
	* thread.h (class pthread_attr): Add name element.
	* include/pthread.h (pthread_getname_np): Declare.
	(pthread_setname_np): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.254
diff -u -p -r1.254 cygwin.din
--- cygwin.din	22 Feb 2012 01:58:24 -0000	1.254
+++ cygwin.din	23 Feb 2012 06:27:21 -0000
@@ -1226,6 +1226,7 @@ pthread_exit SIGFE
 pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
 pthread_getcpuclockid SIGFE
+pthread_getname_np SIGFE
 pthread_getschedparam SIGFE
 pthread_getsequence_np SIGFE
 pthread_getspecific SIGFE
@@ -1266,6 +1267,7 @@ pthread_self SIGFE
 pthread_setcancelstate SIGFE
 pthread_setcanceltype SIGFE
 pthread_setconcurrency SIGFE
+pthread_setname_np SIGFE
 pthread_setschedparam SIGFE
 pthread_setschedprio SIGFE
 pthread_setspecific SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.76
diff -u -p -r1.76 posix.sgml
--- posix.sgml	22 Feb 2012 01:58:24 -0000	1.76
+++ posix.sgml	23 Feb 2012 06:27:21 -0000
@@ -1133,6 +1133,8 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pow10f
     ppoll
     pthread_getattr_np
+    pthread_getname_np
+    pthread_setname_np
     pthread_sigqueue
     ptsname_r
     removexattr
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.256
diff -u -p -r1.256 thread.cc
--- thread.cc	14 Feb 2012 09:45:21 -0000	1.256
+++ thread.cc	23 Feb 2012 06:27:22 -0000
@@ -27,6 +27,7 @@ details. */
 #include "miscfuncs.h"
 #include "path.h"
 #include <stdlib.h>
+#include <stdio.h>
 #include "sigproc.h"
 #include "fhandler.h"
 #include "dtable.h"
@@ -1124,7 +1125,8 @@ pthread::resume ()
 pthread_attr::pthread_attr ():verifyable_object (PTHREAD_ATTR_MAGIC),
 joinable (PTHREAD_CREATE_JOINABLE), contentionscope (PTHREAD_SCOPE_PROCESS),
 inheritsched (PTHREAD_INHERIT_SCHED), stackaddr (NULL),
-stacksize (PTHREAD_DEFAULT_STACKSIZE), guardsize (PTHREAD_DEFAULT_GUARDSIZE)
+stacksize (PTHREAD_DEFAULT_STACKSIZE), guardsize (PTHREAD_DEFAULT_GUARDSIZE),
+name (NULL)
 {
   schedparam.sched_priority = 0;
 }
@@ -2547,6 +2549,55 @@ pthread_getattr_np (pthread_t thread, pt
   return 0;
 }
 
+#define NAMELEN 16
+
+extern "C" int
+pthread_getname_np (pthread_t thread, char *buf, size_t buflen)
+{
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+  if (buflen < NAMELEN)
+    return ERANGE;
+
+  myfault efault;
+  if (efault.faulted ())
+    return EFAULT;
+
+  if (!thread->attr.name)
+    strlcpy (buf, program_invocation_short_name, NAMELEN);
+  else
+    strlcpy (buf, thread->attr.name, NAMELEN);
+  return 0;
+}
+
+extern "C" int
+pthread_setname_np (pthread_t thread, const char *name)
+{
+  int namelen;
+  char *oldname, *cp, newname[NAMELEN];
+
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  namelen = snprintf(newname, NAMELEN, name);
+  if (namelen >= NAMELEN)
+    return ERANGE;
+
+  cp = strdup(newname);
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
+#undef NAMELEN
+
 /* provided for source level compatability.
    See http://www.opengroup.org/onlinepubs/007908799/xsh/pthread_getconcurrency.html
 */
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.127
diff -u -p -r1.127 thread.h
--- thread.h	13 Feb 2012 13:12:37 -0000	1.127
+++ thread.h	23 Feb 2012 06:27:22 -0000
@@ -261,6 +261,7 @@ public:
   void *stackaddr;
   size_t stacksize;
   size_t guardsize;
+  char *name;
 
   pthread_attr ();
   ~pthread_attr ();
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.36
diff -u -p -r1.36 pthread.h
--- include/pthread.h	13 Feb 2012 01:46:46 -0000	1.36
+++ include/pthread.h	23 Feb 2012 06:27:22 -0000
@@ -203,6 +199,8 @@ void pthread_testcancel (void);
 /* Non posix calls */
 
 int pthread_getattr_np (pthread_t, pthread_attr_t *);
+int pthread_getname_np (pthread_t, char *, size_t) __attribute__((nonnull(2)));
+int pthread_setname_np (pthread_t, const char *) __attribute__((nonnull(2)));
 int pthread_sigqueue (pthread_t *, int, const union sigval);
 int pthread_suspend (pthread_t);
 int pthread_continue (pthread_t);
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.364
diff -u -p -r1.364 version.h
--- include/cygwin/version.h	22 Feb 2012 01:58:24 -0000	1.364
+++ include/cygwin/version.h	23 Feb 2012 06:27:22 -0000
@@ -429,12 +429,13 @@ details. */
       258: Export get_current_dir_name.
       259: Export pthread_sigqueue.
       260: Export scandirat.
+      261: Export pthread_getname_np, pthread_setname_np.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 260
+#define CYGWIN_VERSION_API_MINOR 261
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: release/1.7.11
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/release/1.7.11,v
retrieving revision 1.3
diff -u -p -r1.3 1.7.11
--- release/1.7.11	22 Feb 2012 02:07:07 -0000	1.3
+++ release/1.7.11	24 Feb 2012 03:10:38 -0000
@@ -1,7 +1,7 @@
 What's new:
 -----------
 
-- New API: scandirat.
+- New API: pthread_getname_np, pthread_setname_np, scandirat.
 
 
 What changed:

--=-ucTwx4wK8jHAb2vS70Pm
Content-Disposition: attachment; filename="doc-pthread_getname_np.patch"
Content-Type: text/x-patch; name="doc-pthread_getname_np.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 640

2012-02-??  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.11): Document pthread_getname_np
	and pthread_setname_np.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.102
diff -u -p -r1.102 new-features.sgml
--- new-features.sgml	22 Feb 2012 02:06:15 -0000	1.102
+++ new-features.sgml	24 Feb 2012 03:18:05 -0000
@@ -5,7 +5,7 @@
 <itemizedlist mark="bullet">
 
 <listitem><para>
-New API: scandirat.
+New API: pthread_getname_np, pthread_setname_np, scandirat.
 </para></listitem>
 
 </itemizedlist>

--=-ucTwx4wK8jHAb2vS70Pm
Content-Disposition: attachment; filename="pthread-getname-test.c"
Content-Type: text/x-csrc; name="pthread-getname-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3511

/*
 * The _np isn't a joke, this really isn't portable:
 * IBM i, MKS: both functions take two arguments
 * NetBSD, Tru64, VMS: both functions take three arguments
 * QNX, Linux: getname takes three arguments, setname takes two
 *
 * Obviously I could only test with Linux and NetBSD, and my patch
 * tries to follow Linux behaviour:
 * - default thread name: empty on NetBSD, exe name on Linux/Cygwin
 * - program_invocation_short_name and __progname have no effect on NetBSD
 *   or Linux, but does on Cygwin
 * - max name length: 32 on NetBSD (EINVAL), 16 on Linux/Cygwin (ERANGE)
 * - getname with NULL buffer: SEGV on NetBSD, EFAULT on Linux/Cygwin.
 * - setname with NULL string: SEGV on NetBSD/Linux, "" on Cygwin.
 *
 * cc -pthread -o pthread-getname-test pthread-getname-test.c
 */

#define _GNU_SOURCE
#include <errno.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef __CYGWIN__
#include <dlfcn.h>
#include <cygwin/version.h>
#endif

extern char *__progname;

#ifdef __NetBSD__
/* setname takes three arguments */
#define THIRDARG , 0
#else
#define THIRDARG
#endif

#ifdef PTHREAD_MAX_NAMELEN_NP  // e.g. NetBSD
#define NAMELEN PTHREAD_MAX_NAMELEN_NP
#else
#define NAMELEN 16
#endif

int
main(void)
{
#if defined(__CYGWIN__) && CYGWIN_VERSION_API_MINOR < 261
  void *libc = dlopen ("cygwin1.dll", 0);
  int (*pthread_getname_np) (pthread_t, char *, size_t) = dlsym (libc, "pthread_getname_np");
  int (*pthread_setname_np) (pthread_t, const char *) = dlsym (libc, "pthread_setname_np");
#endif

  char *buf = (char *) malloc (NAMELEN);
  pthread_t thr = pthread_self ();
  int ret;

#ifndef __NetBSD__ // segfaults
  ret = pthread_getname_np (thr, NULL, NAMELEN-1); // null buffer and too short
  printf ("getname_np: %s\n", strerror (ret));

  ret = pthread_getname_np (thr, NULL, NAMELEN); // null buffer
  printf ("getname_np: %s\n", strerror (ret));
#endif

  ret = pthread_getname_np (thr, buf, NAMELEN-1); // too short
  printf ("getname_np: %s\n", strerror (ret));

  ret = pthread_getname_np (thr, buf, NAMELEN); // just right
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);

#ifndef __NetBSD__  // GNU extension
  program_invocation_short_name = "foobar";
  ret = pthread_getname_np (thr, buf, NAMELEN); // no effect
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);
#endif

  __progname = "foobar";
  ret = pthread_getname_np (thr, buf, NAMELEN); // no effect
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);

#if !defined(__GLIBC__) && !defined(__NetBSD__) // segfaults
  ret = pthread_setname_np (thr, NULL); // null string
  printf ("setname_np: %s\n", strerror (ret));
  ret = pthread_getname_np (thr, buf, NAMELEN);
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);
#endif

  ret = pthread_setname_np (thr, "" THIRDARG); // empty string
  printf ("setname_np: %s\n", strerror (ret));
  ret = pthread_getname_np (thr, buf, NAMELEN);
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);

  ret = pthread_setname_np (thr, "12345678901234567890123456789012" THIRDARG); // too long
  printf ("setname_np: %s\n", strerror (ret));
  ret = pthread_getname_np (thr, buf, NAMELEN);  // Linux: still empty
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);

  ret = pthread_setname_np (thr, "123456789012345" THIRDARG); // just right for all
  printf ("setname_np: %s\n", strerror (ret));
  ret = pthread_getname_np (thr, buf, NAMELEN);
  printf ("getname_np: %s: '%s'\n", strerror (ret), buf);

  return 0;
}

--=-ucTwx4wK8jHAb2vS70Pm--
