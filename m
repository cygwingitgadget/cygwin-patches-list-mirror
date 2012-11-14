Return-Path: <cygwin-patches-return-7784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26553 invoked by alias); 14 Nov 2012 20:11:16 -0000
Received: (qmail 26408 invoked by uid 22791); 14 Nov 2012 20:10:59 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 14 Nov 2012 20:10:52 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E0C4B2C00B1; Wed, 14 Nov 2012 21:10:47 +0100 (CET)
Date: Wed, 14 Nov 2012 20:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Try #3 for changes to Cygwin configure
Message-ID: <20121114201047.GD13931@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121113000257.GA13261@ednor.casa.cgf.cx> <20121113033105.GA24866@ednor.casa.cgf.cx> <20121113093301.GA23491@calimero.vinschen.de> <20121113173900.GA13846@ednor.casa.cgf.cx> <20121113183414.GA12388@ednor.casa.cgf.cx> <20121113184732.GB27964@calimero.vinschen.de> <20121113210739.GA22535@ednor.casa.cgf.cx> <20121114033958.GA16881@ednor.casa.cgf.cx> <20121114115707.GC27964@calimero.vinschen.de> <20121114190837.GA31576@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121114190837.GA31576@ednor.casa.cgf.cx>
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
X-SW-Source: 2012-q4/txt/msg00061.txt.bz2

On Nov 14 14:08, Christopher Faylor wrote:
> On Wed, Nov 14, 2012 at 12:57:07PM +0100, Corinna Vinschen wrote:
> >For a start I applied the patch to CVS HEAD and ran a stock `configure;
> >make' from toplevel on Fedora 17 with Yaakov's Cygwin packages.
> >
> >I can't link the Cygwin DLL:
> >
> >/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -luser32
> >/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -lkernel32
> >/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -ladvapi32
> >/usr/lib64/gcc/i686-pc-cygwin/4.5.3/../../../../i686-pc-cygwin/bin/ld: cannot find -lshell32
> >collect2: ld returned 1 exit status
> >
> >I didn't look why it doesn't find these libs.  But this means the
> >-nostdlib flag is missing.
> 
> AFAIK, it means that the -nostdlib is used and the path to the libraries
> isn't right.

Weird.  The above libs are pulled in via the *lib: directive in the
gcc specs file.  They are in the default lib search path and they
definitely exist.  And no, when it fails there is no -nostdlib in
the compiler directive:

  i686-pc-cygwin-c++ \
    -L${builddir}/i686-pc-cygwin/winsup/cygwin \
    -isystem ${srcdir}/winsup/cygwin/include \
    -B${builddir}/i686-pc-cygwin/newlib/ \
    -isystem ${builddir}/i686-pc-cygwin/newlib/targ-include \
    -isystem ${srcdir}/newlib/libc/include    \
    -g -O2 \
    -L${builddir}/i686-pc-cygwin/winsup/cygwin \
    -Wl,--gc-sections  \
    -Wl,-T${srcdir}/winsup/cygwin/cygwin.sc \
    -static \
    -Wl,--heap=0 -Wl,--out-implib,cygdll.a -shared -o cygwin0.dll \
    -e _dll_entry@12 cygwin.def
    <...lots of .o files>
    ${builddir}/i686-pc-cygwin/winsup/cygserver/libcygserver.a \
    ${builddir}/i686-pc-cygwin/newlib/libm/libm.a \
    ${builddir}/i686-pc-cygwin/newlib/libc/libc.a \
    -lgcc \
    /usr/i686-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a \
    /usr/i686-pc-cygwin/sys-root/usr/lib/w32api/libntdll.a \
    -Wl,-Map,cygwin.map

I don't see anything in there which would explain why the default lib
search path isn't searched.

> >When building cygserver stuff, the flags -mno-use-libstdc-wrappers
> >-fno-rtti -fno-exceptions are missing, too.
> 
> -fno-rtti and -fno-exceptions are expected given the above.  AFAICT,
> cygserver hasn't ever set -mno-use-libstdc-wrappers.

You're right.  Wrong conclusion without testing, sorry.

> >In utils, I get an interesting error when building cygcheck:
> >
> >  In file included from .../cygcheck.cc:13:0:
> >  .../newlib/libc/include/stdio.h:35:20: fatal error: stddef.h: No such file or directory
> >
> >Newlib?  For a Mingw application?  The compiler instruction actually
> >contains the following paths:
> >
> >  -I${srcdir}/winsup/cygwin \
> >  -isystem /usr/i686-pc-cygwin/sys-root/usr/include/w32api \
> >  -isystem ${srcdir}/winsup/cygwin/include \
> >  -isystem ${srcdir}-pc-cygwin/newlib/targ-include \
> >  -isystem ${srcdir}/newlib/libc/include
> >
> >None of them should be used when building with the Mingw compiler.
> 
> Actually, cygcheck.o and path.o need newlib since cygcheck includes
> mntent.h and mntent.h uses paths.h which comes from newlib.  It
> shouldn't be trying to get stdio.h from newlib though.  That's fixed.

Ouch!  That's a bug.  Building the native utils with the Mingw compiler
should not need any of the above paths, and quite certainly not access
any newlib headers.  I'd rather like to propose the following patch to
mntent.h and get rid of all of the above paths:

Index: include/mntent.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/mntent.h,v
retrieving revision 1.7
diff -u -p -r1.7 mntent.h
--- include/mntent.h	18 Jul 2012 11:17:25 -0000	1.7
+++ include/mntent.h	14 Nov 2012 19:52:28 -0000
@@ -15,8 +15,6 @@ details. */
 extern "C" {
 #endif
 
-#include <paths.h>
-
 struct mntent
 {
   char *mnt_fsname;
@@ -35,6 +33,10 @@ struct mntent *getmntent_r (FILE *, stru
 int endmntent (FILE *__filep);
 #endif
 
+#ifdef __CYGWIN__
+
+#include <paths.h>
+
 /* The following two defines are deprecated.  Use the equivalent
    names from paths.h instead. */
 #ifndef MNTTAB
@@ -48,6 +50,8 @@ int endmntent (FILE *__filep);
 #define MOUNTED _PATH_MOUNTED
 #endif
 
+#endif /* __CYGWIN__ */
+
 #ifdef __cplusplus
 };
 #endif

> However, I did add code to Makefile.common so that if you say:
> 
> "make CFLAGS=-g" it will remove any optimization from CXXFLAGS as
> well.

Thanks.  It's just that... I usually use this the other way around.
The dir is built with CFLAGS/CXXFLAGS=-g and then I call make like
this for some optimization testing:

  make CFLAGS='-g -O2'   :}

> I have nearly everything working again but I'm surprised to find out
> that I can't build dump_setup.o with FC16 installed mingw compilers due

Do you mean F17?  F16 only came with the old mingw32 stuff.

> to complaints about missing definitions for:
> 
> NT_SUCCESS
> OBJ_CASE_INSENSITIVE
> InitializeObjectAttributes
> 
> I can't build strace.o because of missing definitions for:
> ProcessDebugFlags
> NtSetInformationProcess
> 
> These are not pulled in by winternl.h in the
> mingw32-headers-2.0.999-0.5.trunk.20120224.fc17.noarch package but
> they do seem to be handled correctly in the versions I downloaded from
> the Cygwin repo.

This is an old package.  The current F17 version of this package is

  mingw32-headers-2.0.999-0.8.trunk.20121016.fc17.noarch

and this package is practically equivalent to Yaakov's package for Cygwin.
It's also the required package to build Cygwin since it's the first package
which contains all changes I applied to mingw64.

> What version of mingw headers are you running that enables you to
> compile these packages?  I can't get them to build even in an unpatched
> sandbox.

See above.  I'm using latest
mingw32-headers-2.0.999-0.8.trunk.20121016.fc17.noarch
and mingw32-crt-2.0.999-0.13.trunk.20121016.fc17.noarch packages.

> Btw, I believe that these will probably compile correctly if I use the
> w32api headers from Yaakov's cygwin cross gcc packages (which was why
> things seemed to work for me before) but that's clearly not the right
> way to deal with this issue.

Indeed.  You just have to update to the latest F17 packages.  I'm sorry
for the hassle you're going through, but the changes are still pretty
fresh, so there were some problems to be expected.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
