Return-Path: <cygwin-patches-return-4921-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24175 invoked by alias); 29 Aug 2004 16:56:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24160 invoked from network); 29 Aug 2004 16:56:09 -0000
Message-Id: <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 29 Aug 2004 16:56:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [PATCH]: broken pipe
Cc: errol@mail.ros.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00073.txt.bz2

I have been investigation the broken pipe problem reported in
<http://cygwin.com/ml/cygwin/2004-07/msg01120.html>
Thanks to Errol for providing a simple test case, from which
I wrote a C program with similar features.

Once in many thousands fork will return 0 to the parent.
The parent then thinks it is the child, closes the reader
side of the pipe and starts writing to the pipe, causing its death.
Meanwhile the child also writes to the pipe and dies of the same cause.

There is a scenario that explains the above observations.
Both the parent and the child try to create the child pinfo 
simultaneously. The following sequence can occur:
 - child creates pinfo
 - parent opens pinfo
 - parent reads cygpid from pinfo (== 0)
 - child writes its cygpid
The parent fork then returns 0.

My solution is for the parent fork to return the cygpid calculated
from the winpid.
The test program is still running after 100,000 fork/exec/pipe,
a longevity record. 

Two other comments:
- there is still a race to create the pinfo. Hopefully all versions
of Windows handle it properly. To be on the safe side, the parent could
open (not create) the pinfo after the child's longjmp.
- the parent copies myself->progname into the child. This seems
duplicative, given that the child always sets progname from 
GetModuleFileName in set_myself.
 
Pierre

P.S.: That may or may not solve Errol's original problem.

2004-08-29  Pierre Humblet <pierre.humblet@ieee.org>

	* fork.cc (fork_parent): Return the cygpid directly derived
	from the winpid.


Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.131
diff -u -p -r1.131 fork.cc
--- fork.cc     7 Mar 2004 04:57:47 -0000       1.131
+++ fork.cc     29 Aug 2004 14:35:15 -0000
@@ -500,10 +500,11 @@ fork_parent (HANDLE& hParent, dll *&firs
     }
 
 #ifdef DEBUGGING
-  pinfo forked ((ch.cygpid != 1 ? ch.cygpid : cygwin_pid
(pi.dwProcessId)), 1);
+  int forked_pid = ch.cygpid != 1 ? ch.cygpid : cygwin_pid (pi.dwProcessId);
 #else
-  pinfo forked (cygwin_pid (pi.dwProcessId), 1);
+  int forked_pid = cygwin_pid (pi.dwProcessId);
 #endif
+  pinfo forked (forked_pid, 1);
   if (!forked)
     {
       syscall_printf ("pinfo failed");
@@ -512,10 +513,6 @@ fork_parent (HANDLE& hParent, dll *&firs
       goto cleanup;
     }
 
-  int forked_pid;
-
-  forked_pid = forked->pid;
-
   /* Initialize things that are done later in dll_crt0_1 that aren't done
      for the forkee.  */
   strcpy (forked->progname, myself->progname);
