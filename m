Return-Path: <cygwin-patches-return-5596-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14724 invoked by alias); 31 Jul 2005 19:18:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14700 invoked by uid 22791); 31 Jul 2005 19:18:10 -0000
Received: from sccrmhc12.comcast.net (HELO sccrmhc12.comcast.net) (204.127.202.56)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Sun, 31 Jul 2005 19:18:10 +0000
Received: from [192.168.15.2] (c-65-96-128-135.hsd1.ma.comcast.net[65.96.128.135])
          by comcast.net (sccrmhc12) with SMTP
          id <20050731191808012006crt6e>; Sun, 31 Jul 2005 19:18:09 +0000
Date: Sun, 31 Jul 2005 19:18:00 -0000
From: Mike Gorse <mgorse@alum.wpi.edu>
X-X-Sender: mgorse@mgorse.dhs.org
To: cygwin-patches@cygwin.com
Subject: fix possible segfault creating detached thread
Message-ID: <Pine.LNX.4.61.0507311501560.1072@mgorse.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SW-Source: 2005-q3/txt/msg00051.txt.bz2

This patch fixes a seg fault when a thread is created in a detached state 
and terminates the first time it is scheduled.  pthread::create (the 
four-parameter version) calls the three-parameter pthread::create function 
which unlocks the mutex, allowing the called thread to be scheduled, then 
exits at which point the outer create function calls is_good_objectg(), 
but this causes a core dump if pthread::exit() has already been called and 
deleted the pthread object.

2005-07-31 Michael Gorse <mgorse@alum.wpi.edu>

         * thread.cc (pthread::create): Make bool.
         * thread.cc (pthread_null::create): Ditto.
         * thread.h: Ditto.

         * pthread.cc (pthread_create): Check return of inner create rather
         than calling is_good_object().

---

Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.190
diff -u -p -r1.190 thread.cc
--- thread.cc	6 Jul 2005 20:05:03 -0000	1.190
+++ thread.cc	31 Jul 2005 02:13:14 -0000
@@ -491,13 +491,15 @@ pthread::precreate (pthread_attr *newatt
      magic = 0;
  }

-void
+bool
  pthread::create (void *(*func) (void *), pthread_attr *newattr,
  		 void *threadarg)
  {
+  bool retval;
+
    precreate (newattr);
    if (!magic)
-    return;
+    return false;

    function = func;
    arg = threadarg;
@@ -517,7 +519,9 @@ pthread::create (void *(*func) (void *),
        while (!cygtls)
  	low_priority_sleep (0);
      }
+  retval =magic;
    mutex.unlock ();
+  return retval;
  }

  void
@@ -1993,8 +1997,7 @@ pthread::create (pthread_t *thread, cons
      return EINVAL;

    *thread = new pthread ();
-  (*thread)->create (start_routine, attr ? *attr : NULL, arg);
-  if (!is_good_object (thread))
+  if (!(*thread)->create (start_routine, attr ? *attr : NULL, arg))
      {
        delete (*thread);
        *thread = NULL;
@@ -3262,9 +3265,10 @@ pthread_null::~pthread_null ()
  {
  }

-void
+bool
  pthread_null::create (void *(*)(void *), pthread_attr *, void *)
  {
+  return true;
  }

  void
Index: thread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.h,v
retrieving revision 1.100
diff -u -p -r1.100 thread.h
--- thread.h	5 Jul 2005 03:16:46 -0000	1.100
+++ thread.h	31 Jul 2005 02:10:52 -0000
@@ -380,7 +380,7 @@ public:
    HANDLE cancel_event;
    pthread_t joiner;

-  virtual void create (void *(*)(void *), pthread_attr *, void *);
+  virtual bool create (void *(*)(void *), pthread_attr *, void *);

    pthread ();
    virtual ~pthread ();
@@ -473,7 +473,7 @@ class pthread_null : public pthread
    /* From pthread These should never get called
    * as the ojbect is not verifyable
    */
-  void create (void *(*)(void *), pthread_attr *, void *);
+  bool create (void *(*)(void *), pthread_attr *, void *);
    void exit (void *value_ptr) __attribute__ ((noreturn));
    int cancel ();
    void testcancel ();
