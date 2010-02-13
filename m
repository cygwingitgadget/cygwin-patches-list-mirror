Return-Path: <cygwin-patches-return-6954-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15584 invoked by alias); 13 Feb 2010 06:44:03 -0000
Received: (qmail 15567 invoked by uid 22791); 13 Feb 2010 06:44:01 -0000
X-SWARE-Spam-Status: No, hits=0.8 required=5.0 	tests=AWL,BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS,URIBL_BLACK
X-Spam-Check-By: sourceware.org
Received: from out2.smtp.messagingengine.com (HELO out2.smtp.messagingengine.com) (66.111.4.26)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 13 Feb 2010 06:43:56 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 91C38E145D 	for <cygwin-patches@cygwin.com>; Sat, 13 Feb 2010 01:43:54 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Sat, 13 Feb 2010 01:43:54 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 94716E73A; 	Sat, 13 Feb 2010 01:43:53 -0500 (EST)
Message-ID: <4B764A1F.6060003@cwilson.fastmail.fm>
Date: Sat, 13 Feb 2010 06:44:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Add xdr support
Content-Type: multipart/mixed;  boundary="------------090904040404000507050502"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00070.txt.bz2

This is a multi-part message in MIME format.
--------------090904040404000507050502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 6329

The attached patch(es) add XDR support to cygwin. eXternal Data
Representation (XDR) is a standard data encoding mechanism (RFC 1832,
4506) most frequently seen in the implementation of the SunRPC protocol.
 XDR allows binary data structures to be encoded in an architecture
independent manner for communication between heterogeneous computer systems.

For years, the Sun RPC code, and the XDR implementation, was in legal
license limbo
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=181493
as its license terms were of debatable compatibility with the GPL. In
February of 2009, that changed:

http://blogs.sun.com/webmink/entry/old_code_and_old_licenses
http://lwn.net/Articles/319648/

As documented in the libtirpc rpm.spec file from Fedora 11:
* Tue May 19 2009 Tom "spot" Callaway <tcallawa@redhat.com> 0.1.10-7
- Replace the Sun RPC license with the BSD license, with the explicit
  permission of Sun Microsystems

So, the attached implementations were taken from Fedora 11's libtirpc
package, after the modifications by Tom Callaway. Thus, each file
carries the (3-clause) BSD license, and not the old "SunRPC" license.

Last year, I worked on it some to get it to compile cleanly under cygwin
(1.5,1.7), mingw, msvc80, and linux (32bit, 64bit), while being careful
to maintain the BSD license.  I also wrote a whole slew of tests to
guarantee correct operation and identical representation on all of these
platforms (these carry the MIT/X license). I won't say it has full test
coverage, but it's awfully close.  Anyway, I finally got around to
uploading that package to googlecode this week:

http://code.google.com/p/bsd-xdr/

The attached patch is basically a fork of that bsd-xdr core code. I
removed all the #ifdefs that made msvc80 and mingw happy, as they aren't
needed in newlib and would complicate any attempt to expand the use of
the new code to other newlib targets other than cygwin.  I reworked both
the headers and implementation files to follow newlib-isms like using
_EXFUN() and _DEFUN macros and such.  I did not, however, attempt to add
'chew'-able documentation to the various files.

This fork, rather than relying on <byteorder.h> (which isn't available
inside newlib), uses its own private ntohl/htonl implementations. Also,
while most xdr implementations print errors to stderr using the
BSD-flavor warnx() function, this version allows the caller to configure
an error reporting function (more below).

I did not include the test suite; it would take quite a bit of effort to
translate the bsd-xdr/test/ code into cygwin's testsuite framework --
newlib/libc/ itself doesn't appear to have a test suite AFAICT.  I'm not
sure it's worth the effort, actually -- none of the BSD's or glibc or
linux's include test code for XDR, which is why I had to code tests from
the ground up for my bsd-xdr package.  I did link my test suite against
this implementation inside a newly-built cygwin1.dll, and it passed with
flying colors.

Most of the code goes in newlib, but is only built for $host cygwin.
However, I post it here first for review and comments; rev 2 will go to
the newlib list.  The cygwin components are basically just adding the
new exports, and providing a callback function for the error reporting
framework in the xdr implementation, that uses (in effect) debug_printf().

Note that the newlib patches depend on the ones I posted earlier today
to the newlib list, concerning compatibility with the src/libtool.m4 and
src/ltmain.sh files which were recently updated, as well as
compatibility with ac-2.64 and am-1.11.1:
http://sourceware.org/ml/newlib/2010/msg00114.html

So, apply those two patches first, then these three.  Yes, three: (1)
newlib 'primary' changes, (2) newlib 're-autotool' changes, and (3)
cygwin changes.  I had to compress the first two, because they are too
large to include as inline attachments.

Obviously, the newlib contributions can retain their BSD (or MIT/X, for
two internal files) license, like all the other such files in newlib.
The cygwin components are GPL, and fall under my existing copyright
assignment to Red Hat.

Patch#1: newlib primary
==========================
2010-02-12  Charles Wilson  <...>

        Add eXtensible Data Record (XDR) support for cygwin
	* configure.host: Build libc/xdr only on cygwin.
	* Makefile.am: Install xdr headers.
	* libc/configure.in: Support new libc/xdr subdirectory.
	* libc/Makefile.am: Support new libc/xdr subdirectory.
	* libc/include/rpc/types.h: New.
	* libc/include/rpc/xdr.h: New.
	* libc/xdr/Makefile.am: New.
	* libc/xdr/dummy.c: New.
	* libc/xdr/xdr.c: New.
	* libc/xdr/xdr_array.c: New.
	* libc/xdr/xdr_float.c: New.
	* libc/xdr/xdr_mem.c: New.
	* libc/xdr/xdr_private.c: New.
	* libc/xdr/xdr_private.h: New.
	* libc/xdr/xdr_rec.c: New.
	* libc/xdr/xdr_reference.c: New.
	* libc/xdr/xdr_sizeof.c: New.
	* libc/xdr/xdr_stdio.c: New.

Patch#2: newlib auto
===========================
2010-02-12  Charles Wilson  <...>

	Regenerate using ac-2.64 and am-1.11.1
	* Makefile.in: Regenerate.
	* libc/configure: Regenerate.
	* libc/Makefile.in: Regenerate.
	* libc/argz/Makefile.in: Regenerate.
	* libc/ctype/Makefile.in: Regenerate.
	* libc/errno/Makefile.in: Regenerate.
	* libc/iconv/ccs/binary/Makefile.in: Regenerate.
	* libc/iconv/ccs/Makefile.in: Regenerate.
	* libc/iconv/ces/Makefile.in: Regenerate.
	* libc/iconv/lib/Makefile.in: Regenerate.
	* libc/iconv/Makefile.in: Regenerate.
	* libc/locale/Makefile.in: Regenerate.
	* libc/misc/Makefile.in: Regenerate.
	* libc/posix/Makefile.in: Regenerate.
	* libc/reent/Makefile.in: Regenerate.
	* libc/search/Makefile.in: Regenerate.
	* libc/signal/Makefile.in: Regenerate.
	* libc/stdio/Makefile.in: Regenerate.
	* libc/stdio64/Makefile.in: Regenerate.
	* libc/stdlib/Makefile.in: Regenerate.
	* libc/string/Makefile.in: Regenerate.
	* libc/syscalls/Makefile.in: Regenerate.
	* libc/time/Makefile.in: Regenerate.
	* libc/unix/Makefile.in: Regenerate.
	* libc/xdr/Makefile.in: Regenerate.

Patch #3: cygwin
=========================
2010-02-12  Charles Wilson  <...>

	Add XDR support.
	* cygwin.din: Export xdr functions.
	* include/cygwin/version.h: Bump version.
	* cygxdr.cc: New.
	* cygxdr.h: New.
	* init.cc: Ensure that xdr functions use an approximation
	to debug_print for warnings, rather than stderr.
	* Makefile.in: Add cygxdr.

--
Chuck

--------------090904040404000507050502
Content-Type: text/x-patch;
 name="xdr-cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xdr-cygwin.patch"
Content-length: 4841

diff -u src-newlib-p/winsup/cygwin/cygwin.din src/winsup/cygwin/cygwin.din
--- src-newlib-p/winsup/cygwin/cygwin.din	2010-02-12 01:17:47.586400000 -0500
+++ src/winsup/cygwin/cygwin.din	2010-02-12 19:24:06.883800000 -0500
@@ -1815,6 +1815,53 @@
 writev SIGFE
 _writev = writev SIGFE
 wscanf SIGFE
+xdr_array SIGFE
+xdr_bool SIGFE
+xdr_bytes SIGFE
+xdr_char SIGFE
+xdr_double SIGFE
+xdr_enum SIGFE
+xdr_float SIGFE
+xdr_free SIGFE
+xdr_hyper SIGFE
+xdr_int SIGFE
+xdr_int16_t SIGFE
+xdr_int32_t SIGFE
+xdr_int64_t SIGFE
+xdr_int8_t SIGFE
+xdr_long SIGFE
+xdr_longlong_t SIGFE
+xdr_netobj SIGFE
+xdr_opaque SIGFE
+xdr_pointer SIGFE
+xdr_reference SIGFE
+xdr_short SIGFE
+xdr_sizeof SIGFE
+xdr_string SIGFE
+xdr_u_char SIGFE
+xdr_u_hyper SIGFE
+xdr_u_int SIGFE
+xdr_u_int16_t SIGFE
+xdr_u_int32_t SIGFE
+xdr_u_int64_t SIGFE
+xdr_u_int8_t SIGFE
+xdr_u_long SIGFE
+xdr_u_longlong_t SIGFE
+xdr_u_short SIGFE
+xdr_uint16_t SIGFE
+xdr_uint32_t SIGFE
+xdr_uint64_t SIGFE
+xdr_uint8_t SIGFE
+xdr_union SIGFE
+xdr_vector SIGFE
+xdr_void SIGFE
+xdr_wrapstring SIGFE
+xdrmem_create SIGFE
+xdrrec_create SIGFE
+xdrrec_endofrecord SIGFE
+xdrrec_eof SIGFE
+xdrrec_skiprecord SIGFE
+xdrstdio_create SIGFE
 y0 NOSIGFE
 y0f NOSIGFE
 y1 NOSIGFE
diff -u src-newlib-p/winsup/cygwin/cygxdr.cc src/winsup/cygwin/cygxdr.cc
--- src-newlib-p/winsup/cygwin/cygxdr.cc	1969-12-31 19:00:00.000000000 -0500
+++ src/winsup/cygwin/cygxdr.cc	2010-02-12 20:14:43.634000000 -0500
@@ -0,0 +1,26 @@
+/* cygxdr.cc: 
+
+   Copyright 2010 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+
+#include "winsup.h"
+#include <stdarg.h>
+#include "cygxdr.h"
+
+extern "C" void
+cygxdr_vwarnx (const char * fmt, va_list ap)
+{
+  static const char * fake_func_name = "xdr-routines";
+
+  /* workaround missing debug_vprintf() */
+  if (fmt && *fmt && strace.active())
+    {
+      strace.vprntf (_STRACE_DEBUG, fake_func_name, fmt, ap);
+    }
+}
+
diff -u src-newlib-p/winsup/cygwin/cygxdr.h src/winsup/cygwin/cygxdr.h
--- src-newlib-p/winsup/cygwin/cygxdr.h	1969-12-31 19:00:00.000000000 -0500
+++ src/winsup/cygwin/cygxdr.h	2010-02-12 20:11:35.455000000 -0500
@@ -0,0 +1,25 @@
+/* cygxdr.h: 
+
+   Copyright 2010 Red Hat, Inc.
+
+This file is part of Cygwin.
+
+This software is a copyrighted work licensed under the terms of the
+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
+details. */
+#ifndef _CYGXDR_H
+#define _CYGXDR_H
+
+extern "C"
+{
+
+typedef void (*xdr_vprintf_t)(const char *, va_list);
+
+xdr_vprintf_t xdr_set_vprintf (xdr_vprintf_t);
+
+void cygxdr_vwarnx (const char *, va_list);
+
+}
+
+#endif
+
diff -u src-newlib-p/winsup/cygwin/include/cygwin/version.h src/winsup/cygwin/include/cygwin/version.h
--- src-newlib-p/winsup/cygwin/include/cygwin/version.h	2010-02-12 01:17:49.738400000 -0500
+++ src/winsup/cygwin/include/cygwin/version.h	2010-02-12 19:25:24.951800000 -0500
@@ -376,12 +376,13 @@
       220: Export accept4, SOCK_CLOEXEC, SOCK_NONBLOCK.
       221: Export strfmon.
       222: CW_INT_SETLOCALE added.
+      223: Export xdr* functions.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 222
+#define CYGWIN_VERSION_API_MINOR 223
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff -u src-newlib-p/winsup/cygwin/init.cc src/winsup/cygwin/init.cc
--- src-newlib-p/winsup/cygwin/init.cc	2010-02-12 01:17:48.563400000 -0500
+++ src/winsup/cygwin/init.cc	2010-02-12 20:15:11.105000000 -0500
@@ -13,6 +13,7 @@
 #include "cygtls.h"
 #include "ntdll.h"
 #include "shared_info.h"
+#include "cygxdr.h"
 
 static DWORD _my_oldfunc;
 
@@ -138,6 +139,7 @@
 
       dll_crt0_0 ();
       _my_oldfunc = TlsAlloc ();
+      (void) xdr_set_vprintf (&cygxdr_vwarnx);
       break;
     case DLL_PROCESS_DETACH:
       if (dynamically_loaded)
diff -u src-newlib-p/winsup/cygwin/Makefile.in src/winsup/cygwin/Makefile.in
--- src-newlib-p/winsup/cygwin/Makefile.in	2010-02-12 01:17:47.477400000 -0500
+++ src/winsup/cygwin/Makefile.in	2010-02-12 20:04:17.184800000 -0500
@@ -136,7 +136,7 @@
 # Please maintain this list in sorted order, with maximum files per 86 col line
 #
 DLL_OFILES:=assert.o autoload.o bsdlib.o ctype.o cxx.o cygheap.o cygthread.o \
-	cygtls.o dcrt0.o debug.o devices.o dir.o dlfcn.o dll_init.o \
+	cygtls.o cygxdr.o dcrt0.o debug.o devices.o dir.o dlfcn.o dll_init.o \
 	dtable.o environ.o errno.o exceptions.o exec.o external.o fcntl.o \
 	fhandler.o fhandler_clipboard.o fhandler_console.o fhandler_disk_file.o \
 	fhandler_dsp.o fhandler_fifo.o fhandler_floppy.o fhandler_mailslot.o \

--------------090904040404000507050502
Content-Type: application/octet-stream;
 name="xdr-newlib-primary.patch.lzma"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xdr-newlib-primary.patch.lzma"
Content-length: 27361

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
jTlanEK55Iv+b0RdVb96tqjLv//+8uc6

--------------090904040404000507050502
Content-Type: application/octet-stream;
 name="xdr-newlib-auto.patch.lzma"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="xdr-newlib-auto.patch.lzma"
Content-length: 9614

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
F6VHXo7f6XkIeSzDuKEW1mWgetaXf5obgFT2FwKmmCCuYGOHKRmMaUV8v+rp
eaz5QRcf3qR5j5nJee1j6rl8zU3AOAQTbI1JkXPm0aJtagz7CH562B6MznV+
Yp2sv4OQ4+yYBl69f0cku9e1ig3OXZLHU936IM+VrKmYN5u6rSDDmpJ/FdtP
XzkK2JZHjJH0Lo9JaaFiom9dLmfaoNVpP+T3uJHTp/Q4pY3jfDVtp7P37zuc
Rm8UKb31L/3CuG+dytiWm7eaTeff0P0p4Mz3D2yDdxWo4GKbPHG03Phh71J+
v+32Pc/5VFxycA+4raE7IMuBqjmwJdb8p6m7dovM0JedBNyBU37FmAqA25MR
TakuVGpW5yx1+cGO5XI4Wfa/35Z9t6eoEsQU5i3OuH7VAWp/8eXOqj06pMk4
/ZBHuFSNYnERB/WsHAXWJNCZkBQRZZUn0w11O3GhlS3WerVpIOe1MiaOqswR
WscnGMYIciNaIHsfLc05xmz0qQJldDl0pjFggCtbsWvaF01uRkFOUbB/nsCG
e1CwfneLg1dZlfm9f3WFYeaxHEKgnMgWVygPasepKs0kP8TqW6872iwFaQPC
XdgwDlSmHSis5SpRG+++nfpgnUVmQIYRTRO5ECwxWzC8Ftagq5d8NL173y1C
doPU9xmu5TxkjEoNYeloSEpYSrVo/vgu0F8ch8ck7bkuKwFZ1vTbJrRbqFQs
XIZxulYfD7dNCPUdcHKUKxz7I7pMHBZThiyMluGukTXg9VXYsCpLH6ra2jFF
084cPX46iCl5bBvyVxlQ8Yxt3SFxL9V16tFTcuOLSwasXv6CBWV5iXomQzGr
LwpD7sqNCpxQJo+CjMZdLzmfKj5fIzs+xsNwg0hFjs+zHDMgmHiRsEzDKq4r
b59Ld4VaRStnkmhxHEShn0VU7LYkKk38DIDpsY/FMrVMukKTsZrhkT3x7W2G
5ITYX2jxF23y5A28XTTxy9CmIZDI3w/U4gZMHVAUEMXP2SpOzDfM08NKuqgL
hq3+OhqMEAXGrujs2AM+VJFlntbkxqTGQfgKieBTDR6bP3SSnTnoWCRPCBAS
3UXDk8ME137V1gty1B8qshpBpnqqbeRhQXm7Ol8wDOLbjGDk9Zh2Jwyw25wc
uJb3KCpQM8gxbZiVcnfCCzWWU2L/XCZZcJWWWeAJ92mpFgN4+BnADNQK0joy
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
AzbrN2wwnCujbtaXpS6HwN1eeP//bjflAA==

--------------090904040404000507050502--
