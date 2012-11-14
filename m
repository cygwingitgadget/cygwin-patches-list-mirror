Return-Path: <cygwin-patches-return-7783-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18516 invoked by alias); 14 Nov 2012 19:08:45 -0000
Received: (qmail 18500 invoked by uid 22791); 14 Nov 2012 19:08:44 -0000
X-SWARE-Spam-Status: No, hits=-1.2 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mho-04-ewr.mailhop.org (HELO mho-02-ewr.mailhop.org) (204.13.248.74)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 14 Nov 2012 19:08:39 +0000
Received: from pool-98-110-183-145.bstnma.fios.verizon.net ([98.110.183.145] helo=cgf.cx)	by mho-02-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TYiKE-000I9L-Er	for cygwin-patches@cygwin.com; Wed, 14 Nov 2012 19:08:38 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B9BBF13C0C8	for <cygwin-patches@cygwin.com>; Wed, 14 Nov 2012 14:08:37 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/K05B4u80CK4Qcn+mBtu4F
Date: Wed, 14 Nov 2012 19:08:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Try #3 for changes to Cygwin configure
Message-ID: <20121114190837.GA31576@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121112215023.GA1436@calimero.vinschen.de> <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx> <20121113183414.GA12388@ednor.casa.cgf.cx> <20121113184732.GB27964@calimero.vinschen.de> <20121113210739.GA22535@ednor.casa.cgf.cx> <20121114033958.GA16881@ednor.casa.cgf.cx> <20121114115707.GC27964@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121114115707.GC27964@calimero.vinschen.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00060.txt.bz2

On Wed, Nov 14, 2012 at 12:57:07PM +0100, Corinna Vinschen wrote:
>On Nov 13 22:39, Christopher Faylor wrote:
>> Try #3.  This is a smaller patch with some bug fixes found after
>> building from-scratch, cleanly on a Fedora system with Yaakov's cross
>> tools (ok, so I lied and did end up setting up a Fedora system to test
>> this).
>
>Is that the point where I have to say "na na na na naaa na"?  Just kidding.
>
>> Also fixed some long-standing Makefile bugs and misconceptions in
>> cygwin and utils.
>> 
>> I'm not entirely thrilled with the fact that configuring and building
>> this from the level above winsup results in lots of compiler command
>> line parameters passed in which are also discerned by macros in
>> acinclude.m4.  If we do end up staying in the src CVS repository I'll
>> have to fix that.
>
>For a start I applied the patch to CVS HEAD and ran a stock `configure;
>make' from toplevel on Fedora 17 with Yaakov's Cygwin packages.
>
>I can't link the Cygwin DLL:
>
>/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -luser32
>/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -lkernel32
>/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -ladvapi32
>/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -lshell32
>collect2: ld returned 1 exit status
>
>I didn't look why it doesn't find these libs.  But this means the
>-nostdlib flag is missing.

AFAIK, it means that the -nostdlib is used and the path to the libraries
isn't right.  It is when you specify the windows library path
explicitly.  This should be fixed now.  Finding the path to where the
linker locates libraries turned out to be harder than it first appeared.

>If I add it I get a lot of messages pointing out missing symbols,
>though:
>
>.../cygtls.h:301: undefined reference to `__Unwind_Resume'
>.../bsdlib.o:bsdlib.cc:(.eh_frame+0x12): undefined reference to
>`___gxx_personality_v0' [...]
>
>After a bit of digging I found that the -fno-rtti -fno-exceptions flags
>are missing when building the C++ source files.

Thanks for tracking this down.  That was part of an overaggressive
purging of Makefile.common.  I don't know why I wouldn't be seeing this
when building with nonstandard library locations though.

>When building cygserver stuff, the flags -mno-use-libstdc-wrappers
>-fno-rtti -fno-exceptions are missing, too.

-fno-rtti and -fno-exceptions are expected given the above.  AFAICT,
cygserver hasn't ever set -mno-use-libstdc-wrappers.

>In utils, I get an interesting error when building cygcheck:
>
>  In file included from .../cygcheck.cc:13:0:
>  .../newlib/libc/include/stdio.h:35:20: fatal error: stddef.h: No such file or directory
>
>Newlib?  For a Mingw application?  The compiler instruction actually
>contains the following paths:
>
>  -I${srcdir}/winsup/cygwin \
>  -isystem /usr/i686-pc-cygwin/sys-root/usr/include/w32api \
>  -isystem ${srcdir}/winsup/cygwin/include \
>  -isystem ${srcdir}-pc-cygwin/newlib/targ-include \
>  -isystem ${srcdir}/newlib/libc/include
>
>None of them should be used when building with the Mingw compiler.

Actually, cygcheck.o and path.o need newlib since cygcheck includes
mntent.h and mntent.h uses paths.h which comes from newlib.  It
shouldn't be trying to get stdio.h from newlib though.  That's fixed.

>Btw., why did you remove $(CFLAGS) from the definition of MINGW_CXX?
>I added it just a couple of days ago explicitely to be able to build
>the utils manually with different optimizing settings:

I didn't know it was a recent change but, as I mentioned in my initial
notes, I decoupled CFLAGS and CXXFLAGS when I got rid of our nonstandard
checks for the C compiler.  The change was inadvertent at first but then
I realized that everywhere else in the world those two flags mean two
different things and are meant to control c/c++ compilation.  The fact
that they don't in Cygwin is just because I was either too lazy or too
ignorant when I first set that up.

However, I did add code to Makefile.common so that if you say:

"make CFLAGS=-g" it will remove any optimization from CXXFLAGS as
well.

I have nearly everything working again but I'm surprised to find out
that I can't build dump_setup.o with FC16 installed mingw compilers due
to complaints about missing definitions for:

NT_SUCCESS
OBJ_CASE_INSENSITIVE
InitializeObjectAttributes

I can't build strace.o because of missing definitions for:
ProcessDebugFlags
NtSetInformationProcess

These are not pulled in by winternl.h in the
mingw32-headers-2.0.999-0.5.trunk.20120224.fc17.noarch package but
they do seem to be handled correctly in the versions I downloaded from
the Cygwin repo.

What version of mingw headers are you running that enables you to
compile these packages?  I can't get them to build even in an unpatched
sandbox.

Btw, I believe that these will probably compile correctly if I use the
w32api headers from Yaakov's cygwin cross gcc packages (which was why
things seemed to work for me before) but that's clearly not the right
way to deal with this issue.

cgf
