Return-Path: <cygwin-patches-return-3741-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25250 invoked by alias); 23 Mar 2003 00:55:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25237 invoked from network); 23 Mar 2003 00:55:54 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sun, 23 Mar 2003 00:55:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Robert Collins <rbcollins@cygwin.com>
cc: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>,
   <cygwin-patches@cygwin.com>
Subject: Re: Patched doc/setup-net.sgml
In-Reply-To: <1048379098.912.47.camel@localhost>
Message-ID: <Pine.GSO.4.44.0303221949580.561-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q1/txt/msg00390.txt.bz2

On 23 Mar 2003, Robert Collins wrote:

> [snip]
> * For most users, the Direct Connection method of downloading is the
> best choice.
>
> IMO the IE5 method is best. I've been considering making it the default.
> The IE5 method will leverage your IE5 cache and or organisational proxy
> server for performance. It will also honour browser auto-configuration
> scripts.

This doesn't work for me.  I'm still trying to figure out why, but since
the possibility is there, better err on the side of caution.

> * setup.ini
> setup actually downloads setup.bz2 these days, setup.ini is a suported
> legacy config file. I don't know if you want to mention that or not.

It's stored locally as setup.ini, though, isn't it?

> [snip]
> * packages are divided into categories
> you might want to say 'grouped into', or 'categorized by'. divided into
> could suggest literal division of individual packages to a non english
> reader - i.e. /bin files go into the foo package :].

How about "Packages are assigned categories, and one package may belong to
multiple categories".

> * a very basic Cygwin
> to me, 'minimal' reads more clearly than 'very basic'. Just a thought.

Minimal is overloaded to mean other things, though...  I'm not sure what
the right term here would be, "reasonable", perhaps?
	Igor

> [snip]
> Fantastic job otherwise!
> Cheers,
> Rob

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Oh, boy, virtual memory! Now I'm gonna make myself a really *big* RAMdisk!
  -- /usr/games/fortune
