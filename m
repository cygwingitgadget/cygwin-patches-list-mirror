Return-Path: <cygwin-patches-return-6682-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13884 invoked by alias); 4 Oct 2009 11:27:03 -0000
Received: (qmail 13870 invoked by uid 22791); 4 Oct 2009 11:27:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 04 Oct 2009 11:26:58 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 411C46D5598; Sun,  4 Oct 2009 13:26:48 +0200 (CEST)
Date: Sun, 04 Oct 2009 11:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091004112648.GE4563@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com> <4AC84E5A.7040203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4AC84E5A.7040203@gmail.com>
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
X-SW-Source: 2009-q4/txt/msg00013.txt.bz2

On Oct  4 08:27, Dave Korn wrote:
> Dave Korn wrote:
> 
> >> Apparently.  There's no line containing __wrap__Znaj in config.log.
> > 
> >   Yeh, that proves I'm using the wrong sort of autoconf test.  
> 
>   No it doesn't!
> 
> >> While you're at it, there is another problem.  When building gcc-4.3.4
> >> as cross, the auto-host.h file contains
> >>
> >>   #ifndef USED_FOR_TARGET
> >>   /* #undef HAVE_GAS_ALIGNED_COMM */
> >>   #endif
> >>
> >> afterwards.  That's quite unlucky, since options.c contains an
> >> unconditional
> >>
> >>   int use_pe_aligned_common = HAVE_GAS_ALIGNED_COMM;
> >>
> >> So, right now I had to define HAVE_GAS_ALIGNED_COMM to 1 manually in
> >> auto-host.h.
> 
>   Got it.  The cygport-generated diffs don't include patches to the generated
> configure scripts, only the *.ac templates, so you need to manually reconf the
> sources after applying the patch.  Check the cygport script for a list of
> which directories need which auto* tool run on them (I haven't tried just
> blindly autoreconf'ing the whole lot from top level but in theory that would
> work too), and don't forget you need autoconf-2.59 and make-1.9.6.

Since I have a running gcc-4.34 now, do you still want me to do that?
Plaese keep in mind that I'm a lazy cow...


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
