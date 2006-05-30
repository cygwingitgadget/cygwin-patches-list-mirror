Return-Path: <cygwin-patches-return-5881-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25979 invoked by alias); 30 May 2006 02:39:19 -0000
Received: (qmail 25967 invoked by uid 22791); 30 May 2006 02:39:18 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 30 May 2006 02:39:17 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 6DFB613C020; Mon, 29 May 2006 22:36:39 -0400 (EDT)
Date: Tue, 30 May 2006 02:39:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix leaky pipe
Message-ID: <20060530023639.GB10576@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20060529220033.GA4454@trixie.casa.cgf.cx> <028601c68387$109c4c20$a501a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <028601c68387$109c4c20$a501a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00069.txt.bz2

On Tue, May 30, 2006 at 02:19:14AM +0100, Dave Korn wrote:
>On 29 May 2006 23:01, Christopher Faylor wrote:
>>On Mon, May 29, 2006 at 09:48:50AM +0100, Dave Korn wrote:
>>>As discussed elsewhere, here's a patch that solves the race problem
>>>without leaking handles any more by placing the master-pipe-closing
>>>logic where it really belongs, in fhandler_tty_common::close where the
>>>send-an-EOF decision is made.  I figured 4 extra bytes in the vtable
>>>isn't too bad, it's not like you expect to have millions of terminals
>>>open at once.
>>
>>I don't know.  The more I think about this problem, the more I think
>>that the logic which you've exposed which deals with "inuse" in
>>fhandler_pty_master::close is wrong.
>>
>>It's been a while since I looked at this code (and I've always hated it
>>-- even after I sort of rewrote it) but for a pty, I don't see why it
>>should matter if there are still other things using the open master
>>handles.  I think that each parent pty should have its own copy of the
>>from_master/to_master handles which are unconditionally closed.  I'm
>>probably missing something, but I think the inuse handle for the master
>>part of the pty is probably not needed.
>
>Well, all this is entirely possible; I'm not even sufficiently familiar
>with how ptys are specified to work by the standard.  From what I
>understand of it, though, ISTM that having one set of master handles
>and using the reference count on an event (as manifested through the
>inuse handle to the master-alive event) to track users of them is
>basically equivalent to the way you suggest doing it there, with the
>cumulative reference count on the pipes imposed by the open handles
>representing the use count, and the inuse event omitted.  However all
>this is massively complicated by permutation vs.  close-on-exec and
>fork-and-dup, I don't want to make reckless predictions.

But, all of it is already done that way for the slave.

>>I probably will propose another way to handle this that will reorganize
>>the tty structure and the fhandler_[pt]tty classes.  OTOH, I haven't
>>given this as much thought as you have, so maybe I'll come around to
>>agreeing that your patch is the best way to go.
>>
>>Right now, however, this code is sending off little alarms that tell me
>>that something is wrong.  I tend to trust these alarms because they are
>>right 50% of the time.
>>
>>I know.  It's an amazing ability.
>>
>>Anyway, thanks again for the patch.  I hope to discuss this more
>>intelligently in the next couple of days.
>
>Well, I can't hear the alarm bells, but then I'm less familiar with the
>code.  This patch is less invasive and fixes the current problem; it's
>really just a revision of Pavel's patch which we all see clearly
>identified a real race condition.  If you want a low-risk option for
>the next release while you think about a serious refactoring, I reckon
>this would be a good band-aid.

The problem is that I think that the current implementation is really
flawed.  Why should it be making decisions about closing handles based
on whether something else currently is using the master?  If some other
process has the master open, that doesn't mean that the master handles
should be left open in this process.

Also, the code is just unilaterally closing the handles even though
it may not actually *own* them, which could end up closing the wrong
handle.  In practice this probably doesn't cause many problems but
it is really wrong.

cgf
