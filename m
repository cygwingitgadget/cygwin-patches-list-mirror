Return-Path: <cygwin-patches-return-6995-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12954 invoked by alias); 2 Mar 2010 15:33:17 -0000
Received: (qmail 12929 invoked by uid 22791); 2 Mar 2010 15:33:16 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from out1.smtp.messagingengine.com (HELO out1.smtp.messagingengine.com) (66.111.4.25)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Mar 2010 15:33:11 +0000
Received: from compute1.internal (compute1 [10.202.2.41]) 	by gateway1.messagingengine.com (Postfix) with ESMTP id 0C54CE2934 	for <cygwin-patches@cygwin.com>; Tue,  2 Mar 2010 10:33:10 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])   by compute1.internal (MEProxy); Tue, 02 Mar 2010 10:33:10 -0500
Received: from [192.168.1.3] (user-0c6sbd2.cable.mindspring.com [24.110.45.162]) 	by mail.messagingengine.com (Postfix) with ESMTPSA id 7B2AACF0E; 	Tue,  2 Mar 2010 10:33:09 -0500 (EST)
Message-ID: <4B8D2F9D.4090309@cwilson.fastmail.fm>
Date: Tue, 02 Mar 2010 15:33:00 -0000
From: Charles Wilson <cygwin@cwilson.fastmail.fm>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Add xdr support
References: <4B764A1F.6060003@cwilson.fastmail.fm>
In-Reply-To: <4B764A1F.6060003@cwilson.fastmail.fm>
Content-Type: multipart/mixed;  boundary="------------070507080405090302070203"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2010-q1/txt/msg00111.txt.bz2

This is a multi-part message in MIME format.
--------------070507080405090302070203
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2277

Charles Wilson wrote:
> The attached patch(es) add XDR support to cygwin. eXternal Data

Now that newlib has accepted the XDR patches, the following simply
exports those symbols. It also ensures that the (rare) xdr error
messages are handled by cygwin as they are in glibc: print them to
stderr (unlike the previous patch, which printed them to cygwin's debug
strace).

I know we're in the run-up to 1.7.2, so it may be prudent to delay these
changes until after that, which is fine by me.

Now, I ran into a small problem: applying the attached patch to current
HEAD:

2010-03-01  Christopher Faylor  <...>
	* cygtls.h: Replace /*gentls_offsets*/ at end.

and doing an incremental rebuild (e.g. not a full clean&rebuild), I get
a non-functional cygwin1.dll:

C:\cygwin-1.7\bin>bash
      3 [main] bash 6840 exception::handle: Exception:
STATUS_ACCESS_VIOLATION
Exception: STATUS_ACCESS_VIOLATION at eip=61113909
eax=00000000 ebx=00000000 ecx=00000001 edx=00000008 esi=6115B2B0
edi=00000000
ebp=0022CB18 esp=0022CB00 program=C:\cygwin-1.7\bin\bash.exe, pid 6840,
thread m
ain
cs=001B ds=0023 es=0023 fs=003B gs=0000 ss=0023
Stack trace:
Frame     Function  Args
0022CB18  61113909  (0022D008, 00000000, 0022CB48, 61115228)
0022CB28  61113A22  (0022D008, 00000000, 0022CB48, 00000000)
0022CB48  61115228  (6115B2B0, 0022CD40, 00477CE4, 00550130)
0022CD08  610BC4B8  (0022CD40, 00000005, 0022CD68, 61006E43)
0022CD68  61006E43  (00000000, 0022CDA4, 61006700, 7FFDC000)
End of stack trace

However, rolling back CVS to here:

2010-02-26  Christopher Faylor  <...>
	* mkimport: cd away from temp directory or Windows will
	have problems

and applying this patch, and all is well (again with an incremental).
It could be that there is something funky going on with the recent
commits -- or it may be something as simple as, with HEAD, I need to do
a complete clean&rebuild.  I'll kick one of those off tonight.

However, I do not believe /THIS/ patch is related to /those/ problems. Okay?


2010-03-02  Charles Wilson  <...>

	Add XDR support.
	* cygwin.din: Export xdr functions.
	* include/cygwin/version.h: Bump version.
	* cygxdr.cc: New.
	* cygxdr.h: New.
	* dcrt0.cc (dll_crt0_1): Print the (rare) xdr-related
	error messages to stderr.
	* Makefile.in: Add cygxdr.


--
Chuck

--------------070507080405090302070203
Content-Type: text/x-patch;
 name="xdr-cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="xdr-cygwin.patch"
Content-length: 4943

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.233
diff -u -p -r1.233 Makefile.in
--- Makefile.in	4 Feb 2010 12:35:49 -0000	1.233
+++ Makefile.in	2 Mar 2010 13:58:51 -0000
@@ -136,7 +136,7 @@ MT_SAFE_OBJECTS:=
 # Please maintain this list in sorted order, with maximum files per 86 col line
 #
 DLL_OFILES:=assert.o autoload.o bsdlib.o ctype.o cxx.o cygheap.o cygthread.o \
-	cygtls.o dcrt0.o debug.o devices.o dir.o dlfcn.o dll_init.o \
+	cygtls.o cygxdr.o dcrt0.o debug.o devices.o dir.o dlfcn.o dll_init.o \
 	dtable.o environ.o errno.o exceptions.o exec.o external.o fcntl.o \
 	fhandler.o fhandler_clipboard.o fhandler_console.o fhandler_disk_file.o \
 	fhandler_dsp.o fhandler_fifo.o fhandler_floppy.o fhandler_mailslot.o \
Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.220
diff -u -p -r1.220 cygwin.din
--- cygwin.din	22 Jan 2010 22:31:31 -0000	1.220
+++ cygwin.din	2 Mar 2010 13:58:51 -0000
@@ -1815,6 +1815,53 @@ _write = write SIGFE
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
Index: dcrt0.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
retrieving revision 1.374
diff -u -p -r1.374 dcrt0.cc
--- dcrt0.cc	28 Feb 2010 15:54:25 -0000	1.374
+++ dcrt0.cc	2 Mar 2010 13:58:51 -0000
@@ -35,6 +35,7 @@ details. */
 #include "heap.h"
 #include "tls_pbuf.h"
 #include "exception.h"
+#include "cygxdr.h"
 
 #define MAX_AT_FILE_LEVEL 10
 
@@ -911,6 +912,7 @@ dll_crt0_1 (void *)
       set_console_title (cp);
     }
 
+  (void) xdr_set_vprintf (&cygxdr_vwarnx);
   cygwin_finished_initializing = true;
   /* Call init of loaded dlls. */
   dlls.init ();
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.310
diff -u -p -r1.310 version.h
--- include/cygwin/version.h	26 Feb 2010 05:43:50 -0000	1.310
+++ include/cygwin/version.h	2 Mar 2010 13:58:51 -0000
@@ -377,12 +377,13 @@ details. */
       221: Export strfmon.
       222: CW_INT_SETLOCALE added.
       223: SIGPWR added.
+      224: Export xdr* functions.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 223
+#define CYGWIN_VERSION_API_MINOR 224
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
diff -u /dev/null cygxdr.h
--- /dev/null	2006-11-30 19:00:00.000000000 -0500
+++ cygxdr.h	2010-02-24 22:57:13.178300000 -0500
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
diff -u /dev/null cygxdr.cc
--- /dev/null	2006-11-30 19:00:00.000000000 -0500
+++ cygxdr.cc	2010-02-26 11:04:08.032000000 -0500
@@ -0,0 +1,25 @@
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
+#include <stdio.h>
+#include "cygxdr.h"
+
+extern "C" void
+cygxdr_vwarnx (const char * fmt, va_list ap)
+{
+  /* imitate glibc behavior for xdr: messages
+   * are printed to stderr */
+  (void) fputs ("xdr-routines: ", stderr);
+  (void) vfprintf (stderr, fmt, ap);
+  (void) fputs ("\n", stderr);
+}
+

--------------070507080405090302070203--
