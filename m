Return-Path: <cygwin-patches-return-7846-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22921 invoked by alias); 5 Mar 2013 08:50:22 -0000
Received: (qmail 22765 invoked by uid 22791); 5 Mar 2013 08:50:02 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 05 Mar 2013 08:49:54 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F15965203B8; Tue,  5 Mar 2013 09:49:50 +0100 (CET)
Date: Tue, 05 Mar 2013 08:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130305084950.GB16361@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130304021224.381b9ec4@YAAKOV04> <20130304105134.GF5468@calimero.vinschen.de> <20130304053936.49484e71@YAAKOV04> <20130304131539.GE2481@calimero.vinschen.de> <20130304144022.GI2481@calimero.vinschen.de> <20130305000934.66f77aba@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130305000934.66f77aba@YAAKOV04>
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
X-SW-Source: 2013-q1/txt/msg00057.txt.bz2

On Mar  5 00:09, Yaakov wrote:
> On Mon, 4 Mar 2013 15:40:22 +0100, Corinna Vinschen wrote:
> > On Mar  4 14:15, Corinna Vinschen wrote:
> > > Thanks, but here's a question:  If the libgcj ABI version really changes
> > > with every GCC major.minor release, wouldn't it then make sense to
> > > change the libgcj DLL versioning scheme so it uses the GCC major.minor
> > > number rather than an arbitrary version number?
> > > 
> > > In other words, why not cyggcj-4.8.dll?  This would allow easy
> > > automation of Cygwin's LIBGCJ_SONAME, and everybody would know what
> > > GCC version it's based on.
> > 
> > Here's my version of the LIBGCJ_SONAME setting:
> > 
> > #ifndef BUILDING_GCC_MAJOR
> > #include "bversion.h"
> > #endif
> > #define ___cyg_mkstr(x) #x
> > #define __cyg_mkstr(x)  ___cyg_mkstr(x)
> > #define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MAJOR) "." \
> > 				__cyg_mkstr (BUILDING_GCC_MINOR) ".dll"
> 
> I don't know if the version changes are a matter of policy or just how
> it has happened, but in any case that's not the current versioning
> scheme, nor is it how libtool libraries are usually versioned (and no,
> libgnat is not built with libtool).  As long as this continues, the
> following would work instead if you want to automate it:

Where exactly is the problem?  I thought *we* can define how the DLL is
called.  Is anything outside of the GCC toolchain expecting a specific
DLL name and relying on it?  I also don't understand the connection to
libgnat.  Does it load libgcj dynamically?  If not, why is it important
to libgnat how the libgcj DLL is called?!?

> #define LIBGCJ_SONAME "cyggcj-" __cyg_mkstr (BUILDING_GCC_MINOR+6) ".dll"
> 
> Also, you missed the #undef CXX_WRAP_SPEC_LIST before #define
> CXX_WRAP_SPEC_LIST in cygwin-w64.h; this avoids a bunch of warnings
> building GCC.

That wasn't in cygwin.h either.  I fix that.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
