Return-Path: <cygwin-patches-return-4922-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21525 invoked by alias); 30 Aug 2004 04:22:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21511 invoked from network); 30 Aug 2004 04:22:06 -0000
Date: Mon, 30 Aug 2004 04:22:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: broken pipe
Message-ID: <20040830042249.GA8900@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040829125154.00810900@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00074.txt.bz2

On Sun, Aug 29, 2004 at 12:51:54PM -0400, Pierre A. Humblet wrote:
>I have been investigation the broken pipe problem reported in
><http://cygwin.com/ml/cygwin/2004-07/msg01120.html>
>Thanks to Errol for providing a simple test case, from which
>I wrote a C program with similar features.
>
>Once in many thousands fork will return 0 to the parent.
>The parent then thinks it is the child, closes the reader
>side of the pipe and starts writing to the pipe, causing its death.
>Meanwhile the child also writes to the pipe and dies of the same cause.
>
>There is a scenario that explains the above observations.
>Both the parent and the child try to create the child pinfo 
>simultaneously. The following sequence can occur:
> - child creates pinfo
> - parent opens pinfo
> - parent reads cygpid from pinfo (== 0)
> - child writes its cygpid
>The parent fork then returns 0.
>
>My solution is for the parent fork to return the cygpid calculated
>from the winpid.
>The test program is still running after 100,000 fork/exec/pipe,
>a longevity record. 

Wouldn't the below solve this problem more minimally?  It moves the
setting of forked_pid to after it is known that the pinfo structure
has been filled out.

>Two other comments:
>- there is still a race to create the pinfo. Hopefully all versions
>of Windows handle it properly. To be on the safe side, the parent could
>open (not create) the pinfo after the child's longjmp.
>- the parent copies myself->progname into the child. This seems
>duplicative, given that the child always sets progname from 
>GetModuleFileName in set_myself.

I'm not clear on why you think the race is a problem.  The end result
should be that the correct info is in the pinfo regardless.  It shouldn't
matter if CreateFileMapping or OpenFileMapping is called.

cgf

Index: fork.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/fork.cc,v
retrieving revision 1.131
diff -u -p -r1.131 fork.cc
--- fork.cc	7 Mar 2004 04:57:47 -0000	1.131
+++ fork.cc	30 Aug 2004 04:17:17 -0000
@@ -514,8 +514,6 @@ fork_parent (HANDLE& hParent, dll *&firs
 
   int forked_pid;
 
-  forked_pid = forked->pid;
-
   /* Initialize things that are done later in dll_crt0_1 that aren't done
      for the forkee.  */
   strcpy (forked->progname, myself->progname);
@@ -552,6 +550,7 @@ fork_parent (HANDLE& hParent, dll *&firs
   if (!sync_with_child (pi, subproc_ready, true, "waiting for longjmp"))
     goto cleanup;
 
+  forked_pid = forked->pid;
   /* CHILD IS STOPPED */
   debug_printf ("child is alive (but stopped)");
 
