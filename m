Return-Path: <cygwin-patches-return-4146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4843 invoked by alias); 30 Aug 2003 19:23:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4834 invoked from network); 30 Aug 2003 19:23:30 -0000
Message-Id: <3.0.5.32.20030830152207.007bde60@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 30 Aug 2003 19:23:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Signal handling tune up.
In-Reply-To: <20030829155520.GA12716@redhat.com>
References: <3F4F60EA.4DBB8A51@phumblet.no-ip.org>
 <3.0.5.32.20030818201736.0080e4e0@mail.attbi.com>
 <3.0.5.32.20030818222927.008114e0@incoming.verizon.net>
 <20030819024617.GA6581@redhat.com>
 <3.0.5.32.20030819084636.0081c730@incoming.verizon.net>
 <20030819143305.GA17431@redhat.com>
 <3F43B482.AC7F68F4@phumblet.no-ip.org>
 <3.0.5.32.20030828205339.0081f920@incoming.verizon.net>
 <20030829011926.GA16898@redhat.com>
 <20030829031256.GA18890@redhat.com>
 <3F4F60EA.4DBB8A51@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2003-q3/txt/msg00162.txt.bz2

At 11:55 AM 8/29/2003 -0400, you wrote:
>On Fri, Aug 29, 2003 at 10:19:22AM -0400, Pierre A. Humblet wrote:
>>Christopher Faylor wrote:
>>>I was heartened to see that zsh did not crash when I sicc'ed this
>>>program on it -- until I tried to type something at the zsh prompt and
>>>saw that it was hung.  The reason was that the recursive signal call
>>>stuff was still not right.  We were restoring the return address
>>>incorrectly.  AFAICT, we really do have to use the stored
>>>retaddr_on_stack to rectify setup_handler's inappropriate "fixup" of
>>>the return address.  Restoring it to 36(%%esp) wasn't right.
>>
>>Wow.  What was wrong?  After you noticed that one could remove
>>movl    %%esp,%%ebp
>>addl    $36,%%ebp
>>before the call to set_process_mask, I though eveything made perfect
>>sense.  After returning from the (user) signal handler and pulling off
>>the argument, both the esp and ebp should be exactly as before the
>>call.  It that's not true, the whole stack model of programming breaks
>>down.
>
>The code that was there put the return address of the nested call onto the
>stack for the return of the initial signal handler.  I just changed it
>to mimic what call_signal_handler_now does.

FWIW, I have identified the error in my reasoning.
I was assuming the return address from the initial handler to be 
"interruptible" (makes sense, otherwise the handler shouldn't have started
there...).
 
When it is, retaddr_on_stack is identical to esp + 36 and the code was OK.

However there is one case where it is not: when the handler is called
by sigframe::call_signal_handler from sig_dispatch_pending.

Pierre
