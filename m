Return-Path: <cygwin-patches-return-4136-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27124 invoked by alias); 29 Aug 2003 01:19:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27115 invoked from network); 29 Aug 2003 01:19:26 -0000
Date: Fri, 29 Aug 2003 01:19:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Signal handling tune up.
Message-ID: <20030829011926.GA16898@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3F43B482.AC7F68F4@phumblet.no-ip.org> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com> <3.0.5.32.20030818222927.008114e0@incoming.verizon.net> <20030819024617.GA6581@redhat.com> <3.0.5.32.20030819084636.0081c730@incoming.verizon.net> <20030819143305.GA17431@redhat.com> <3F43B482.AC7F68F4@phumblet.no-ip.org> <3.0.5.32.20030828205339.0081f920@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030828205339.0081f920@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00152.txt.bz2

On Thu, Aug 28, 2003 at 08:53:39PM -0400, Pierre A. Humblet wrote:
>At 02:09 PM 8/20/2003 -0400, you wrote:
>>On Wed, Aug 20, 2003 at 01:48:50PM -0400, Pierre A. Humblet wrote:
>>>Christopher Faylor wrote:
>>>>>If you do something like:
>>>>>
>>>>>foo()
>>>>>{
>>>>>   sigframe thisframe;
>>>>>   sig_dispatch_pending ();
>>>>>}
>>>>>
>>>>>then the signal dispatch will happen when foo returns, not when
>>>>>sig_dispatch_pending returns.  The goal is that, in most cases, the
>>>>>function closest to the user should be the one that gets "interrupted".
>>>>
>>>>Well, that is what I thought the goal was, but looking at the sigframe
>>>>code again it doesn't work that way.  If it did work that way then the
>>>>current call to call_signal_handler_now in sigreturn wouldn't be
>>>>necessary, although the stack pressue would be even greater.
>>>>
>>>>So, I don't know why I put that explicit call in that function.  It's
>>>>probably superfluous, as you suspect.
>>>
>>>After sleeping over this I have a new hypothesis, kind of just the
>>>opposite of what we were thinking above.
>>>
>>>interrupt_on_return will walk the stack and find an "interruptible"
>>>address in the user code (outside of cygwin).  The handler starts when
>>>returning from that frame (closest to the user).
>>>
>>>sigframe::call_signal_handler () undoes that and forces an immediate
>>>run of the handler.  So it makes sense to use it in
>>>sig_dispatch_pending ().
>>
>>Except that since sig_dispatch_pending may not be the "owner" of the
>>frame info, it will not call anything in some (most) cases.  I saw this
>>in a debugging session last night.
>
>For the benefit of future maintainers I went back to this and figured
>it out. sigframe::call_signal_handler () will do its job iff there is
>no earlier sigframe (thus not from set_process_mask). That's why in 
>e.g. syscalls.cc and net.cc the following order is always respected:
>  1) sig_dispatch_pending ();
>  2) sigframe thisframe;
>
>I was planning to also eventually propose patches for the  following,
>but it's more efficient to tell Chris while he is working on the code
>and before I forget:
>1) sigcatch_nosync could be an event instead of a semaphore. This 
>   doesn't affect the logic and will cut down useless loops, mainly
>   at high load with pending_signals set.

Are you seeing a lot of loops through the signal handler due to
semaphores being > 1?

>2) When a signal is pending but blocked, pending_signals is set and
>   sig_dispatch_pending() signals the sigthread. It would be more 
>   efficient to have a pending_signal_mask and to do mask comparison
>   in sig_dispatch_pending(). It's just a courtesy call, no interlock
>   is necessary.

There are all sorts of optimizations like this which could be done.  Do
you think that an occasional loop through the signal handler is slowing
things down that much?  Do you think that sig_dispatch_pending gets
called a lot with all pending signals blocked?  Are you convinced that
you can set a mask in a non-raceable way?

cgf
