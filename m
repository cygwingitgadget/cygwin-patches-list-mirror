Return-Path: <cygwin-patches-return-5649-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15213 invoked by alias); 19 Sep 2005 14:31:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15182 invoked by uid 22791); 19 Sep 2005 14:31:02 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 19 Sep 2005 14:31:02 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 828823B0001; Mon, 19 Sep 2005 14:31:01 +0000 (UTC)
Date: Mon, 19 Sep 2005 14:31:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PING: fix ARG_MAX
Message-ID: <20050919143101.GA16760@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <loom.20050906T172937-420@post.gmane.org> <loom.20050910T164247-175@post.gmane.org> <20050912152245.GB29379@calimero.vinschen.de> <43265113.3000207@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43265113.3000207@byu.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00104.txt.bz2

On Mon, Sep 12, 2005 at 10:09:55PM -0600, Eric Blake wrote:
>Also, the argument brought up on the findutils mailing list was that
>beyond a certain size, the cost of processing each argument starts to
>outweigh the benefits of forking fewer tasks, to the point that the
>difference between a 32k ARG_MAX vs.  a 1M ARG_MAX falls in the noise
>when the same amount of data is divided by xargs to as few runs as
>possible, so a 32k limit is not really penalizing cygwin apps.

If this is really true, then the findutils configury should be
attempting some kind of timing which finds that magic point where it
should be ignoring _SC_ARG_MAX.  It shouldn't be vaguely assuming that
it is in its best interests to ignore it because someone thinks that the
cost of processing each argument outweighs the benefits of forking fewer
tests.

Given that cost of forking is much more expensive on cygwin than on
other systems I really don't see how you can use this argument anyway
and, IMO, it doesn't make much sense on standard UNIX either.  If you
create more processes via fork you are invoking the OS and incurring
context switches.  You're still processing the same number of arguments
but you're just going to the OS to handle them more often.  I don't see
how that's ever a win.

I'm willing to be proven wrong by hard data but I think that you and the
findutils mailing list shouldn't be making assumptions without data to
back them up.

cgf
