Return-Path: <cygwin-patches-return-3080-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30226 invoked by alias); 22 Oct 2002 18:06:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30204 invoked from network); 22 Oct 2002 18:06:20 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Tue, 22 Oct 2002 11:06:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Steve O <bub@io.com>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_tty deadlock patch + console
In-Reply-To: <20021022003249.A32108@eris.io.com>
Message-ID: <Pine.GSO.4.44.0210221404560.8025-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0210221404562.8025@slinky.cs.nyu.edu>
Content-Disposition: INLINE
X-SW-Source: 2002-q4/txt/msg00031.txt.bz2

On Tue, 22 Oct 2002, Steve O wrote:

> On Mon, Oct 21, 2002 at 12:20:38PM -0400, Christopher Faylor wrote:
> > Keep resubmitting on large patch until it is accepted.
> >
> > My time is limited right now so I may not be able to completely review
> > this for a couple of weeks.  I'm going to be on a business trip starting
> > on Wednesday.
> >
> > So, I would appreciate it if people would try this out and report their
> > experiences.
> >
> > cgf
>
> Here's the original patch plus the recent fix.
> -steve
> [snip]

One more thing I noticed when using this patch is that pasting now seems
really slow, as if it's sending one character at a time...  Did you turn
off the buffering somewhere by any chance?
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Water molecules expand as they grow warmer" (C) Popular Science, Oct'02, p.51
