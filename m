Return-Path: <cygwin-patches-return-4079-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30474 invoked by alias); 13 Aug 2003 14:44:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30465 invoked from network); 13 Aug 2003 14:44:00 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Wed, 13 Aug 2003 14:44:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Consider extensions for special names in managed mode
In-Reply-To: <20030813142608.GD3101@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.44.0308131041350.8046-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00095.txt.bz2

On Wed, 13 Aug 2003, Corinna Vinschen wrote:

> On Wed, Aug 13, 2003 at 10:19:08AM -0400, Igor Pechtchanski wrote:
> > Yeah.  I promised a patch, didn't I?  *Sigh*.
> > 	Igor
> > ==============================================================================
> > 2003-08-13  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> >
> > 	* path.cc (special_name): Add checks for some specials
> > 	followed by a "." and a FIXME comment.
>
> I leave this to Chris for obvious reasons.
>
> > +  // FIXME: add com0 and {com,lpt}N.*
> >    if (strcasematch (s, "nul")
> > +      || strncasematch (s, "nul.", 4)
> >        || strcasematch (s, "aux")
> > +      || strncasematch (s, "aux.", 4)
> >        || strcasematch (s, "prn")
> > +      || strncasematch (s, "prn.", 4)
> >        || strcasematch (s, "con")
> > +      || strncasematch (s, "con.", 4)
> >        || strcasematch (s, "conin$")
> >        || strcasematch (s, "conout$"))
> >      return -1;
>
> Clueless question:  What about sth. like foo.aux?
>
> Corinna

<http://cygwin.com/cygwin-ug-net/using-specialnames.html#AEN745>.
"touch foo.aux" works perfectly well even on normal mounts.
I think <http://cygwin.com/faq/faq_4.html#SEC59> is wrong, though.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
