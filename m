From: Earnie Boyd <earnie_boyd@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: exceptions.cc (call_signal_handler_now)
Date: Thu, 05 Apr 2001 07:19:00 -0000
Message-id: <3ACC7EFA.D650E2D3@yahoo.com>
X-SW-Source: 2001-q2/msg00007.html

 
2001-04-05  Earnie Boyd  <earnie_boyd@yahoo.com

	* exceptions.cc (call_signal_handler_now): Remove the static declaration
	to allow -finline-functions option to work.

Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.73
diff -u -p -r1.73 exceptions.cc
--- exceptions.cc	2001/04/02 00:18:29	1.73
+++ exceptions.cc	2001/04/05 14:08:42
@@ -1119,7 +1119,7 @@ events_terminate (void)
 }
 
 extern "C" {
-static int __stdcall
+int __stdcall
 call_signal_handler_now ()
 {
   int sa_flags = sigsave.sa_flags;
