Return-Path: <cygwin-patches-return-5561-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8903 invoked by alias); 6 Jul 2005 15:36:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8880 invoked by uid 22791); 6 Jul 2005 15:35:55 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 06 Jul 2005 15:35:55 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j66FZquA018674;
	Wed, 6 Jul 2005 11:35:53 -0400 (EDT)
Date: Wed, 06 Jul 2005 15:36:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Eric Blake <ebb9@byu.net>
cc: cygwin-patches@cygwin.com
Subject: Re: cygcheck exit status
In-Reply-To: <loom.20050706T160843-889@post.gmane.org>
Message-ID: <Pine.GSO.4.61.0507061133490.18488@slinky.cs.nyu.edu>
References: <loom.20050705T224501-8@post.gmane.org> <20050705205334.GA12357@trixie.casa.cgf.cx>
 <loom.20050705T225652-764@post.gmane.org> <Pine.GSO.4.61.0507061001050.17582@slinky.cs.nyu.edu>
 <loom.20050706T160843-889@post.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q3/txt/msg00016.txt.bz2

On Wed, 6 Jul 2005, Eric Blake wrote:

> Igor Pechtchanski <pechtcha <at> cs.nyu.edu> writes:
> > > Because it's in a for loop, and when the first file fails but second
> > > succeeds, you still want the overall command to exit with failure.
> >
> > That's the correct intent, but shouldn't it be &&= instead of &=,
> > technically?
>
> There's no such thing as &&=.  And even if there was, you wouldn't want
> to use it, because it would short-circuit running cygcheck().  The whole
> point of the boolean collector is to run the test on every file, but to
> remember if any of the tests failed.  Maybe thinking of a short-circuit
> in the reverse direction will help you understand:
> [snip]

Ok, ok, IOWTWIWT... :-)  I'm well aware of the short circuiting
behavior of &&.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
