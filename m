Return-Path: <cygwin-patches-return-5523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29353 invoked by alias); 6 Jun 2005 21:12:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29327 invoked by uid 22791); 6 Jun 2005 21:12:04 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 06 Jun 2005 21:12:04 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j56LC2W3006560
	for <cygwin-patches@cygwin.com>; Mon, 6 Jun 2005 17:12:02 -0400 (EDT)
Date: Mon, 06 Jun 2005 21:12:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Loading cygwin1.dll from MinGW and MSVC
In-Reply-To: <20050606205259.GB14555@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0506061710450.15703@slinky.cs.nyu.edu>
References: <20050606193232.GA12606@trixie.casa.cgf.cx>
 <Pine.GSO.4.61.0506061536381.15703@slinky.cs.nyu.edu>
 <20050606195234.GA13442@trixie.casa.cgf.cx> <Pine.GSO.4.61.0506061556260.15703@slinky.cs.nyu.edu>
 <20050606204230.GA14555@trixie.casa.cgf.cx> <20050606205259.GB14555@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00119.txt.bz2

On Mon, 6 Jun 2005, Christopher Faylor wrote:

> On Mon, Jun 06, 2005 at 04:42:30PM -0400, Christopher Faylor wrote:
> >On Mon, Jun 06, 2005 at 04:09:13PM -0400, Igor Pechtchanski wrote:
> >I guess you could do it that way.  It would look more transparent to the
> >end user if you did.  You'd still have to make it clear that this has to
> >happen first thing in the main() function or you could suffer problems
> >with automatic initialization or constructors.
>
> Actually, if you do it that way, there's no reason to pass in main()
> since the DLL already knows how to find it.

True, provided you're not doing this from a console application which uses
WinMain (but then the arguments will all be different as well).
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
