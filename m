Return-Path: <cygwin-patches-return-4129-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 317 invoked by alias); 20 Aug 2003 02:36:18 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 308 invoked from network); 20 Aug 2003 02:36:17 -0000
Message-Id: <3.0.5.32.20030819223422.00815bc0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 20 Aug 2003 02:36:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030820011646.GA26276@redhat.com>
References: <3.0.5.32.20030819210645.00815bc0@incoming.verizon.net>
 <3F4288CE.C5133419@ieee.org>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819143305.GA17431@redhat.com>
 <3F4288CE.C5133419@ieee.org>
 <3.0.5.32.20030819210645.00815bc0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00145.txt.bz2

I got blocked from the list for the second time today,
so I changed my address. Mail sent to the old one will
still get to me.

At 09:16 PM 8/19/2003 -0400, Christopher Faylor wrote:
>>
>>Yep. But the 'confusion by "simultaneous" signals' was due to
>>thisproc which was set to "rc == 2"
>
>No.  The confusion could result from two signals coming in at the nearly
>the same time, one from an external source and one from internal.  In
>that case wait_sig had no way of telling which signal was which and
>could end up either not setting a completion event or setting it
>erroneously.

OK, I trust you although I don't see it.
 
>I think we're talking about different things.  The only thing I did was
>move the existing code out of setup_handler and into wait_sig.  There
>should be very little functional difference in doing this.

Right. You did 50% of that particular change and I got worried. I will
try to relax.

>>>Not necessarily.  It depends on who is calling sig_dispatch_pending.  An
>>>outer sigframe user wins.  This guarantees that signals will be
>>>dispatched in sig_dispatch_pending.
>>
>>Thanks, but it's still greek to me. What is an "outer sigframe user".
>
>Someone who calls sigframe earlier in the call stack.

Still desperately trying to understand (I should stick to bicycles, 
I guess).
sig_dispatch_pending builds a sigframe. It will be found by 
setup_handler, which will call interrupt_on_return,
which will spoof the return address and call interrupt_setup to
build sigsave.
If nothing special is done, the handler will start when  
sig_dispatch_pending returns.
By calling sigframe::call_signal_handler () the handler gets
called just before the return. What's the gain?

Pierre 
