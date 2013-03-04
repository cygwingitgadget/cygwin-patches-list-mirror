Return-Path: <cygwin-patches-return-7840-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11905 invoked by alias); 4 Mar 2013 08:12:41 -0000
Received: (qmail 11892 invoked by uid 22791); 4 Mar 2013 08:12:40 -0000
X-SWARE-Spam-Status: No, hits=-4.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,SARE_URI_CONS7,TW_CX,TW_NW,URI_NOVOWEL
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f176.google.com (HELO mail-ia0-f176.google.com) (209.85.210.176)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Mar 2013 08:12:30 +0000
Received: by mail-ia0-f176.google.com with SMTP id i18so4503994iac.35        for <cygwin-patches@cygwin.com>; Mon, 04 Mar 2013 00:12:30 -0800 (PST)
X-Received: by 10.42.128.70 with SMTP id l6mr13159054ics.54.1362384749987;        Mon, 04 Mar 2013 00:12:29 -0800 (PST)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ew5sm9952962igc.2.2013.03.04.00.12.28        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Mon, 04 Mar 2013 00:12:29 -0800 (PST)
Date: Mon, 04 Mar 2013 08:12:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130304021224.381b9ec4@YAAKOV04>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/F5kLHeS52AFoglV/EkYmnPJ"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00051.txt.bz2


--MP_/F5kLHeS52AFoglV/EkYmnPJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Content-length: 293

Corinna,

More fun from our good friend, size_t:

Because operator new (in its various forms) takes a size_t argument, it
is mangled differently on x86_64 above and beyond the common leading
underscore issue.  Patches for winsup/cygwin and gcc (on top of your
latest patch) attached.


Yaakov

--MP_/F5kLHeS52AFoglV/EkYmnPJ
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cygwin-ondee-64bit.patch
Content-length: 3663

2013-03-04  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin64.din: Fix mangled operator new names for size_t==long.
	* libstdcxx_wrapper.cc: Ditto for x86_64.

Index: cygwin64.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Attic/cygwin64.din,v
retrieving revision 1.1.2.9
diff -u -p -r1.1.2.9 cygwin64.din
--- cygwin64.din	25 Feb 2013 12:53:21 -0000	1.1.2.9
+++ cygwin64.din	4 Mar 2013 05:36:54 -0000
@@ -1348,7 +1348,7 @@ __wrap__ZdaPv NOSIGFE               # vo
 __wrap__ZdaPvRKSt9nothrow_t NOSIGFE # void operator delete[](void *p, const std::nothrow_t &nt) throw()
 __wrap__ZdlPv NOSIGFE               # void operator delete(void *p) throw()
 __wrap__ZdlPvRKSt9nothrow_t NOSIGFE # void operator delete(void *p, const std::nothrow_t &nt) throw()
-__wrap__Znaj NOSIGFE                # void *operator new[](std::size_t sz) throw (std::bad_alloc)
-__wrap__ZnajRKSt9nothrow_t NOSIGFE  # void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
-__wrap__Znwj NOSIGFE                # void *operator new(std::size_t sz) throw (std::bad_alloc)
-__wrap__ZnwjRKSt9nothrow_t NOSIGFE  # void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
+__wrap__Znam NOSIGFE                # void *operator new[](std::size_t sz) throw (std::bad_alloc)
+__wrap__ZnamRKSt9nothrow_t NOSIGFE  # void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
+__wrap__Znwm NOSIGFE                # void *operator new(std::size_t sz) throw (std::bad_alloc)
+__wrap__ZnwmRKSt9nothrow_t NOSIGFE  # void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
Index: libstdcxx_wrapper.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libstdcxx_wrapper.cc,v
retrieving revision 1.3.8.1
diff -u -p -r1.3.8.1 libstdcxx_wrapper.cc
--- libstdcxx_wrapper.cc	18 Jan 2013 15:34:11 -0000	1.3.8.1
+++ libstdcxx_wrapper.cc	4 Mar 2013 05:36:54 -0000
@@ -22,19 +22,30 @@ details.  */
    around the standard C++ memory management operators; these are the wrappers,
    but we want the compiler to know they are the malloc operators and not have
    it think they're just any old function matching 'extern "C" _wrap_*'.  */
+#ifdef __x86_64__
+#define MANGLED_ZNWX			"__wrap__Znwm"
+#define MANGLED_ZNAX			"__wrap__Znam"
+#define MANGLED_ZNWX_NOTHROW_T		"__wrap__ZnwmRKSt9nothrow_t"
+#define MANGLED_ZNAX_NOTHROW_T		"__wrap__ZnamRKSt9nothrow_t"
+#else
+#define MANGLED_ZNWX			"___wrap__Znwj"
+#define MANGLED_ZNAX			"___wrap__Znaj"
+#define MANGLED_ZNWX_NOTHROW_T		"___wrap__ZnwjRKSt9nothrow_t"
+#define MANGLED_ZNAX_NOTHROW_T		"___wrap__ZnajRKSt9nothrow_t"
+#endif
 
 extern void *operator new(std::size_t sz) throw (std::bad_alloc)
-			__asm__ (_SYMSTR (__wrap__Znwj));
+			__asm__ (MANGLED_ZNWX);
 extern void *operator new[](std::size_t sz) throw (std::bad_alloc)
-			__asm__ (_SYMSTR (__wrap__Znaj));
+			__asm__ (MANGLED_ZNAX);
 extern void operator delete(void *p) throw()
 			__asm__ (_SYMSTR (__wrap__ZdlPv));
 extern void operator delete[](void *p) throw()
 			__asm__ (_SYMSTR (__wrap__ZdaPv));
 extern void *operator new(std::size_t sz, const std::nothrow_t &nt) throw()
-			__asm__ (_SYMSTR (__wrap__ZnwjRKSt9nothrow_t));
+			__asm__ (MANGLED_ZNWX_NOTHROW_T);
 extern void *operator new[](std::size_t sz, const std::nothrow_t &nt) throw()
-			__asm__ (_SYMSTR (__wrap__ZnajRKSt9nothrow_t));
+			__asm__ (MANGLED_ZNAX_NOTHROW_T);
 extern void operator delete(void *p, const std::nothrow_t &nt) throw()
 			__asm__ (_SYMSTR (__wrap__ZdlPvRKSt9nothrow_t));
 extern void operator delete[](void *p, const std::nothrow_t &nt) throw()

--MP_/F5kLHeS52AFoglV/EkYmnPJ
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=gcc48-ondee-64bit.patch
Content-length: 2718

--- origsrc/gcc-4.8-20130224/gcc/config/i386/cygwin-w64.h	2013-03-03 23:36:49.242030600 -0600
+++ src/gcc-4.8-20130224/gcc/config/i386/cygwin-w64.h	2013-03-03 23:46:37.374669900 -0600
@@ -70,13 +70,14 @@ along with GCC; see the file COPYING3.
 
 /* To implement C++ function replacement we always wrap the cxx
    malloc-like operators.  See N2800 #17.6.4.6 [replacement.functions] */
+#undef CXX_WRAP_SPEC_LIST
 #define CXX_WRAP_SPEC_LIST " \
-  --wrap _Znwj \
-  --wrap _Znaj \
+  --wrap _Znwm \
+  --wrap _Znam \
   --wrap _ZdlPv \
   --wrap _ZdaPv \
-  --wrap _ZnwjRKSt9nothrow_t \
-  --wrap _ZnajRKSt9nothrow_t \
+  --wrap _ZnwmRKSt9nothrow_t \
+  --wrap _ZnamRKSt9nothrow_t \
   --wrap _ZdlPvRKSt9nothrow_t \
   --wrap _ZdaPvRKSt9nothrow_t \
 "
--- origsrc/gcc-4.8-20130224/gcc/configure	2013-02-01 14:26:24.000000000 -0600
+++ src/gcc-4.8-20130224/gcc/configure	2013-03-03 23:54:23.174312100 -0600
@@ -24261,7 +24261,7 @@ fi
 	# wrappers to aid in interposing and redirecting operators new, delete,
 	# etc., as per n2800 #17.6.4.6 [replacement.functions].  Check if we
 	# are configuring for a version of Cygwin that exports the wrappers.
-	if test x$host = x$target; then
+	if test x$host = x$target && test x$host_cpu = xi686; then
 	  ac_fn_c_check_func "$LINENO" "__wrap__Znaj" "ac_cv_func___wrap__Znaj"
 if test "x$ac_cv_func___wrap__Znaj" = x""yes; then :
   gcc_ac_cygwin_dll_wrappers=yes
@@ -24270,7 +24270,8 @@ else
 fi
 
 	else
-	  # Can't check presence of libc functions during cross-compile, so
+	  # Either we're compiling for x86_64-cygwin, which is new enough, or
+	  # we can't check presence of libc functions during cross-compile, so
 	  # we just have to assume we're building for an up-to-date target.
 	  gcc_ac_cygwin_dll_wrappers=yes
 	fi
--- origsrc/gcc-4.8-20130224/gcc/configure.ac	2013-02-01 14:26:24.000000000 -0600
+++ src/gcc-4.8-20130224/gcc/configure.ac	2013-03-03 23:53:37.503699900 -0600
@@ -3611,10 +3611,11 @@ changequote([,])dnl
 	# wrappers to aid in interposing and redirecting operators new, delete,
 	# etc., as per n2800 #17.6.4.6 [replacement.functions].  Check if we
 	# are configuring for a version of Cygwin that exports the wrappers.
-	if test x$host = x$target; then
+	if test x$host = x$target && test x$host_cpu = xi686; then
 	  AC_CHECK_FUNC([__wrap__Znaj],[gcc_ac_cygwin_dll_wrappers=yes],[gcc_ac_cygwin_dll_wrappers=no])
 	else
-	  # Can't check presence of libc functions during cross-compile, so
+	  # Either we're compiling for x86_64-cygwin, which is new enough, or
+	  # we can't check presence of libc functions during cross-compile, so
 	  # we just have to assume we're building for an up-to-date target.
 	  gcc_ac_cygwin_dll_wrappers=yes
 	fi

--MP_/F5kLHeS52AFoglV/EkYmnPJ--
