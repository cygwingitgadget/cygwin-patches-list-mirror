Return-Path: <cygwin-patches-return-3283-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24892 invoked by alias); 6 Dec 2002 23:41:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24846 invoked from network); 6 Dec 2002 23:41:53 -0000
Message-ID: <3DF13580.5060403@earthlink.net>
Date: Fri, 06 Dec 2002 15:41:00 -0000
From: Christophe Galerne <christophegalerne@earthlink.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en, fr-fr, fr
MIME-Version: 1.0
To: cygwin <cygwin@cygwin.com>,  cygwin-patches@cygwin.com
Subject: [patch] Symbolic value for PTHREAD_MUTEX_DEFAULT 
Content-Type: multipart/mixed;
 boundary="------------020708060309050108090106"
X-SW-Source: 2002-q4/txt/msg00234.txt.bz2

This is a multi-part message in MIME format.
--------------020708060309050108090106
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 411

Hi,

As discussed with Robert Collins, I propose this patch to make
the 'default' mutex type more explicit.

2002-12-05 Christophe Galerne <christophegalerne@earthlink.net>

	* pthread.h (PTHREAD_MUTEX_DEFAULT):
	reorder PTHREAD_MUTEX_DEFAULT and PTHREAD_MUTEX_RECURSIVE so that
	PTHREAD_MUTEX_DEFAULT can be defined as PTHREAD_MUTEX_RECURSIVE.
	add a comment that PTHREAD_MUTEX_NORMAL is not yet implemented.


--------------020708060309050108090106
Content-Type: text/plain;
 name="pthread_constant.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pthread_constant.patch"
Content-length: 1207

? pthread_constant.patch
Index: pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.12
diff -u -p -r1.12 pthread.h
--- pthread.h	4 Jul 2002 14:17:30 -0000	1.12
+++ pthread.h	6 Dec 2002 22:55:18 -0000
@@ -50,12 +50,15 @@ extern "C"
 #define PTHREAD_CREATE_JOINABLE 0
 #define PTHREAD_EXPLICIT_SCHED 1
 #define PTHREAD_INHERIT_SCHED 0
-#define PTHREAD_MUTEX_DEFAULT 0
+
+#define PTHREAD_MUTEX_RECURSIVE 0
 #define PTHREAD_MUTEX_ERRORCHECK 1
+/* not implemented yet */
 #define PTHREAD_MUTEX_NORMAL 2
+#define PTHREAD_MUTEX_DEFAULT PTHREAD_MUTEX_RECURSIVE
+
 /* this should be too low to ever be a valid address */
 #define PTHREAD_MUTEX_INITIALIZER (void *)20
-#define PTHREAD_MUTEX_RECURSIVE 0
 #define PTHREAD_ONCE_INIT { PTHREAD_MUTEX_INITIALIZER, 0 }
 #define PTHREAD_PRIO_INHERIT
 #define PTHREAD_PRIO_NONE
@@ -103,7 +106,7 @@ void pthread_cleanup_push (void (*routin
 void pthread_cleanup_pop (int execute);
 */
 typedef void (*__cleanup_routine_type) (void *);
-typedef struct _pthread_cleanup_handler 
+typedef struct _pthread_cleanup_handler
 {
   __cleanup_routine_type function;
   void *arg;

--------------020708060309050108090106--
