Return-Path: <cygwin-patches-return-7849-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25037 invoked by alias); 5 Mar 2013 09:39:27 -0000
Received: (qmail 24983 invoked by uid 22791); 5 Mar 2013 09:39:01 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 05 Mar 2013 09:38:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2212C5203B8; Tue,  5 Mar 2013 10:38:50 +0100 (CET)
Date: Tue, 05 Mar 2013 09:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130305093850.GE16361@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130304021224.381b9ec4@YAAKOV04> <20130304105134.GF5468@calimero.vinschen.de> <20130304053936.49484e71@YAAKOV04> <20130304131539.GE2481@calimero.vinschen.de> <20130304144022.GI2481@calimero.vinschen.de> <20130305000934.66f77aba@YAAKOV04> <20130305084950.GB16361@calimero.vinschen.de> <20130305031430.5ff522eb@YAAKOV04> <20130305093009.GD16361@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130305093009.GD16361@calimero.vinschen.de>
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
X-SW-Source: 2013-q1/txt/msg00060.txt.bz2

On Mar  5 10:30, Corinna Vinschen wrote:
> On Mar  5 03:14, Yaakov wrote:
> > On Tue, 5 Mar 2013 09:49:50 +0100, Corinna Vinschen wrote:
> > > On Mar  5 00:09, Yaakov wrote:
> > > > I don't know if the version changes are a matter of policy or just how
> > > > it has happened, but in any case that's not the current versioning
> > > > scheme, nor is it how libtool libraries are usually versioned (and no,
> > > > libgnat is not built with libtool).  As long as this continues, the
> > > > following would work instead if you want to automate it:
> > > 
> > > Where exactly is the problem?  I thought *we* can define how the DLL is
> > > called.  Is anything outside of the GCC toolchain expecting a specific
> > > DLL name and relying on it? 
> > 
> > No, we don't control the DLL name; libjava/Makefile.am and
> > libjava/libtool-version determine the soname of libgcj based on
> > standard libtool naming and versioning practices.  Since GCC 3.2
> > (libgcj.so.3), there has been a consistent +1 version bump for each
> > major.minor release, hence the x+6 for the 4.x series
> > (for 4.8: cyggcj-14.dll, libgcj.so.14, etc.).
> > 
> > The define in cygwin*.h or mingw32.h is used in
> > libgcc/config/i386/cygming-crtbegin.c:__gcc_register_frame(), so it's
> > the define that needs to match the build system, not the other way
> > around.
> 
> Sigh, ok.  I'll use your definition.  What do we do when gcc 5.0
> is getting close?

What about

#if BUILDING_GCC_MAJOR == 4
#define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MINOR+6) ".dll"
#else
#error LIBGCJ_SONAME versioning scheme needs attention
#endif

for now?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
