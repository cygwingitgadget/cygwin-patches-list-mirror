Return-Path: <cygwin-patches-return-4093-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5983 invoked by alias); 16 Aug 2003 04:01:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5973 invoked from network); 16 Aug 2003 04:01:54 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 16 Aug 2003 04:01:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for
 cygcheck
In-Reply-To: <3F3DA55A.1070703@acm.org>
Message-ID: <Pine.GSO.4.44.0308152358290.15497-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00109.txt.bz2

On Fri, 15 Aug 2003, David Rothenberger wrote:

> Igor Pechtchanski wrote:
> > Dave,
> >
> > Thanks for catching this -- this was a genuine bug.  Thanks also for the
> > patch, but I have another one in the pipeline that'll conflict with yours
> > (<http://cygwin.com/ml/cygwin-patches/2003-q3/msg00105.html>).  How about
> > I just resubmit that patch with your changes included?
> >
> > Attached is a new patch, with an updated ChangeLog entry (well, two
> > entries).
>
> Thanks for fixing package_find(), too.  I should've checked that myself.
>
> I notice that package_list() prints a message in this case with the -v
> switch, but package_find() does not.  My personal pref. is for the
> message, but I'll leave it to you to decide.
>
> Dave

Dave,

Actually, there's a reason for that (and, in fact, it used to be the way
you described, and I changed it).  If package_list() looks at a package,
the contents of that package were requested on the command line, and thus,
if the list file is not found, an error message makes sense.  On the other
hand, package_find() looks at *all* the packages, so if the list for one
of them is missing (which could happen if the package is empty, for
example), package_find() will (should, IMO) simply ignore it.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
