Return-Path: <cygwin-patches-return-4332-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24811 invoked by alias); 31 Oct 2003 21:11:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24799 invoked from network); 31 Oct 2003 21:11:53 -0000
Message-ID: <3FA2D012.5060607@gmx.net>
Date: Fri, 31 Oct 2003 21:11:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030901 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Fix debugger attach for threads
Content-Type: multipart/mixed;
 boundary="------------080805070709020204060602"
X-SW-Source: 2003-q4/txt/msg00051.txt.bz2

This is a multi-part message in MIME format.
--------------080805070709020204060602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 531

This patch allows a debugger to attach when an exception occurs in a 
thread other than the mainthread.

I am not happy about the wait in handle_exceptions, but it works on my 
machine. I think that a waitloop until the debugger is attached is 
cleaner, but there must be a reason why the debbugging loop is 
implemented this way.

Thomas

003-10-31  Thomas Pfaff  <tpfaff@gmx.net>

	* exceptions.cc (try_to_debug): Suspend/resume all threads when
	a debugger is attaching.
	(handle_exceptions): Give debugger CPU time to attach.


--------------080805070709020204060602
Content-Type: text/plain;
 name="thread_try_to_debug.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="thread_try_to_debug.patch"
Content-length: 1834

? suspend_all_on_stop.patch
? thread_try_to_debug.patch
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.172
diff -u -p -r1.172 exceptions.cc
--- exceptions.cc	14 Oct 2003 09:21:55 -0000	1.172
+++ exceptions.cc	31 Oct 2003 20:50:31 -0000
@@ -360,9 +360,7 @@ try_to_debug (bool waitloop)
   si.dwFlags = 0;
   si.cb = sizeof (si);
 
-  /* FIXME: need to know handles of all running threads to
-     suspend_all_threads_except (current_thread_id);
-  */
+  pthread::suspend_all_except_self ();
 
   /* if any of these mutexes is owned, we will fail to start any cygwin app
      until trapped app exits */
@@ -400,7 +398,10 @@ try_to_debug (bool waitloop)
   else
     {
       if (!waitloop)
-	return 1;
+        {
+          pthread::resume_all ();
+          return 1;
+        }
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
       while (!being_debugged ())
 	Sleep (0);
@@ -409,9 +410,8 @@ try_to_debug (bool waitloop)
       SetThreadPriority (GetCurrentThread (), prio);
     }
 
-  /* FIXME: need to know handles of all running threads to
-    resume_all_threads_except (current_thread_id);
-  */
+  pthread::resume_all ();
+
   return 0;
 }
 
@@ -426,7 +426,15 @@ handle_exceptions (EXCEPTION_RECORD *e, 
 
   if (debugging && ++debugging < 500000)
     {
-      SetThreadPriority (hMainThread, THREAD_PRIORITY_NORMAL);
+      /*
+       * Give debugger a chance to attach
+       */
+      LONG prio = GetThreadPriority (GetCurrentThread ());
+      pthread::suspend_all_except_self ();
+      SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
+      Sleep (0);
+      SetThreadPriority (GetCurrentThread (), prio);
+      pthread::resume_all ();
       return 0;
     }
 

--------------080805070709020204060602--
