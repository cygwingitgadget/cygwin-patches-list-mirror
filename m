Return-Path: <cygwin-patches-return-4124-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6018 invoked by alias); 20 Aug 2003 01:08:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6009 invoked from network); 20 Aug 2003 01:08:12 -0000
Message-Id: <3.0.5.32.20030819210645.00815bc0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net
Date: Wed, 20 Aug 2003 01:08:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <Pierre.Humblet@ieee.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030820003737.GA25880@redhat.com>
References: <3F4288CE.C5133419@ieee.org>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819143305.GA17431@redhat.com>
 <3F4288CE.C5133419@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00140.txt.bz2

At 08:37 PM 8/19/2003 -0400, Christopher Faylor wrote:
>On Tue, Aug 19, 2003 at 04:30:06PM -0400, Pierre A. Humblet wrote:
>>Regarding your changes (it will take me a while to fully understand them)
>>- What problem are you trying to solve by having a local sigtodo?
>>  Specifically now that you have removed the thisproc argument in
sig_handle,
>>  rc is not used in any function call and I don't see why it's helpful
>>  to segregate signals on a per source basis. 
>
>>On Tue, Aug 19, 2003 at 12:22:17AM -0400, Christopher Faylor wrote:
>>>Oh, right.  I was remembering a time when the inner while used to
>>>exhaust the InterlockedDecrement.  It doesn't do that anymore but that
>>>hardly matters because, as you say, it is possible to the current code
>>>to be confused by "simultaneous" signals coming from the outside and
>>>from the current process.
>>>
>>>The only way I can think of around that is to add another an internal
>>>sigtodo array to every process just for signals sent to myself and scan
>>>that and the sigtodo process table.  I guess I'll implement that in the
>>>next couple of days.

Yep. But the 'confusion by "simultaneous" signals' was due to
thisproc which was set to "rc == 2"
Now that you have gotten rid of that I don't see any confusion
left and I don't see the reason for the local sigtodo.

>>- Having low_priority_sleep (SLEEP_0_STAY_LOW) in the sigthread loop 
>>  leaves it running (and WFMOing) at low priority. 
>
>How is moving it into the sigthread loop any different than having it
>where it was previously?  The point was for the sigthread loop to
>take a nap for a while and give the main thread a chance to wake up.

For two reasons:
- Taking a nap is not useful if the mainthread is waiting for
a semaphore from the sigthread. The nap should occur after the
semaphore has been signaled.
- When the sleep is at the top of the loop it is before the statement
that sets the sigthread priority to a high value. And the WFMO occurs
while the thread has high priority, which is important.

>>Also, as you wrote the signal code is not as simple as a bicycle! A
>>question I have is why it's helpful to call
>>thisframe.call_signal_handler in sig_dispatch_pending.  I was under the
>>impression that something like it would happen automagically on return.
>
>Not necessarily.  It depends on who is calling sig_dispatch_pending.  An
>outer sigframe user wins.  This guarantees that signals will be
>dispatched in sig_dispatch_pending.

Thanks, but it's still greek to me. What is an "outer sigframe user".
 
Pierre
