Return-Path: <cygwin-patches-return-4466-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9109 invoked by alias); 1 Dec 2003 19:56:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9099 invoked from network); 1 Dec 2003 19:56:12 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Mon, 01 Dec 2003 19:56:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] localtime.cc: Point TZDIR to the /usr/share/zoneinfo
In-Reply-To: <20031201183430.GA32563@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0312011454350.1309@slinky.cs.nyu.edu>
References: <87ad6cgb3m.fsf@vzell-de.de.oracle.com> <20031201102807.GB27760@cygbert.vinschen.de>
 <Pine.GSO.4.56.0312010820520.26435@slinky.cs.nyu.edu>
 <20031201183430.GA32563@cygbert.vinschen.de>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00185.txt.bz2

On Mon, 1 Dec 2003, Corinna Vinschen wrote:

> On Mon, Dec 01, 2003 at 11:50:39AM -0500, Igor Pechtchanski wrote:
> > On Mon, 1 Dec 2003, Corinna Vinschen wrote:
> > > Should we do some extra stuff to maintain backward compatibility with
> > > the old /usr/local/etc path?  I don't think so but...
> > >
> > > Corinna
> >
> > That's pretty much what I suggested in
> > <http://cygwin.com/ml/cygwin-apps/2003-11/msg00443.html>.  Right now, the
> > code is not $TZDIR-aware, AFAICS.  IMO, having it first check the TZDIR
> > environment variable, and if that's not set, default to the #defined value
> > of TZDIR would be the right solution.  Something like (very raw)
>
> Interested to change this to a real patch with ChangeLog and all that?
>
> Corinna

Corinna,

If you don't see anything obviously wrong (or missing) in these changes,
I'll test this and submit a proper patch (eventually).
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
