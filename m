Return-Path: <cygwin-patches-return-4058-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18072 invoked by alias); 9 Aug 2003 19:59:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18063 invoked from network); 9 Aug 2003 19:59:01 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 09 Aug 2003 19:59:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
In-Reply-To: <20030809161211.GB9514@redhat.com>
Message-ID: <Pine.GSO.4.44.0308091553280.7386-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00074.txt.bz2

On Sat, 9 Aug 2003, Christopher Faylor wrote:

> [snip]
> Btw, have you considered some kind of rpm -f functionality?  That would
> allow a user to do a:
>
> cygcheck -f /usr/bin/ls.exe
> fileutils-4.1-2
>
> Also some kind of functionality which would allow cygcheck to query
> the same files as the web search would be really cool.  Something like
> a:
>
> cygcheck --whatprovides /usr/bin/ls.exe
>
> would be really useful.

I'm not sure I see the difference between the two cases above.  Also, I
think this kind of query would be easier to implement if setup maintained
a more comprehensive database of files keyed by the filename.  I could
whip up something quick and dirty, but let's first decide on whether to
use the zlib library instead of calling gzip.exe -- that wasn't something
I intended to be permanent.

> Another interesting thing would be to do some ntsec/mkpasswd/mkgroup
> type sanity checks or even to fix up common ntsec problems.
>
> cgf

Yeah.  At least have it check for the group name of "mkpasswd" or
"mkgroup"...  That, however, would require a separate flag, IMO.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
