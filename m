Return-Path: <cygwin-patches-return-5284-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31217 invoked by alias); 24 Dec 2004 04:33:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31112 invoked from network); 24 Dec 2004 04:33:49 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 24 Dec 2004 04:33:49 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 2F87C1B401; Thu, 23 Dec 2004 23:35:22 -0500 (EST)
Date: Fri, 24 Dec 2004 04:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041224043522.GA22309@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org> <41C9C088.9E9B16E3@phumblet.no-ip.org> <3.0.5.32.20041223182306.00824b60@incoming.verizon.net> <3.0.5.32.20041223215420.0082b790@incoming.verizon.net> <3.0.5.32.20041223230550.0081e100@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041223230550.0081e100@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00285.txt.bz2

On Thu, Dec 23, 2004 at 11:05:50PM -0500, Pierre A. Humblet wrote:
>At 10:50 PM 12/23/2004 -0500, Christopher Faylor wrote:
>>On Thu, Dec 23, 2004 at 09:54:20PM -0500, Pierre A. Humblet wrote:
>>>At 09:27 PM 12/23/2004 -0500, Christopher Faylor wrote:
>>>>On Thu, Dec 23, 2004 at 06:23:06PM -0500, Pierre A. Humblet wrote:
>>
>>FWIW, I modified cygwin so that it seems as if with a status of '1' if
>>you use ExitProcess and a status of "SIGTERM" (as in terminated by a
>>signal) if you kill a process via task manager (aka TerminateProcess).
>
>Good. 
>
>>>>>This can be fixed with my lunch time ideas of yesterday.
>>>>>Looking at the code, I saw that most of them were already 
>>>>>implemented. The only changes are:
>>>>>1) remove child_proc_info->parent_wr_proc_pipe stuff
>>>>>2) in pinfo::wait, duplicate into non-inheritable wr_proc_pipe
>>>>
>>>>As may not be too surprising, I already considered creating the pipe
>>>>before creating the process (somehow I am hearing echoes of John Kerry
>>>>here).  I actually coded it that way to begin with but then chose to go
>>>>with the current plan.
>>>
>>>That's fine, and I am not suggesting that you should change your way.
>>
>>Ah.  I didn't get that the first two times you explained it.  Now I get
>>it.  Sorry.
>>
>>>Perhaps I wasn't clear. Just duplicate the pipe into the new process,
>>>as you do now, but not inheritable. The new process makes it inheritable
>>>before execing a new new process.
>>
>>How about just using the present method but never making the handle
>>inheritable?  Just duplicate the wr_proc_pipe to the child on a
>>fork/spawn, closing the original in the DuplicateHandle. 
>
>Fine.
>
>> When a process
>>execs, use the same code to pass the pipe along to the newly created
>>"child".  If the DuplicateHandle fails because the process has already
>>exited, it doesn't matter because the stub is exiting anyway.  
>
>The problem in that case is that the logical parent won't get the exit
>status because the final process won't have the pipe open.

It doesn't matter if the final process has the pipe open as long as the
final process filled out exitcode.  The parent will notice that the
cygwin process exits when the stub exits in that case.

Although, hmm, a process which execs another process before getting its
wr_proc_pipe filled out will have a problem.

>I see two ways to guarantee that the pipe is passed:
>1) always start the new exec'ed process in suspended state (not only
>when the parent was started from Windows

I've never been clear on whether the other process needs to have the
shared memory mapped into its space for DuplicateHandle to fill in the
value.  If it does need this then CREATE_SUSPEND won't work.

>2) Make the pipe inheritable before exec.  I prefer 2 because it's
>bound to be slightly faster.

I don't think you need it.  You just need to tell a process which is
about to exec after having been execed to make sure that its
wr_proc_pipe is valid.

>>I think it ends up being fewer number of DuplicateHandles in that case
>>because you won't have to make the handle noninheritable again if the
>>CreateProcess fails.
>>
>>I've implemented this code and it seems to work.
>
>Perhaps, but I think there is a race.
>
>To avoid having the "undo" of the inheritance, I was suggesting after
>point 4) a couple of mails ago that we keep track of the inheritance
>state of the pipe.  The rules are simple: - if the pipe is inheritable
>when fork/spawn: make it non inheritable - if the pipe is
>non-inheritable when exec: make it inheritable.  So if an exec
>CreateProcess fails, there is nothing to do until the next fork/spawn,
>if any.

That just delays the setting of "noninheritance" to the next potential fork
or spawn, adding a test to every fork/spawn.

cgf
