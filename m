Return-Path: <cygwin-patches-return-7231-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23009 invoked by alias); 31 Mar 2011 04:38:01 -0000
Received: (qmail 22866 invoked by uid 22791); 31 Mar 2011 04:37:59 -0000
X-SWARE-Spam-Status: No, hits=-2.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gw0-f43.google.com (HELO mail-gw0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 31 Mar 2011 04:37:55 +0000
Received: by gwj21 with SMTP id 21so1015551gwj.2        for <cygwin-patches@cygwin.com>; Wed, 30 Mar 2011 21:37:54 -0700 (PDT)
Received: by 10.150.114.11 with SMTP id m11mr2331475ybc.426.1301546274467;        Wed, 30 Mar 2011 21:37:54 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id t12sm444054ybe.15.2011.03.30.21.37.51        (version=SSLv3 cipher=OTHER);        Wed, 30 Mar 2011 21:37:53 -0700 (PDT)
Subject: [PATCH] compile cyglsa with mingw-w64
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-kVsWB0eJzD1yU+pJKDQX"
Date: Thu, 31 Mar 2011 04:38:00 -0000
Message-ID: <1301546273.2936.6.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q1/txt/msg00086.txt.bz2


--=-kVsWB0eJzD1yU+pJKDQX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 282

The mingw-w64 toolchain can now be used in place of MSVC to build
cyglsa64.dll.  I didn't integrate this into the Makefile because that
would make the toolchain a hard build-time requirement, and I don't
think that is desirable at this time.

Patch and new file attached.


Yaakov


--=-kVsWB0eJzD1yU+pJKDQX
Content-Disposition: attachment; filename="cyglsa-w64.patch"
Content-Type: text/x-patch; name="cyglsa-w64.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 868

2011-03-30  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* cyglsa.c: Fix compilation with MinGW-w64 toolchains.
	* make-64bit-version-with-mingw-w64.sh: New file.

Index: cyglsa.c
===================================================================
RCS file: /cvs/src/src/winsup/lsaauth/cyglsa.c,v
retrieving revision 1.7
diff -u -r1.7 cyglsa.c
--- cyglsa.c	29 Jan 2010 19:50:15 -0000	1.7
+++ cyglsa.c	31 Mar 2011 02:33:26 -0000
@@ -1,6 +1,6 @@
 /* cyglsa.c: LSA authentication module for Cygwin
 
-   Copyright 2006, 2008, 2010 Red Hat, Inc.
+   Copyright 2006, 2008, 2010, 2011 Red Hat, Inc.
 
    Written by Corinna Vinschen <corinna@vinschen.de>
 
@@ -19,7 +19,7 @@
 #include <lmcons.h>
 #include <iptypes.h>
 #include <ntsecapi.h>
-#ifdef __MINGW32__
+#if defined(__MINGW32__) && !defined(_W64)
 #include <ntddk.h>
 #endif
 #include "../cygwin/cyglsa.h"

--=-kVsWB0eJzD1yU+pJKDQX
Content-Type: application/x-shellscript; name="make-64bit-version-with-mingw-w64.sh"
Content-Disposition: attachment; filename="make-64bit-version-with-mingw-w64.sh"
Content-Transfer-Encoding: 7bit
Content-length: 967

#! /bin/sh
# This script shows how to generate a 64 bit version of cyglsa.dll.
# The 32 bit version will not work on 64 bit systems.
#
# Note that you need MinGW-w64 GCC, headers, and import libs.  On Cygwin,
# the required packages are: mingw64-x86_64-binutils, mingw64-x86_64-gcc-core,
# mingw64-x86_64-headers, and mingw64-x86_64-runtime.
#
# Note that this is for building inside the source dir as not to interfere
# with the "official" 32 bit build in the build directory.
#
# Install the dll into /bin and use the cyglsa-config script to register it.
# Don't forget to reboot afterwards.
#
# Add "-DDEBUGGING" to CFLAGS below to create debugging output to
# C:\cyglsa.dbgout at runtime.
#
set -e

CC="x86_64-w64-mingw32-gcc"
CFLAGS="-fno-exceptions -O0 -Wall -Werror"
LDFLAGS="-s -nostdlib -Wl,--entry,DllMain,--major-os-version,5,--minor-os-version,2"
LIBS="-ladvapi32 -lkernel32 -lntdll"

$CC $CFLAGS $LDFLAGS -shared -o cyglsa64.dll cyglsa.c mslsa.def $LIBS

--=-kVsWB0eJzD1yU+pJKDQX--
