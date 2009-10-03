Return-Path: <cygwin-patches-return-6671-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19517 invoked by alias); 3 Oct 2009 12:09:12 -0000
Received: (qmail 19506 invoked by uid 22791); 3 Oct 2009 12:09:11 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 12:09:05 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B51DA6D5598; Sat,  3 Oct 2009 14:08:54 +0200 (CEST)
Date: Sat, 03 Oct 2009 12:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
Message-ID: <20091003120854.GA22019@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20091002221933.GB12372@ednor.casa.cgf.cx>
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
X-SW-Source: 2009-q4/txt/msg00002.txt.bz2

On Oct  2 18:19, Christopher Faylor wrote:
> On Fri, Oct 02, 2009 at 10:11:14PM +0100, Dave Korn wrote:
> >
> >  So, nobody did ask for a compiler version check(*), so here's the patch plus
> >changelog, and I'd like to get separate OKs from both cgf and cv to say that
> >you've each either updated your cross-build environments or don't mind
> >patching the flag back out locally until you can.
> >
> >winsup/cygwin/ChangeLog:
> >
> >	* Makefile.in (CFLAGS): Add -mno-use-libstdc-wrappers
> >
> >  (In case anyone was wondering, I think CFLAGS, rather than CXXFLAGS, is the
> >right place to add it; it applies to cross-language mixed linking situations
> >as much as it does to C++ alone).
> 
> I think we've confirmed that this is a good fix.  Please check it in.

I just built a gcc 4.3.4 Linux->Cygwin cross compiler using the sources
from the Cygwin 1.7 distro.  I used the following build flags:

  --disable-bootstrap --enable-version-specific-runtime-libs \
  --enable-static --enable-shared --enable-shared-libgcc \
  --disable-__cxa_atexit --with-gnu-ld --with-gnu-as --with-dwarf2 \
  --disable-sjlj-exceptions --enable-languages=c,c++ --disable-symvers \
  --enable-threads=posix --with-arch=i686 --with-tune=generic \
  --with-newlib

When I try to build Cygwin I get:

  cc1plus: error: command line option '-muse-libstdc-wrappers' is not
  supported by this configuration

What am I doing wrong?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
