Return-Path: <cygwin-patches-return-4003-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10155 invoked by alias); 11 Jul 2003 14:51:04 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10145 invoked from network); 11 Jul 2003 14:51:04 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 11 Jul 2003 14:51:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck parsing of id output
In-Reply-To: <Pine.GSO.4.44.0305011823430.25128-200000@slinky.cs.nyu.edu>
Message-ID: <Pine.GSO.4.44.0307111050180.6088-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0307111050182.6088@slinky.cs.nyu.edu>
X-SW-Source: 2003-q3/txt/msg00019.txt.bz2

Another ping.
	Igor

On Thu, 1 May 2003, Igor Pechtchanski wrote:

> Hi,
>
> The attached patch allows cygcheck to handle spaces, commas, and
> *matching* parentheses in user and group names in the "id" output.
> There's some code sharing in parsing the user and group names, but that
> could be refactored in a later cleanup.
>
> One issue that also came up is the old "run a cygwin program from a
> non-cygwin program from an xterm" issue -- when running cygcheck from an
> xterm, id pops up a separate window and cygcheck gets no output from id...
> I'm not sure how to fix this.  One thing that comes to mind is making
> cygcheck aware of Cygwin ptys, but I don't know how hard that would be...
> 	Igor
> ==============================================================================
> ChangeLog:
> 2003-05-01  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>
> 	* cygcheck.cc (pretty_id): Parse id output without
> 	using strtok.
> 	(match_paren): New static function.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
