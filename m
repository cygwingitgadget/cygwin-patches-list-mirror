Return-Path: <cygwin-patches-return-7510-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25096 invoked by alias); 5 Oct 2011 10:58:13 -0000
Received: (qmail 25085 invoked by uid 22791); 5 Oct 2011 10:58:12 -0000
X-SWARE-Spam-Status: No, hits=-1.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,TW_DR,TW_XF,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout08.t-online.de (HELO mailout08.t-online.de) (194.25.134.20)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 05 Oct 2011 10:57:55 +0000
Received: from fwd05.aul.t-online.de (fwd05.aul.t-online.de )	by mailout08.t-online.de with smtp 	id 1RBPAf-0000aF-BZ; Wed, 05 Oct 2011 12:57:53 +0200
Received: from [192.168.2.108] (bKVMvcZcohfbiJwOdnFjpT5PIkTCEi1FSQOcrc7tdE4KVbjUoeTV2-hgd3kVTziwIX@[79.224.114.200]) by fwd05.t-online.de	with esmtp id 1RBPAX-2F9IQ40; Wed, 5 Oct 2011 12:57:45 +0200
Message-ID: <4E8C3828.4010009@t-online.de>
Date: Wed, 05 Oct 2011 10:58:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Allow usage of union wait for wait() functions and macros
Content-Type: multipart/mixed; boundary="------------030407010905020801080100"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q4/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------030407010905020801080100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 410

The file include/sys/wait.h provides union wait but neither the wait() 
functions nor the W*() macros allow to actually use it. Compilation of 
cdrkit 1.1.11 fails because the configure check assumes that union wait 
is the status parameter type if its declaration exists.

The attached patch fixes this. It uses GCC extensions for C and 
overloading for C++. Works also with the old Cygwin gcc-3.

Christian


--------------030407010905020801080100
Content-Type: text/x-diff;
 name="cygwin-union_wait.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-union_wait.patch"
Content-length: 4445

2011-10-05  Christian Franke  <franke@computer.org>

	* include/cygwin/wait.h: Use new __wait_status_to_int()
	macro to access status value in W*() status checks.
	* include/sys/wait.h: Allow `int' and `union wait' as
	wait status parameter.  Change __wait_status_to_int()
	macro and wait () prototypes accordingly.  Add inline
	functions for C++.  Remove extra `;'.

diff --git a/winsup/cygwin/include/cygwin/wait.h b/winsup/cygwin/include/cygwin/wait.h
index bed81b7..e4edba2 100644
--- a/winsup/cygwin/include/cygwin/wait.h
+++ b/winsup/cygwin/include/cygwin/wait.h
@@ -1,6 +1,6 @@
 /* cygwin/wait.h
 
-   Copyright 2006, 2009 Red Hat, Inc.
+   Copyright 2006, 2009, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -16,6 +16,9 @@ details. */
 #define WCONTINUED 8
 #define __W_CONTINUED	0xffff
 
+/* Will be redefined in sys/wait.h.  */
+#define __wait_status_to_int(w)  (w)
+
 /* A status looks like:
       <2 bytes info> <2 bytes code>
 
@@ -25,13 +28,14 @@ details. */
       <code> == 80, there was a core dump.
 */
 
-#define WIFEXITED(w)	(((w) & 0xff) == 0)
-#define WIFSIGNALED(w)	(((w) & 0x7f) > 0 && (((w) & 0x7f) < 0x7f))
-#define WIFSTOPPED(w)	(((w) & 0xff) == 0x7f)
-#define WIFCONTINUED(w)	(((w) & 0xffff) == __W_CONTINUED)
-#define WEXITSTATUS(w)	(((w) >> 8) & 0xff)
-#define WTERMSIG(w)	((w) & 0x7f)
+#define WIFEXITED(w)	((__wait_status_to_int(w) & 0xff) == 0)
+#define WIFSIGNALED(w)	((__wait_status_to_int(w) & 0x7f) > 0 \
+			 && ((__wait_status_to_int(w) & 0x7f) < 0x7f))
+#define WIFSTOPPED(w)	((__wait_status_to_int(w) & 0xff) == 0x7f)
+#define WIFCONTINUED(w)	((__wait_status_to_int(w) & 0xffff) == __W_CONTINUED)
+#define WEXITSTATUS(w)	((__wait_status_to_int(w) >> 8) & 0xff)
+#define WTERMSIG(w)	(__wait_status_to_int(w) & 0x7f)
 #define WSTOPSIG	WEXITSTATUS
-#define WCOREDUMP(w)	(WIFSIGNALED(w) && (w & 0x80))
+#define WCOREDUMP(w)	(WIFSIGNALED(w) && (__wait_status_to_int(w) & 0x80))
 
 #endif /* _CYGWIN_WAIT_H */
diff --git a/winsup/cygwin/include/sys/wait.h b/winsup/cygwin/include/sys/wait.h
index 04bbae7..b355222 100644
--- a/winsup/cygwin/include/sys/wait.h
+++ b/winsup/cygwin/include/sys/wait.h
@@ -1,6 +1,6 @@
 /* sys/wait.h
 
-   Copyright 1997, 1998, 2001, 2002, 2003, 2004, 2006 Red Hat, Inc.
+   Copyright 1997, 1998, 2001, 2002, 2003, 2004, 2006, 2011 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -19,10 +19,25 @@ details. */
 extern "C" {
 #endif
 
-pid_t wait (int *);
-pid_t waitpid (pid_t, int *, int);
-pid_t wait3 (int *__status, int __options, struct rusage *__rusage);
-pid_t wait4 (pid_t __pid, int *__status, int __options, struct rusage *__rusage);
+#if defined(__cplusplus) || defined(__INSIDE_CYGWIN__)
+
+typedef int *__wait_status_ptr_t;
+
+#else
+
+/* Allow `int' and `union wait' for the status.  */
+typedef union
+  {
+    int *__int_ptr;
+    union wait *__union_wait_ptr;
+  } __wait_status_ptr_t  __attribute__ ((__transparent_union__));
+
+#endif
+
+pid_t wait (__wait_status_ptr_t __status);
+pid_t waitpid (pid_t __pid, __wait_status_ptr_t __status, int __options);
+pid_t wait3 (__wait_status_ptr_t __status, int __options, struct rusage *__rusage);
+pid_t wait4 (pid_t __pid, __wait_status_ptr_t __status, int __options, struct rusage *__rusage);
 
 union wait
   {
@@ -49,7 +64,37 @@ union wait
 #define	w_stopval	__wait_stopped.__w_stopval
 
 #ifdef __cplusplus
-};
+}
+#endif
+
+#ifndef __INSIDE_CYGWIN__
+
+/* Used in cygwin/wait.h, redefine to accept `int' and `union wait'.  */
+#undef __wait_status_to_int
+
+#ifdef __cplusplus
+
+inline int __wait_status_to_int (int __status)
+  { return __status; }
+inline int __wait_status_to_int (const union wait & __status)
+  { return __status.w_status; }
+
+/* C++ wait() variants for `union wait'.  */
+inline pid_t wait (union wait *__status)
+  { return wait ((int *) __status); }
+inline pid_t waitpid (pid_t __pid, union wait *__status, int __options)
+  { return waitpid(__pid, (int *) __status, __options); }
+inline pid_t wait3 (union wait *__status, int __options, struct rusage *__rusage)
+  { return wait3 ((int *) __status, __options, __rusage); }
+inline pid_t wait4 (pid_t __pid, union wait *__status, int __options, struct rusage *__rusage)
+  { return wait4 (__pid, (int *) __status, __options, __rusage); }
+
+#else
+
+#define __wait_status_to_int(__status)  (__extension__ \
+  (((union { __typeof(__status) __in; int __out; }) { .__in = (__status) }).__out))
+
+#endif
 #endif
 
 #endif

--------------030407010905020801080100--
