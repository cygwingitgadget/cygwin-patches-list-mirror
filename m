Return-Path: <cygwin-patches-return-4933-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19571 invoked by alias); 8 Sep 2004 01:30:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19562 invoked from network); 8 Sep 2004 01:30:28 -0000
Message-Id: <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 08 Sep 2004 01:30:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: [Patch]: Setting the winpid in pinfo
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00085.txt.bz2

I am looking at some oddities involving ^C and signals.

In the current code, set_myself sets the dwProcessId when
a pinfo is created. The upshot is that signals to a process
that is exec'ing will be prematurely directed to the child
(using a meaningless handle from the parent). 
The bug can be fixed by simply removing the offending line.

Also, in proc_can_be_signalled, I don't understand the line  
  if (ISSTATE (p, PID_INITIALIZING) ||
      (((p)->process_state & (PID_ACTIVE | PID_IN_USE)) ==
       (PID_ACTIVE | PID_IN_USE)))
    return true;
The test for PID_INITIALIZING will allow a doomed attempt
at signaling a process while it is being forked (and its
sendsig is still NULL). Am I missing something?

Also, on WinME, simply holding down ^C in the bash shell will
cause a crash (thanks to Errol Smith)
~>     142 [sig] BASH 1853149 handle_threadlist_exception: 
handle_threadlist_exception called with threadlist_ix -1
    1751 [sig] BASH 1853149 handle_exceptions: Exception: 
STATUS_ACCESS_VIOLATION

Any idea about what's happening? I have been unable to
make any progress.

Pierre

2004-09-08  Pierre Humblet <pierre.humblet@ieee.org>

	* pinfo.cc (set_myself): Do not set dwProcessId.

Index: pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.119
diff -u -p -r1.119 pinfo.cc
--- pinfo.cc    30 Aug 2004 22:08:50 -0000      1.119
+++ pinfo.cc    8 Sep 2004 01:15:28 -0000
@@ -64,7 +64,6 @@ set_myself (pid_t pid, HANDLE h)
   if (pid == 1)
     pid = cygwin_pid (winpid);
   myself.init (pid, PID_IN_USE | PID_MYSELF, h);
-  myself->dwProcessId = winpid;
   myself->process_state |= PID_IN_USE;
   myself->start_time = time (NULL); /* Register our starting time. */
 

 
