Return-Path: <cygwin-patches-return-6680-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6542 invoked by alias); 3 Oct 2009 14:46:22 -0000
Received: (qmail 6530 invoked by uid 22791); 3 Oct 2009 14:46:21 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 14:46:16 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 16D1A6D5598; Sat,  3 Oct 2009 16:46:06 +0200 (CEST)
Date: Sat, 03 Oct 2009 14:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091003144606.GC4563@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com> <20091003133135.GB32613@calimero.vinschen.de> <4AC759F0.4000209@gmail.com> <20091003143835.GB4563@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091003143835.GB4563@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00011.txt.bz2

On Oct  3 16:38, Corinna Vinschen wrote:
> On Oct  3 15:04, Dave Korn wrote:
> > Corinna Vinschen wrote:
> > 
> > >>   I'll start building 4.3.4-2 on Monday.  Busy this weekend.
> > > 
> > > 'k.  However, if you could give me the required expression, I'll add it
> > > to my cross gcc today :)
> > 
> >   Just add it to LINK_SPEC, making sure it's at the top level rather than
> > inside any of the nested braces, e.g.:
> > 
> > > #define LINK_SPEC "\
> > >   %{mwindows:--subsystem windows} \
> > >   %{mconsole:--subsystem console} \
> >     -tsaware \
> > >   " CXX_WRAP_SPEC " \
> > >   %{shared: %{mdll: %eshared and mdll are not compatible}} \
> > >   %{shared: --shared} %{mdll:--dll} \
> > >   %{static:-Bstatic} %{!static:-Bdynamic} \
> > >   %{shared|mdll: -e \
> > >     %{mno-cygwin:_DllMainCRTStartup@12 --enable-auto-image-base} \
> > >     %{!mno-cygwin:__cygwin_dll_entry@12 --enable-auto-image-base}}\
> > >   %{!mno-cygwin:--dll-search-prefix=cyg}\
> > >   %(shared_libgcc_undefs)"
> > 
> > > Oh, another question.  When unpacking your package, there's a file called
> > > CYGWIN-PATCHES/pr38579.missing.diff.  The patch in that file hasn't been
> > > applied to the sources.  Should it?
> > 
> >   Yep, I stashed it away there because I forgot to put it in the build.  It's
> > the fix for a problem someone reported on the main list.
> 
> Ok, I applied it, thank you.

..and adding the tsaware flag to LINK_SPEC works, too.  Thanks!


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
