Return-Path: <cygwin-patches-return-6677-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9100 invoked by alias); 3 Oct 2009 13:31:51 -0000
Received: (qmail 9090 invoked by uid 22791); 3 Oct 2009 13:31:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 13:31:46 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id C05516D5598; Sat,  3 Oct 2009 15:31:35 +0200 (CEST)
Date: Sat, 03 Oct 2009 13:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091003133135.GB32613@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC75235.1070403@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00008.txt.bz2

On Oct  3 14:31, Dave Korn wrote:
> Corinna Vinschen wrote:
> 
> > Btw., I also had to set --disable-__cxa_atexit in contrast to your
> > --enable-__cxa_atexit.  If I don't do that, I get undefined reference
> > errors (some dso_foo and cxa_foo functions) when building libstdc++.
> 
>   Yes, that's just a dumbass typo on my part.  I meant to fix it a version or
> two ago but it slipped my mind and I didn't remember because it gets
> suppressed somehow on a native build.
> 
> > Apparently.  There's no line containing __wrap__Znaj in config.log.
> 
>   Yeh, that proves I'm using the wrong sort of autoconf test.  Argh, thanks
> for finding that out for me.
> 
> >> "-DUSE_CYGWIN_LIBSTDCXX_WRAPPERS=1" into the CFLAGS.  Meanwhile, I need to go
> > 
> > Thanks, I'll try that.
> 
>   That really ought to work.  Let me know if it does; I'm still holding back
> on committing that patch to the flags.

Will, do, but takes some time.  I'm just preparing the 1.7.0-62 release.
Creating the announcement takes all my nerves...

> > While you're at it, there is another problem.  When building gcc-4.3.4
> > as cross, the auto-host.h file contains
> > 
> >   #ifndef USED_FOR_TARGET
> >   /* #undef HAVE_GAS_ALIGNED_COMM */
> >   #endif
> > 
> > afterwards.  That's quite unlucky, since options.c contains an
> > unconditional
> > 
> >   int use_pe_aligned_common = HAVE_GAS_ALIGNED_COMM;
> > 
> > So, right now I had to define HAVE_GAS_ALIGNED_COMM to 1 manually in
> > auto-host.h.
> 
>   *headdesk*  Right, one more for the to-do list, thanks for finding it.
> 
> > And, while we're at it, how do I switch on the TSAWARE flag by default?
> 
>   I'm planning to add it to LINK_SPEC in gcc/config/i386/cygwin.h.
> 
>   I'll start building 4.3.4-2 on Monday.  Busy this weekend.

'k.  However, if you could give me the required expression, I'll add it
to my cross gcc today :)

Oh, another question.  When unpacking your package, there's a file called
CYGWIN-PATCHES/pr38579.missing.diff.  The patch in that file hasn't been
applied to the sources.  Should it?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
