Return-Path: <cygwin-patches-return-5765-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6467 invoked by alias); 17 Feb 2006 14:06:35 -0000
Received: (qmail 6457 invoked by uid 22791); 17 Feb 2006 14:06:34 -0000
X-Spam-Check-By: sourceware.org
Received: from ACCESS1.CIMS.NYU.EDU (HELO access1.cims.nyu.edu) (128.122.81.155)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 17 Feb 2006 14:06:31 +0000
Received: from localhost (localhost [127.0.0.1]) 	by access1.cims.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id k1HE6TA7022432 	for <cygwin-patches@cygwin.com>; Fri, 17 Feb 2006 09:06:29 -0500 (EST)
Date: Fri, 17 Feb 2006 14:06:00 -0000
From: Igor Peshansky <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: follow symbolic links
In-Reply-To: <20060217113100.GT26541@calimero.vinschen.de>
Message-ID: <Pine.GSO.4.63.0602170900350.1592@access1.cims.nyu.edu>
References: <Pine.GSO.4.63.0602131341020.17217@access1.cims.nyu.edu>  <20060216160637.GQ26541@calimero.vinschen.de> <Pine.GSO.4.63.0602161116540.22053@access1.cims.nyu.edu>  <20060217113100.GT26541@calimero.vinschen.de>
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
X-SW-Source: 2006-q1/txt/msg00074.txt.bz2

On Fri, 17 Feb 2006, Corinna Vinschen wrote:

> On Feb 16 12:26, Igor Peshansky wrote:
> > On Thu, 16 Feb 2006, Corinna Vinschen wrote:
> > > - Most of your patch should go into path.cc so it can be reused, for
> > >   instance in strace.
> >
> > Agreed -- that's why I put that TODO in there. :-)  Should I move it in
> > the next iteration of the patch?
>
> Please move it now.  I don't think it's non-trivial enough to justify
> multiple iterations.

Whoops.  Misspoke.  I meant "incarnation".  Never mind, I'll just do it.
:-)  Expect a new patch today.

> > > - Couldn't you just reuse the readlink implementation in
> > >   ../cygwin/path.cc as is, to avoid having to different
> > >   implementations?
> >
> > Umm, most of that code is very general purpose, and has too much extra
> > stuff in it.  I basically used part of it (symlink_info::check_shortcut)
> > for my implementation.  I wanted something lightweight and easy to
> > understand (also, the code in path.cc doesn't check for PE headers, so I
> > had to write that part anyway).
>
> Well, what I meant isn't readlink but symlink_info::check_shortcut and
> cmp_shortcut_header.  It would be helpful if the rules to identify a
> symlink are identical, wouldn't it?  As for the PE headers, that's fine.

It would certainly help, but then we would need to extract the bit of code
that deals with symlinks and put it in a Cygwin-independent static
library.  See my reply to Dave.
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
