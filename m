Return-Path: <cygwin-patches-return-4096-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1807 invoked by alias); 16 Aug 2003 12:43:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1798 invoked from network); 16 Aug 2003 12:43:33 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 16 Aug 2003 12:43:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Package content search and listing functionality for
 cygcheck
In-Reply-To: <16189.45520.758000.679252@gargle.gargle.HOWL>
Message-ID: <Pine.GSO.4.44.0308160842240.15497-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.44.0308160842242.15497@slinky.cs.nyu.edu>
Content-Description: message body text
X-SW-Source: 2003-q3/txt/msg00112.txt.bz2

On Fri, 15 Aug 2003, David Rothenberger wrote:

> Igor Pechtchanski writes:
>  > On Fri, 15 Aug 2003, David Rothenberger wrote:
>  >
>  > > I notice that package_list() prints a message in this case with the -v
>  > > switch, but package_find() does not.  My personal pref. is for the
>  > > message, but I'll leave it to you to decide.
>  > >
>  > > Dave
>  >
>  > Dave,
>  >
>  > Actually, there's a reason for that (and, in fact, it used to be the way
>  > you described, and I changed it).  If package_list() looks at a package,
>  > the contents of that package were requested on the command line, and thus,
>  > if the list file is not found, an error message makes sense.  On the other
>  > hand, package_find() looks at *all* the packages, so if the list for one
>  > of them is missing (which could happen if the package is empty, for
>  > example), package_find() will (should, IMO) simply ignore it.
>  > 	Igor
>
> Igor,
>
> Yeah, that makes perfect sense, and I would have seen it was
> intentional if I had looked closely at the patch.  Sorry for the
> false alarm.
>
> Here's another small patch for "cygcheck -c" that strips leading ./
> and / from filenames in the package lists.
>
> I have Joshua's packages for building cygwin-doc installed, and the
> entries in those packages' lists start with "./", which breaks the
> postinstall check, causing them to show up as bad.
>
> I know these are non-standard packages, but it's such a small little
> fix to support them and I would really like my "cygcheck -c" output
> to be clean.  This gets it closer; it still complains about empty
> packages like diff, but I don't see an easy way to solve that.
>
> This patch includes all your previous changes.
>
> Dave
> ======================================================================
> 2003-08-15  David Rothenberger  <daveroth@acm.org>
>
> 	* dump_setup.cc (package_find): Don't stop searching on missing
> 	file list.
> 	(package_list): Ditto.
> 	(check_package_files): Strip leading ./ and / from package
> 	contents.
>
> 2003-08-15  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>
> 	* dump_setup.cc: (package_list): Make output terse unless
> 	verbose requested.  Fix formatting.
> 	(package_find): Ditto.

Dave,

Oops, Corinna just applied my previous patch.  I guess you'll have to
re-generate this one against the CVS HEAD...  Sorry.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
