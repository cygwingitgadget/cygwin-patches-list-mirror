Return-Path: <cygwin-patches-return-7855-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5407 invoked by alias); 17 Mar 2013 09:18:36 -0000
Received: (qmail 5395 invoked by uid 22791); 17 Mar 2013 09:18:35 -0000
X-SWARE-Spam-Status: No, hits=-5.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f180.google.com (HELO mail-ia0-f180.google.com) (209.85.210.180)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 17 Mar 2013 09:18:29 +0000
Received: by mail-ia0-f180.google.com with SMTP id f27so4365398iae.39        for <cygwin-patches@cygwin.com>; Sun, 17 Mar 2013 02:18:29 -0700 (PDT)
X-Received: by 10.50.149.233 with SMTP id ud9mr8520918igb.92.1363511909070;        Sun, 17 Mar 2013 02:18:29 -0700 (PDT)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id uy13sm6108143igb.7.2013.03.17.02.18.27        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Sun, 17 Mar 2013 02:18:28 -0700 (PDT)
Date: Sun, 17 Mar 2013 09:18:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130317041825.42371500@YAAKOV04>
In-Reply-To: <20130316104515.GA30245@calimero.vinschen.de>
References: <20130304131539.GE2481@calimero.vinschen.de>	<20130304144022.GI2481@calimero.vinschen.de>	<20130305000934.66f77aba@YAAKOV04>	<20130305084950.GB16361@calimero.vinschen.de>	<20130305031430.5ff522eb@YAAKOV04>	<20130305093009.GD16361@calimero.vinschen.de>	<20130305093850.GE16361@calimero.vinschen.de>	<20130315051819.2ce99a0b@YAAKOV04>	<20130315102655.GD1360@calimero.vinschen.de>	<20130315165640.14bdcb71@YAAKOV04>	<20130316104515.GA30245@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00066.txt.bz2

On Sat, 16 Mar 2013 11:45:15 +0100, Corinna Vinschen wrote:
> > Also, in libstdc++-v3/crossconfig.m4:
> > 
> > > +  *-cygwin*)
> > > +    GLIBCXX_CHECK_COMPILER_FEATURES
> > > +    GLIBCXX_CHECK_LINKER_FEATURES
> > > +    GLIBCXX_CHECK_MATH_SUPPORT
> > > +    GLIBCXX_CHECK_STDLIB_SUPPORT
> > > +    ;;
> > 
> > I think cygwin should be added to the preceding linux|gnu|k*bsd-gnu
> > case, as we also have /dev/random, pthreads, and iconv.
> 
> Yeah, this sounds like the right thing to do.  Thanks for the reminder.
> I can build a new linux toolchain next week, and I suppose you did
> build your native gcc toolchain with these changes already?

I also discovered two more gcc macros which were missing updates for
x86_64-cygwin.  I have added those patches, and incorporated your x86_64
patches into mine, into a 4.8 branch of my gcc port:

http://cygwin-ports.git.sourceforge.net/git/gitweb.cgi?p=cygwin-ports/gcc;a=shortlog;h=refs/heads/4.8

I am building native and 32-to-64 compilers with this patchset now.

> > BTW, the good news is that I was able to build cygwin-64bit-branch and
> > gcc (3-stage bootstrap with C/C++) natively on x86_64, albeit with
> > -j1, so we're officially at the point of self-hosting.  Hopefully your
> > latest patches will fix parallel make, but that will have to wait until
> > next week.
> 
> Yes, it does, but the price is too high.  It's still a really puzzeling
> problem and the patch, even though it appeared to fix parallel makes,
> is apparently only covering the real, still undiscovered problem.
> 
> The patch only moved the place in the code at which the pseudo relocator
> is called in the child after fork.  In the old location, everything
> appears to work fine, except for those weird, random crashes in parallel
> makes.  In the new location, the parallel makes work fine, but then
> autoreconf hangs in bash.

So I noticed; for now, I've reverted to -5 and MAKEOPTS=-j1.

> This is really, really frustrating.  I hope we can fix this next week,
> but right now I need a weekend off to get my head clear.

Well, with the sourceware upgrade, we've got a few days before we can
proceed much further either way.


Yaakov
