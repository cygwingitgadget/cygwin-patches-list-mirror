Return-Path: <cygwin-patches-return-5177-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3321 invoked by alias); 3 Dec 2004 02:18:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2498 invoked from network); 3 Dec 2004 02:18:11 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.190.188)
  by sourceware.org with SMTP; 3 Dec 2004 02:18:11 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I84JW7-0002E5-DC
	for cygwin-patches@cygwin.com; Thu, 02 Dec 2004 21:21:43 -0500
Message-Id: <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 03 Dec 2004 02:18:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041126042908.GA12730@trixie.casa.cgf.cx>
References: <20041120062339.GA31757@trixie.casa.cgf.cx>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx>
 <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org>
 <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00178.txt.bz2

At 11:29 PM 11/25/2004 -0500, Christopher Faylor wrote:
>On Sat, Nov 20, 2004 at 01:23:39AM -0500, Christopher Faylor wrote:
>>On Tue, Nov 16, 2004 at 10:56:40AM -0500, Christopher Faylor wrote:
>>>The simplification of the code from removing all of the reparenting
>>>considerations is not something that I'm going to give up on easily.
>>
>>Well, the code seems to be slightly faster now than the old method, so
>>that's something.  I think it's also a lot simpler.
>
>I've checked in my revamp of the exec/wait code.  There are still some
>other ways to do what I did and maybe I'll experiment with using
>multiple threads running WaitForMultipleObjects, but, for now, cygwin is
>using the one thread per process technique.


I have downloaded and run a recent snapshot on WinME,
CYGWIN_ME-4.90 hpn5170 1.5.13s(0.116/4/2) 20041125 23:34:52 i686 unknown unknown Cygwin
and tried a few things. I have also gone through the diff.
Here are my initial comments:

- Non cygwin processes started by cygwin are not shown by ps
  anymore and cannot be killed.

- spawn(P_DETACH) does not work correctly when spawning non-cygwin 
  processes.
  This is due to using a pipe to detect process termination. 

- >AFAIK, the only problem with the current code is if a parent process
>forks a process, calls setuid, and execs a non-cygwin process it is
>possible that the parent process won't be able to retrieve the exit
>value of the non-cygwin process.
  I assume you are referring to the use of OpenProcess to reparent, 
  instead of duplicating the child process handle.


This patch uses very innovative methods, but IMHO the net result
goes against Cygwin tradition.
It decreases features (the support of non-cygwin processes) to 
simplify code.

In fact there are many design issues and choices that have been
lumped together. They can be separated, at least partially, and
discussed individually.

 1) parent getting handle to child:
      A) child duplicates handle   [security issue]
      B) parent duplicates handle
      C) parent opens process      [access issue]
 2) child termination detection
      A) WaitFor(child process) 
      B) pipe       [problem spawning non-cygwin processes]
      C) Windows select and socket [like pipes, but untested & risky]
 3) number of waiting threads
      A) one thread per 63 processes [WaitFor only]
      B) one thread per process  [pipe or WaitFor]
      C) one thread for all processes [perhaps..., with select]
 4) communication with parent
      A) common sig pipe
      B) process termination detection pipe  
 5) support for non-cygwin processes
      A) subproc_ready event
      B) don't support
 6) reporting exit status
      A) GetExitCodeProcess only
      B) pinfo->exit_status + fallback with GetExitCodeProcess  

Here is my analysis and recommendation for the 6 issues:
 1) Use B), it has no drawback
 2) Use A), it has no drawback, although B is tempting due
    to its simplicity. Perhaps worth more than spawn(P_DETACH). 
 3) Which one is faster? 
 4) Dictated by choice for 2)
 5) Support it.
 6) Use B), it must be slightly faster.


Other points:
- The on demand creation of the pid_handles is a good idea

- The name of the waiting threads should not be "sig"

- opening the pinfo of ppid in set_myself(), just to close 
  parent->wr_proc_pipe, looks simple but is costly.
  I understand that it's nicer than closing the handle in dcrt0.cc
  (from the childinfo).
  A middle ground would be to have a ppid_wr_proc_pipe in the
  child pinfo. 

- I did not expect that you would always start the new process
  in suspended state due to reparenting. This is likely to degrade speed.
  It can be avoided without increase in code complexity.

- I think there is a race condition during spawn.
  The logical parent can terminate just after the SIGREPARENT
  signal has been sent, causing an infinite loop in.
      if (exec_cygstarted)
        while (myself->cygstarted == exec_cygstarted)
          low_priority_sleep (0);

  The same issue was addressed (with a detailed comment) in my
  initial patch in this thread.  
      while (myself->isreparenting && myself->ppid != 1 
             && my_parent_is_alive ())
        low_priority_sleep (0); 


- It is said in spawn_guts;
  "/* If wr_proc_pipe doesn't exist then this process was not started
   by a cygwin process. "
  but in pinfo::alert_parent() the pipe is set to NULL when the cygwin
  parent has disappeared.

- Re-execing does not always work properly. This can be
  demonstrated with exim running as daemon (exim -bd).
  Note that it was started from cygwin but ppid = 1.
  BEFORE
  ~: ps -a | fgrep EXIM
   159801       1  159801 4294807495    ?  400 00:32:08 /c/PROGRAM FILES/CYGNUS/BIN/EXIM-4.43-2
  ~: kill -HUP 159801  [This causes re-execing]
  ~: ps -a | fgrep EXIM
   159801       1  159801 4294856995    ?  400 19:16:32 /c/PROGRAM FILES/CYGNUS/BIN/EXIM-4.43-2
   Note the new winpid, but same cygpid

  AFTER
  ~: ps | fgrep -i exim
  1109249       1 1109249 4293858047    ?  740 20:32:57 /c/PROGRAM FILES/CYGWIN/BIN/EXIM-4.43-2
  ~: kill -HUP 1109249 
  ~: ps | fgrep -i exim
  1043517       1 1043517 4293923779    ?  740 20:33:19 /c/PROGRAM FILES/CYGWIN/BIN/EXIM-4.43-2
  Note that the cygpid and winpid have changed.

 - In bash I type "sleep 1000 &" a dozen times (sometimes more) then type "exit".
   Bash then outputs "logout" and hangs. It eventually goes away. When I timed it,
   that took about 16 minutes.

Pierre
