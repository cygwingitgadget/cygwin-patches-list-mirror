Return-Path: <cygwin-patches-return-7284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 728 invoked by alias); 2 May 2011 15:33:23 -0000
Received: (qmail 707 invoked by uid 22791); 2 May 2011 15:33:21 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-gx0-f171.google.com (HELO mail-gx0-f171.google.com) (209.85.161.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 May 2011 15:33:05 +0000
Received: by gxk22 with SMTP id 22so2544590gxk.2        for <cygwin-patches@cygwin.com>; Mon, 02 May 2011 08:33:04 -0700 (PDT)
Received: by 10.91.199.3 with SMTP id b3mr6772373agq.168.1304350384469;        Mon, 02 May 2011 08:33:04 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id w6sm5826936anf.6.2011.05.02.08.33.02        (version=SSLv3 cipher=OTHER);        Mon, 02 May 2011 08:33:03 -0700 (PDT)
Subject: [PATCH] pthread_attr_getstack{,addr}, pthread_getattr_np
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-WvJGNT90JLZigfBe9D6p"
Date: Mon, 02 May 2011 15:33:00 -0000
Message-ID: <1304350389.6972.11.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00050.txt.bz2


--=-WvJGNT90JLZigfBe9D6p
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 794

This implements pthread_attr_getstack(), pthread_attr_getstackaddr, and
pthread_getattr_np(), which I need for webkitgtk.

In essence, I added a stackaddr member to pthread_attr, which is
accessed (slightly differently) by pthread_attr_getstack{,attr},
behaving just as on Linux.  The bulk of the work is to support
pthread_getattr_np, which provides the real attributes of the given
thread, including the real stack address and size.

The pthread_attr_setstack{,addr} setters are not implemented, as I have
yet to find a way to set the thread stack address on Windows.  For that
reason I'm not defining _POSIX_THREAD_ATTR_STACKADDR, as the feature is
not yet (fully) implemented.

Patches for winsup/cygwin and winsup/doc, as well as a sample program
for Cygwin and Linux, attached.


Yaakov


--=-WvJGNT90JLZigfBe9D6p
Content-Disposition: attachment; filename="pthread_attr_getstack.patch"
Content-Type: text/x-patch; name="pthread_attr_getstack.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 10171

2011-05-01  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (pthread_attr_getstack): Export.
	(pthread_attr_getstackaddr): Export.
	(pthread_getattr_np): Export.
	* ntdll.h (enum _THREAD_INFORMATION_CLASS): Add ThreadBasicInformation.
	(struct _THREAD_BASIC_INFORMATION): Define.
	(NtQueryInformationThread): Declare.
	* posix.sgml (std-susv4): Add pthread_attr_getstack.
	(std-gnu): Add pthread_getattr_np.
	(std-deprec): Add pthread_attr_getstackaddr.
	(std-notimpl): Remove pthread_attr_[gs]etstackaddr, as they were
	removed from SUSv4.
	* thread.cc (pthread_attr::pthread_attr): Initialize stackaddr.
	(pthread_attr_getstack): New function.
	(pthread_attr_getstackaddr): New function.
	(pthread_attr_setstacksize): Return EINVAL if passed size less than
	PTHREAD_STACK_MIN, as required by POSIX.
	(pthread_getattr_np): New function.
	* thread.h (class pthread_attr): Add stackaddr member.
	* include/pthread.h (pthread_attr_getstack): Declare.
	(pthread_attr_getstackaddr): Declare unconditionally.
	(pthread_attr_setstack): Declare inside false conditional for reference.
	(pthread_getattr_np): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.236
diff -u -r1.236 cygwin.din
--- cygwin.din	18 Apr 2011 12:00:03 -0000	1.236
+++ cygwin.din	2 May 2011 04:12:54 -0000
@@ -1174,6 +1174,8 @@
 pthread_attr_getschedparam SIGFE
 pthread_attr_getschedpolicy SIGFE
 pthread_attr_getscope SIGFE
+pthread_attr_getstack SIGFE
+pthread_attr_getstackaddr SIGFE
 pthread_attr_getstacksize SIGFE
 pthread_attr_init SIGFE
 pthread_attr_setdetachstate SIGFE
@@ -1200,6 +1202,7 @@
 pthread_detach SIGFE
 pthread_equal SIGFE
 pthread_exit SIGFE
+pthread_getattr_np SIGFE
 pthread_getconcurrency SIGFE
 pthread_getschedparam SIGFE
 pthread_getsequence_np SIGFE
Index: ntdll.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/ntdll.h,v
retrieving revision 1.114
diff -u -r1.114 ntdll.h
--- ntdll.h	29 Apr 2011 08:27:11 -0000	1.114
+++ ntdll.h	2 May 2011 04:12:54 -0000
@@ -898,9 +898,19 @@
 
 typedef enum _THREAD_INFORMATION_CLASS
 {
+  ThreadBasicInformation = 0,
   ThreadImpersonationToken = 5
 } THREAD_INFORMATION_CLASS, *PTHREAD_INFORMATION_CLASS;
 
+typedef struct _THREAD_BASIC_INFORMATION {
+    NTSTATUS  ExitStatus;
+    PNT_TIB  TebBaseAddress;
+    CLIENT_ID  ClientId;
+    KAFFINITY  AffinityMask;
+    KPRIORITY  Priority;
+    KPRIORITY  BasePriority;
+} THREAD_BASIC_INFORMATION, *PTHREAD_BASIC_INFORMATION;
+
 #define RTL_QUERY_REGISTRY_SUBKEY 0x01
 #define RTL_QUERY_REGISTRY_TOPKEY 0x02
 #define RTL_QUERY_REGISTRY_REQUIRED 0x04
@@ -1058,6 +1068,8 @@
 					 ULONG, FILE_INFORMATION_CLASS);
   NTSTATUS NTAPI NtQueryInformationProcess (HANDLE, PROCESSINFOCLASS,
 					    PVOID, ULONG, PULONG);
+  NTSTATUS NTAPI NtQueryInformationThread (HANDLE, THREAD_INFORMATION_CLASS,
+					    PVOID, ULONG, PULONG);
   NTSTATUS NTAPI NtQueryInformationToken (HANDLE, TOKEN_INFORMATION_CLASS,
 					  PVOID, ULONG, PULONG);
   NTSTATUS NTAPI NtQueryObject (HANDLE, OBJECT_INFORMATION_CLASS, VOID *,
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.57
diff -u -r1.57 posix.sgml
--- posix.sgml	18 Apr 2011 12:00:03 -0000	1.57
+++ posix.sgml	2 May 2011 04:12:54 -0000
@@ -534,6 +534,7 @@
     pthread_attr_getschedparam
     pthread_attr_getschedpolicy
     pthread_attr_getscope
+    pthread_attr_getstack
     pthread_attr_getstacksize
     pthread_attr_init
     pthread_attr_setdetachstate
@@ -1117,6 +1118,7 @@
     pow10
     pow10f
     ppoll
+    pthread_getattr_np
     removexattr
     setxattr
     strchrnul
@@ -1230,6 +1232,7 @@
     mallopt			(SVID)
     mktemp			(SUSv3)
     on_exit			(SunOS)
+    pthread_attr_getstackaddr	(SUSv3)
     pthread_continue		(XPG2)
     pthread_getsequence_np	(Tru64)
     pthread_suspend		(XPG2)
@@ -1375,11 +1378,8 @@
     psiginfo
     psignal
     pthread_attr_getguardsize
-    pthread_attr_getstack
-    pthread_attr_getstackaddr
     pthread_attr_setguardsize
     pthread_attr_setstack
-    pthread_attr_setstackaddr
     pthread_barrier[...]
     pthread_condattr_getclock
     pthread_condattr_setclock
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.233
diff -u -r1.233 thread.cc
--- thread.cc	30 Apr 2011 16:34:48 -0000	1.233
+++ thread.cc	2 May 2011 04:12:55 -0000
@@ -1085,7 +1085,7 @@
 
 pthread_attr::pthread_attr ():verifyable_object (PTHREAD_ATTR_MAGIC),
 joinable (PTHREAD_CREATE_JOINABLE), contentionscope (PTHREAD_SCOPE_PROCESS),
-inheritsched (PTHREAD_INHERIT_SCHED), stacksize (0)
+inheritsched (PTHREAD_INHERIT_SCHED), stackaddr (NULL), stacksize (0)
 {
   schedparam.sched_priority = 0;
 }
@@ -2238,10 +2238,34 @@
 }
 
 extern "C" int
+pthread_attr_getstack (const pthread_attr_t *attr, void **addr, size_t *size)
+{
+  if (!pthread_attr::is_good_object (attr))
+    return EINVAL;
+  /* uses lowest address of stack on all platforms */
+  *addr = (void *)((int)(*attr)->stackaddr - (*attr)->stacksize);
+  *size = (*attr)->stacksize;
+  return 0;
+}
+
+extern "C" int
+pthread_attr_getstackaddr (const pthread_attr_t *attr, void **addr)
+{
+  if (!pthread_attr::is_good_object (attr))
+    return EINVAL;
+  /* uses stack address, which is the higher address on platforms
+     where the stack grows downwards, such as x86 */
+  *addr = (*attr)->stackaddr;
+  return 0;
+}
+
+extern "C" int
 pthread_attr_setstacksize (pthread_attr_t *attr, size_t size)
 {
   if (!pthread_attr::is_good_object (attr))
     return EINVAL;
+  if (size < PTHREAD_STACK_MIN)
+    return EINVAL;    
   (*attr)->stacksize = size;
   return 0;
 }
@@ -2381,6 +2405,51 @@
   return 0;
 }
 
+extern "C" int
+pthread_getattr_np (pthread_t thread, pthread_attr_t *attr)
+{
+  const size_t sizeof_tbi = sizeof (THREAD_BASIC_INFORMATION);
+  PTHREAD_BASIC_INFORMATION tbi;
+  NTSTATUS ret;
+
+  if (!pthread::is_good_object (&thread))
+    return ESRCH;
+
+  /* attr may not be pre-initialized */
+  if (!pthread_attr::is_good_object (attr))
+  {
+    int rv = pthread_attr_init (attr);
+    if (rv != 0)
+      return rv;
+  }
+
+  (*attr)->joinable = thread->attr.joinable;
+  (*attr)->contentionscope = thread->attr.contentionscope;
+  (*attr)->inheritsched = thread->attr.inheritsched;
+  (*attr)->schedparam = thread->attr.schedparam;
+
+  tbi = (PTHREAD_BASIC_INFORMATION) malloc (sizeof_tbi);
+  ret = NtQueryInformationThread (thread->win32_obj_id, ThreadBasicInformation,
+                                  tbi, sizeof_tbi, NULL);
+
+  if (NT_SUCCESS (ret))
+    {
+      PNT_TIB tib = tbi->TebBaseAddress;
+      (*attr)->stackaddr = tib->StackBase;
+      /* stack grows downwards on x86 systems */
+      (*attr)->stacksize = (int)tib->StackBase - (int)tib->StackLimit;
+    }
+  else
+    {
+      debug_printf ("NtQueryInformationThread(ThreadBasicInformation), "
+                    "status %p", ret);
+      (*attr)->stackaddr = thread->attr.stackaddr;
+      (*attr)->stacksize = thread->attr.stacksize;
+    }
+
+  return 0;
+}
+
 /* provided for source level compatability.
    See http://www.opengroup.org/onlinepubs/007908799/xsh/pthread_getconcurrency.html
 */
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.117
diff -u -r1.117 thread.h
--- thread.h	30 Apr 2011 10:20:25 -0000	1.117
+++ thread.h	2 May 2011 04:12:55 -0000
@@ -250,6 +250,7 @@
   int contentionscope;
   int inheritsched;
   struct sched_param schedparam;
+  void *stackaddr;
   size_t stacksize;
 
   pthread_attr ();
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.30
diff -u -r1.30 pthread.h
--- include/pthread.h	15 Apr 2011 09:22:14 -0000	1.30
+++ include/pthread.h	2 May 2011 04:12:55 -0000
@@ -76,6 +76,8 @@
 int pthread_attr_getschedparam (const pthread_attr_t *, struct sched_param *);
 int pthread_attr_getschedpolicy (const pthread_attr_t *, int *);
 int pthread_attr_getscope (const pthread_attr_t *, int *);
+int pthread_attr_getstack (const pthread_attr_t *, void **, size_t *);
+int pthread_attr_getstackaddr (const pthread_attr_t *, void **);
 int pthread_attr_init (pthread_attr_t *);
 int pthread_attr_setdetachstate (pthread_attr_t *, int);
 int pthread_attr_setinheritsched (pthread_attr_t *, int);
@@ -88,7 +90,7 @@
  * Not supported or implemented. The prototypes are here so if someone greps the
  * source they will see these comments
  */
-int pthread_attr_getstackaddr (const pthread_attr_t *, void **);
+int pthread_attr_setstack (pthread_attr_t *, void *, size_t);
 int pthread_attr_setstackaddr (pthread_attr_t *, void *);
 #endif
 
@@ -200,6 +202,7 @@
 
 /* Non posix calls */
 
+int pthread_getattr_np (pthread_t, pthread_attr_t *);
 int pthread_suspend (pthread_t);
 int pthread_continue (pthread_t);
 int pthread_yield (void);
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.341
diff -u -r1.341 version.h
--- include/cygwin/version.h	18 Apr 2011 12:00:04 -0000	1.341
+++ include/cygwin/version.h	2 May 2011 04:12:55 -0000
@@ -405,12 +405,14 @@
 	   pthread_spin_trylock, pthread_spin_unlock.
       239: Export pthread_setschedprio.
       240: Export ppoll.
+      241: Export pthread_attr_getstack, pthread_attr_getstackaddr,
+	   pthread_getattr_np.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 240
+#define CYGWIN_VERSION_API_MINOR 241
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-WvJGNT90JLZigfBe9D6p
Content-Disposition: attachment; filename="doc-pthread_attr_getstack.patch"
Content-Type: text/x-patch; name="doc-pthread_attr_getstack.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 655

2011-05-02  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document new pthread APIs.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.76
diff -u -r1.76 new-features.sgml
--- new-features.sgml	2 May 2011 11:56:36 -0000	1.76
+++ new-features.sgml	2 May 2011 15:17:54 -0000
@@ -39,7 +39,8 @@
 </para></listitem>
 
 <listitem><para>
-Other new API: ppoll.
+Other new API: ppoll, pthread_attr_getstack, pthread_attr_getstackaddr,
+pthread_getattr_np, pthread_setschedprio.
 </para></listitem>
 
 </itemizedlist>

--=-WvJGNT90JLZigfBe9D6p
Content-Disposition: attachment; filename="pthread-attr-test.c"
Content-Type: text/x-csrc; name="pthread-attr-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1046

#pragma CCOD:script no
#pragma CCOD:options -pthread

#define _GNU_SOURCE
#include <limits.h>
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#define NUM_THREADS 3

void *hello (void *threadid) {
	sleep(1);
	return NULL;
}

int main(void) {
	pthread_t thr[NUM_THREADS];
	pthread_attr_t attr, attr2;
	void *stackbottom;
	void *stacktop;
	size_t stacksize;
	int t;

	pthread_attr_init(&attr);
	pthread_attr_setstacksize(&attr, PTHREAD_STACK_MIN);

	pthread_attr_getstack(&attr, &stackbottom, &stacksize);
	pthread_attr_getstackaddr(&attr, &stacktop);
	printf("Initialization: %p -> %p = %d kB\n", stackbottom, stacktop, stacksize >> 10);

	for (t=0; t<NUM_THREADS; t++) {
		pthread_create(&thr[t], &attr, hello, (void *)t);

		pthread_getattr_np(thr[t], &attr2);
		pthread_attr_getstack(&attr2, &stackbottom, &stacksize);
		pthread_attr_getstackaddr(&attr2, &stacktop);
		printf("Thread %d: %p -> %p = %d kB\n", t, stackbottom, stacktop, stacksize >> 10);
		pthread_attr_destroy(&attr2);
	}
	pthread_attr_destroy(&attr);

	return 0;
}

--=-WvJGNT90JLZigfBe9D6p--
