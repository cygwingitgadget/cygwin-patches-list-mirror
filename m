Return-Path: <cygwin-patches-return-8978-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 75888 invoked by alias); 20 Dec 2017 08:09:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 75061 invoked by uid 89); 20 Dec 2017 08:08:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-23.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY autolearn=ham version=3.3.2 spammy=25612, HTo:U*cygwin-patches
X-HELO: m0.truegem.net
Received: from m0.truegem.net (HELO m0.truegem.net) (69.55.228.47) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 20 Dec 2017 08:08:53 +0000
Received: (from daemon@localhost)	by m0.truegem.net (8.12.11/8.12.11) id vBK88qr8034050;	Wed, 20 Dec 2017 00:08:52 -0800 (PST)	(envelope-from mark@maxrnd.com)
Received: from 76-217-5-154.lightspeed.irvnca.sbcglobal.net(76.217.5.154), claiming to be "localhost.localdomain" via SMTP by m0.truegem.net, id smtpd8mttZx; Wed Dec 20 00:08:43 2017
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>
Subject: [PATCH] cygwin_internal methods to get/set thread name
Date: Wed, 20 Dec 2017 08:09:00 -0000
Message-Id: <20171220080832.2328-1-mark@maxrnd.com>
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00108.txt.bz2

Add support to cygwin_internal() for setting a cygthread name and getting or setting a pthread name.  Also add support for getting the internal i/o handle for a given file descriptor.
---
 winsup/cygwin/cygthread.cc         | 40 +++++++++++++++++++++++++++++++--
 winsup/cygwin/cygthread.h          |  1 +
 winsup/cygwin/external.cc          | 45 ++++++++++++++++++++++++++++++++++++--
 winsup/cygwin/include/sys/cygwin.h |  6 +++++
 4 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/cygthread.cc b/winsup/cygwin/cygthread.cc
index 4404e4a19..35eb48241 100644
--- a/winsup/cygwin/cygthread.cc
+++ b/winsup/cygwin/cygthread.cc
@@ -231,7 +231,7 @@ cygthread::create ()
   h = htobe;
 }
 
-/* Return the symbolic name of the current thread for debugging.
+/* Return the symbolic name of the given (or current) thread for debugging.
  */
 const char *
 cygthread::name (DWORD tid)
@@ -256,12 +256,48 @@ cygthread::name (DWORD tid)
     res = "main";
   else
     {
-      __small_sprintf (_my_tls.locals.unknown_thread_name, "unknown (%y)", tid);
+      /* courtesy: if tid==current thread is a pthread return its name */
+      int status = EINVAL;
+      if (tid == GetCurrentThreadId ())
+	status = pthread_getname_np (pthread_self (),
+			(char *) &_my_tls.locals.unknown_thread_name,
+			(size_t) sizeof (_my_tls.locals.unknown_thread_name));
+      if (status)
+	__small_sprintf (_my_tls.locals.unknown_thread_name,
+			 "unknown (%y)", tid);
       res = _my_tls.locals.unknown_thread_name;
     }
   return res;
 }
 
+/* Set the symbolic name of the given (or current) thread for debugging.
+ */
+int
+cygthread::setname (DWORD tid, const char *name)
+{
+  int i;
+  char *oldname;
+
+  if (!tid)
+    tid = GetCurrentThreadId ();
+
+  for (i = 0; i < (int) NTHREADS; i++)
+    if (threads[i].id == tid)
+      {
+	oldname = (char *) threads[i].__name;
+	break;
+      }
+
+  if (i >= (int) NTHREADS)
+    return ESRCH;
+
+  threads[i].__name = strdup (name);
+  if (oldname)
+    free (oldname);
+
+  return 0;
+}
+
 cygthread::operator
 HANDLE ()
 {
diff --git a/winsup/cygwin/cygthread.h b/winsup/cygwin/cygthread.h
index f3b0bf00d..016d5ca8f 100644
--- a/winsup/cygwin/cygthread.h
+++ b/winsup/cygwin/cygthread.h
@@ -36,6 +36,7 @@ class cygthread
   static DWORD WINAPI simplestub (VOID *);
   static DWORD main_thread_id;
   static const char *name (DWORD = 0);
+  static int setname (DWORD = 0, const char *name = NULL);
   void __reg2 callfunc (bool) __attribute__ ((noinline, ));
   void auto_release () {func = NULL;}
   void release (bool);
diff --git a/winsup/cygwin/external.cc b/winsup/cygwin/external.cc
index 3a9130efd..bfe112f2c 100644
--- a/winsup/cygwin/external.cc
+++ b/winsup/cygwin/external.cc
@@ -223,8 +223,41 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 
       case CW_SETTHREADNAME:
 	{
-	  set_errno (ENOSYS);
-	  res = 0;
+	  DWORD tid = va_arg (arg, DWORD);
+	  char *name = va_arg (arg, char *);
+
+	  int status = cygthread::setname (tid, name);
+	  if (status > 0)
+	    set_errno (status);
+	  else
+	    res = 0;
+	}
+	break;
+
+      case CW_GET_PTHREADNAME:
+	{
+	  pthread_t ptid = va_arg (arg, pthread_t);
+	  char *buf = va_arg (arg, char *);
+	  size_t buflen = va_arg (arg, size_t);
+
+	  int status = pthread_getname_np (ptid, buf, buflen);
+	  if (status > 0)
+	    set_errno (status);
+	  else
+	    res = 0;
+	}
+	break;
+
+      case CW_SET_PTHREADNAME:
+	{
+	  pthread_t ptid = va_arg (arg, pthread_t);
+	  char *name = va_arg (arg, char *);
+
+	  int status = pthread_setname_np (ptid, name);
+	  if (status > 0)
+	    set_errno (status);
+	  else
+	    res = 0;
 	}
 	break;
 
@@ -710,6 +743,14 @@ cygwin_internal (cygwin_getinfo_types t, ...)
 	}
 	break;
 
+      case CW_GET_IO_HANDLE_FROM_FD:
+	{
+	  int fd = va_arg(arg, int);
+	  fhandler_base *fh = cygheap->fdtab[fd];
+	  res = (uintptr_t) (fh->get_io_handle ());
+	}
+	break;
+
       default:
 	set_errno (ENOSYS);
     }
diff --git a/winsup/cygwin/include/sys/cygwin.h b/winsup/cygwin/include/sys/cygwin.h
index c5da87c65..741e7d62d 100644
--- a/winsup/cygwin/include/sys/cygwin.h
+++ b/winsup/cygwin/include/sys/cygwin.h
@@ -158,6 +158,9 @@ typedef enum
     CW_GETNSS_GRP_SRC,
     CW_EXCEPTION_RECORD_FROM_SIGINFO_T,
     CW_CYGHEAP_PROFTHR_ALL,
+    CW_GET_PTHREADNAME,
+    CW_SET_PTHREADNAME,
+    CW_GET_IO_HANDLE_FROM_FD,
   } cygwin_getinfo_types;
 
 #define CW_LOCK_PINFO CW_LOCK_PINFO
@@ -220,6 +223,9 @@ typedef enum
 #define CW_GETNSS_GRP_SRC CW_GETNSS_GRP_SRC
 #define CW_EXCEPTION_RECORD_FROM_SIGINFO_T CW_EXCEPTION_RECORD_FROM_SIGINFO_T
 #define CW_CYGHEAP_PROFTHR_ALL CW_CYGHEAP_PROFTHR_ALL
+#define CW_GET_PTHREADNAME CW_GET_PTHREADNAME
+#define CW_SET_PTHREADNAME CW_SET_PTHREADNAME
+#define CW_GET_IO_HANDLE_FROM_FD CW_GET_IO_HANDLE_FROM_FD
 
 /* Token type for CW_SET_EXTERNAL_TOKEN */
 enum
-- 
2.15.1
