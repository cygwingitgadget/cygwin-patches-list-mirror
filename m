Return-Path: <cygwin-patches-return-4248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13258 invoked by alias); 26 Sep 2003 13:25:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13249 invoked from network); 26 Sep 2003 13:25:55 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 26 Sep 2003 13:25:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [Patch] Recent security improvements breaks proftpd
In-Reply-To: <20030926131258.GM22787@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0309260925040.3193@slinky.cs.nyu.edu>
References: <3.0.5.32.20030925204653.008234f0@incoming.verizon.net>
 <20030926125328.GB29894@cygbert.vinschen.de> <Pine.GSO.4.56.0309260906240.3193@slinky.cs.nyu.edu>
 <20030926131258.GM22787@cygbert.vinschen.de>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00264.txt.bz2

On Fri, 26 Sep 2003, Corinna Vinschen wrote:

> On Fri, Sep 26, 2003 at 09:08:08AM -0400, Igor Pechtchanski wrote:
> > On Fri, 26 Sep 2003, Corinna Vinschen wrote:
> >
> > > [snip]
> > > > +  char buf [1024];
> > >
> > > In sec_acl.cc and security.cc, this buffer is named `acl_buf' and it's
> > > size is 3072.  Let's do it the same here.  I've seen amazingly big ACLs
> > > on NT4 once.
> >
> > Corinna,
> >
> > Just a quick note: doesn't the above call for a #define'd constant?
>
> wtf PTC
>
> Corinna

Ok, I'll make a note of that.  I just thought that since you were already
working on this one, this would be a good time to introduce the #define.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
