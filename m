Return-Path: <cygwin-patches-return-4130-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30153 invoked by alias); 20 Aug 2003 03:31:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30144 invoked from network); 20 Aug 2003 03:31:33 -0000
Date: Wed, 20 Aug 2003 03:31:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030820033132.GA26048@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F4288CE.C5133419@ieee.org> <3.0.5.32.20030819210645.00815bc0@incoming.verizon.net> <3.0.5.32.20030819223422.00815bc0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030819223422.00815bc0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00146.txt.bz2

On Tue, Aug 19, 2003 at 10:34:22PM -0400, Pierre A. Humblet wrote:
>I got blocked from the list for the second time today,
>so I changed my address. Mail sent to the old one will
>still get to me.

What a pain.  It's been a horrible day.  I've been trying to do my
real job while attempting to deal with the massive flood of email resulting
from that (&*! virus.  I don't know if the virus is causing your problems
or not but I suspect it is.  I have to change the subscription mechanism
on sources.redhat.com so that it ignores virus-like email.

>At 09:16 PM 8/19/2003 -0400, Christopher Faylor wrote:
>>I think we're talking about different things.  The only thing I did was
>>move the existing code out of setup_handler and into wait_sig.  There
>>should be very little functional difference in doing this.
>
>Right. You did 50% of that particular change and I got worried. I will
>try to relax.

I did a little more just now but it is still not right.  I was going to
check in your recursive elimination patch to sigdelayed but noticed that
my simple test case to check how recursion worked doesn't work.  Sigh.
I should just go to bed.

>>>>Not necessarily.  It depends on who is calling sig_dispatch_pending.  An
>>>>outer sigframe user wins.  This guarantees that signals will be
>>>>dispatched in sig_dispatch_pending.
>>>
>>>Thanks, but it's still greek to me. What is an "outer sigframe user".
>>
>>Someone who calls sigframe earlier in the call stack.
>
>Still desperately trying to understand (I should stick to bicycles, 
>I guess).
>sig_dispatch_pending builds a sigframe. It will be found by 
>setup_handler, which will call interrupt_on_return,
>which will spoof the return address and call interrupt_setup to
>build sigsave.
>If nothing special is done, the handler will start when  
>sig_dispatch_pending returns.
>By calling sigframe::call_signal_handler () the handler gets
>called just before the return. What's the gain?

sig_dispatch_pending is supposed to guarantee that signals have been
flushed.

If you do something like:

foo()
{
   sigframe thisframe;
   sig_dispatch_pending ();
}

then the signal dispatch will happen when foo returns, not when
sig_dispatch_pending returns.  The goal is that, in most cases, the
function closest to the user should be the one that gets "interrupted".

cgf
