Return-Path: <cygwin-patches-return-7214-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1499 invoked by alias); 28 Mar 2011 22:13:57 -0000
Received: (qmail 1482 invoked by uid 22791); 28 Mar 2011 22:13:56 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from smtpout.karoo.kcom.com (HELO smtpout.karoo.kcom.com) (212.50.160.34)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 28 Mar 2011 22:13:49 +0000
Received: from 213-152-38-55.dsl.eclipse.net.uk (HELO [192.168.0.8]) ([213.152.38.55])  by smtpout.karoo.kcom.com with ESMTP; 28 Mar 2011 23:13:47 +0100
Message-ID: <4D91082B.1050102@dronecode.org.uk>
Date: Mon, 28 Mar 2011 22:13:00 -0000
From: Jon TURNEY <jon.turney@dronecode.org.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix return value and errno set by sem_init(), sem_destroy() and sem_close()
Content-Type: multipart/mixed; boundary="------------000703050805060604060804"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00069.txt.bz2

This is a multi-part message in MIME format.
--------------000703050805060604060804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2576


While looking into some mysterious failures of sem_init() in python, I was
somewhat surprised to find the following comment in python/thread_pthread.h:

> /*
>  * As of February 2002, Cygwin thread implementations mistakenly report error
>  * codes in the return value of the sem_ calls (like the pthread_ functions).
>  * Correct implementations return -1 and put the code in errno. This supports
>  * either.
>  */

While this comment refers to sem_wait() and sem_trywait(), which seem to have
been fixed since [1], it seems that sem_init(), sem_destroy() and sem_close()
are still non-conformant with SUS in that (i) they do not set errno, and (ii)
they don't return -1 on failure, instead returning the value which should be
set as errno.

I'm not sure if (ii) makes much practical difference, as portable code should
arguably be comparing the result against 0, although this is not helped by the
fact that (as the linux man page puts it) "Bizarrely, POSIX.1-2001 does not
specify the value that should be returned by a successful call to sem_init().
 POSIX.1-2008 rectifies this, specifying the zero return on success."

(i) causes the reason for a sem_init() failure to be incorrectly reported as
whatever the previous value of errno is, more on which anon.

Attached is a patch which fixes this conformance issue with these functions.

I did wonder if there were internal uses in the cygwin DLL of these functions
which might be affected by this change. In a quick audit, the only point of
concern I found was semaphore::_terminate(). semaphore::_terminate() is only
used by semaphore::terminate() and does not propagate the result, but now may
be setting errno.  I guess that semaphore::terminate() will now normally be
setting errno, as it attempts to apply semaphore::_terminate() to all
semaphores, not just shared ones.

semaphore::terminate() is only called from close_all_files().  Having this
change errno when used from do_exit() seems safe as we are past the point
where errno might be of significance, but the other uses of close_all_files()
are a bit more mysterious to me.

In what is probably an excess of caution, I've added a save_errno to
semaphore::terminate(), but I could use some help in determining if that is
actually needed.

2011-03-28  Jon TURNEY  <jon.turney@dronecode.org.uk>

	* thread.cc (semaphore::init, destroy, close): Standards conformance
	fix.  On a failure, return -1 and set errno.
	* thread.h (semaphore::terminate): Save errno since semaphore::close()
	may now modify it.

[1] http://cygwin.com/ml/cygwin/2002-02/msg01379.html

--------------000703050805060604060804
Content-Type: text/plain;
 name="sem_init_errno_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sem_init_errno_fix.patch"
Content-length: 2241

Index: cygwin/thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.225
diff -u -p -r1.225 thread.cc
--- cygwin/thread.cc	6 Apr 2010 15:27:34 -0000	1.225
+++ cygwin/thread.cc	28 Mar 2011 21:46:56 -0000
@@ -3076,10 +3076,16 @@ semaphore::init (sem_t *sem, int pshared
 {
   /* opengroup calls this undefined */
   if (is_good_object (sem))
-    return EBUSY;
+    {
+      set_errno(EBUSY);
+      return -1;
+    }
 
   if (value > SEM_VALUE_MAX)
-    return EINVAL;
+    {
+      set_errno(EINVAL);
+      return -1;
+    }
 
   *sem = new semaphore (pshared, value);
 
@@ -3087,7 +3093,8 @@ semaphore::init (sem_t *sem, int pshared
     {
       delete (*sem);
       *sem = NULL;
-      return EAGAIN;
+      set_errno(EAGAIN);
+      return -1;
     }
   return 0;
 }
@@ -3096,11 +3103,17 @@ int
 semaphore::destroy (sem_t *sem)
 {
   if (!is_good_object (sem))
-    return EINVAL;
+    {
+      set_errno(EINVAL);
+      return -1;
+    }
 
   /* It's invalid to destroy a semaphore not opened with sem_init. */
   if ((*sem)->fd != -1)
-    return EINVAL;
+    {
+      set_errno(EINVAL);
+      return -1;
+    }
 
   /* FIXME - new feature - test for busy against threads... */
 
@@ -3113,11 +3126,17 @@ int
 semaphore::close (sem_t *sem)
 {
   if (!is_good_object (sem))
-    return EINVAL;
+    {
+      set_errno(EINVAL);
+      return -1;
+    }
 
   /* It's invalid to close a semaphore not opened with sem_open. */
   if ((*sem)->fd == -1)
-    return EINVAL;
+    {
+      set_errno(EINVAL);
+      return -1;
+    }
 
   delete (*sem);
   delete sem;
Index: cygwin/thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.114
diff -u -p -r1.114 thread.h
--- cygwin/thread.h	22 Feb 2010 20:36:04 -0000	1.114
+++ cygwin/thread.h	28 Mar 2011 21:46:56 -0000
@@ -21,6 +21,7 @@ details. */
 #include <limits.h>
 #include "security.h"
 #include <errno.h>
+#include "cygerrno.h"
 
 enum cw_sig_wait
 {
@@ -641,6 +642,7 @@ public:
   }
   static void terminate ()
   {
+    save_errno save;
     semaphores.for_each (&semaphore::_terminate);
   }
 

--------------000703050805060604060804--
