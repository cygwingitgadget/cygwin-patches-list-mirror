Return-Path: <cygwin-patches-return-5282-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1197 invoked by alias); 24 Dec 2004 03:48:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1145 invoked from network); 24 Dec 2004 03:48:35 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 24 Dec 2004 03:48:35 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 4BF551B401; Thu, 23 Dec 2004 22:50:08 -0500 (EST)
Date: Fri, 24 Dec 2004 03:48:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041224035008.GC20554@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org> <41C9C088.9E9B16E3@phumblet.no-ip.org> <3.0.5.32.20041223182306.00824b60@incoming.verizon.net> <3.0.5.32.20041223215420.0082b790@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20041223215420.0082b790@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00283.txt.bz2

On Thu, Dec 23, 2004 at 09:54:20PM -0500, Pierre A. Humblet wrote:
>At 09:27 PM 12/23/2004 -0500, Christopher Faylor wrote:
>>On Thu, Dec 23, 2004 at 06:23:06PM -0500, Pierre A. Humblet wrote:
>>
>>The side effect of doing things this way is that the program will seem
>>to have exited with a SIGTERM value if it calls ExitProcess, too.
>>That is a depature from previous behavior that I'm sure I'll hear about.
>
>Good point. But even if you leave it to be 0, the complain will be that
>the exit value won't be passed.

Right.

>Of course a Cygwin program should call >exit.

Right.

FWIW, I modified cygwin so that it seems as if with a status of '1' if
you use ExitProcess and a status of "SIGTERM" (as in terminated by a
signal) if you kill a process via task manager (aka TerminateProcess).

>>>This can be fixed with my lunch time ideas of yesterday.
>>>Looking at the code, I saw that most of them were already 
>>>implemented. The only changes are:
>>>1) remove child_proc_info->parent_wr_proc_pipe stuff
>>>2) in pinfo::wait, duplicate into non-inheritable wr_proc_pipe
>>
>>As may not be too surprising, I already considered creating the pipe
>>before creating the process (somehow I am hearing echoes of John Kerry
>>here).  I actually coded it that way to begin with but then chose to go
>>with the current plan.
>
>That's fine, and I am not suggesting that you should change your way.

Ah.  I didn't get that the first two times you explained it.  Now I get
it.  Sorry.

>Perhaps I wasn't clear. Just duplicate the pipe into the new process,
>as you do now, but not inheritable. The new process makes it inheritable
>before execing a new new process.

How about just using the present method but never making the handle
inheritable?  Just duplicate the wr_proc_pipe to the child on a
fork/spawn, closing the original in the DuplicateHandle.  When a process
execs, use the same code to pass the pipe along to the newly created
"child".  If the DuplicateHandle fails because the process has already
exited, it doesn't matter because the stub is exiting anyway.  I think
it ends up being fewer number of DuplicateHandles in that case because
you won't have to make the handle noninheritable again if the
CreateProcess fails.

I've implemented this code and it seems to work.

>>I'll have to think about my reasons for not implementing it that way.
>>I don't remember what they are right now.
>
>OK. 
>
>I am looking at the code again.  As I see it, a cygwin process A
>started from Windows that execs another process B will create the pipe
>after B has been created.  There is a possibility that B has already
>terminated at that moment, perhaps after having exec'ed another process
>C.  Is that race taken care of?  Perhaps a Cygwin process started from
>Windows should start an exec'ed process in the suspended state.

I thought I tested that case but, you're right, it's a problem.  I'll
create the process in a suspended state when !myself->wr_proc_pipe.

cgf
