Return-Path: <cygwin-patches-return-4150-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14363 invoked by alias); 31 Aug 2003 18:39:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14353 invoked from network); 31 Aug 2003 18:39:49 -0000
Date: Sun, 31 Aug 2003 18:39:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030831183948.GA4314@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net> <20030829011926.GA16898@redhat.com> <20030829031256.GA18890@redhat.com> <3F4F60EA.4DBB8A51@phumblet.no-ip.org> <3.0.5.32.20030830152207.007bde60@incoming.verizon.net> <3.0.5.32.20030831112352.008161c0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030831112352.008161c0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00166.txt.bz2


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 2706

On Sun, Aug 31, 2003 at 11:23:52AM -0400, Pierre A. Humblet wrote:
>thanks for your quick response to the ftp crash.

It would have been much quicker if I'd clued into the fact that an
address like a0dc018 != a0dc01c.  It took my 127 attempts at running ftp
to finally see what was going on.

I can't believe that this hasn't caused problems for other programs.
It's a pretty serious problem.  Every time I think I've got this fixed
another corner case occurs to me which has to be dealt with.

Basically, you can't rely on the fact that the pointers inside of such
thigs as a hostent structure are valid since a user could trash them.
So you can't use them in calls to free().

>At 04:32 PM 8/30/2003 -0400, you wrote:
>>retaddr_on_stack is not always going to be identical to esp + 36 no
>>matter where it comes from.  I modified my test program to tickle the
>>previous problem.  I've included it below.  You can short circuit the
>>sig_dispatch_pending functioni and it will still report different
>>retaddr_on_stack values -- as it should.  kill is getting called from
>>different stack depths.
>>
>>I didn't notice this before since the SIGHUP signal is masked in
>>'ouch()' function so a call to ouch() wouldn't be made until the mask
>>was removed.  Changing the code to call another, unmasked signal, whose
>>handler is dispatched immediately, shows (in the debugger) that
>>retaddr_on_stack is different.
>
>Hmm, what I see here is that the handler (call it A1) for SIGUSR1 starts 
>first and the handler (B1) for SIGHUP starts while A1 is still running.
>B1 terminates and A1 resumes (A2 is blocked). The recursion avoidance 
>code is not invoked when B1 terminates. 

Ok, you're right.  It's sad that I need you to explain my own coding
rationales to me.

>writev (const int fd, const struct iovec *const iov, const int iovcnt)
>{
>  sig_dispatch_pending ();
>  sigframe thisframe (mainthread);
>
>The call to sig_dispatch_pending is meant for the case where
>there is a pending signal. Assume there indeed is one.
>The call to sig_dispatch_pending will setup an interrupt in sigsave. 
>The return address on the stack will be the first interruptible return 
>address above sig_dispatch_pending, i.e. the return address of writev.
>The handler will not be entered until writev returns.

Ok.  I see what you mean but the old code was not actually right either.
I wrote a test case (enclosed) which sent a signal to a process running
a modified version of cygwin1.dll after the call to sigframe
("guaranteed" with the judicious use of Sleep) in sig_dispatch_pending.
The 'ouch' wasn't triggered by the either the old or new cygwin code.
So, I've checked in new code in sig_dispatch_pending.

cgf

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="writeint.c"
Content-length: 401

#include <stdio.h>
#include <sys/signal.h>
#include <stdlib.h>

void
ouch (int sig)
{
  write (1, "ouch\n", strlen ("ouch\n"));
}

int
main (int argc, char **argv)
{
  int pid = getpid ();
  signal (SIGHUP, ouch);
  if (fork () == 0)
    {
      usleep (200000);
      kill (getppid (), SIGHUP);
      write (1, "sent sig\n", strlen ("sent sig\n"));
      exit (0);
    }
  write (1, "hello\n", 6);
}

--0F1p//8PRICkK4MW--
