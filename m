Return-Path: <cygwin-patches-return-5879-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28413 invoked by alias); 29 May 2006 22:00:36 -0000
Received: (qmail 28402 invoked by uid 22791); 29 May 2006 22:00:36 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-19.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.19)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 29 May 2006 22:00:34 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 22CFE13C020; Mon, 29 May 2006 18:00:33 -0400 (EDT)
Date: Mon, 29 May 2006 22:00:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix leaky pipe
Message-ID: <20060529220033.GA4454@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <022401c682fc$b51c2d50$a501a8c0@CAM.ARTIMI.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <022401c682fc$b51c2d50$a501a8c0@CAM.ARTIMI.COM>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00067.txt.bz2

On Mon, May 29, 2006 at 09:48:50AM +0100, Dave Korn wrote:
>As discussed elsewhere, here's a patch that solves the race problem
>without leaking handles any more by placing the master-pipe-closing
>logic where it really belongs, in fhandler_tty_common::close where the
>send-an-EOF decision is made.  I figured 4 extra bytes in the vtable
>isn't too bad, it's not like you expect to have millions of terminals
>open at once.

I don't know.  The more I think about this problem, the more I think
that the logic which you've exposed which deals with "inuse" in
fhandler_pty_master::close is wrong.

It's been a while since I looked at this code (and I've always hated it
-- even after I sort of rewrote it) but for a pty, I don't see why it
should matter if there are still other things using the open master
handles.  I think that each parent pty should have its own copy of the
from_master/to_master handles which are unconditionally closed. I'm
probably missing something, but I think the inuse handle for the master
part of the pty is probably not needed.

So, thanks very much for the patch, Dave, but I think I have to cogitate
on this some more.

I probably will propose another way to handle this that will reorganize
the tty structure and the fhandler_[pt]tty classes.  OTOH, I haven't
given this as much thought as you have, so maybe I'll come around to
agreeing that your patch is the best way to go.

Right now, however, this code is sending off little alarms that tell me
that something is wrong.  I tend to trust these alarms because they are
right 50% of the time.

I know.  It's an amazing ability.

Anyway, thanks again for the patch.  I hope to discuss this more
intelligently in the next couple of days.

cgf
