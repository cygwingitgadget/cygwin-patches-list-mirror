Return-Path: <cygwin-patches-return-2943-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15265 invoked by alias); 6 Sep 2002 15:14:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15251 invoked from network); 6 Sep 2002 15:14:45 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Fri, 06 Sep 2002 08:14:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
To: cygwin-patches@cygwin.com, <mingw-users@lists.sourceforge.net>
Subject: Re: [Mingw-users] Re: WINVER constant value [WAS: GetConsoleWindow]
In-Reply-To: <3D78A6BD.3BF99DCC@yahoo.com>
Message-ID: <Pine.GSO.4.44.0209061113340.13825-100000@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00391.txt.bz2

On Fri, 6 Sep 2002, Earnie Boyd wrote:

> Earnie Boyd wrote:
> >
> > My guess is that there are more GCC experienced people using MinGW for
> > mingw32-gcc than there are MSVC experienced people using MinGW for any
> > reason.  A drop in replacement for MSVC, surely isn't the desire.
> > Wanting to the package to port to all versions of Win32 is the desire.
>           ^^^^^^ s/to the/a
> > Using new Win32 API not supported on older versions of the OS isn't the
> > way to go about doing that.  Runtime surprises, is not the place to
> > discover that the port doesn't work.
>                                      ^on prior versions of win32
> Earnie.

I'm not qualified to have an opinion on this, but something here reminds
me of the old discussion on whether to use numeric co-processor features
in a compiler vs. emulating floating point in software...
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

It took the computational power of three Commodore 64s to fly to the moon.
It takes a 486 to run Windows 95.  Something is wrong here. -- SC sig file
