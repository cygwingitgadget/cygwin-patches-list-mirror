Return-Path: <cygwin-patches-return-4170-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32171 invoked by alias); 6 Sep 2003 02:04:27 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32162 invoked from network); 6 Sep 2003 02:04:26 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 06 Sep 2003 02:04:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygcheck: don't fail integrity check on empty package
In-Reply-To: <20030906020301.GA4981@redhat.com>
Message-ID: <Pine.GSO.4.56.0309052203380.7348@slinky.cs.nyu.edu>
References: <Pine.GSO.4.56.0309052041170.7348@slinky.cs.nyu.edu>
 <Pine.GSO.4.56.0309052046590.7348@slinky.cs.nyu.edu> <20030906020301.GA4981@redhat.com>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00186.txt.bz2

On Fri, 5 Sep 2003, Christopher Faylor wrote:

> On Fri, Sep 05, 2003 at 08:53:54PM -0400, Igor Pechtchanski wrote:
> >On Fri, 5 Sep 2003, Igor Pechtchanski wrote:
> >>This patch fixes the erroneous failure of "cygcheck -c" when the
> >>package is empty (and thus the file list for it is missing), e.g.,
> >>XFree86-base.
> >
> >Sorry, I've messed up the ChangeLog entry.  The correct one is included
> >below.
> >
> >>==============================================================================
> >>ChangeLog:
> >2003-09-05 Igor Pechtchanski <pechtcha@cs.nyu.edu>
> >
> >* dump_setup.cc (check_package_files): Don't fail on empty package.
>
> I'll check this in but I wonder if the printfs here shouldn't be fprintf(stderr
> since they are sort of an error condition.
>
> cgf

Perhaps, but they are only printed if verbose output is requested, so
presumably the user wants to see them on stdout.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
