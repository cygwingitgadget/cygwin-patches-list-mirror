Return-Path: <cygwin-patches-return-5179-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32081 invoked by alias); 4 Dec 2004 05:43:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32047 invoked from network); 4 Dec 2004 05:43:22 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 4 Dec 2004 05:43:22 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 986411B491; Sat,  4 Dec 2004 00:43:48 -0500 (EST)
Date: Sat, 04 Dec 2004 05:43:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041204054348.GA14532@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00180.txt.bz2


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 8755

[and now the more detailed reply]
On Thu, Dec 02, 2004 at 09:13:11PM -0500, Pierre A. Humblet wrote:
>At 11:29 PM 11/25/2004 -0500, Christopher Faylor wrote:
>I have downloaded and run a recent snapshot on WinME,
>CYGWIN_ME-4.90 hpn5170 1.5.13s(0.116/4/2) 20041125 23:34:52 i686 unknown unknown Cygwin
>and tried a few things. I have also gone through the diff.
>Here are my initial comments:
>
>- Non cygwin processes started by cygwin are not shown by ps
>  anymore and cannot be killed.
>
>- spawn(P_DETACH) does not work correctly when spawning non-cygwin 
>  processes.
>  This is due to using a pipe to detect process termination. 
>
>- >AFAIK, the only problem with the current code is if a parent process
>>forks a process, calls setuid, and execs a non-cygwin process it is
>>possible that the parent process won't be able to retrieve the exit
>>value of the non-cygwin process.
>  I assume you are referring to the use of OpenProcess to reparent, 
>  instead of duplicating the child process handle.

Yes, although cygwin was already using OpenProcess for other things so if
the OpenProcess method was unsafe in this case it would have been unsafe
in the other case, too.

I've eliminated the need for both OpenProcess's but there are still more
sprinkled throughout cygwin.

>This patch uses very innovative methods, but IMHO the net result
>goes against Cygwin tradition.
>It decreases features (the support of non-cygwin processes) to 
>simplify code.

It's intent was only to cause problems with that one rare feature that I
mentioned.  I sincerely doubt that it would have caused a problem owing
to the fact that cygwin was already using the same method elsewhere.

The gain was code simplification and fewer synchronization points
between a parent/child process.  I'd hoped to see some noticeable speed
improvements but I think the bottleneck lies in fork.

>In fact there are many design issues and choices that have been
>lumped together. They can be separated, at least partially, and
>discussed individually.
>
> 1) parent getting handle to child:
>      A) child duplicates handle   [security issue]
>      B) parent duplicates handle
>      C) parent opens process      [access issue]
> 2) child termination detection
>      A) WaitFor(child process) 
>      B) pipe       [problem spawning non-cygwin processes]
>      C) Windows select and socket [like pipes, but untested & risky]
> 3) number of waiting threads
>      A) one thread per 63 processes [WaitFor only]
>      B) one thread per process  [pipe or WaitFor]
>      C) one thread for all processes [perhaps..., with select]
> 4) communication with parent
>      A) common sig pipe
>      B) process termination detection pipe  
> 5) support for non-cygwin processes
>      A) subproc_ready event
>      B) don't support
> 6) reporting exit status
>      A) GetExitCodeProcess only
>      B) pinfo->exit_status + fallback with GetExitCodeProcess  
>
>Here is my analysis and recommendation for the 6 issues:
> 1) Use B), it has no drawback

And that's what is currently in use.

> 2) Use A), it has no drawback, although B is tempting due
>    to its simplicity. Perhaps worth more than spawn(P_DETACH). 

The "problem spawning non-cygwin processes" was because there were bugs
in my code, which is hardly surprising given how much was rewritten.  In
my sandbox, I've again gotten rid of the reparenting code at the cost of
keeping a cygwin stub around for the case where an exec is attempted on
a pure-windows program.  It's almost possible to handle this without the
stub and it would be nice to think that windows processes could be
handled without extra process overhead, but I finally decided that it
wasn't worth the amount of bookkeeping required.

The net result of the way I'm doing things now should be slightly
improved functionality over 1.5.12.

> 3) Which one is faster? 

In my tests, the cvs code is as fast or very slightly faster than 1.5.12 as
far as wall clock time is concerned.  If cygwin is smaller and the code is
simpler, then I'm satisfied with the tradeoff.  I suspect that most of
the slowness in process creation is in fork, not in the "wait for a process
to die" code.

> 4) Dictated by choice for 2)
> 5) Support it.

I've put it back again but it isn't exactly the same.  I merged the handling
of subproc_ready processing under the child_info class and use the same
functions in spawn, dcrt0, and fork.

> 6) Use B), it must be slightly faster.

I'm not sure it is all that much faster but it is more foolproof a method
for passing around true UNIX exit values (Hi Igor).

>Other points:
>- The on demand creation of the pid_handles is a good idea

Yes, that hit me as I was reimplementing this.

>- The name of the waiting threads should not be "sig"

Yep.  Cut/paste error.  It would be nice if the thread names were based on
the pid but that's extra processing just for strace, so I just named them
"proc_waiter".

>- opening the pinfo of ppid in set_myself(), just to close 
>  parent->wr_proc_pipe, looks simple but is costly.
>  I understand that it's nicer than closing the handle in dcrt0.cc
>  (from the childinfo).
>  A middle ground would be to have a ppid_wr_proc_pipe in the
>  child pinfo. 

Ok.  I've put a parent_wr_proc_pipe handle in child_info and close it in
set_myself.  This eliminates the possibility of a handle being left
around.

>- I did not expect that you would always start the new process
>  in suspended state due to reparenting. This is likely to degrade speed.
>  It can be avoided without increase in code complexity.

I don't think this was a big deal.  There was always synchronization
between the parent and the child with the subproc_ready handshake.  That
was eliminated in CVS, but there is still a "handshake" in terms of
creating the process in a suspended state.

In any event, this is gone in my sandbox.  I reinstated the old
determination of when to start suspended when I re-removed the handling
for reparenting.

So, subproc_ready is back but the child signals the parent much earlier
in the cygwin initialization process.

>- I think there is a race condition during spawn.
>  The logical parent can terminate just after the SIGREPARENT
>  signal has been sent, causing an infinite loop in.
>      if (exec_cygstarted)
>        while (myself->cygstarted == exec_cygstarted)
>          low_priority_sleep (0);
>
>  The same issue was addressed (with a detailed comment) in my
>  initial patch in this thread.  
>      while (myself->isreparenting && myself->ppid != 1 
>             && my_parent_is_alive ())
>        low_priority_sleep (0); 

Yes, you're right.  That was a race.  I fixed it in CVS by creating a
pinfo.parent_alive function which polled the parent pipe to see if the
parent was responding but this loop is now gone from my sandbox
entirely.  I guess I should also remove the short-lived parent_alive
now.

>- It is said in spawn_guts;
>  "/* If wr_proc_pipe doesn't exist then this process was not started
>   by a cygwin process. "
>  but in pinfo::alert_parent() the pipe is set to NULL when the cygwin
>  parent has disappeared.

Yep.  That's a bug.  I now set the pipe to INVALID_HANDLE_VALUE when the
parent goes away.

>- Re-execing does not always work properly. This can be
>  demonstrated with exim running as daemon (exim -bd).
>  Note that it was started from cygwin but ppid = 1.
>  BEFORE
>  ~: ps -a | fgrep EXIM
>   159801       1  159801 4294807495    ?  400 00:32:08 /c/PROGRAM FILES/CYGNUS/BIN/EXIM-4.43-2
>  ~: kill -HUP 159801  [This causes re-execing]
>  ~: ps -a | fgrep EXIM
>   159801       1  159801 4294856995    ?  400 19:16:32 /c/PROGRAM FILES/CYGNUS/BIN/EXIM-4.43-2
>   Note the new winpid, but same cygpid
>
>  AFTER
>  ~: ps | fgrep -i exim
>  1109249       1 1109249 4293858047    ?  740 20:32:57 /c/PROGRAM FILES/CYGWIN/BIN/EXIM-4.43-2
>  ~: kill -HUP 1109249 
>  ~: ps | fgrep -i exim
>  1043517       1 1043517 4293923779    ?  740 20:33:19 /c/PROGRAM FILES/CYGWIN/BIN/EXIM-4.43-2
>  Note that the cygpid and winpid have changed.

I wrote a simple test case to check this and I don't see it -- on XP.  I
can't easily run Me anymore.  Does the attached program demonstrate this
behavior when you run it?  It should re-exec itself every time you hit
CTRL-C.

> - In bash I type "sleep 1000 &" a dozen times (sometimes more) then type "exit".
>   Bash then outputs "logout" and hangs. It eventually goes away. When I timed it,
>   that took about 16 minutes.

I haven't tried this yet with the new code I just wrote.  I want to try
this and also try running some things on a single-processor system
before I check everything in.

I wish I could get vmware working so that I could check this on Me.
Sigh.

Thanks for the feeback, Pierre.

cgf

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="execit2.c"
Content-length: 319

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/signal.h>

void ouch (int sig)
{
  printf ("got signal %d\n", sig);
  return;
}

int
main (int argc, char **argv)
{
  signal (SIGINT, ouch);
  while (pause ())
    {
      puts ("execing myself");
      execv (argv[0], argv);
    }
  exit (0);
}

--IS0zKkzwUGydFO0o--
