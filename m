Return-Path: <cygwin-patches-return-3538-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11529 invoked by alias); 7 Feb 2003 14:35:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11520 invoked from network); 7 Feb 2003 14:35:08 -0000
Date: Fri, 07 Feb 2003 14:35:00 -0000
From: Vaclav Haisman <V.Haisman@sh.cvut.cz>
To: cygwin-patches@cygwin.com
Subject: Make busy waiting loop in exceptions.cc (try_to_debug) less busy.
Message-ID: <20030207152049.N27816-100000@logout.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: AMaViS at Silicon Hill
X-Spam-Status: No, hits=1.1 required=5.0
	tests=CARRIAGE_RETURNS,SPAM_PHRASE_00_01
	version=2.43
X-Spam-Level: *
X-SW-Source: 2003-q1/txt/msg00187.txt.bz2


Hi,
this patch makes busy waiting loop in try_to_debug less busy by lowering
priority of current thread to idle and by giving up time slices with Sleep(0).
Without this patch it takes tens of seconds to start dumper or gdb because this
busy loop eats whole CPU and computer almost stops responding. With this patch
dumper/gdb starts (almost) immediately. You can test it yourselves with this
simple programm:

int main ()
{
  throw 1;
}


Vaclav Haisman

PS: Assignment has been snailed.

2003-02-07  Vaclav Haisman  <V.Haisman@sh.cvut.cz>
	* exceptions.cc (try_to_debug): Set priority of current thread to
	idle. Make busy waiting loop less busy.

Index: cygwin/exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.140
diff -u -p -r1.140 exceptions.cc
--- cygwin/exceptions.cc	4 Feb 2003 03:01:17 -0000	1.140
+++ cygwin/exceptions.cc	7 Feb 2003 14:08:57 -0000
@@ -392,10 +392,11 @@ try_to_debug (bool waitloop)
   else
     {
       SetThreadPriority (hMainThread, THREAD_PRIORITY_IDLE);
+      SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
       if (!waitloop)
 	return 1;
       while (!being_debugged ())
-	/* spin */;
+	Sleep (0);
       Sleep (4000);
       small_printf ("*** continuing from debugger call\n");
     }
