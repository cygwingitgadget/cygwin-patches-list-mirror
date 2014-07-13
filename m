Return-Path: <cygwin-patches-return-8005-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4558 invoked by alias); 13 Jul 2014 23:38:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 4541 invoked by uid 89); 13 Jul 2014 23:38:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.4 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2
X-HELO: mail-ig0-f171.google.com
Received: from mail-ig0-f171.google.com (HELO mail-ig0-f171.google.com) (209.85.213.171) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-SHA encrypted) ESMTPS; Sun, 13 Jul 2014 23:38:27 +0000
Received: by mail-ig0-f171.google.com with SMTP id l13so1170734iga.4        for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2014 16:38:24 -0700 (PDT)
X-Received: by 10.50.25.71 with SMTP id a7mr20551829igg.17.1405294704684;        Sun, 13 Jul 2014 16:38:24 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.212.134])        by mx.google.com with ESMTPSA id j5sm10826741ige.12.2014.07.13.16.38.22        for <cygwin-patches@cygwin.com>        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);        Sun, 13 Jul 2014 16:38:23 -0700 (PDT)
Message-ID: <53C31871.9020900@cygwin.com>
Date: Sun, 13 Jul 2014 23:38:00 -0000
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] default to normal pthread mutexes
Content-Type: multipart/mixed; boundary="------------000700040000060205010102"
X-SW-Source: 2014-q3/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------000700040000060205010102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 283

Defaulting to ERRORCHECK mutexes (with the various stringencies it 
implies) does not match the behaviour on Linux, where NORMAL mutexes are 
the default.  I have been testing this locally for some time, and I 
believe it affects a lot of software.  Patch and STC attached.


Yaakov

--------------000700040000060205010102
Content-Type: text/plain; charset=windows-1252;
 name="pthread-mutex-default.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pthread-mutex-default.patch"
Content-length: 2388

2014-07-13  Yaakov Selkowitz  <yselkowitz@...>

	* thread.cc (pthread_mutex::pthread_mutex): Change default type
	to PTHREAD_MUTEX_NORMAL.
	(pthread_mutexattr::pthread_mutexattr): Ditto.
	(pthread_mutex_unlock): Do not fail if mutex is a normal mutex
	initializer.
	* include/pthread.h (PTHREAD_MUTEX_INITIALIZER): Redefine as
	PTHREAD_NORMAL_MUTEX_INITIALIZER_NP.

Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.287
diff -u -p -r1.287 thread.cc
--- thread.cc	1 Dec 2013 10:27:16 -0000	1.287
+++ thread.cc	26 Mar 2014 04:24:08 -0000
@@ -1708,7 +1708,7 @@ pthread_mutex::pthread_mutex (pthread_mu
   tid (0),
 #endif
   recursion_counter (0), condwaits (0),
-  type (PTHREAD_MUTEX_ERRORCHECK),
+  type (PTHREAD_MUTEX_NORMAL),
   pshared (PTHREAD_PROCESS_PRIVATE)
 {
   win32_obj_id = ::CreateEvent (&sec_none_nih, false, false, NULL);
@@ -1850,7 +1850,7 @@ pthread_mutex::_fixup_after_fork ()
 }
 
 pthread_mutexattr::pthread_mutexattr ():verifyable_object (PTHREAD_MUTEXATTR_MAGIC),
-pshared (PTHREAD_PROCESS_PRIVATE), mutextype (PTHREAD_MUTEX_ERRORCHECK)
+pshared (PTHREAD_PROCESS_PRIVATE), mutextype (PTHREAD_MUTEX_NORMAL)
 {
 }
 
@@ -3158,7 +3158,7 @@ extern "C" int
 pthread_mutex_unlock (pthread_mutex_t *mutex)
 {
   if (pthread_mutex::is_initializer (mutex))
-    return EPERM;
+    pthread_mutex::init (mutex, NULL, *mutex);
   if (!pthread_mutex::is_good_object (mutex))
     return EINVAL;
   return (*mutex)->unlock ();
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.39
diff -u -p -r1.39 pthread.h
--- include/pthread.h	26 Feb 2013 10:32:36 -0000	1.39
+++ include/pthread.h	26 Mar 2014 04:24:08 -0000
@@ -49,7 +49,7 @@ extern "C"
 #define PTHREAD_RECURSIVE_MUTEX_INITIALIZER_NP (pthread_mutex_t)18
 #define PTHREAD_NORMAL_MUTEX_INITIALIZER_NP (pthread_mutex_t)19
 #define PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP (pthread_mutex_t)20
-#define PTHREAD_MUTEX_INITIALIZER PTHREAD_ERRORCHECK_MUTEX_INITIALIZER_NP
+#define PTHREAD_MUTEX_INITIALIZER PTHREAD_NORMAL_MUTEX_INITIALIZER_NP
 #define PTHREAD_ONCE_INIT { PTHREAD_MUTEX_INITIALIZER, 0 }
 #if defined(_POSIX_THREAD_PRIO_INHERIT) && _POSIX_THREAD_PRIO_INHERIT >= 0
 #define PTHREAD_PRIO_NONE 0

--------------000700040000060205010102
Content-Type: text/plain; charset=windows-1252;
 name="pthread-mutex-test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pthread-mutex-test.c"
Content-length: 1008

#include <pthread.h>
#include <stdio.h>
#include <error.h>

int
main(void)
{
  int ret;
  pthread_mutexattr_t attr;
  pthread_mutex_t mutex;
#ifdef __CYGWIN__
  pthread_mutex_t mutexstatic = PTHREAD_NORMAL_MUTEX_INITIALIZER_NP;
#else
  pthread_mutex_t mutexstatic = PTHREAD_MUTEX_INITIALIZER;
#endif

  pthread_mutexattr_init(&attr);
  {
    int type;
    printf ("PTHREAD_MUTEX_NORMAL = %d\n", PTHREAD_MUTEX_NORMAL);
    printf ("PTHREAD_MUTEX_ERRORCHECK = %d\n", PTHREAD_MUTEX_ERRORCHECK);
    printf ("PTHREAD_MUTEX_DEFAULT = %d\n", PTHREAD_MUTEX_DEFAULT);

    pthread_mutexattr_gettype (&attr, &type);
    printf ("pthread_mutexattr_init(NULL) type is: %d\n", type);
  }
  pthread_mutex_init(&mutex, &attr);
  pthread_mutexattr_destroy(&attr);
  if ((ret = pthread_mutex_unlock(&mutex)))
    error(0, ret, "pthread_mutex_unlock(mutex)");

//  pthread_mutex_init(&mutexstatic, NULL);
  if ((ret = pthread_mutex_unlock(&mutexstatic)))
    error(0, ret, "pthread_mutex_unlock(mutexstatic)");
  return 0;
}

--------------000700040000060205010102--
