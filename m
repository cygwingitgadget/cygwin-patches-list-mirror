Return-Path: <cygwin-patches-return-4211-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7261 invoked by alias); 13 Sep 2003 01:25:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7252 invoked from network); 13 Sep 2003 01:25:11 -0000
Date: Sat, 13 Sep 2003 01:25:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] pthread patch - Thomas Pfaff, please note
Message-ID: <20030913012508.GA2870@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00227.txt.bz2

Thomas, I made the change below to stop a SEGV on thread exit as evinced
by the threadidafterfork test in the testsuite.

The problem is that this code overwrites impure_ptr with the contents of
the thread which called fork, which is not the correct thing to do since
_impure_ptr contains global information not present in the calling threads
reent structure.

I hope it makes sense.  If there is some better way to do this, please
feel free to check it in.  This looked right to me, though.

cgf

2003-09-12  Christopher Faylor  <cgf@redhat.com>

        * thread.cc (MTinterface::fixup_after_fork): Remove code which 
        potentially overwrote _impure pointer with contents of thread which
        invoked fork since this eliminates important information like the
        pointer to the atexit queue.


Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.131
retrieving revision 1.132
diff -u -p -r1.131 -r1.132
--- thread.cc	26 Jul 2003 04:53:59 -0000	1.131
+++ thread.cc	13 Sep 2003 01:21:32 -0000	1.132
@@ -224,10 +224,6 @@ MTinterface::fixup_after_fork (void)
   /* As long as the signal handling not multithreaded
      switch reents storage back to _impure_ptr for the mainthread
      to support fork from threads other than the mainthread */
-  struct _reent *reent_old = __getreent ();
-
-  if (reent_old && _impure_ptr != reent_old)
-    *_impure_ptr = *reent_old;
   reents._clib = _impure_ptr;
   reents._winsup = &winsup_reent;
   winsup_reent._process_logmask = LOG_UPTO (LOG_DEBUG);
