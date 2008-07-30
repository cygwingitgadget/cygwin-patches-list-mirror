Return-Path: <cygwin-patches-return-6341-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10507 invoked by alias); 30 Jul 2008 05:57:51 -0000
Received: (qmail 10490 invoked by uid 22791); 30 Jul 2008 05:57:50 -0000
X-Spam-Check-By: sourceware.org
Received: from py-out-1112.google.com (HELO py-out-1112.google.com) (64.233.166.178)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 30 Jul 2008 05:57:27 +0000
Received: by py-out-1112.google.com with SMTP id w53so101949pyg.25         for <cygwin-patches@cygwin.com>; Tue, 29 Jul 2008 22:57:25 -0700 (PDT)
Received: by 10.65.232.2 with SMTP id j2mr13881414qbr.3.1217397445379;         Tue, 29 Jul 2008 22:57:25 -0700 (PDT)
Received: from ?192.168.0.101? ( [24.76.249.6])         by mx.google.com with ESMTPS id k7sm959967qba.3.2008.07.29.22.57.24         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Tue, 29 Jul 2008 22:57:24 -0700 (PDT)
Message-ID: <489002C6.6020503@users.sourceforge.net>
Date: Wed, 30 Jul 2008 05:57:00 -0000
From: "Yaakov (Cygwin Ports)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: cygcheck linking without libz
Content-Type: multipart/mixed;  boundary="------------030004080205010307090300"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.
--------------030004080205010307090300
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 582

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

"godlygeek" in IRC just came across a bug with building cygcheck where
mingw-zlib is not installed.  The link fails with undefined symbols
because -lntdll is only specified if libz is present.  (bloda.cc
requires ntdll regardless of the zlib usage.)

Patch attached.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAkiQAsYACgkQpiWmPGlmQSNl6ACaAlY5juJ7aNuSXToKtZ7GrQlY
vIQAnAl3btQ3sDUZh5gMvs564yduXbAn
=dKL5
-----END PGP SIGNATURE-----

--------------030004080205010307090300
Content-Type: text/x-patch;
 name="cygcheck-ntdll.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygcheck-ntdll.patch"
Content-length: 1175

--- winsup/utils/ChangeLog.orig	2008-07-30 00:51:43.890625000 -0500
+++ winsup/utils/ChangeLog	2008-07-30 00:54:15.125000000 -0500
@@ -1,3 +1,7 @@
+2008-07-30  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
+
+	* Makefile.in: Link cygcheck with -lntdll even without mingw-zlib.
+
 2008-07-27  Christopher Faylor  <me+cygwin@cgf.cx>
 
 	* cygcheck.cc (load_cygwin): Free the cygwin dll after we're done with
--- winsup/utils/Makefile.in.orig	2008-07-30 00:43:31.062500000 -0500
+++ winsup/utils/Makefile.in	2008-07-30 00:46:06.968750000 -0500
@@ -71,6 +71,7 @@
 cygcheck.exe: bloda.o path.o dump_setup.o
 
 # Provide any necessary per-target variable overrides.
+cygcheck.exe: MINGW_LDFLAGS += -lntdll
 cygpath.exe: ALL_LDFLAGS += -lntdll
 
 # Check for dumper's requirements and enable it if found.
@@ -94,7 +95,7 @@
 zlib_h  := -include ${patsubst %/lib/mingw/libz.a,%/include/zlib.h,${patsubst %/lib/libz.a,%/include/zlib.h,$(libz)}}
 zconf_h := ${patsubst %/zlib.h,%/zconf.h,$(zlib_h)}
 dump_setup.o: MINGW_CXXFLAGS += $(zconf_h) $(zlib_h)
-cygcheck.exe: MINGW_LDFLAGS += $(libz) -lntdll
+cygcheck.exe: MINGW_LDFLAGS += $(libz)
 else
 all: warn_cygcheck_zlib
 endif

--------------030004080205010307090300--
