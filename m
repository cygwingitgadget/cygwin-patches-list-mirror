From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: Bugfix for pthread_cond_init
Date: Fri, 16 Mar 2001 20:44:00 -0000
Message-id: <02b401c0ae9c$d58d43b0$0200a8c0@lifelesswks>
X-SW-Source: 2001-q1/msg00191.html

Changelog:
Saturday Mar 17 3:45 2001 Robert Collins <rbtcollins@hotmail.com>
    * thread.cc MTinterface::CreateCond check for null attr pointer.

Index: cygwin/thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.17
diff -u -p -r1.17 thread.cc
--- thread.cc   2001/03/17 01:14:57     1.17
+++ thread.cc   2001/03/17 04:41:40
@@ -483,7 +483,7 @@ MTinterface::CreateCond (pthread_cond_t
   if (!item)
     system_printf ("cond creation failed");
   item->used = true;
-  item->shared = attr->shared;
+  item->shared = attr ? attr->shared: PTHREAD_PROCESS_PRIVATE;
   item->mutexitem=NULL;
   item->waiting=0;


