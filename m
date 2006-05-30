Return-Path: <cygwin-patches-return-5880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30892 invoked by alias); 30 May 2006 01:23:41 -0000
Received: (qmail 30701 invoked by uid 22791); 30 May 2006 01:23:40 -0000
X-Spam-Check-By: sourceware.org
Received: from mail.artimi.com (HELO mail.artimi.com) (217.40.213.68)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 30 May 2006 01:23:38 +0000
Received: from mail.artimi.com ([192.168.1.3]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 30 May 2006 02:19:15 +0100
Received: from rainbow ([192.168.1.165]) by mail.artimi.com with Microsoft SMTPSVC(6.0.3790.1830); 	 Tue, 30 May 2006 02:19:14 +0100
From: "Dave Korn" <dave.korn@artimi.com>
To: <cygwin-patches@cygwin.com>
Subject: RE: Fix leaky pipe
Date: Tue, 30 May 2006 01:23:00 -0000
Message-ID: <028601c68387$109c4c20$a501a8c0@CAM.ARTIMI.COM>
MIME-Version: 1.0
Content-Type: text/plain; 	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20060529220033.GA4454@trixie.casa.cgf.cx>
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00068.txt.bz2

On 29 May 2006 23:01, Christopher Faylor wrote:

> On Mon, May 29, 2006 at 09:48:50AM +0100, Dave Korn wrote:
>> As discussed elsewhere, here's a patch that solves the race problem
>> without leaking handles any more by placing the master-pipe-closing
>> logic where it really belongs, in fhandler_tty_common::close where the
>> send-an-EOF decision is made.  I figured 4 extra bytes in the vtable
>> isn't too bad, it's not like you expect to have millions of terminals
>> open at once.
> 
> I don't know.  The more I think about this problem, the more I think
> that the logic which you've exposed which deals with "inuse" in
> fhandler_pty_master::close is wrong.
> 
> It's been a while since I looked at this code (and I've always hated it
> -- even after I sort of rewrote it) but for a pty, I don't see why it
> should matter if there are still other things using the open master
> handles.  I think that each parent pty should have its own copy of the
> from_master/to_master handles which are unconditionally closed. I'm
> probably missing something, but I think the inuse handle for the master
> part of the pty is probably not needed.

  Well, all this is entirely possible; I'm not even sufficiently familiar with
how ptys are specified to work by the standard.  From what I understand of it,
though, ISTM that having one set of master handles and using the reference
count on an event (as manifested through the inuse handle to the master-alive
event) to track users of them is basically equivalent to the way you suggest
doing it there, with the cumulative reference count on the pipes imposed by
the open handles representing the use count, and the inuse event omitted.
However all this is massively complicated by permutation vs. close-on-exec and
fork-and-dup, I don't want to make reckless predictions.

> I probably will propose another way to handle this that will reorganize
> the tty structure and the fhandler_[pt]tty classes.  OTOH, I haven't
> given this as much thought as you have, so maybe I'll come around to
> agreeing that your patch is the best way to go.
> 
> Right now, however, this code is sending off little alarms that tell me
> that something is wrong.  I tend to trust these alarms because they are
> right 50% of the time.
> 
> I know.  It's an amazing ability.
>
> Anyway, thanks again for the patch.  I hope to discuss this more
> intelligently in the next couple of days.

  Well, I can't hear the alarm bells, but then I'm less familiar with the
code.  This patch is less invasive and fixes the current problem; it's really
just a revision of Pavel's patch which we all see clearly identified a real
race condition.  If you want a low-risk option for the next release while you
think about a serious refactoring, I reckon this would be a good band-aid.


    cheers,
      DaveK
-- 
Can't think of a witty .sigline today....
