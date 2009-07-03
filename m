Return-Path: <cygwin-patches-return-6547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18972 invoked by alias); 3 Jul 2009 12:34:48 -0000
Received: (qmail 18955 invoked by uid 22791); 3 Jul 2009 12:34:45 -0000
X-SWARE-Spam-Status: No, hits=-0.1 required=5.0 	tests=AWL,BAYES_00,HK_OBFDOM,J_CHICKENPOX_36,J_CHICKENPOX_62,J_CHICKENPOX_63,J_CHICKENPOX_64,J_CHICKENPOX_74,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta11.emeryville.ca.mail.comcast.net (HELO QMTA11.emeryville.ca.mail.comcast.net) (76.96.27.211)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Jul 2009 12:34:37 +0000
Received: from OMTA11.emeryville.ca.mail.comcast.net ([76.96.30.36]) 	by QMTA11.emeryville.ca.mail.comcast.net with comcast 	id BQXg1c0020mlR8UABQadDm; Fri, 03 Jul 2009 12:34:37 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA11.emeryville.ca.mail.comcast.net with comcast 	id BQab1c0090Lg2Gw8XQacbo; Fri, 03 Jul 2009 12:34:36 +0000
Message-ID: <4A4DFAE4.3090008@byu.net>
Date: Fri, 03 Jul 2009 12:34:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: mkstemps
References: <4A46A3AB.2060604@byu.net> <20090628103249.GX30864@calimero.vinschen.de> <4A4DFA3E.2010909@byu.net>
In-Reply-To: <4A4DFA3E.2010909@byu.net>
Content-Type: multipart/mixed;  boundary="------------050706010901060602060309"
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
X-SW-Source: 2009-q3/txt/msg00001.txt.bz2

This is a multi-part message in MIME format.
--------------050706010901060602060309
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 974

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 7/3/2009 6:31 AM:
> With that vote of confidence, here's the patch (the changes to mktemp.cc,
> modulo a changed variable name, mirror newlib):
> 
> 2009-07-03  Eric Blake  <ebb9@byu.net>
> 
> 	Add fpurge, mkstemps.
> 	* cygwin.din (fpurge, mkstemps): New exports.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
> 	* mktemp.cc (_gettemp): Add parameter.
> 	(mkstemps): New function.
> 	(mkstemp, mkdtemp, mktemp): Adjust clients.

Updated to avoid a compiler warning.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkpN+uQACgkQ84KuGfSFAYCNEgCgikCAcF6adNz5AiSQT3qNC+mI
P58An3BTzCtkSmdx/F7LnRFmVvOTcMNx
=Upbc
-----END PGP SIGNATURE-----

--------------050706010901060602060309
Content-Type: text/plain;
 name="cygwin.patch16"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch16"
Content-length: 3701

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.212
diff -u -p -r1.212 cygwin.din
--- cygwin.din	28 Jun 2009 18:23:35 -0000	1.212
+++ cygwin.din	3 Jul 2009 12:33:07 -0000
@@ -505,6 +505,7 @@ __fpclassifyd NOSIGFE
 __fpclassifyf NOSIGFE
 fprintf SIGFE
 _fprintf = fprintf SIGFE
+fpurge SIGFE
 fputc SIGFE
 _fputc = fputc SIGFE
 fputs SIGFE
@@ -984,6 +985,7 @@ _mknod32 = mknod32 SIGFE
 mknodat SIGFE
 mkstemp SIGFE
 _mkstemp = mkstemp SIGFE
+mkstemps SIGFE
 mktemp SIGFE
 _mktemp = mktemp SIGFE
 mktime SIGFE
Index: mktemp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mktemp.cc,v
retrieving revision 1.5
diff -u -p -r1.5 mktemp.cc
--- mktemp.cc	13 Mar 2009 20:49:42 -0000	1.5
+++ mktemp.cc	3 Jul 2009 12:33:07 -0000
@@ -1,15 +1,16 @@
 /* mktemp.cc: mktemp functions
 
-This file is adapted for Cygwin from FreeBSD.
+This file is adapted for Cygwin from FreeBSD and newlib.
 
 See the copyright at the bottom of this file. */
 
 #include "winsup.h"
 #include "cygerrno.h"
 #include <fcntl.h>
+#include <sys/stat.h>
 #include <unistd.h>
 
-static int _gettemp(char *, int *, int);
+static int _gettemp(char *, int *, int, size_t);
 static uint32_t arc4random ();
 
 static const char padchar[] =
@@ -19,23 +20,30 @@ extern "C" int
 mkstemp(char *path)
 {
   int fd;
-  return _gettemp(path, &fd, 0) ? fd : -1;
+  return _gettemp(path, &fd, 0, 0) ? fd : -1;
 }
 
 extern "C" char *
 mkdtemp(char *path)
 {
-  return _gettemp(path, NULL, 1) ? path : NULL;
+  return _gettemp(path, NULL, 1, 0) ? path : NULL;
+}
+
+extern "C" int
+mkstemps(char *path, int len)
+{
+  int fd;
+  return _gettemp(path, &fd, 0, len) ? fd : -1;
 }
 
 extern "C" char *
 mktemp(char *path)
 {
-  return _gettemp(path, NULL, 0) ? path : (char *) NULL;
+  return _gettemp(path, NULL, 0, 0) ? path : (char *) NULL;
 }
 
 static int
-_gettemp(char *path, int *doopen, int domkdir)
+_gettemp(char *path, int *doopen, int domkdir, size_t suffixlen)
 {
   char *start, *trv, *suffp;
   char *pad;
@@ -46,12 +54,14 @@ _gettemp(char *path, int *doopen, int do
       return 0;
     }
 
-  suffp = trv = strchr (path, '\0');
-  if (--trv < path)
+  trv = strchr (path, '\0');
+  if ((size_t) (trv - path) < suffixlen)
     {
       set_errno (EINVAL);
       return 0;
     }
+  trv -= suffixlen;
+  suffp = trv--;
 
   /* Fill space with random characters */
   while (trv >= path && *trv == 'X')
@@ -59,6 +69,11 @@ _gettemp(char *path, int *doopen, int do
       uint32_t rand = arc4random () % (sizeof (padchar) - 1);
       *trv-- = padchar[rand];
     }
+  if (suffp - trv < 6)
+    {
+      set_errno (EINVAL);
+      return 0;
+    }
   start = trv + 1;
 
   /*
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.295
diff -u -p -r1.295 version.h
--- include/cygwin/version.h	9 May 2009 20:16:06 -0000	1.295
+++ include/cygwin/version.h	3 Jul 2009 12:33:07 -0000
@@ -364,12 +364,13 @@ details. */
       208: Export log2, log2f.
       209: Export wordexp, wordfree.
       210: New ctype layout using variable ctype pointer.  Export __ctype_ptr__.
+      211: Export fpurge, mkstemps.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 210
+#define CYGWIN_VERSION_API_MINOR 211
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------050706010901060602060309--
