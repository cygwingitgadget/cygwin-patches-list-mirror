Return-Path: <cygwin-patches-return-4600-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 17111 invoked by alias); 12 Mar 2004 02:37:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 17102 invoked from network); 12 Mar 2004 02:37:10 -0000
Date: Fri, 12 Mar 2004 02:37:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Signal mask handling
Message-ID: <20040312023709.GA7161@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net> <3.0.5.32.20040310232619.007fac50@incoming.verizon.net> <3.0.5.32.20040310232619.007fac50@incoming.verizon.net> <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net> <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00090.txt.bz2

On Thu, Mar 11, 2004 at 09:04:05PM -0500, Pierre A. Humblet wrote:
>At 08:43 PM 3/11/2004 -0500, you wrote:
>>On Thu, Mar 11, 2004 at 07:36:41PM -0500, Pierre A. Humblet wrote:
>>>There was a problem: pause() calls handle_sigsuspend(), which overwrites
>>>the oldmask set by _cygtls::interrupt_setup. It's all fixed, and I have
>>>renamed newmask to deltamask in cygtls.h. I can send you a fresh patch 
>>>(everything, against cvs) now, or wait until you apply yours.
>>
>>Go ahead and send the patch.
>>
>>Btw, I removed the setting of oldmask in _cygtls::fixup_after_fork after
>>I searched for oldmask last night after seeing your patch.
>
>OK, I had set oldmask again just for the fixup. I have just deleted
>that line without retesting.
>
>>>BTW I noticed that Posix and Cygwin diverge on sigpause.
>>>
>>>Posix:
>>>int sigpause(int sig);
>>>The sigpause() function removes sig from the calling process' signal
>>>mask and suspends the calling process until a signal is received.  The
>>>sigpause() function restores the process' signal mask to its original
>>>state before returning.
>>>
>>>Cygwin
>>>sigpause (int signal_mask)
>>>{
>>>  return handle_sigsuspend ((sigset_t) signal_mask);
>>>}
>>
>>Sorry, but I don't see any divergence.  A reading of the above might
>>seem to indicate that sigpause should return on the receipt of any
>>signal but I notice that on linux (and one other UNIX that I tested this
>>on) sigpause only returns on the receipt of a signal that has a handler
>>associated with it.  This makes sigpause equivalent to sigsuspend,
>>AFAICT.
>
>What I find strange is that usually sig is an integer (1-32), not a mask.
>Compare the two following lines are from the same Posix page
>void (*sigset(int sig, void (*disp)(int)))(int);   <= clearly an integer
>int sigpause(int sig);  <= a mask???

It's a mask, yes.  I guess the only difference is that sigset_t is an
unsigned long on cygwin rather than an int.

cgf
