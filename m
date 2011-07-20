Return-Path: <cygwin-patches-return-7441-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16749 invoked by alias); 20 Jul 2011 22:04:37 -0000
Received: (qmail 16732 invoked by uid 22791); 20 Jul 2011 22:04:35 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 Jul 2011 22:03:53 +0000
Received: by yxk38 with SMTP id 38so381751yxk.2        for <cygwin-patches@cygwin.com>; Wed, 20 Jul 2011 15:03:52 -0700 (PDT)
Received: by 10.236.186.101 with SMTP id v65mr11688644yhm.94.1311199432532;        Wed, 20 Jul 2011 15:03:52 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id o47sm143230yhn.30.2011.07.20.15.03.50        (version=SSLv3 cipher=OTHER);        Wed, 20 Jul 2011 15:03:51 -0700 (PDT)
Subject: Re: [PATCH] clock_nanosleep(2), pthread_condattr_[gs]etclock(3)
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Wed, 20 Jul 2011 22:04:00 -0000
In-Reply-To: <20110720141125.GA15232@calimero.vinschen.de>
References: <1311126880.7796.9.camel@YAAKOV04>	 <20110720075654.GA3667@calimero.vinschen.de>	 <1311153377.7796.66.camel@YAAKOV04> <1311155453.7796.70.camel@YAAKOV04>	 <20110720141125.GA15232@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="=-R2UxFjTtT6Le0YN26W1B"
Message-ID: <1311199441.6248.9.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00017.txt.bz2


--=-R2UxFjTtT6Le0YN26W1B
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1934

On Wed, 2011-07-20 at 16:11 +0200, Corinna Vinschen wrote:
> On Jul 20 04:50, Yaakov (Cygwin/X) wrote:
> > Actually, no need to panic, I took a closer look at this, and it's not
> > all that hard at all, so I'll go ahead and implement
> > pthread_condattr_[gs]etclock() as well.  Just give me a day or two to
> > get it done.  In the meantime, I'll proceed with the revised newlib
> > patch.
> 
> Thanks.

Not taking the following issue into account, my patches to implement
pthread_condwait_[gs]etclock() and update sysconf() are attached.  (The
chunk for include/cygwin/version.h is not included, as that will depend
on which order these patches are applied.)

> The only problem I see is the fact that a call to clock_settime
> influences calls to clock_nanosleep with absolute timeouts(*).
> 
> The problem is that we convert absolute timeouts to relative timeouts
> and then use the timeout facility of the WFMO function to handle the
> timeout for us.  IMO this is neither very reliable, nor is it elegant.
> 
> So, here's the question.  Shouldn't we better use waitable timers
> to implement this sort of stuff?  Waitable timers are pretty easy to
> use, they support relative and absolute timeouts with an accuracy of 100
> ns in the API and a real accuracy which only depends on the underlying
> HW, and they are especially not subject to the 49.7 days overflow
> problem.

I see your point.  The question is how to use waitable timers for
CLOCK_MONOTONIC.

> (*) Does it also influence pthread_cond_timedwait?  This information seems
>     to be missing in SUSv4.

The last paragraph of RATIONALE -> Timed Wait Semantics states:

> For cases when the system clock is advanced discontinuously by an
> operator, it is expected that implementations process any timed wait
> expiring at an intervening time as if that time had actually occurred.

Of course, this would be an old problem with pthread_cond_timedwait().


Yaakov


--=-R2UxFjTtT6Le0YN26W1B
Content-Disposition: attachment; filename="cygwin-posix-clock-selection.patch"
Content-Type: text/x-patch; name="cygwin-posix-clock-selection.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 896

2011-07-20  Yaakov Selkowitz  <yselkowitz@...>

	* sysconf.cc (sca): Set _SC_CLOCK_SELECTION to _POSIX_CLOCK_SELECTION.

Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.60
diff -u -p -r1.60 sysconf.cc
--- sysconf.cc	18 Jul 2011 23:08:09 -0000	1.60
+++ sysconf.cc	20 Jul 2011 21:33:56 -0000
@@ -158,7 +158,7 @@ static struct
   {cons, {c:BC_DIM_MAX}},		/*  58, _SC_BC_DIM_MAX */
   {cons, {c:BC_SCALE_MAX}},		/*  59, _SC_BC_SCALE_MAX */
   {cons, {c:BC_STRING_MAX}},		/*  60, _SC_BC_STRING_MAX */
-  {cons, {c:-1L}},			/*  61, _SC_CLOCK_SELECTION */
+  {cons, {c:_POSIX_CLOCK_SELECTION}},	/*  61, _SC_CLOCK_SELECTION */
   {nsup, {c:0}},			/*  62, _SC_COLL_WEIGHTS_MAX */
   {cons, {c:_POSIX_CPUTIME}},		/*  63, _SC_CPUTIME */
   {cons, {c:EXPR_NEST_MAX}},		/*  64, _SC_EXPR_NEST_MAX */

--=-R2UxFjTtT6Le0YN26W1B
Content-Disposition: attachment; filename="cygwin-pthread_condattr_getclock.patch"
Content-Type: text/x-patch; name="cygwin-pthread_condattr_getclock.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 7702

2011-07-20  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (pthread_condattr_getclock): Export.
	(pthread_condattr_setclock): Export.
	* posix.sgml (std-notimpl): Move pthread_condattr_getclock and
	pthread_condattr_setclock from here...
	(std-susv4): ... to here.
	* thread.cc: (pthread_condattr::pthread_condattr): Initialize clock_id.
	(pthread_cond::pthread_cond): Initialize clock_id.
	(pthread_cond_timedwait): Use clock_gettime() instead of gettimeofday()
	in order to support all allowed clocks.
	(pthread_condattr_getclock): New function.
	(pthread_condattr_setclock): New function.
	* thread.h (class pthread_condattr): Add clock_id member.
	(class pthread_cond): Ditto.
	* include/pthread.h: Remove obsolete comment.
	(pthread_condattr_getclock): Declare.
	(pthread_condattr_setclock): Declare.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.244
diff -u -p -r1.244 cygwin.din
--- cygwin.din	19 May 2011 07:23:28 -0000	1.244
+++ cygwin.din	20 Jul 2011 21:33:53 -0000
@@ -1209,8 +1210,10 @@ pthread_cond_signal SIGFE
 pthread_cond_timedwait SIGFE
 pthread_cond_wait SIGFE
 pthread_condattr_destroy SIGFE
+pthread_condattr_getclock SIGFE
 pthread_condattr_getpshared SIGFE
 pthread_condattr_init SIGFE
+pthread_condattr_setclock SIGFE
 pthread_condattr_setpshared SIGFE
 pthread_continue SIGFE
 pthread_create SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.68
diff -u -p -r1.68 posix.sgml
--- posix.sgml	25 May 2011 06:10:24 -0000	1.68
+++ posix.sgml	20 Jul 2011 21:33:56 -0000
@@ -554,8 +555,10 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     pthread_cond_timedwait
     pthread_cond_wait
     pthread_condattr_destroy
+    pthread_condattr_getclock
     pthread_condattr_getpshared
     pthread_condattr_init
+    pthread_condattr_setclock
     pthread_condattr_setpshared
     pthread_create
     pthread_detach
@@ -1390,8 +1392,6 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     posix_typed_[...]
     powl
     pthread_barrier[...]
-    pthread_condattr_getclock
-    pthread_condattr_setclock
     pthread_mutexattr_getrobust
     pthread_mutexattr_setrobust
     pthread_mutex_consistent
Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.243
diff -u -p -r1.243 thread.cc
--- thread.cc	6 Jun 2011 05:02:13 -0000	1.243
+++ thread.cc	20 Jul 2011 21:33:56 -0000
@@ -1099,7 +1099,8 @@ pthread_attr::~pthread_attr ()
 }
 
 pthread_condattr::pthread_condattr ():verifyable_object
-  (PTHREAD_CONDATTR_MAGIC), shared (PTHREAD_PROCESS_PRIVATE)
+  (PTHREAD_CONDATTR_MAGIC), shared (PTHREAD_PROCESS_PRIVATE),
+  clock_id (CLOCK_REALTIME)
 {
 }
 
@@ -1124,17 +1125,21 @@ pthread_cond::init_mutex ()
 
 pthread_cond::pthread_cond (pthread_condattr *attr) :
   verifyable_object (PTHREAD_COND_MAGIC),
-  shared (0), waiting (0), pending (0), sem_wait (NULL),
-  mtx_cond(NULL), next (NULL)
+  shared (0), clock_id (CLOCK_REALTIME), waiting (0), pending (0),
+  sem_wait (NULL), mtx_cond(NULL), next (NULL)
 {
   pthread_mutex *verifyable_mutex_obj;
 
   if (attr)
-    if (attr->shared != PTHREAD_PROCESS_PRIVATE)
-      {
-	magic = 0;
-	return;
-      }
+    {
+      clock_id = attr->clock_id;
+
+      if (attr->shared != PTHREAD_PROCESS_PRIVATE)
+	{
+	  magic = 0;
+	  return;
+	}
+    }
 
   verifyable_mutex_obj = &mtx_in;
   if (!pthread_mutex::is_good_object (&verifyable_mutex_obj))
@@ -2716,7 +2721,7 @@ extern "C" int
 pthread_cond_timedwait (pthread_cond_t *cond, pthread_mutex_t *mutex,
 			const struct timespec *abstime)
 {
-  struct timeval tv;
+  struct timespec tp;
   DWORD waitlength;
 
   myfault efault;
@@ -2731,17 +2736,18 @@ pthread_cond_timedwait (pthread_cond_t *
       || abstime->tv_nsec > 999999999)
     return EINVAL;
 
-  gettimeofday (&tv, NULL);
+  clock_gettime ((*cond)->clock_id, &tp);
+
   /* Check for immediate timeout before converting to microseconds, since
      the resulting value can easily overflow long.  This also allows to
      evaluate microseconds directly in DWORD. */
-  if (tv.tv_sec > abstime->tv_sec
-      || (tv.tv_sec == abstime->tv_sec
-	  && tv.tv_usec > abstime->tv_nsec / 1000))
+  if (tp.tv_sec > abstime->tv_sec
+      || (tp.tv_sec == abstime->tv_sec
+	  && tp.tv_nsec > abstime->tv_nsec))
     return ETIMEDOUT;
 
-  waitlength = (abstime->tv_sec - tv.tv_sec) * 1000;
-  waitlength += (abstime->tv_nsec / 1000 - tv.tv_usec) / 1000;
+  waitlength = (abstime->tv_sec - tp.tv_sec) * 1000;
+  waitlength += (abstime->tv_nsec - tp.tv_nsec) / 1000000;
   return __pthread_cond_dowait (cond, mutex, waitlength);
 }
 
@@ -2793,6 +2799,32 @@ pthread_condattr_setpshared (pthread_con
 }
 
 extern "C" int
+pthread_condattr_getclock (const pthread_condattr_t *attr, clockid_t *clock_id)
+{
+  if (!pthread_condattr::is_good_object (attr))
+    return EINVAL;
+  *clock_id = (*attr)->clock_id;
+  return 0;
+}
+
+extern "C" int
+pthread_condattr_setclock (pthread_condattr_t *attr, clockid_t clock_id)
+{
+  if (!pthread_condattr::is_good_object (attr))
+    return EINVAL;
+  switch (clock_id)
+    {
+    case CLOCK_REALTIME:
+    case CLOCK_MONOTONIC:
+      break;
+    default:
+      return EINVAL;
+    }
+  (*attr)->clock_id = clock_id;
+  return 0;
+}
+
+extern "C" int
 pthread_condattr_destroy (pthread_condattr_t *condattr)
 {
   if (!pthread_condattr::is_good_object (condattr))
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.121
diff -u -p -r1.121 thread.h
--- thread.h	15 May 2011 18:49:40 -0000	1.121
+++ thread.h	20 Jul 2011 21:33:56 -0000
@@ -488,6 +488,7 @@ class pthread_condattr: public verifyabl
 public:
   static bool is_good_object(pthread_condattr_t const *);
   int shared;
+  clockid_t clock_id;
 
   pthread_condattr ();
   ~pthread_condattr ();
@@ -504,6 +505,7 @@ public:
   static int init (pthread_cond_t *, const pthread_condattr_t *);
 
   int shared;
+  clockid_t clock_id;
 
   unsigned long waiting;
   unsigned long pending;
Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.33
diff -u -p -r1.33 pthread.h
--- include/pthread.h	17 May 2011 17:08:10 -0000	1.33
+++ include/pthread.h	20 Jul 2011 21:33:56 -0000
@@ -27,12 +27,6 @@ extern "C"
 /* Defines. (These are correctly defined here as per
    http://www.opengroup.org/onlinepubs/7908799/xsh/pthread.h.html */
 
-/* FIXME: this should allocate a new cond variable, and return the value  that
- would normally be written to the passed parameter of pthread_cond_init(lvalue, NULL); */
-/* #define PTHREAD_COND_INITIALIZER 0 */
-
-/* the default : joinable */
-
 #define PTHREAD_CANCEL_ASYNCHRONOUS 1
 /* defaults are enable, deferred */
 #define PTHREAD_CANCEL_ENABLE 0
@@ -132,8 +126,10 @@ int pthread_cond_timedwait (pthread_cond
 			    pthread_mutex_t *, const struct timespec *);
 int pthread_cond_wait (pthread_cond_t *, pthread_mutex_t *);
 int pthread_condattr_destroy (pthread_condattr_t *);
+int pthread_condattr_getclock (const pthread_condattr_t *, clockid_t *);
 int pthread_condattr_getpshared (const pthread_condattr_t *, int *);
 int pthread_condattr_init (pthread_condattr_t *);
+int pthread_condattr_setclock (pthread_condattr_t *, clockid_t);
 int pthread_condattr_setpshared (pthread_condattr_t *, int);
 
 int pthread_create (pthread_t *, const pthread_attr_t *,

--=-R2UxFjTtT6Le0YN26W1B--
