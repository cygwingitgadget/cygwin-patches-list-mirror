Return-Path: <cygwin-patches-return-4133-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15133 invoked by alias); 20 Aug 2003 18:09:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15123 invoked from network); 20 Aug 2003 18:09:20 -0000
Date: Wed, 20 Aug 2003 18:09:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030820180919.GB26273@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F43B482.AC7F68F4@phumblet.no-ip.org>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00149.txt.bz2

On Wed, Aug 20, 2003 at 01:48:50PM -0400, Pierre A. Humblet wrote:
>Christopher Faylor wrote:
>>>If you do something like:
>>>
>>>foo()
>>>{
>>>   sigframe thisframe;
>>>   sig_dispatch_pending ();
>>>}
>>>
>>>then the signal dispatch will happen when foo returns, not when
>>>sig_dispatch_pending returns.  The goal is that, in most cases, the
>>>function closest to the user should be the one that gets "interrupted".
>>
>>Well, that is what I thought the goal was, but looking at the sigframe
>>code again it doesn't work that way.  If it did work that way then the
>>current call to call_signal_handler_now in sigreturn wouldn't be
>>necessary, although the stack pressue would be even greater.
>>
>>So, I don't know why I put that explicit call in that function.  It's
>>probably superfluous, as you suspect.
>
>After sleeping over this I have a new hypothesis, kind of just the
>opposite of what we were thinking above.
>
>interrupt_on_return will walk the stack and find an "interruptible"
>address in the user code (outside of cygwin).  The handler starts when
>returning from that frame (closest to the user).
>
>sigframe::call_signal_handler () undoes that and forces an immediate
>run of the handler.  So it makes sense to use it in
>sig_dispatch_pending ().

Except that since sig_dispatch_pending may not be the "owner" of the
frame info, it will not call anything in some (most) cases.  I saw this
in a debugging session last night.

>But now the plot thickens.
>The sigframe has a "* sigthread" member, and the sigthread as an 
>"exception" member, which is initialized to 0 at sigframe creation time
>but can be explicitly set by sigframe::set
>The only place (AFAICS) where it is used is in sig_send, which has an
>"exception" argument that defaults to 0 and that is only used when
>running in the mainthread.
>The only (AFAICS) place where the sig_send "exception" is set 
>is when handle_exceptions calls sig_send.
>
>The only place where I find "sigthread::exception" used is in 
>interrupt_on_return, which won't check for interruptibility if 
>"exception" is true.
>That's efficient because a) it guarantees success without walking the 
>stack and b) the handler is called faster.

Speed is not the issue.  Exceptions know precisely where the return
address is and need to specify it, since a stack walk wouldn't work
correctly.

The normal sigframe case doesn't know exactly where to set the return
address but it should be very short stack walk to get to the return
address given the info set by the sigframe call.

>I am wondering if the same mechanism couldn't/shouldn't be used in
>sig_dispatch_pending () as well, calling sig_send (myself, __SIGFLUSH,
>1) when in the mainthread.  If that works it would be more efficient
>and we wouldn't need a sigframe in sig_dispatch_pending (), nor a call
>to sigframe::call_signal_handler (), after all.

That would require rewriting the sigframe stuff somehow so that the
call_signal_handler actually worked reliably.  Since I'm not aware of
any problems with the current behavior, I don't think it's an issue
especially since the speed gain would be really negligible, I think.

>While looking at the code, I got worried by interrupt_setup().  As soon
>as sigsave.sig = sig; is executed, the sigsave can be picked up by a
>terminating handler.  Thus shouldn't sigsave.sig = sig; be the last
>statement in interrupt_setup() to avoid a race condition?

Yes, it's a race but I think it's harmless since, AFAICT, the only thing
affected is errno which wouldn't be handled in a recursive signal call.
I'll move the setting to the end of interrupt_setup, though.

cgf
