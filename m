Return-Path: <cygwin-patches-return-5602-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 996 invoked by alias); 2 Aug 2005 00:31:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 968 invoked by uid 22791); 2 Aug 2005 00:31:16 -0000
Received: from rwcrmhc11.comcast.net (HELO rwcrmhc11.comcast.net) (204.127.198.35)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Tue, 02 Aug 2005 00:31:16 +0000
Received: from [192.168.15.2] (c-65-96-128-135.hsd1.ma.comcast.net[65.96.128.135])
          by comcast.net (rwcrmhc11) with SMTP
          id <2005080200061301300hqdmre>; Tue, 2 Aug 2005 00:06:14 +0000
Date: Tue, 02 Aug 2005 00:31:00 -0000
From: Mike Gorse <mgorse@alum.wpi.edu>
X-X-Sender: mgorse@mgorse.dhs.org
To: cygwin-patches@cygwin.com
Subject: Re: fix possible segfault creating detached thread
Message-ID: <Pine.LNX.4.61.0508012001310.4694@mgorse.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-SW-Source: 2005-q3/txt/msg00057.txt.bz2

ARGH!  I really need to be more careful...  Sorry for all the emails.

One last correction...

2005-08-01 Michael Gorse <mgorse@alum.wpi.edu>

         * thread.cc (pthread::create(3 args)): Make bool.
         (pthread_null::create): Ditto.
         thread.h: Ditto.

         * thread.cc (pthread::create(4 args)): Check return of inner
         create  rather than calling is_good_object().

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
+  retval = magic;
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
