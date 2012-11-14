Return-Path: <cygwin-patches-return-7782-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7861 invoked by alias); 14 Nov 2012 11:57:27 -0000
Received: (qmail 7825 invoked by uid 22791); 14 Nov 2012 11:57:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 14 Nov 2012 11:57:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DADD02C00C3; Wed, 14 Nov 2012 12:57:07 +0100 (CET)
Date: Wed, 14 Nov 2012 11:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Try #3 for changes to Cygwin configure
Message-ID: <20121114115707.GC27964@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112200223.GA16672@ednor.casa.cgf.cx> <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx> <20121113183414.GA12388@ednor.casa.cgf.cx> <20121113184732.GB27964@calimero.vinschen.de> <20121113210739.GA22535@ednor.casa.cgf.cx> <20121114033958.GA16881@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121114033958.GA16881@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00059.txt.bz2

On Nov 13 22:39, Christopher Faylor wrote:
> Try #3.  This is a smaller patch with some bug fixes found after
> building from-scratch, cleanly on a Fedora system with Yaakov's cross
> tools (ok, so I lied and did end up setting up a Fedora system to test
> this).

Is that the point where I have to say "na na na na naaa na"?  Just kidding.

> Also fixed some long-standing Makefile bugs and misconceptions in
> cygwin and utils.
> 
> I'm not entirely thrilled with the fact that configuring and building
> this from the level above winsup results in lots of compiler command
> line parameters passed in which are also discerned by macros in
> acinclude.m4.  If we do end up staying in the src CVS repository I'll
> have to fix that.

For a start I applied the patch to CVS HEAD and ran a stock `configure;
make' from toplevel on Fedora 17 with Yaakov's Cygwin packages.

I can't link the Cygwin DLL:

/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -luser32
/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -lkernel32
/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -ladvapi32
/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -lshell32
collect2: ld returned 1 exit status

I didn't look why it doesn't find these libs.  But this means the
-nostdlib flag is missing.  If I add it I get a lot of messages pointing
out missing symbols, though:

  .../cygtls.h:301: undefined reference to `__Unwind_Resume'
  .../bsdlib.o:bsdlib.cc:(.eh_frame+0x12): undefined reference to `___gxx_personality_v0'
  [...]

After a bit of digging I found that the -fno-rtti -fno-exceptions flags
are missing when building the C++ source files.

When building cygserver stuff, the flags -mno-use-libstdc-wrappers
-fno-rtti -fno-exceptions are missing, too.

In utils, I get an interesting error when building cygcheck:

  In file included from .../cygcheck.cc:13:0:
  .../newlib/libc/include/stdio.h:35:20: fatal error: stddef.h: No such file or directory

Newlib?  For a Mingw application?  The compiler instruction actually
contains the following paths:

  -I${srcdir}/winsup/cygwin \
  -isystem /usr/i686-pc-cygwin/sys-root/usr/include/w32api \
  -isystem ${srcdir}/winsup/cygwin/include \
  -isystem ${srcdir}-pc-cygwin/newlib/targ-include \
  -isystem ${srcdir}/newlib/libc/include

None of them should be used when building with the Mingw compiler.

Btw., why did you remove $(CFLAGS) from the definition of MINGW_CXX?
I added it just a couple of days ago explicitely to be able to build
the utils manually with different optimizing settings:

 2012-11-05  Corinna Vinschen <...>

	* Makefile.in (MINGW_CXX): Attach $(CFLAGS) to allow providing
	build option tweaks to mingw compiler as well.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
