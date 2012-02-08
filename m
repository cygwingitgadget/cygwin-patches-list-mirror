Return-Path: <cygwin-patches-return-7593-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15218 invoked by alias); 8 Feb 2012 18:40:17 -0000
Received: (qmail 15201 invoked by uid 22791); 8 Feb 2012 18:40:14 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,T_RP_MATCHES_RCVD,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from mailout06.t-online.de (HELO mailout06.t-online.de) (194.25.134.19)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 08 Feb 2012 18:40:00 +0000
Received: from fwd19.aul.t-online.de (fwd19.aul.t-online.de )	by mailout06.t-online.de with smtp 	id 1RvCQw-0004aF-2G; Wed, 08 Feb 2012 19:39:58 +0100
Received: from [192.168.2.108] (Vs-8JGZOYhriR8aD7PlhXhoMdGf026iyYQUislCKUXcS27b+Xu9k0XlZyIl5L2PZmw@[79.224.120.156]) by fwd19.t-online.de	with esmtp id 1RvCQp-11c4Tg0; Wed, 8 Feb 2012 19:39:51 +0100
Message-ID: <4F32C174.1080509@t-online.de>
Date: Wed, 08 Feb 2012 18:40:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110928 Firefox/7.0.1 SeaMonkey/2.4.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix C++ compilation of wait(NULL)
Content-Type: multipart/mixed; boundary="------------010805040005070108030607"
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
X-SW-Source: 2012-q1/txt/msg00016.txt.bz2

This is a multi-part message in MIME format.
--------------010805040005070108030607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 105

This fixes the regression I introduced in sys/wait.h.

Sorry, and thanks for the bug report.

Christian


--------------010805040005070108030607
Content-Type: text/x-diff;
 name="cygwin-union_wait-4.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="cygwin-union_wait-4.patch"
Content-length: 1976

2012-02-08  Christian Franke  <franke@computer.org>

	* include/sys/wait.h: Remove C++ inline functions for `union wait'.
	For C++ use `void *' as __wait_status_ptr_t instead.
	This is less type safe but fixes compile error on `wait(NULL)'.
	Remove extra `;'. 

diff --git a/winsup/cygwin/include/sys/wait.h b/winsup/cygwin/include/sys/wait.h
index 71ede93..78f5d06 100644
--- a/winsup/cygwin/include/sys/wait.h
+++ b/winsup/cygwin/include/sys/wait.h
@@ -19,11 +19,16 @@ details. */
 extern "C" {
 #endif
 
-#ifdef __cplusplus
+#ifdef __INSIDE_CYGWIN__
 
 typedef int *__wait_status_ptr_t;
 
-#else /* !__cplusplus */
+#elif defined(__cplusplus)
+
+/* Attribute __transparent_union__ is only supported for C.  */
+typedef void *__wait_status_ptr_t;
+
+#else /* !__INSIDE_CYGWIN__ && !__cplusplus */
 
 /* Allow `int' and `union wait' for the status.  */
 typedef union
@@ -32,7 +37,7 @@ typedef union
     union wait *__union_wait_ptr;
   } __wait_status_ptr_t  __attribute__ ((__transparent_union__));
 
-#endif /* __cplusplus */
+#endif /* __INSIDE_CYGWIN__ */
 
 pid_t wait (__wait_status_ptr_t __status);
 pid_t waitpid (pid_t __pid, __wait_status_ptr_t __status, int __options);
@@ -77,17 +82,7 @@ inline int __wait_status_to_int (int __status)
   { return __status; }
 inline int __wait_status_to_int (const union wait & __status)
   { return __status.w_status; }
-
-/* C++ wait() variants for `union wait'.  */
-inline pid_t wait (union wait *__status)
-  { return wait ((int *) __status); }
-inline pid_t waitpid (pid_t __pid, union wait *__status, int __options)
-  { return waitpid(__pid, (int *) __status, __options); }
-inline pid_t wait3 (union wait *__status, int __options, struct rusage *__rusage)
-  { return wait3 ((int *) __status, __options, __rusage); }
-inline pid_t wait4 (pid_t __pid, union wait *__status, int __options, struct rusage *__rusage)
-  { return wait4 (__pid, (int *) __status, __options, __rusage); }
-};
+}
 
 #else /* !__cplusplus */
 

--------------010805040005070108030607--
