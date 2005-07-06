Return-Path: <cygwin-patches-return-5557-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26110 invoked by alias); 6 Jul 2005 14:01:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26091 invoked by uid 22791); 6 Jul 2005 14:01:45 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 06 Jul 2005 14:01:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j66E1guA017800;
	Wed, 6 Jul 2005 10:01:42 -0400 (EDT)
Date: Wed, 06 Jul 2005 14:01:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Eric Blake <ebb9@byu.net>
cc: cygwin-patches@cygwin.com
Subject: Re: cygcheck exit status
In-Reply-To: <loom.20050705T225652-764@post.gmane.org>
Message-ID: <Pine.GSO.4.61.0507061001050.17582@slinky.cs.nyu.edu>
References: <loom.20050705T224501-8@post.gmane.org> <20050705205334.GA12357@trixie.casa.cgf.cx>
 <loom.20050705T225652-764@post.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q3/txt/msg00012.txt.bz2

On Tue, 5 Jul 2005, Eric Blake wrote:

> Christopher Faylor <cgf-no-personal-reply-please <at> cygwin.com> writes:
>
> >
> > On Tue, Jul 05, 2005 at 08:49:06PM +0000, Eric Blake wrote:
> > > <at>  <at>  -1677,7 +1681,7  <at>  <at>  main (int argc, char **argv)
> > >       {
> > >        if (i)
> > >          puts ("");
> > >-       cygcheck (argv[i]);
> > >+       ok &= cygcheck (argv[i]);
> >
> > Why are you anding the result here?  Why not just set ok = cygcheck (...)?
>
> Because it's in a for loop, and when the first file fails but second
> succeeds, you still want the overall command to exit with failure.

That's the correct intent, but shouldn't it be &&= instead of &=,
technically?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
