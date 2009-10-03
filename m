Return-Path: <cygwin-patches-return-6673-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28324 invoked by alias); 3 Oct 2009 13:07:02 -0000
Received: (qmail 28314 invoked by uid 22791); 3 Oct 2009 13:07:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 13:06:56 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 02C156D5598; Sat,  3 Oct 2009 15:06:44 +0200 (CEST)
Date: Sat, 03 Oct 2009 13:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091003130644.GJ7193@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC74BB5.9060503@gmail.com>
User-Agent: Mutt/1.5.19 (2009-02-20)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00004.txt.bz2

On Oct  3 14:03, Dave Korn wrote:
> Corinna Vinschen wrote:
> 
> > I just built a gcc 4.3.4 Linux->Cygwin cross compiler using the sources
> > from the Cygwin 1.7 distro.  I used the following build flags:
> > 
> >   --disable-bootstrap --enable-version-specific-runtime-libs \
> >   --enable-static --enable-shared --enable-shared-libgcc \
> >   --disable-__cxa_atexit --with-gnu-ld --with-gnu-as --with-dwarf2 \
> >   --disable-sjlj-exceptions --enable-languages=c,c++ --disable-symvers \
> >   --enable-threads=posix --with-arch=i686 --with-tune=generic \
> >   --with-newlib
>     ^^^^^^^^^^^^^^
> 
>   Are you doing something tricky w.r.t. the headers and libs you supply to the
> build process?  You appear to be using none-at-all out of --with-headers,
> --with-includes and --with-sysroot.

Nothing special.  I need the --with-newlib, otherwise the libstdc++ build
fails with 

 configure:<lineno>: error: No support for this host/target combination.

We talked about this in PM already, back in January.

Btw., I also had to set --disable-__cxa_atexit in contrast to your
--enable-__cxa_atexit.  If I don't do that, I get undefined reference
errors (some dso_foo and cxa_foo functions) when building libstdc++.

> > When I try to build Cygwin I get:
> > 
> >   cc1plus: error: command line option '-muse-libstdc-wrappers' is not
> >   supported by this configuration
> > 
> > What am I doing wrong?
> 
>   Take a look in $objdir/gcc/config.log; what happened during the "checking
> for __wrap__Znaj" test?  Hmmmmm, I may have the config set up wrong so it only
> works in bootstrap, not crossbuilds.  You could try manually hacking

Apparently.  There's no line containing __wrap__Znaj in config.log.

> "-DUSE_CYGWIN_LIBSTDCXX_WRAPPERS=1" into the CFLAGS.  Meanwhile, I need to go

Thanks, I'll try that.

> figure out how to make sure and check the target rather than host libraries
> for the presence of a function.  (It's worth adding fixing this to the to-do
> list for -2).

While you're at it, there is another problem.  When building gcc-4.3.4
as cross, the auto-host.h file contains

  #ifndef USED_FOR_TARGET
  /* #undef HAVE_GAS_ALIGNED_COMM */
  #endif

afterwards.  That's quite unlucky, since options.c contains an
unconditional

  int use_pe_aligned_common = HAVE_GAS_ALIGNED_COMM;

So, right now I had to define HAVE_GAS_ALIGNED_COMM to 1 manually in
auto-host.h.


And, while we're at it, how do I switch on the TSAWARE flag by default?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
