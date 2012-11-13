Return-Path: <cygwin-patches-return-7779-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27347 invoked by alias); 13 Nov 2012 18:48:01 -0000
Received: (qmail 27279 invoked by uid 22791); 13 Nov 2012 18:47:49 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 13 Nov 2012 18:47:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EC3672C00C3; Tue, 13 Nov 2012 19:47:32 +0100 (CET)
Date: Tue, 13 Nov 2012 18:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [WIP] mingw64 related changes to Cygwin configure and other assorted files with departed w32api/mingw
Message-ID: <20121113184732.GB27964@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx> <20121113183414.GA12388@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121113183414.GA12388@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00056.txt.bz2

On Nov 13 13:34, Christopher Faylor wrote:
> On Tue, Nov 13, 2012 at 12:39:00PM -0500, Christopher Faylor wrote:
> >Maybe I can use -isystem with ccwraper.  I'd previously gotten things
> >working without the wrapper, using idirafter so that's what I stuck
> >with.  However, the wrapper may now allow just always including the
> >windows headers last.
> 
> Yep.  Adding the windows headers directories dead last as -isystem means
> that none of my header file changes are needed, *except* for the #define
> _WIN32.  I wonder why you don't need those.  My (i.e., Yaakov's) cross
> compiler doesn't define _WIN32.
> 
> % /cygwin/bin/i686-cygwin-gcc --version
> i686-cygwin-gcc (GCC) 4.5.3 20110428 (Fedora Cygwin 4.5.3-4)
> Copyright (C) 2010 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> % /cygwin/bin/i686-cygwin-gcc -dD -E -xc /dev/null | grep WIN
> #define __WINT_TYPE__ unsigned int
> #define __WINT_MAX__ 4294967295U
> #define __WINT_MIN__ 0U
> #define __SIZEOF_WINT_T__ 4
> #define __CYGWIN32__ 1
> #define __CYGWIN__ 1
> 
> So, except for that, mystery solved.
> 
> My new, smaller diff is attached.  Unless you have objections, I'll be
> checking this in.

I have no objections against the patch in general, but I'd rather like to
test it first.  I'd like to try to figure out what the _WIN32 problem is
first, and I'd like to give it a try in the 64 bit scenario.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
