Return-Path: <cygwin-patches-return-2700-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4474 invoked by alias); 24 Jul 2002 08:24:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4420 invoked from network); 24 Jul 2002 08:24:20 -0000
Date: Wed, 24 Jul 2002 01:24:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <145518762130.20020724122337@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/cygwin ChangeLog cygwin.din
In-Reply-To: <20020724073803.17255.qmail@sources.redhat.com>
References: <20020724073803.17255.qmail@sources.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q3/txt/msg00148.txt.bz2

Hi!

Wednesday, 24 July, 2002 corinna@cygwin.com corinna@cygwin.com wrote:

ccc> CVSROOT:        /cvs/src
ccc> Module name:    src
ccc> Changes by:     corinna@sources.redhat.com      2002-07-24 00:38:03

ccc> Modified files:
ccc>         winsup/cygwin  : ChangeLog cygwin.din 

ccc> Log message:
ccc>         * cygwin.din (fcloseall): Add symbol for export.
ccc>         (fcloseall_r): Ditto.

How about this? The check is not a panacea, but at least it catches
most typical cases.

2002-07-24  Egor Duda  <deo@logos-m.ru>

        * Makefile.in: Check if API version is updated when exports
        from dll are changed and stop if not so.
        * include/cygwin/version.h: Bump minor API version.

Index: cygwin/Makefile.in
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/Makefile.in,v
retrieving revision 1.96
diff -u -p -2 -r1.96 Makefile.in
--- cygwin/Makefile.in  14 Jul 2002 04:14:32 -0000      1.96
+++ cygwin/Makefile.in  24 Jul 2002 08:15:45 -0000
@@ -145,4 +145,6 @@ NEW_FUNCTIONS:=regcomp posix_regcomp \
               regfree posix_regfree
 
+API_VER:=$(srcdir)/include/cygwin/version.h
+
 PWD:=${shell pwd}
 SUBLIBS:=libpthread.a $(PWD)/libm.a libc.a
@@ -248,5 +250,5 @@ maintainer-clean realclean: clean
 
 # Rule to build cygwin.dll
-new-$(DLL_NAME): $(LDSCRIPT) $(DLL_OFILES) $(DEF_FILE) $(DLL_IMPORTS) $(LIBC) $(LIBM) Makefile winver_stamp
+new-$(DLL_NAME): $(LDSCRIPT) $(DLL_OFILES) $(DEF_FILE) $(DLL_IMPORTS) $(LIBC) $(LIBM) $(API_VER) Makefile winver_stamp
        $(CXX) $(CXXFLAGS) -nostdlib -Wl,-T$(firstword $^) -Wl,--out-implib,cygdll.a -shared -o $@ \
        -e $(DLL_ENTRY) $(DEF_FILE) $(DLL_OFILES) version.o winver.o \
@@ -272,4 +274,8 @@ dll_ofiles: $(DLL_OFILES)
 $(LIBGMON_A): $(GMON_OFILES) $(GMON_START)
        $(AR) rcv $(LIBGMON_A) $(GMON_OFILES)
+
+$(API_VER): $(srcdir)/cygwin.din
+       @echo Error: Version info is older than DLL API!
+       @false
 
 version.cc winver.o: winver_stamp
Index: cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/uberbaum/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.67
diff -u -p -2 -r1.67 version.h
--- cygwin/include/cygwin/version.h     3 Jul 2002 22:25:38 -0000       1.67
+++ cygwin/include/cygwin/version.h     24 Jul 2002 08:15:48 -0000
@@ -153,4 +153,5 @@ details. */
        53: Export strlcat, strlcpy.
        54: Export __fpclassifyd, __fpclassifyf, __signbitd, __signbitf.
+       55: Export fcloseall, fcloseall_r.
      */
 
@@ -158,5 +159,5 @@ details. */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 54
+#define CYGWIN_VERSION_API_MINOR 55
 
      /* There is also a compatibity version number associated with the

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
