Return-Path: <cygwin-patches-return-7745-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26507 invoked by alias); 22 Oct 2012 12:24:29 -0000
Received: (qmail 26345 invoked by uid 22791); 22 Oct 2012 12:23:56 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 22 Oct 2012 12:23:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id ED36D2C02AB; Mon, 22 Oct 2012 14:23:44 +0200 (CEST)
Date: Mon, 22 Oct 2012 12:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121022122344.GC2469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com> <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <1350855543.1244.64.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1350855543.1244.64.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00022.txt.bz2

Hi Yaakov,

On Oct 21 16:39, Yaakov (Cygwin/X) wrote:
> On Fri, 2012-10-19 at 11:33 -0500, Yaakov (Cygwin/X) wrote:
> > I'll include those changes and post a new patch then.
> 
> Revised patches for toplevel, winsup, winsup/cygwin, winsup/lsaauth, and
> winsup/utils attached.  Tested on Cygwin and F17 with mingw32-headers
> from rawhide.

The patch looks pretty well for i686.  The only nit I have left is that
the DLL_IMPORTS expression should just use ${shell ...} rather than `...`:

  DLL_IMPORTS:=${shell $(CC) -print-file-name=w32api/libkernel32.a} ${shell $(CC) -print-file-name=w32api/libntdll.a}

The lsaauth changes still give me a tiny little bit of headache, but
it's certainly an improvement over the current state, so we take it
as is and improve it when the time is ripe.

I also tested the patch in the 64 bit branch with a 64 bit compiler,
which uncovered two problems which were not visible before:

- AC_NO_EXECUTABLES is missing in doc/configure.in, lsaauth/configure.in
  and utils/configure.in.  Without this, configure tries to link with
  the target compiler, but that's not possible during bootstrap.

- OTOH, AC_NO_EXECUTABLES disables any linkage tests, so the LIBICONV
  test in utils/configure.in has to be replaced or go away.  In my below
  patch I opted for "go away".  I just replaced it by -liconv in
  Makefile.in:

Index: Makefile.in
[...]
 # Check for dumper's requirements and enable it if found.
-LIBICONV := @libiconv@
 libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
 libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
 bfdlink	 := $(shell ${CC} -xc /dev/null -o /dev/null -c -B${bupdir2}/bfd/ -include bfd.h 2>&1)
-build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" -a -z "${bfdlink}" && echo 1}
+build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -z "${bfdlink}" && echo 1}
 ifdef build_dumper
 CYGWIN_BINS += dumper.exe
 dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty -lz
+dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty -liconv -liberty -lz
 else
 all: warn_dumper
 endif
[...]
 warn_dumper:
 	@echo '*** Not building dumper.exe since some required libraries or'
 	@echo '*** or headers are missing.  Potential candidates are:'
-	@echo '***   bfd.h, libbfd.a, libiconv.a, or libintl.a'
+	@echo '***   bfd.h, libbfd.a, or libintl.a'
 	@echo '*** If you need this program, check out the naked-bfd and naked-intl'
 	@echo '*** sources from sourceware.org.  Then, configure and build these'
 	@echo '*** libraries.  Otherwise, you can safely ignore this warning.'
Index: configure.in
[...]
 AC_ARG_PROGRAM
 
-AC_CHECK_LIB(iconv, libiconv, libiconv=-liconv)
-AC_SUBST(libiconv)
-
 INSTALL="/bin/sh "`cd $srcdir/../..; echo $(pwd)/install-sh -c`
[...]

If the original patch with the aforementioned changes is ok with
everybody, I'd apply it asap and remove lsaauth/cyglsa64.dll,
lsaauth/make-64bit-version-with-mingw-w64.sh, and utils/mingw.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
