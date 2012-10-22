Return-Path: <cygwin-patches-return-7747-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1293 invoked by alias); 22 Oct 2012 15:01:23 -0000
Received: (qmail 1207 invoked by uid 22791); 22 Oct 2012 15:01:04 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 22 Oct 2012 15:00:55 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 474582C02AB; Mon, 22 Oct 2012 17:00:52 +0200 (CEST)
Date: Mon, 22 Oct 2012 15:01:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
Message-ID: <20121022150052.GF2469@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20121017164440.GA12989@ednor.casa.cgf.cx> <20121017170514.GD10578@calimero.vinschen.de> <20121017193258.GA15271@ednor.casa.cgf.cx> <1350545597.3492.59.camel@YAAKOV04> <20121018083419.GC6221@calimero.vinschen.de> <1350580828.3492.73.camel@YAAKOV04> <20121019092135.GA22432@calimero.vinschen.de> <1350664438.3492.114.camel@YAAKOV04> <1350855543.1244.64.camel@YAAKOV04> <20121022122344.GC2469@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20121022122344.GC2469@calimero.vinschen.de>
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
X-SW-Source: 2012-q4/txt/msg00024.txt.bz2

On Oct 22 14:23, Corinna Vinschen wrote:
> - OTOH, AC_NO_EXECUTABLES disables any linkage tests, so the LIBICONV
>   test in utils/configure.in has to be replaced or go away.  In my below
>   patch I opted for "go away".  I just replaced it by -liconv in
>   Makefile.in:

On (YA) second thought, maybe it would be better to use a
--print-file-name test for libiconv as well?

Index: utils/Makefile.in
===================================================================
[...]
@@ -83,21 +80,20 @@ strace.exe: MINGW_LDFLAGS += -lntdll
 ldd.exe: ALL_LDFLAGS += -lpsapi
 pldd.exe: ALL_LDFLAGS += -lpsapi
 
-ldh.exe: MINGW_LDLIBS :=
 ldh.exe: MINGW_LDFLAGS := -nostdlib -lkernel32
 
 # Check for dumper's requirements and enable it if found.
-LIBICONV := @libiconv@
 libbfd   := ${shell $(CC) -B$(bupdir2)/bfd/ --print-file-name=libbfd.a}
 libintl  := ${shell $(CC) -B$(bupdir2)/intl/ --print-file-name=libintl.a}
+libiconv  := ${shell $(CC) --print-file-name=libiconv.a}
 bfdlink	 := $(shell ${CC} -xc /dev/null -o /dev/null -c -B${bupdir2}/bfd/ -include bfd.h 2>&1)
-build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -n "$(LIBICONV)" -a -z "${bfdlink}" && echo 1}
+build_dumper := ${shell test -r $(libbfd) -a -r $(libintl) -a -r $(libiconv) -a -z "${bfdlink}" && echo 1}
 ifdef build_dumper
 CYGWIN_BINS += dumper.exe
 dumper.o module_info.o parse_pe.o: CXXFLAGS += -I$(bupdir2)/bfd -I$(updir1)/include
 dumper.o parse_pe.o: dumper.h
 dumper.exe: module_info.o parse_pe.o
-dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty $(LIBICONV) -liberty -lz
+dumper.exe: ALL_LDFLAGS += ${libbfd} ${libintl} -L$(bupdir1)/libiberty ${libiconv} -liberty -lz
 else
 all: warn_dumper
 endif
[...]


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
