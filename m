Return-Path: <cygwin-patches-return-5773-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15109 invoked by alias); 23 Feb 2006 11:30:00 -0000
Received: (qmail 15099 invoked by uid 22791); 23 Feb 2006 11:30:00 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Thu, 23 Feb 2006 11:29:59 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 88D86544001; Thu, 23 Feb 2006 12:29:56 +0100 (CET)
Date: Thu, 23 Feb 2006 11:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
Message-ID: <20060223112956.GF4294@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu> <20060216160637.GQ26541@calimero.vinschen.de> <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu> <20060217113100.GT26541@calimero.vinschen.de> <Pine.GSO.4.63.0602170900350.1592@access1.cims.nyu.edu> <Pine.GSO.4.63.0602221335110.4972@access1.cims.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.0602221335110.4972@access1.cims.nyu.edu>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q1/txt/msg00082.txt.bz2

On Feb 22 13:55, Igor Peshansky wrote:
> On Fri, 17 Feb 2006, Igor Peshansky wrote:
> > On Fri, 17 Feb 2006, Corinna Vinschen wrote:
> > > On Feb 16 12:26, Igor Peshansky wrote:
> > > > On Thu, 16 Feb 2006, Corinna Vinschen wrote:
> > > > > - Most of your patch should go into path.cc so it can be reused,
> > > > >   for instance in strace.
> > > >
> > > > Agreed -- that's why I put that TODO in there. :-)  Should I move it
> > > > in the next iteration of the patch?
> > >
> > > Please move it now.  I don't think it's non-trivial enough to justify
> > > multiple iterations.
> >
> > Whoops.  Misspoke.  I meant "incarnation".  Never mind, I'll just do it.
> > :-)  Expect a new patch today.
> 
> I guess "today" is a stretchable concept. :-)  In any case, here's a new
> patch.  Moving things into path.cc turned out to be indeed non-trivial,
> since the new functionality was using static functions in cygcheck.cc
> which now needed to be moved out into a separate file.  I don't expect
> this to be applied right away (hence no ChangeLog), but is this along the
> lines of what you were expecting?

Yes, this looks generally ok to me.  I didn't *test* your patch, but
from the look of it, it seems fine, with one exception:

I don't see a reason to introduce a new fileutil.cc file.  Please move
the functions into path.cc, add the extern declarations to path.h (so
you can drop them from cygcheck.cc), and revert the Makefile changes.
Then, together with a neat ChangeLog entry, we're pratically done :-)

Thanks for doing this, btw.  I really appreciate it.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
