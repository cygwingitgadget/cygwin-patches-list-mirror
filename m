Return-Path: <cygwin-patches-return-4149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22796 invoked by alias); 31 Aug 2003 15:25:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22748 invoked from network); 31 Aug 2003 15:25:18 -0000
Message-Id: <3.0.5.32.20030831112352.008161c0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sun, 31 Aug 2003 15:25:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030830203246.GA19303@redhat.com>
References: <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
 <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819143305.GA17431@redhat.com>
 <3F43B482.AC7F68F4@phumblet.no-ip.org>
 <3.0.5.32.20030828205339.0081f920@incoming.verizon.net>
 <20030829011926.GA16898@redhat.com>
 <20030829031256.GA18890@redhat.com>
 <3F4F60EA.4DBB8A51@phumblet.no-ip.org>
 <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00165.txt.bz2

Hi Chris,

thanks for your quick response to the ftp crash.

At 04:32 PM 8/30/2003 -0400, you wrote:
>retaddr_on_stack is not always going to be identical to esp + 36 no
>matter where it comes from.  I modified my test program to tickle the
>previous problem.  I've included it below.  You can short circuit the
>sig_dispatch_pending functioni and it will still report different
>retaddr_on_stack values -- as it should.  kill is getting called from
>different stack depths.
>
>I didn't notice this before since the SIGHUP signal is masked in
>'ouch()' function so a call to ouch() wouldn't be made until the mask
>was removed.  Changing the code to call another, unmasked signal, whose
>handler is dispatched immediately, shows (in the debugger) that
>retaddr_on_stack is different.

Hmm, what I see here is that the handler (call it A1) for SIGUSR1 starts 
first and the handler (B1) for SIGHUP starts while A1 is still running.
B1 terminates and A1 resumes (A2 is blocked). The recursion avoidance 
code is not invoked when B1 terminates. 
When A1 terminates we get a case of tail recursion, with a new handler A2 
starting immediately.
It is correct that the stack depths of Ai and Bi are different, but in both
cases the respective retaddr_on_stack == stack + 36.

**************

Your example shows many interesting phenomena. It behaves periodically and
it's
instructive to look at one period.
0) handler A terminates
1) mask changes from 20000000 to 0
2) wait_sig awake 0, processes -2
3) wait_sig awake 2, processes sig 30 and starts handler A, pending_signals
= 0
4) mask changes from 0 to 20000000
5) kill(1)
6) wait_sig awake 0, processes sig 1 and starts handler
7) mask changes from 020000000 to 20000001
8) kill(30)9) wait_sig awake 0, finds 30 blocked, pending_signals = 1
10) B terminates
11) mask changes from 20000001 to 20000000
12) wait_sig awake 0, processes -2
13) wait_sig awake 2, finds 30 blocked
loop back to 0)

There are 6 awakes. Two of them [ 3) and 13) ] are due to the recent
changes to the wait_sig loops. 
Another two [9) and 12) ] could be avoided simply by having a 
pending_signal_mask.
  
**************

I see that you have eliminated the call to thisframe.call_signal_handler
This has some negative implications. Consider for example in syscalls

writev (const int fd, const struct iovec *const iov, const int iovcnt)
{
  sig_dispatch_pending ();
  sigframe thisframe (mainthread);

The call to sig_dispatch_pending is meant for the case where
there is a pending signal. Assume there indeed is one.
The call to sig_dispatch_pending will setup an interrupt in sigsave. 
The return address on the stack will be the first interruptible return 
address above sig_dispatch_pending, i.e. the return address of writev.
The handler will not be entered until writev returns.

Because writev can be slow, it is quite possible that another
signal will occur. 
That's the reason to have sigframe thisframe (mainthread);

If such a signal occurs, the sigthread will awake and find the sigsave
busy. It will then starts looping until the writev completes.

I believe thisframe.call_signal_handler was invented to avoid
this kind of situation, where not only an old interrupt is delayed
until after a slow call returns, but where signals occurring 
during the blocking call cause a thread to start polling. 

Pierre
