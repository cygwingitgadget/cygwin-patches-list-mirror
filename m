Return-Path: <cygwin-patches-return-7819-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30286 invoked by alias); 20 Feb 2013 21:37:02 -0000
Received: (qmail 30188 invoked by uid 22791); 20 Feb 2013 21:37:00 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_YG
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f170.google.com (HELO mail-ia0-f170.google.com) (209.85.210.170)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 Feb 2013 21:36:56 +0000
Received: by mail-ia0-f170.google.com with SMTP id k20so7752918iak.29        for <cygwin-patches@cygwin.com>; Wed, 20 Feb 2013 13:36:56 -0800 (PST)
X-Received: by 10.50.208.40 with SMTP id mb8mr5277268igc.91.1361396215901;        Wed, 20 Feb 2013 13:36:55 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ur12sm17172693igb.8.2013.02.20.13.36.54        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Wed, 20 Feb 2013 13:36:55 -0800 (PST)
Date: Wed, 20 Feb 2013 21:37:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH] utils: force static linkage
Message-ID: <20130220153103.48a3a6d5@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/66+FX6xCR/GGg=fpgL_2YSx"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00030.txt.bz2


--MP_/66+FX6xCR/GGg=fpgL_2YSx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 663

Last time I checked, we were linking all utils statically, so this
caught me by surprise:

$ /bin/ldd dumper.exe 
	ntdll.dll => /cygdrive/c/Windows/SysWOW64/ntdll.dll (0x77d70000)
	kernel32.dll => /cygdrive/c/Windows/syswow64/kernel32.dll (0x75a50000)
	KERNELBASE.dll => /cygdrive/c/Windows/syswow64/KERNELBASE.dll (0x76ef0000)
	cygwin1.dll => /usr/bin/cygwin1.dll (0x61000000)
	cygintl-8.dll => /usr/bin/cygintl-8.dll (0x49bd0000)
	cygiconv-2.dll => /usr/bin/cygiconv-2.dll (0x6bfb0000)
	??? => ??? (0x550000)

The -static flag implies -static-libgcc (see gcc -dumpspecs) and affects
all other libraries (including libstdc++).  Patch for HEAD attached.


Yaakov

--MP_/66+FX6xCR/GGg=fpgL_2YSx
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=utils-static.patch
Content-length: 1356

2013-02-20  Yaakov Selkowitz  <yselkowitz@...>

	* Makefile.in (CYGWIN_LDFLAGS): Replace -static-lib* with -static.
	(MINGW_LDFLAGS): Ditto.
	(ZLIB): Simplify accordingly.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/utils/Makefile.in,v
retrieving revision 1.109
diff -u -p -r1.109 Makefile.in
--- Makefile.in	21 Jan 2013 16:28:27 -0000	1.109
+++ Makefile.in	20 Feb 2013 21:19:54 -0000
@@ -49,7 +49,7 @@ EXEEXT_FOR_BUILD:=@EXEEXT_FOR_BUILD@
 .PHONY: all install clean realclean warn_dumper warn_cygcheck_zlib
 
 LDLIBS := -lnetapi32 -ladvapi32 -lkernel32 -luser32
-CYGWIN_LDFLAGS := -static-libgcc -static-libstdc++ -Wl,--enable-auto-import -L${WINDOWS_LIBDIR} $(LDLIBS)
+CYGWIN_LDFLAGS := -static -Wl,--enable-auto-import -L${WINDOWS_LIBDIR} $(LDLIBS)
 DEP_LDLIBS := $(cygwin_build)/libcygwin.a
 
 MINGW_CXX      := @MINGW_CXX@
@@ -67,10 +67,10 @@ MINGW_BINS := ${addsuffix .exe,cygcheck 
 # list will will be compiled in Cygwin mode implicitly, so there is no
 # need for a CYGWIN_OBJS.
 MINGW_OBJS := bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
-MINGW_LDFLAGS:=-L${WINDOWS_LIBDIR} -static-libgcc -static-libstdc++
+MINGW_LDFLAGS:=-L${WINDOWS_LIBDIR} -static
 
 CYGCHECK_OBJS:=cygcheck.o bloda.o path.o dump_setup.o
-ZLIB:=-Wl,-dn,-lz,-dy
+ZLIB:=-lz
 
 .PHONY: all
 all:

--MP_/66+FX6xCR/GGg=fpgL_2YSx--
