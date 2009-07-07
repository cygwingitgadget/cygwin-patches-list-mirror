Return-Path: <cygwin-patches-return-6556-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23243 invoked by alias); 7 Jul 2009 16:10:06 -0000
Received: (qmail 23123 invoked by uid 22791); 7 Jul 2009 16:10:00 -0000
X-SWARE-Spam-Status: No, hits=-0.6 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_32,J_CHICKENPOX_63,J_CHICKENPOX_64,J_CHICKENPOX_72,SARE_URI_CONS7,SPF_PASS,URI_NOVOWEL
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f213.google.com (HELO mail-ew0-f213.google.com) (209.85.219.213)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 16:09:51 +0000
Received: by ewy9 with SMTP id 9so5520458ewy.2         for <cygwin-patches@cygwin.com>; Tue, 07 Jul 2009 09:09:47 -0700 (PDT)
Received: by 10.210.53.5 with SMTP id b5mr3886029eba.51.1246982987731;         Tue, 07 Jul 2009 09:09:47 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm3897100eyg.37.2009.07.07.09.09.46         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Jul 2009 09:09:47 -0700 (PDT)
Message-ID: <4A537645.1070004@gmail.com>
Date: Tue, 07 Jul 2009 16:10:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] Libstdc++ support changes.
Content-Type: multipart/mixed;  boundary="------------080501050105020500040701"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00010.txt.bz2

This is a multi-part message in MIME format.
--------------080501050105020500040701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 4826


    Hi all,

  I just got done doing a C/C++/libstdc++-v3 test run against GCC HEAD using
the Cygwin DLL built with these patches, and everything worked.  In
particular, it passed these tests:

> FAIL: g++.old-deja/g++.abi/cxa_vec.C execution test
> FAIL: g++.old-deja/g++.brendan/new3.C execution test

... which fail on current 4.3.2-2 using shared libstdc++ DLL precisely because
they expect to be able to interpose libstdc++'s own internal calls to the
allocation operators.  I've also been using it in daily use (and before that,
the previous spin of this patch) for a while now and nothing unusual has been
showing up.

  I'm now busy packaging a version of gcc-4.3.3 that will incorporate the
necessary support to make this work, and though that'll be another few days
testing, it's not going to need anything different by way of support from the
Cygwin DLL, so I reckon this is ready for primetime.

  Re: the last outstanding issues we discussed; I decided not to try and fold
the malloc handling into this.  The malloc wrappers work without needing
compiler support, and we can do that because we are the libc and we own
malloc.  That isn't the same as for the C++ operators, and I don't think we
should conflate parts of libstdc++ into the Cygwin DLL.  For that reason, I
figured we shouldn't export ONDEE directly, even weakly, and that leaves us
just the option of ld wrappers.  Given that C++ is big and complex and
requires the whole toolchain to be aware anyway, I think that's an acceptable
compromise, but malloc and friends are plain old C and someone might even want
to call them from assembly, and I didn't see it was worth adding complexity
and fragility.

  The second idea was representing the pointers as an array somehow to make
extending it in future easier.  I had a quick go, but it gets pretty ugly
pretty quickly when you try and union them against an array of PVOIDs or
whatever, because you can't statically initialise a union, so you end up only
declaring the struct and then having to cast it to a union in other places.  I
 don't suppose extending this mechanism in future is terribly likely; it
exists to support the requirements of the C++ spec, and that's not likely to
start specifying any new function replacements anytime foreseeable.

winsup/ChangeLog:

	* Makefile.common (COMPILE_CXX):  Add support for per-file overrides
	to exclude $(nostdinc) and $(nostdincxx) from compiler flags.
	(COMPILE_CC):  Likewise for $(nostdinc).

winsup/cygwin/ChangeLog:

	* Makefile.in (DLL_OFILES):  Add libstdcxx_wrapper.o
	(libstdcxx_wrapper_CFLAGS):  Add flags for new module.
	(_cygwin_crt0_common_STDINCFLAGS):  Define per-file override.
	(libstdcxx_wrapper_STDINCFLAGS, cxx_STDINCFLAGS):  Likewise.
	* cxx.cc:  Include "cygwin-cxx.h".
	(operator new):  Tweak prototype for full standards compliance.
	(operator new[]):  Likewise.
	(operator new (nothrow)):  New fallback function.
	(operator new[] (nothrow), operator delete (nothrow),
	operator delete[] (nothrow)):  Likewise.
	(default_cygwin_cxx_malloc):  New struct of pointers to the above,
	for final last-resort fallback default.
	* cygwin-cxx.h:  New file.
	(struct per_process_cxx_malloc):  Define.
	(default_cygwin_cxx_malloc):  Declare extern.
	* cygwin.din (__wrap__ZdaPv):  Export new wrapper.
	(__wrap__ZdaPvRKSt9nothrow_t, __wrap__ZdlPv,
	__wrap__ZdlPvRKSt9nothrow_t, __wrap__Znaj,
	__wrap__ZnajRKSt9nothrow_t, __wrap__Znwj,
	__wrap__ZnwjRKSt9nothrow_t):  Likewise.
	* globals.cc (__cygwin_user_data):  Init newly-repurposed 'forkee'
	field (now 'cxx_malloc') to point to default_cygwin_cxx_malloc.
	* libstdcxx_wrapper.cc:  New file.
	(__wrap__ZdaPv, __wrap__ZdaPvRKSt9nothrow_t, __wrap__ZdlPv,
	__wrap__ZdlPvRKSt9nothrow_t, __wrap__Znaj,
	__wrap__ZnajRKSt9nothrow_t, __wrap__Znwj,
	__wrap__ZnwjRKSt9nothrow_t):  Define wrapper functions for libstdc++
	malloc operators and their overrides.
	* winsup.h (default_cygwin_cxx_malloc):  Declare extern.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR):  Bump.
	* include/sys/cygwin.h (struct per_process_cxx_malloc):  Forward
	declare here.
	(struct per_process::forkee):  Rename and repurpose from this ...
	(struct per_process::cxx_malloc):  ... to this.
	* lib/_cygwin_crt0_common.cc:  Include cygwin-cxx.h.
	(WEAK):  Define shorthand helper macro.
	(__cygwin_cxx_malloc):  Define and populate with weak references
	to whatever libstdc++ malloc operators will be visible at final
	link time for Cygwin apps and dlls.
	(_cygwin_crt0_common):  Always look up cygwin DLL's internal
	per_process data, and don't test for (impossible) failure.  Inherit
	any members of __cygwin_cxx_malloc that we don't have overrides
	for from the DLL's default and store the resulting overall set of
	overrides back into the DLL's global per_process data.

  Ok?

    cheers,
      DaveK


--------------080501050105020500040701
Content-Type: text/x-c;
 name="cygwin-dll-libstdcxx-wrappers-final.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-dll-libstdcxx-wrappers-final.diff"
Content-length: 17890

? newlib/autom4te.cache
Index: winsup/Makefile.common
===================================================================
RCS file: /cvs/src/src/winsup/Makefile.common,v
retrieving revision 1.55
diff -p -u -r1.55 Makefile.common
--- winsup/Makefile.common	11 Oct 2005 18:17:59 -0000	1.55
+++ winsup/Makefile.common	7 Jul 2009 15:21:56 -0000
@@ -130,9 +130,9 @@ ifeq (,${findstring $(gcc_libdir),$(CFLA
 GCC_INCLUDE:=${subst //,/,-I$(gcc_libdir)/include}
 endif
 
-COMPILE_CXX=$(CXX) $c $(nostdincxx) $(nostdinc) $(ALL_CXXFLAGS) $(GCC_INCLUDE) \
-	     -fno-rtti -fno-exceptions
-COMPILE_CC=$(CC) $c $(nostdinc) $(ALL_CFLAGS) $(GCC_INCLUDE)
+COMPILE_CXX=$(CXX) $c $(if $($(*F)_STDINCFLAGS),,$(nostdincxx) $(nostdinc)) \
+	     $(ALL_CXXFLAGS) $(GCC_INCLUDE) -fno-rtti -fno-exceptions
+COMPILE_CC=$(CC) $c $(if $($(*F)_STDINCFLAGS),,$(nostdinc)) $(ALL_CFLAGS) $(GCC_INCLUDE)
 
 vpath %.a	$(cygwin_build):$(w32api_lib):$(newlib_build)/libc:$(newlib_build)/libm
 
Index: winsup/cygwin/Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.227
diff -p -u -r1.227 Makefile.in
--- winsup/cygwin/Makefile.in	6 Jul 2009 23:19:08 -0000	1.227
+++ winsup/cygwin/Makefile.in	7 Jul 2009 15:21:56 -0000
@@ -145,9 +145,9 @@ DLL_OFILES:=assert.o autoload.o bsdlib.o
 	fhandler_termios.o fhandler_tty.o fhandler_virtual.o fhandler_windows.o \
 	fhandler_zero.o flock.o fnmatch.o fork.o fts.o ftw.o getopt.o glob.o \
 	glob_pattern_p.o globals.o grp.o heap.o hookapi.o inet_addr.o inet_network.o \
-	init.o ioctl.o ipc.o kernel32.o localtime.o lsearch.o malloc_wrapper.o \
-	minires-os-if.o minires.o miscfuncs.o mktemp.o mmap.o msg.o mount.o \
-	net.o netdb.o nfs.o nftw.o ntea.o passwd.o path.o pinfo.o pipe.o \
+	init.o ioctl.o ipc.o kernel32.o libstdcxx_wrapper.o localtime.o lsearch.o \
+	malloc_wrapper.o minires-os-if.o minires.o miscfuncs.o mktemp.o mmap.o msg.o \
+	mount.o net.o netdb.o nfs.o nftw.o ntea.o passwd.o path.o pinfo.o pipe.o \
 	poll.o posix_ipc.o pthread.o random.o regcomp.o regerror.o regexec.o \
 	regfree.o registry.o resource.o rexec.o rcmd.o scandir.o sched.o \
 	sec_acl.o sec_auth.o sec_helper.o security.o select.o sem.o \
@@ -268,6 +268,7 @@ fhandler_windows_CFLAGS:=-fomit-frame-po
 fhandler_zero_CFLAGS:=-fomit-frame-pointer
 flock_CFLAGS:=-fomit-frame-pointer
 grp_CFLAGS:=-fomit-frame-pointer
+libstdcxx_wrapper_CFLAGS:=-fomit-frame-pointer
 malloc_CFLAGS:=-fomit-frame-pointer
 malloc_wrapper_CFLAGS:=-fomit-frame-pointer
 miscfuncs_CFLAGS:=-fomit-frame-pointer
@@ -285,6 +286,10 @@ sysconf_CFLAGS:=-fomit-frame-pointer
 uinfo_CFLAGS:=-fomit-frame-pointer
 endif
 
+_cygwin_crt0_common_STDINCFLAGS:=yes
+libstdcxx_wrapper_STDINCFLAGS:=yes
+cxx_STDINCFLAGS:=yes
+
 .PHONY: all force dll_ofiles install all_target install_target all_host install_host \
 	install install-libs install-headers
 
Index: winsup/cygwin/cxx.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cxx.cc,v
retrieving revision 1.4
diff -p -u -r1.4 cxx.cc
--- winsup/cygwin/cxx.cc	3 Jan 2009 05:12:20 -0000	1.4
+++ winsup/cygwin/cxx.cc	7 Jul 2009 15:21:56 -0000
@@ -11,9 +11,14 @@ details. */
 #if (__GNUC__ >= 3)
 
 #include "winsup.h"
+#include "cygwin-cxx.h"
+
+/* These implementations of operators new and delete are used internally by
+   the DLL, and are kept separate from the user's/libstdc++'s versions by
+   use of LD's --wrap option.  */
 
 void *
-operator new (size_t s)
+operator new (std::size_t s)
 {
   void *p = calloc (1, s);
   return p;
@@ -26,7 +31,7 @@ operator delete (void *p)
 }
 
 void *
-operator new[] (size_t s)
+operator new[] (std::size_t s)
 {
   return ::operator new (s);
 }
@@ -37,6 +42,34 @@ operator delete[] (void *p)
   ::operator delete (p);
 }
 
+/* Nothrow versions, provided only for completeness in the fallback array.  */
+
+void *
+operator new (std::size_t s, const std::nothrow_t &)
+{
+  void *p = calloc (1, s);
+  return p;
+}
+
+void
+operator delete (void *p, const std::nothrow_t &)
+{
+  free (p);
+}
+
+void *
+operator new[] (std::size_t s, const std::nothrow_t &nt)
+{
+  return ::operator new (s, nt);
+}
+
+void
+operator delete[] (void *p, const std::nothrow_t &nt)
+{
+  ::operator delete (p, nt);
+}
+
+
 extern "C" void
 __cxa_pure_virtual (void)
 {
@@ -52,4 +85,21 @@ extern "C" void
 __cxa_guard_release ()
 {
 }
+
+/* These routines are made available as last-resort fallbacks
+   for the application.  Should not be used in practice.  */
+
+struct per_process_cxx_malloc default_cygwin_cxx_malloc = 
+{
+  &(operator new),
+  &(operator new[]),
+  &(operator delete),
+  &(operator delete[]),
+  &(operator new),
+  &(operator new[]),
+  &(operator delete),
+  &(operator delete[]),
+};
+
+
 #endif
Index: winsup/cygwin/cygwin-cxx.h
===================================================================
RCS file: winsup/cygwin/cygwin-cxx.h
diff -N winsup/cygwin/cygwin-cxx.h
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ winsup/cygwin/cygwin-cxx.h	7 Jul 2009 15:21:56 -0000
@@ -0,0 +1,37 @@
+/* cygwin-cxx.h
+
+   Copyright 2009 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#ifndef _CYGWIN_CXX_H
+#define _CYGWIN_CXX_H
+
+#ifndef __cplusplus
+#error This header should not be included by C source files.
+#endif
+
+/* Files including this header must override -nostdinc++ */
+#include <new>
+
+/* This is an optional struct pointed to by per_process if it exists.  */
+struct per_process_cxx_malloc
+{
+  void *(*oper_new) (std::size_t);
+  void *(*oper_new__) (std::size_t);
+  void (*oper_delete) (void *);
+  void (*oper_delete__) (void *);
+  void *(*oper_new_nt) (std::size_t, const std::nothrow_t &);
+  void *(*oper_new___nt) (std::size_t, const std::nothrow_t &);
+  void (*oper_delete_nt) (void *, const std::nothrow_t &);
+  void (*oper_delete___nt) (void *, const std::nothrow_t &);
+};
+
+/* Defined in cxx.cc  */
+extern struct per_process_cxx_malloc default_cygwin_cxx_malloc;
+
+#endif /* _CYGWIN_CXX_H */
Index: winsup/cygwin/cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.213
diff -p -u -r1.213 cygwin.din
--- winsup/cygwin/cygwin.din	3 Jul 2009 13:01:16 -0000	1.213
+++ winsup/cygwin/cygwin.din	7 Jul 2009 15:21:57 -0000
@@ -1808,3 +1808,11 @@ y1 NOSIGFE
 y1f NOSIGFE
 yn NOSIGFE
 ynf NOSIGFE
+__wrap__ZdaPv NOSIGFE               # void operator delete[](void *p) throw()
+__wrap__ZdaPvRKSt9nothrow_t NOSIGFE # void operator delete[](void *p, const std::nothrow_t &nt) throw()
+__wrap__ZdlPv NOSIGFE               # void operator delete(void *p) throw()
+__wrap__ZdlPvRKSt9nothrow_t NOSIGFE # void operator delete(void *p, const std::nothrow_t &nt) throw()
+__wrap__Znaj NOSIGFE                # void *operator new[](std::size_t sz) throw (std::bad_alloc)
+__wrap__ZnajRKSt9nothrow_t NOSIGFE  # void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
+__wrap__Znwj NOSIGFE                # void *operator new(std::size_t sz) throw (std::bad_alloc)
+__wrap__ZnwjRKSt9nothrow_t NOSIGFE  # void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
Index: winsup/cygwin/globals.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/globals.cc,v
retrieving revision 1.2
diff -p -u -r1.2 globals.cc
--- winsup/cygwin/globals.cc	24 Mar 2009 12:18:34 -0000	1.2
+++ winsup/cygwin/globals.cc	7 Jul 2009 15:21:57 -0000
@@ -98,7 +98,7 @@ extern "C"
    /* premain */ {NULL, NULL, NULL, NULL},
    /* run_ctors_p */ 0,
    /* unused */ {0, 0, 0, 0, 0, 0, 0},
-   /* UNUSED forkee */ 0,
+   /* cxx_malloc */ &default_cygwin_cxx_malloc,
    /* hmodule */ NULL,
    /* api_major */ CYGWIN_VERSION_API_MAJOR,
    /* api_minor */ CYGWIN_VERSION_API_MINOR,
Index: winsup/cygwin/libstdcxx_wrapper.cc
===================================================================
RCS file: winsup/cygwin/libstdcxx_wrapper.cc
diff -N winsup/cygwin/libstdcxx_wrapper.cc
--- /dev/null	1 Jan 1970 00:00:00 -0000
+++ winsup/cygwin/libstdcxx_wrapper.cc	7 Jul 2009 15:21:57 -0000
@@ -0,0 +1,91 @@
+/* libstdcxx_wrapper.cc
+
+   Copyright 2009 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details.  */
+
+
+/* We provide these stubs to call into a user's
+   provided ONDEE replacement if there is one - otherwise
+   it must fall back to the standard libstdc++ version.
+*/
+
+#include "winsup.h"
+#include "cygwin-cxx.h"
+#include "perprocess.h"
+
+// We are declaring asm names for the functions we define here, as we want
+// to define the wrappers in this file.  GCC links everything with wrappers
+// around the standard C++ memory management operators; these are the wrappers,
+// but we want the compiler to know they are the malloc operators and not have
+// it think they're just any old function matching 'extern "C" _wrap_*'.
+
+extern void *operator new(std::size_t sz) throw (std::bad_alloc)
+			__asm__ ("___wrap__Znwj");
+extern void *operator new[](std::size_t sz) throw (std::bad_alloc)
+			__asm__ ("___wrap__Znaj");
+extern void operator delete(void *p) throw()
+			__asm__ ("___wrap__ZdlPv ");
+extern void operator delete[](void *p) throw()
+			__asm__ ("___wrap__ZdaPv");
+extern void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
+			__asm__ ("___wrap__ZnwjRKSt9nothrow_t");
+extern void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
+			__asm__ ("___wrap__ZnajRKSt9nothrow_t");
+extern void operator delete(void *p, const std::nothrow_t &nt) throw()
+			__asm__ ("___wrap__ZdlPvRKSt9nothrow_t");
+extern void operator delete[](void *p, const std::nothrow_t &nt) throw()
+			__asm__ ("___wrap__ZdaPvRKSt9nothrow_t");
+
+extern void *
+operator new(std::size_t sz) throw (std::bad_alloc)
+{
+  return (*user_data->cxx_malloc->oper_new) (sz);
+}
+
+extern void *
+operator new[](std::size_t sz) throw (std::bad_alloc)
+{
+  return (*user_data->cxx_malloc->oper_new__) (sz);
+}
+
+extern void
+operator delete(void *p) throw()
+{
+  (*user_data->cxx_malloc->oper_delete) (p);
+}
+
+extern void
+operator delete[](void *p) throw()
+{
+  (*user_data->cxx_malloc->oper_delete__) (p);
+}
+
+extern void *
+operator new(std::size_t sz, const std::nothrow_t &nt) throw()
+{
+  return (*user_data->cxx_malloc->oper_new_nt) (sz, nt);
+}
+
+extern void *
+operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
+{
+  return (*user_data->cxx_malloc->oper_new___nt) (sz, nt);
+}
+
+extern void 
+operator delete(void *p, const std::nothrow_t &nt) throw()
+{
+  (*user_data->cxx_malloc->oper_delete_nt) (p, nt);
+}
+
+extern void 
+operator delete[](void *p, const std::nothrow_t &nt) throw()
+{
+  (*user_data->cxx_malloc->oper_delete___nt) (p, nt);
+}
+
Index: winsup/cygwin/winsup.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
retrieving revision 1.228
diff -p -u -r1.228 winsup.h
--- winsup/cygwin/winsup.h	7 Apr 2009 12:13:37 -0000	1.228
+++ winsup/cygwin/winsup.h	7 Jul 2009 15:21:57 -0000
@@ -183,6 +183,9 @@ extern "C" int dll_dllcrt0 (HMODULE, per
 extern "C" int dll_noncygwin_dllcrt0 (HMODULE, per_process *);
 void __stdcall do_exit (int) __attribute__ ((regparm (1), noreturn));
 
+/* libstdc++ malloc operator wrapper support. */
+extern struct per_process_cxx_malloc default_cygwin_cxx_malloc;
+
 /* UID/GID */
 void uinfo_init ();
 
Index: winsup/cygwin/include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.296
diff -p -u -r1.296 version.h
--- winsup/cygwin/include/cygwin/version.h	3 Jul 2009 13:01:17 -0000	1.296
+++ winsup/cygwin/include/cygwin/version.h	7 Jul 2009 15:21:57 -0000
@@ -365,12 +365,13 @@ details. */
       209: Export wordexp, wordfree.
       210: New ctype layout using variable ctype pointer.  Export __ctype_ptr__.
       211: Export fpurge, mkstemps.
+      212: Add and export libstdc++ malloc wrappers.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 211
+#define CYGWIN_VERSION_API_MINOR 212
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: winsup/cygwin/include/sys/cygwin.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
retrieving revision 1.79
diff -p -u -r1.79 cygwin.h
--- winsup/cygwin/include/sys/cygwin.h	16 Jan 2009 12:17:28 -0000	1.79
+++ winsup/cygwin/include/sys/cygwin.h	7 Jul 2009 15:21:57 -0000
@@ -194,6 +194,8 @@ enum
 class MTinterface;
 #endif
 
+struct per_process_cxx_malloc;
+
 struct per_process
 {
   char *initial_sp;
@@ -238,9 +240,8 @@ struct per_process
 
   DWORD unused[7];
 
-  /* Non-zero means the task was forked.  The value is the pid.
-     Inherited from parent. */
-  int forkee;
+  /* Pointers to real operator new/delete functions for forwarding.  */
+  struct per_process_cxx_malloc *cxx_malloc;
 
   HMODULE hmodule;
 
Index: winsup/cygwin/lib/_cygwin_crt0_common.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/lib/_cygwin_crt0_common.cc,v
retrieving revision 1.16
diff -p -u -r1.16 _cygwin_crt0_common.cc
--- winsup/cygwin/lib/_cygwin_crt0_common.cc	3 Jan 2009 05:12:22 -0000	1.16
+++ winsup/cygwin/lib/_cygwin_crt0_common.cc	7 Jul 2009 15:21:57 -0000
@@ -10,6 +10,31 @@ details. */
 
 #include "winsup.h"
 #include "crt0.h"
+#include "cygwin-cxx.h"
+
+// Weaken these declarations so the references don't pull in C++ dependencies unnecessarily.
+#define WEAK __attribute__ ((weak))
+
+// Use asm names to bypass the --wrap that is being applied to redirect all other
+// references to these operators toward the redirectors in the Cygwin DLL; this
+// way we can record what definitions were visible at final link time but still
+// send all calls to the redirectors.
+extern WEAK void *operator new(std::size_t sz) throw (std::bad_alloc)
+			__asm__ ("___real__Znwj");
+extern WEAK void *operator new[](std::size_t sz) throw (std::bad_alloc)
+			__asm__ ("___real__Znaj");
+extern WEAK void operator delete(void *p) throw()
+			__asm__ ("___real__ZdlPv ");
+extern WEAK void operator delete[](void *p) throw()
+			__asm__ ("___real__ZdaPv");
+extern WEAK void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
+			__asm__ ("___real__ZnwjRKSt9nothrow_t");
+extern WEAK void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
+			__asm__ ("___real__ZnajRKSt9nothrow_t");
+extern WEAK void operator delete(void *p, const std::nothrow_t &nt) throw()
+			__asm__ ("___real__ZdlPvRKSt9nothrow_t");
+extern WEAK void operator delete[](void *p, const std::nothrow_t &nt) throw()
+			__asm__ ("___real__ZdaPvRKSt9nothrow_t");
 
 /* Avoid an info message from linker when linking applications. */
 extern __declspec(dllimport) struct _reent *_impure_ptr;
@@ -25,6 +50,14 @@ int main (int, char **, char **);
 int _fmode;
 void _pei386_runtime_relocator ();
 
+struct per_process_cxx_malloc __cygwin_cxx_malloc = 
+{
+  &(operator new), &(operator new[]),
+  &(operator delete), &(operator delete[]),
+  &(operator new), &(operator new[]),
+  &(operator delete), &(operator delete[])
+};
+
 /* Set up pointers to various pieces so the dll can then use them,
    and then jump to the dll.  */
 
@@ -33,16 +66,14 @@ _cygwin_crt0_common (MainFunc f, per_pro
 {
   /* This is used to record what the initial sp was.  The value is needed
      when copying the parent's stack to the child during a fork.  */
-  DWORD newu;
+  per_process *newu = (per_process *) cygwin_internal (CW_USER_DATA);
   int uwasnull;
 
   if (u != NULL)
     uwasnull = 0;	/* Caller allocated space for per_process structure */
-  else if ((newu = cygwin_internal (CW_USER_DATA)) == (DWORD) -1)
-    return 0;
   else
     {
-      u = (per_process *) newu;	/* Using DLL built-in per_process */
+      u = newu;	/* Using DLL built-in per_process */
       uwasnull = 1;	/* Remember for later */
     }
 
@@ -64,8 +95,6 @@ _cygwin_crt0_common (MainFunc f, per_pro
   else
     u->impure_ptr_ptr = &_impure_ptr;	/* Older DLLs need this. */
 
-  u->forkee = 0;			/* This should only be set in dcrt0.cc
-					   when the process is actually forked */
   u->main = f;
 
   /* These functions are executed prior to main.  They are just stubs unless the
@@ -84,6 +113,27 @@ _cygwin_crt0_common (MainFunc f, per_pro
   u->realloc = &realloc;
   u->calloc = &calloc;
 
+  /* Likewise for the C++ memory operators - if any.  */
+  if (newu && newu->cxx_malloc)
+    {
+      /* Inherit what we don't override.  */
+#define CONDITIONALLY_OVERRIDE(MEMBER) \
+      if (!__cygwin_cxx_malloc.MEMBER) \
+	__cygwin_cxx_malloc.MEMBER = newu->cxx_malloc->MEMBER;
+      CONDITIONALLY_OVERRIDE(oper_new);
+      CONDITIONALLY_OVERRIDE(oper_new__);
+      CONDITIONALLY_OVERRIDE(oper_delete);
+      CONDITIONALLY_OVERRIDE(oper_delete__);
+      CONDITIONALLY_OVERRIDE(oper_new_nt);
+      CONDITIONALLY_OVERRIDE(oper_new___nt);
+      CONDITIONALLY_OVERRIDE(oper_delete_nt);
+      CONDITIONALLY_OVERRIDE(oper_delete___nt);
+    }
+
+  /* Now update the resulting set into the global redirectors.  */
+  if (newu)
+    newu->cxx_malloc = &__cygwin_cxx_malloc;
+
   /* Setup the module handle so fork can get the path name. */
   u->hmodule = GetModuleHandle (0);
 

--------------080501050105020500040701--
