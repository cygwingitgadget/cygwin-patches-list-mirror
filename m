Return-Path: <cygwin-patches-return-4944-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22663 invoked by alias); 11 Sep 2004 01:33:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22649 invoked from network); 11 Sep 2004 01:33:56 -0000
Message-Id: <3.0.5.32.20040910212935.007e4310@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 11 Sep 2004 01:33:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: Setting the winpid in pinfo
In-Reply-To: <20040908041556.GA7793@trixie.casa.cgf.cx>
References: <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
 <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q3/txt/msg00096.txt.bz2

At 12:15 AM 9/8/2004 -0400, Christopher Faylor wrote:
>On Tue, Sep 07, 2004 at 09:26:02PM -0400, Pierre A. Humblet wrote:

>>Also, on WinME, simply holding down ^C in the bash shell will
>>cause a crash (thanks to Errol Smith)
>>~>     142 [sig] BASH 1853149 handle_threadlist_exception: 
>>handle_threadlist_exception called with threadlist_ix -1
>>    1751 [sig] BASH 1853149 handle_exceptions: Exception: 
>>STATUS_ACCESS_VIOLATION
>>
>>Any idea about what's happening? I have been unable to
>>make any progress.
>
>I'll see if I can duplicate the problem with VMware.  That's the only
>WinME system that I have available to me currently.

Should we appeal for the donation of a small laptop? It wouldn't
crowd your office much. BTW, I keep my Win95 in my guestroom,
so my guests can check their e-mail.

Here are 2 other small changes.

When killing the (system stressing) program I used to track the
fork bug, I noticed that it occasionally leaves stray processes
behind, as in
821 49315459       1  557307 4245651837    0  740 20:50:10 /c/HOME/PIERRE/A
0x821 = PID_INITIALIZING + PID_ORPHANED + PID_IN_USE
What's happening is that there is a race between the winpids
scanning in kill_pgrp and the creation of new processes.
The patch in fork.cc improves the situation by exiting
children immediately when the parent dies during a fork.

Also a ^C immediately terminates processes that are initializing.
That is not desirable for processes created by Cygwin processes. 
The patch in exceptions.cc changes that.
Note that new processes will still be killed if the ^C occurs
in the initial interval where they are suspended (otherwise 
those processes could stay in that state forever, due to the
phenomenon described in the previous paragraph).

2004-09-11  Pierre Humblet <pierre.humblet@ieee.org>

	* fork.cc (sync_with_parent): Exit if parent died.
	* exceptions.cc: Add header files.
	(ctrl_c_handler): Do nothing while a Cygwin subprocess is
	starting.


Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.133
diff -u -p -r1.133 fork.cc
--- fork.cc     31 Aug 2004 03:34:04 -0000      1.133
+++ fork.cc     11 Sep 2004 01:12:14 -0000
@@ -203,16 +203,21 @@ sync_with_parent (const char *s, bool ha
     api_fatal ("fork child - SetEvent for %s failed, %E", s);
   if (hang_self)
     {
-      HANDLE h = fork_info->forker_finished;
+      HANDLE w4[2];
+      w4[0] = fork_info->forker_finished;
+      w4[1] = fork_info->parent;
       /* Wait for the parent to fill in our stack and heap.
         Don't wait forever here.  If our parent dies we don't want to clog
         the system.  If the wait fails, we really can't continue so exit.  */
-      DWORD psync_rc = WaitForSingleObject (h, FORK_WAIT_TIMEOUT);
+      DWORD psync_rc = WaitForMultipleObjects (2, w4, FALSE,
FORK_WAIT_TIMEOUT);
       debug_printf ("awake");
       switch (psync_rc)
        {
+       case WAIT_OBJECT_0 + 1:
+         debug_printf ("Parent died %s", s);
+         myself->exit (1);
        case WAIT_TIMEOUT:
-         api_fatal ("WFSO timed out %s", s);
+         api_fatal ("WFMO timed out %s", s);
          break;
        case WAIT_FAILED:
          if (GetLastError () == ERROR_INVALID_HANDLE &&
Index: exceptions.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exceptions.cc,v
retrieving revision 1.217
diff -u -p -r1.217 exceptions.cc
--- exceptions.cc       3 Sep 2004 01:53:11 -0000       1.217
+++ exceptions.cc       11 Sep 2004 01:12:16 -0000
@@ -26,6 +26,11 @@ details. */
 #include "perprocess.h"
 #include "security.h"
 #include "cygthread.h"
+#include "path.h"
+#include "fhandler.h"
+#include "dtable.h"
+#include "cygheap.h"
+#include "child_info.h"
 
 #define CALL_HANDLER_RETRY 20
 
@@ -805,6 +810,8 @@ ctrl_c_handler (DWORD type)
 
   if (!cygwin_finished_initializing)
     {
+      if (child_proc_info) 
+        return TRUE; /* Let parent handle it */
       debug_printf ("exiting with status %p", STATUS_CONTROL_C_EXIT);
       ExitProcess (STATUS_CONTROL_C_EXIT);
     }

