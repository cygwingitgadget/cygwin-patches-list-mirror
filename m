Return-Path: <cygwin-patches-return-4602-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1916 invoked by alias); 12 Mar 2004 03:12:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1907 invoked from network); 12 Mar 2004 03:12:55 -0000
Message-Id: <3.0.5.32.20040311221130.007f5770@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 12 Mar 2004 03:12:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Signal mask handling
In-Reply-To: <20040312023709.GA7161@redhat.com>
References: <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
 <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net>
 <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
 <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
 <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net>
 <3.0.5.32.20040311210405.007f81e0@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q1/txt/msg00092.txt.bz2

At 09:37 PM 3/11/2004 -0500, you wrote:
>On Thu, Mar 11, 2004 at 09:04:05PM -0500, Pierre A. Humblet wrote:

>>>>BTW I noticed that Posix and Cygwin diverge on sigpause.
>>>>
>>>>Posix:
>>>>int sigpause(int sig);
>>>>The sigpause() function removes sig from the calling process' signal
>>>>mask and suspends the calling process until a signal is received.  The
>>>>sigpause() function restores the process' signal mask to its original
>>>>state before returning.
>>>>
>>>>Cygwin
>>>>sigpause (int signal_mask)
>>>>{
>>>>  return handle_sigsuspend ((sigset_t) signal_mask);
>>>>}
>>>
>>>Sorry, but I don't see any divergence.  A reading of the above might
>>>seem to indicate that sigpause should return on the receipt of any
>>>signal but I notice that on linux (and one other UNIX that I tested this
>>>on) sigpause only returns on the receipt of a signal that has a handler
>>>associated with it.  This makes sigpause equivalent to sigsuspend,
>>>AFAICT.
>>
>>What I find strange is that usually sig is an integer (1-32), not a mask.
>>Compare the two following lines are from the same Posix page
>>void (*sigset(int sig, void (*disp)(int)))(int);   <= clearly an integer
>>int sigpause(int sig);  <= a mask???
>
>It's a mask, yes.  I guess the only difference is that sigset_t is an
>unsigned long on cygwin rather than an int.

After some googling, it looks like BSD and System V differ
http://world.std.com/~jimf/papers/signals/signals.html
"Note that sigpause() conflicts with the BSD function of the same name"

Posix knows the difference between an "int" and a "sigset_t". For some
reason it's not following BSD.
I point to this as a curiosity, I don't care about the outcome.

Pierre
