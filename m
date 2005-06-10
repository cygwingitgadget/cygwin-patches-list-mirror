Return-Path: <cygwin-patches-return-5539-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14513 invoked by alias); 10 Jun 2005 17:05:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14497 invoked by uid 22791); 10 Jun 2005 17:05:16 -0000
Received: from slinky.cs.nyu.edu (HELO slinky.cs.nyu.edu) (128.122.20.14)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 10 Jun 2005 17:05:16 +0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id j5AH5FW3026149
	for <cygwin-patches@cygwin.com>; Fri, 10 Jun 2005 13:05:15 -0400 (EDT)
Date: Fri, 10 Jun 2005 17:05:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take
 3
In-Reply-To: <20050610100410.GQ11065@calimero.vinschen.de>
Message-ID: <Pine.GSO.4.61.0506101304140.17644@slinky.cs.nyu.edu>
References: <20050606200639.GC13442@trixie.casa.cgf.cx> <1118091704.5031.144.camel@fulgurite>
 <20050606213339.GC16960@trixie.casa.cgf.cx> <1118098448.5031.157.camel@fulgurite>
 <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu> <1118099492.5031.160.camel@fulgurite>
 <20050606235137.GE16960@trixie.casa.cgf.cx> <1118256244.5031.2661.camel@fulgurite>
 <20050609085300.GG11065@calimero.vinschen.de> <1118354080.5031.2692.camel@fulgurite>
 <20050610100410.GQ11065@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2005-q2/txt/msg00135.txt.bz2

On Fri, 10 Jun 2005, Corinna Vinschen wrote:

> On Jun  9 14:54, Max Kaehn wrote:
> > On Thu, 2005-06-09 at 01:53, Corinna Vinschen wrote:
> > > On Jun  8 11:44, Max Kaehn wrote:
> > > > I wound up using "eval", and was thoroughly perplexed at the way
> > > > that the first "eval" seems to get thrown away.
> > >
> > > -v, please.
> > >
> > >   tcsh> sh
> > >   $ eval date
> > >   Thu Jun  9 10:52:23 WEDT 2005
> > >   $
> > >
> > > Corinna
> >
> > (I wasn't sure if you meant -v for version numbers
> > or verbose output; I hope what you wanted is somewhere in there.)
>
> I meant "please, be more verbose with information".
>
> > fulgurite-xpdbg% make -f /u/cygwin/src/winsup/testsuite/iterate.mak
> > results_foo=0
> > results_bar=1
> > results_baz=2
> > results_foo =
> > results_bar = 1
> > results_baz = 2
> > results_foo =
> > [: 0: unknown operand
> > results_bar = 1
> > make: *** [all] Error 1
>
> I can reproduce it without having make involved.  It looks like a ash bug.
> Oh boy, I didn't look into ash for ages.  I'm somewhat in real life work,
> but I'll lok into it at one point.

Is this related to CGF's query on cygwin@ about replacing sh=ash with
sh=bash?  If not, it should be.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
