Return-Path: <cygwin-patches-return-5281-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32646 invoked by alias); 24 Dec 2004 02:59:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32594 invoked from network); 24 Dec 2004 02:59:36 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 24 Dec 2004 02:59:36 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I97HT6-00AZG9-K0
	for cygwin-patches@cygwin.com; Thu, 23 Dec 2004 22:03:06 -0500
Message-Id: <3.0.5.32.20041223215420.0082b790@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 24 Dec 2004 02:59:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041224022710.GB20554@trixie.casa.cgf.cx>
References: <3.0.5.32.20041223182306.00824b60@incoming.verizon.net>
 <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
 <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net>
 <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net>
 <20041205010020.GA20101@trixie.casa.cgf.cx>
 <20041213202505.GB27768@trixie.casa.cgf.cx>
 <41BEFBA5.97CA687B@phumblet.no-ip.org>
 <20041214154214.GE498@trixie.casa.cgf.cx>
 <41C99D2A.B5C4C418@phumblet.no-ip.org>
 <41C9C088.9E9B16E3@phumblet.no-ip.org>
 <3.0.5.32.20041223182306.00824b60@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00282.txt.bz2

At 09:27 PM 12/23/2004 -0500, Christopher Faylor wrote:
>On Thu, Dec 23, 2004 at 06:23:06PM -0500, Pierre A. Humblet wrote:
>
>The side effect of doing things this way is that the program will seem
>to have exited with a SIGTERM value if it calls ExitProcess, too.
>That is a depature from previous behavior that I'm sure I'll hear about.

Good point. But even if you leave it to be 0, the complain will be that
the exit value won't be passed. Of course a Cygwin program should call
exit.

>>If my spawn(P_DETACH) program of yesterday is terminated from 
>>Windows during the sleep interval, then the parent process does
>>not notice the termination and keeps waiting.
>
>I think I already mentioned this as a side effect of the new code.

I must have missed it.

>>This can be fixed with my lunch time ideas of yesterday.
>>Looking at the code, I saw that most of them were already 
>>implemented. The only changes are:
>>1) remove child_proc_info->parent_wr_proc_pipe stuff
>>2) in pinfo::wait, duplicate into non-inheritable wr_proc_pipe
>
>As may not be too surprising, I already considered creating the pipe
>before creating the process (somehow I am hearing echoes of John Kerry
>here).  I actually coded it that way to begin with but then chose to go
>with the current plan.

That's fine, and I am not suggesting that you should change your way.
Perhaps I wasn't clear. Just duplicate the pipe into the new process,
as you do now, but not inheritable. The new process makes it inheritable
before execing a new new process.

>I'll have to think about my reasons for not implementing it that way.
>I don't remember what they are right now.

OK. 

I am looking at the code again.
As I see it, a cygwin process A started from Windows that execs another
process B will create the pipe after B has been created.
There is a possibility that B has already terminated at that moment,
perhaps after having exec'ed another process C.
Is that race taken care of? Perhaps a Cygwin process started from Windows
should start an exec'ed process in the suspended state.

Pierre
