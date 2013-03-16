Return-Path: <cygwin-patches-return-7854-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8284 invoked by alias); 16 Mar 2013 10:45:39 -0000
Received: (qmail 8233 invoked by uid 22791); 16 Mar 2013 10:45:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 16 Mar 2013 10:45:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4E0235203B8; Sat, 16 Mar 2013 11:45:15 +0100 (CET)
Date: Sat, 16 Mar 2013 10:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130316104515.GA30245@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130304131539.GE2481@calimero.vinschen.de> <20130304144022.GI2481@calimero.vinschen.de> <20130305000934.66f77aba@YAAKOV04> <20130305084950.GB16361@calimero.vinschen.de> <20130305031430.5ff522eb@YAAKOV04> <20130305093009.GD16361@calimero.vinschen.de> <20130305093850.GE16361@calimero.vinschen.de> <20130315051819.2ce99a0b@YAAKOV04> <20130315102655.GD1360@calimero.vinschen.de> <20130315165640.14bdcb71@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130315165640.14bdcb71@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00065.txt.bz2

On Mar 15 16:56, Yaakov wrote:
> On Fri, 15 Mar 2013 11:26:55 +0100, Corinna Vinschen wrote:
> > ftp://ftp.cygwin.com/pub/cygwin/64bit/x86_64-pc-cygwin-gcc-20130305.patch
> > 
> > I didn't change anything in the toolchain since then.
> 
> This hunk doesn't look right (gcc/config/i386/i386.c):
> 
> >        if (TARGET_64BIT && DEFAULT_ABI == MS_ABI)
> > -       ix86_cmodel = CM_SMALL_PIC, flag_pic = 1;
> > +#ifdef TARGET_CYGWIN64
> > +       ix86_cmodel = CM_MEDIUM_PIC, flag_pic = 1;
> > +#else
> > +       ix86_cmodel = CM_MEDIUM_PIC, flag_pic = 1;
> > +#endif
> 
> It doesn't affect us right now, but this needs to be fixed before
> pushing upstream.

No, this is right at the moment, according to Kai.  Cygwin is supposed
to use the medium code model by default anyway, to support the notion
not having to add "dllimport" to any variable imported from a DLL.  And
the second case is a "reminder to self" from Kai that he's planning to
use the medium model by default on Mingw64 as well at one point.

> Also, in libstdc++-v3/crossconfig.m4:
> 
> > +  *-cygwin*)
> > +    GLIBCXX_CHECK_COMPILER_FEATURES
> > +    GLIBCXX_CHECK_LINKER_FEATURES
> > +    GLIBCXX_CHECK_MATH_SUPPORT
> > +    GLIBCXX_CHECK_STDLIB_SUPPORT
> > +    ;;
> 
> I think cygwin should be added to the preceding linux|gnu|k*bsd-gnu
> case, as we also have /dev/random, pthreads, and iconv.

Yeah, this sounds like the right thing to do.  Thanks for the reminder.
I can build a new linux toolchain next week, and I suppose you did
build your native gcc toolchain with these changes already?

> BTW, the good news is that I was able to build cygwin-64bit-branch and
> gcc (3-stage bootstrap with C/C++) natively on x86_64, albeit with
> -j1, so we're officially at the point of self-hosting.  Hopefully your
> latest patches will fix parallel make, but that will have to wait until
> next week.

Yes, it does, but the price is too high.  It's still a really puzzeling
problem and the patch, even though it appeared to fix parallel makes,
is apparently only covering the real, still undiscovered problem.

The patch only moved the place in the code at which the pseudo relocator
is called in the child after fork.  In the old location, everything
appears to work fine, except for those weird, random crashes in parallel
makes.  In the new location, the parallel makes work fine, but then
autoreconf hangs in bash.

This is really, really frustrating.  I hope we can fix this next week,
but right now I need a weekend off to get my head clear.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
