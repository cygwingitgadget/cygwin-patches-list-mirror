Return-Path: <cygwin-patches-return-4055-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9243 invoked by alias); 9 Aug 2003 19:32:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9234 invoked from network); 9 Aug 2003 19:32:32 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sat, 09 Aug 2003 19:32:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Checking integrity of installed packages in cygcheck
In-Reply-To: <3F3548E8.1040605@cwilson.fastmail.fm>
Message-ID: <Pine.GSO.4.44.0308091527360.7386-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q3/txt/msg00071.txt.bz2

On Sat, 9 Aug 2003, Charles Wilson wrote:

> Christopher Faylor wrote:
>
> > I'll check this in but it would be nice if (WBNI) this used a mingw gzip
> > library rather than calling gzip directly.  That's a fair amount of
> > work but I could resurrect the zlib library in winsup if necessary.

Yes, I found the bzip2 library, but there was no zlib in the mingw
subtree, and I wasn't in the mood to experiment with the makefile magic to
make it work.

> > I wonder why setup is using gzip rather than bzip2 for the package files...
>
> the setup tree contains its own copies of the zlib and bzlib trees;
> thue, they are compiled under the same runtime that setup is.  If setup
> is a 'mingw' app, then so are the internal, statically linked libz and
> bz2lib.
>
> I imagine that the reason Igor used popen and zcat is simply that it was
> easier than directly interfacing to the library.  Perhaps that issue
> could be addressed in a later patch (along the lines of the compress_gz
> class, which also provides uncompression capabilities?)
>
> Chuck

That's exactly my plan.  If there were a mingw zlib example somewhere in
the code, I'd've used that, but I didn't want to venture into unknown
territory without a guide.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
