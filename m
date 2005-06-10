Return-Path: <cygwin-patches-return-5538-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10998 invoked by alias); 10 Jun 2005 10:04:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 10974 invoked by uid 22791); 10 Jun 2005 10:04:02 -0000
Received: from p54941e74.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.30.116)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 10 Jun 2005 10:04:02 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 27A566D41EA; Fri, 10 Jun 2005 12:04:10 +0200 (CEST)
Date: Fri, 10 Jun 2005 10:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Testing loads of cygwin1.dll from MinGW and MSVC, take 3
Message-ID: <20050610100410.GQ11065@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050606200639.GC13442@trixie.casa.cgf.cx> <1118091704.5031.144.camel@fulgurite> <20050606213339.GC16960@trixie.casa.cgf.cx> <1118098448.5031.157.camel@fulgurite> <Pine.GSO.4.61.0506061907220.15703@slinky.cs.nyu.edu> <1118099492.5031.160.camel@fulgurite> <20050606235137.GE16960@trixie.casa.cgf.cx> <1118256244.5031.2661.camel@fulgurite> <20050609085300.GG11065@calimero.vinschen.de> <1118354080.5031.2692.camel@fulgurite>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118354080.5031.2692.camel@fulgurite>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00134.txt.bz2

On Jun  9 14:54, Max Kaehn wrote:
> On Thu, 2005-06-09 at 01:53, Corinna Vinschen wrote:
> > On Jun  8 11:44, Max Kaehn wrote:
> > > I wound up using "eval", and was thoroughly perplexed at the way
> > > that the first "eval" seems to get thrown away.
> > 
> > -v, please.
> > 
> >   tcsh> sh
> >   $ eval date
> >   Thu Jun  9 10:52:23 WEDT 2005
> >   $
> > 
> > Corinna
> 
> (I wasn't sure if you meant -v for version numbers
> or verbose output; I hope what you wanted is somewhere in there.)

I meant "please, be more verbose with information".

> fulgurite-xpdbg% make -f /u/cygwin/src/winsup/testsuite/iterate.mak
> results_foo=0
> results_bar=1
> results_baz=2
> results_foo = 
> results_bar = 1
> results_baz = 2
> results_foo = 
> [: 0: unknown operand
> results_bar = 1
> make: *** [all] Error 1

I can reproduce it without having make involved.  It looks like a ash bug.
Oh boy, I didn't look into ash for ages.  I'm somewhat in real life work,
but I'll lok into it at one point.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
