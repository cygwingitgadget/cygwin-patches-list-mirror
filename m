Return-Path: <cygwin-patches-return-4934-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23901 invoked by alias); 8 Sep 2004 05:10:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23866 invoked from network); 8 Sep 2004 05:10:02 -0000
Date: Wed, 08 Sep 2004 05:10:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch]: Setting the winpid in pinfo
Message-ID: <20040908041556.GA7793@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040907212602.0085d7f0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00086.txt.bz2

On Tue, Sep 07, 2004 at 09:26:02PM -0400, Pierre A. Humblet wrote:
>I am looking at some oddities involving ^C and signals.
>
>In the current code, set_myself sets the dwProcessId when a pinfo is
>created.  The upshot is that signals to a process that is exec'ing will
>be prematurely directed to the child (using a meaningless handle from
>the parent).  The bug can be fixed by simply removing the offending
>line.

It's odd but I would have sworn that I'd removed that setting of
dwProcessId some time ago.  It's been there since 2000, though, so
I am obviously mistaken.

The intent was to set this back to the parent's pid so that the stub
would deal with any potential signal but that wouldn't work right when a
process execs another process anyway, since the cygpid is the pid of the
original process.  I'm not sure why I just didn't forego setting
dwProcessId entirely in that case.  Seems like a botched edit.

Anyway, I've just yanked out all of that code and removed cygpid from
the child_info structure.  child_info reflects a time before the advent
of the cygheap.  Adding the pid to the cygheap at the appropriate time
and using that seems to simplify things a lot.  I basically got rid of
all of the cypid usages and modified set_myself:

Index: pinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
retrieving revision 1.119
diff -u -p -r1.119 pinfo.cc
--- pinfo.cc	30 Aug 2004 22:08:50 -0000	1.119
+++ pinfo.cc	8 Sep 2004 04:06:05 -0000
@@ -58,19 +58,18 @@ pinfo_fixup_after_fork ()
    This is done once when the dll is first loaded.  */
 
 void __stdcall
-set_myself (pid_t pid, HANDLE h)
+set_myself (HANDLE h)
 {
-  DWORD winpid = GetCurrentProcessId ();
-  if (pid == 1)
-    pid = cygwin_pid (winpid);
-  myself.init (pid, PID_IN_USE | PID_MYSELF, h);
-  myself->dwProcessId = winpid;
+  if (!h)
+    cygheap->pid = cygwin_pid (GetCurrentProcessId ());
+  myself.init (cygheap->pid, PID_IN_USE | PID_MYSELF, h);
   myself->process_state |= PID_IN_USE;
   myself->start_time = time (NULL); /* Register our starting time. */
 
   (void) GetModuleFileName (NULL, myself->progname, sizeof (myself->progname));
   if (!strace.active)
     strace.hello ();
+  debug_printf ("myself->dwProcessId %u", myself->dwProcessId);
   InitializeCriticalSection (&myself->lock);
   return;
 }
@@ -90,7 +89,7 @@ pinfo_init (char **envp, int envc)
     {
       /* Invent our own pid.  */
 
-      set_myself (1);
+      set_myself (NULL);
       myself->ppid = 1;
       myself->pgid = myself->sid = myself->pid;
       myself->ctty = -1;


>Also, in proc_can_be_signalled, I don't understand the line  
>  if (ISSTATE (p, PID_INITIALIZING) ||
>      (((p)->process_state & (PID_ACTIVE | PID_IN_USE)) ==
>       (PID_ACTIVE | PID_IN_USE)))
>    return true;
>The test for PID_INITIALIZING will allow a doomed attempt at signaling
>a process while it is being forked (and its sendsig is still NULL).  Am
>I missing something?

If sendsig is NULL then send_sig should loop waiting for it not to be
NULL.  Are you not seeing this happen?  I just added code to wait
similarly for dwProcessId.

I'm toying with the idea of setting dwProcessId to NULL in spawn_guts
when execing so that the child will catch signals.  The problem with
that is that it will cause signals to be uncaught when a pure windows
process is spawned.  CTRL-C from the console would still be handled
correctly but SIGKILL would not be.

>Also, on WinME, simply holding down ^C in the bash shell will
>cause a crash (thanks to Errol Smith)
>~>     142 [sig] BASH 1853149 handle_threadlist_exception: 
>handle_threadlist_exception called with threadlist_ix -1
>    1751 [sig] BASH 1853149 handle_exceptions: Exception: 
>STATUS_ACCESS_VIOLATION
>
>Any idea about what's happening? I have been unable to
>make any progress.

I'll see if I can duplicate the problem with VMware.  That's the only
WinME system that I have available to me currently.

Anyway, I want to run my changes through the test suite before I check
them in.

cgf
