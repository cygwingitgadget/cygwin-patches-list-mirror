Return-Path: <cygwin-patches-return-5774-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30339 invoked by alias); 23 Feb 2006 14:18:58 -0000
Received: (qmail 30329 invoked by uid 22791); 23 Feb 2006 14:18:57 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 23 Feb 2006 14:18:54 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1NEIqfo024202 	for <cygwin-patches@cygwin.com>; Thu, 23 Feb 2006 09:18:52 -0500 (EST)
Date: Thu, 23 Feb 2006 14:18:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
In-Reply-To: <20060223112956.GF4294@calimero.vinschen.de>
Message-ID: <Pine.GSO.4.63.0602230913440.13565@access1.cims.nyu.edu>
References: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu>  <20060216160637.GQ26541@calimero.vinschen.de> <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu>  <20060217113100.GT26541@calimero.vinschen.de> <Pine.GSO.4.63.0602170900350.1592@access1.cims.nyu.edu>  <Pine.GSO.4.63.0602221335110.4972@access1.cims.nyu.edu>  <20060223112956.GF4294@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00083.txt.bz2

On Thu, 23 Feb 2006, Corinna Vinschen wrote:

> On Feb 22 13:55, Igor Peshansky wrote:
> > On Fri, 17 Feb 2006, Igor Peshansky wrote:
> > > On Fri, 17 Feb 2006, Corinna Vinschen wrote:
> > > > On Feb 16 12:26, Igor Peshansky wrote:
> > > > > On Thu, 16 Feb 2006, Corinna Vinschen wrote:
> > > > > > - Most of your patch should go into path.cc so it can be reused,
> > > > > >   for instance in strace.
> > > > >
> > > > > Agreed -- that's why I put that TODO in there. :-)  Should I move it
> > > > > in the next iteration of the patch?
> > > >
> > > > Please move it now.  I don't think it's non-trivial enough to justify
> > > > multiple iterations.
> > >
> > > Whoops.  Misspoke.  I meant "incarnation".  Never mind, I'll just do it.
> > > :-)  Expect a new patch today.
> >
> > I guess "today" is a stretchable concept. :-)  In any case, here's a
> > new patch.  Moving things into path.cc turned out to be indeed
> > non-trivial, since the new functionality was using static functions in
> > cygcheck.cc which now needed to be moved out into a separate file.  I
> > don't expect this to be applied right away (hence no ChangeLog), but
> > is this along the lines of what you were expecting?
>
> Yes, this looks generally ok to me.  I didn't *test* your patch, but
> from the look of it, it seems fine, with one exception:
>
> I don't see a reason to introduce a new fileutil.cc file.  Please move
> the functions into path.cc, add the extern declarations to path.h (so
> you can drop them from cygcheck.cc), and revert the Makefile changes.
> Then, together with a neat ChangeLog entry, we're pratically done :-)

The problem is that most of the functions don't belong in path.cc (e.g.,
display_error).  To do this properly, they will have to be rewritten in a
more general manner, to return the appropriate error code so that the
failure condition can be identified, and display_error should move back to
cygcheck.cc (in particular, display_error prints "cygcheck" as part of the
error).  That's why I chose to add all the functions to cygcheck first --
they are just not yet ready for consumption by other programs.

Sigh.  I'd really like this to get in by 1.5.20, but time is limited, so
that may not happen.  I'll see what I can do to separate the general and
the specific, and split this functionality between cygcheck.cc and
path.cc.

> Thanks for doing this, btw.  I really appreciate it.

Hey, I promised to look into it... :-)
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_	    pechtcha@cs.nyu.edu | igor@watson.ibm.com
ZZZzz /,`.-'`'    -.  ;-;;,_		Igor Peshansky, Ph.D. (name changed!)
     |,4-  ) )-,_. ,\ (  `'-'		old name: Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Las! je suis sot... -Mais non, tu ne l'es pas, puisque tu t'en rends compte."
"But no -- you are no fool; you call yourself a fool, there's proof enough in
that!" -- Rostand, "Cyrano de Bergerac"
