Return-Path: <cygwin-patches-return-5126-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22887 invoked by alias); 14 Nov 2004 17:39:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22877 invoked from network); 14 Nov 2004 17:39:22 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.170.214)
  by sourceware.org with SMTP; 14 Nov 2004 17:39:22 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I76JUT-003DEF-NW
	for cygwin-patches@cygwin.com; Sun, 14 Nov 2004 12:42:29 -0500
Message-Id: <3.0.5.32.20041114123430.008289b0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 14 Nov 2004 17:39:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041114051158.GG7554@trixie.casa.cgf.cx>
References: <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00127.txt.bz2

At 12:11 AM 11/14/2004 -0500, Christopher Faylor wrote:
>
>When you first mentioned this, I had an idea that maybe we could be
>waiting on something else besides a process handle which would be
>inherited by any subprocesses.  I thought that maybe we could somehow
>use a mutex but there would always be a period when you'd have to do
>some tricky synchronization to make sure that the child gets to lock the
>mutex but the parent doesn't.
>
>I don't know how many times I have wished for a non-process handle that
>would become signalled when a process exits.
>
>So, today, it occurred to me that pipes could come to the rescue again.
>If we opened a pipe and put the write end in every child process, the
>parent could wait on the read end of the pipe.  When the last child
>process dies, the parent would wake up and do what it does now.
>
>At first, I was hoping that pipes would work correctly when called
>with WaitFor* and we could just drop pipe handles in there.  Of course,
>it can't be that simple and I really should have known that wouldn't
>work.  I think I have tried this technique about twice a year since
>1998.
>
>Instead, you have to use ReadFile in a thread.  So, the children would
>gain an extra open handle, the parent would get some new threads.  But
>the parent would be able to track A LOT more subprocesses than the
>current 63.

That would be the key advantage of this approach. Do you have a
way (async I/O?) to avoid having one thread per child?
BTW, have you ever tried using select, having a connection from the
parent to the child?
 
>I just implemented most of this and it seems to work ok.  One side
>effect of this technique is that any subprocess created with
>CreateProcess will also inherit the pipe and so, a parent cygwin process
>will wait for all of the processes created with CreateProcess.  I'm not
>sure if I really care about that, though.
>
>The other negative side effect is the overhead of creating a pipe and a
>thread.  I don't think this is noticeable and this technique eliminates
>some overhead in cygwin, too.  It's not exactly a wash, but I'm hoping
>it won't be too bad, regardless.
>
>When I get the code to a point that it can run configure, I'll do a
>benchmark and see how bad this technique is.  If there is not a
>noticeable degradation, I think I'll probably duplicate the scenario of
>last year and checkin this revamp which, I believe will eliminate the
>security problem that you were talking about.

There is also the case where a setuid child needs to signal its parent.
That's another use of my ppid_waitsig, avoiding the PROCESS_DUP_HANDLE
issue.
Could your "end of pid" pipe be used to transmit signals, with the reader
thread forwarding the sigpacket to the local sigthread?

Pierre
