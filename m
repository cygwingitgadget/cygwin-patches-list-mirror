Return-Path: <cygwin-patches-return-5629-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 845 invoked by alias); 26 Aug 2005 13:09:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 370 invoked by uid 22791); 26 Aug 2005 13:08:50 -0000
Received: from rwcrmhc14.comcast.net (HELO rwcrmhc12.comcast.net) (204.127.198.54)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 26 Aug 2005 13:08:50 +0000
Received: from [192.168.0.100] (c-67-172-242-110.hsd1.ut.comcast.net[67.172.242.110])
          by comcast.net (rwcrmhc14) with ESMTP
          id <2005082613084801400hggo9e>; Fri, 26 Aug 2005 13:08:48 +0000
Message-ID: <430F145F.80306@byu.net>
Date: Fri, 26 Aug 2005 13:09:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Problem with sh/bash and snapshot cygwin1-20050825.dll
Content-Type: multipart/mixed;
 boundary="------------090705020608060605090301"
X-SW-Source: 2005-q3/txt/msg00084.txt.bz2

This is a multi-part message in MIME format.
--------------090705020608060605090301
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1278

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

>> While you're at it, fix realpath(NULL, buf) to set buf[0]='\0', instead of
>> leaving garbage there.
>
>http://cygwin.com/acronyms/#PTC

Also, strdup() is faster than malloc()/strcpy(), since it calculates the
path length only once instead of twice.

>> Also, realpath("//..", buf) should be "//", not "/", since it is its own
>> root (there is no way to make // a subdirectory of /).  And when pwd is
>> //, realpath("..", buf) is correctly "//", but realpath("../..", buf) is
>> mistakenly "/".
>
>http://cygwin.com/acronyms/#PTC

Unfortunately, I don't have copyright assignment (I've tried convincing my
employer; I'll try again), and this would push me over my current
contribution limits.

2005-08-26  Eric Blake  <ebb9@byu.net>

	* path.cc (realpath): Truncate resolved when path is NULL.  Use
	strdup when resolved is NULL.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDDxRe84KuGfSFAYARAnXaAJ0b9xkB+hhmp9GQk0S52vSlzbtqkwCdGlfE
wjGOq/B2Iv2JyJ2HA81HZIc=
=EXXF
-----END PGP SIGNATURE-----

--------------090705020608060605090301
Content-Type: text/plain;
 name="cygwin.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch"
Content-length: 1089

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.388
diff -u -p -b -r1.388 path.cc
--- path.cc	25 Aug 2005 21:18:26 -0000	1.388
+++ path.cc	26 Aug 2005 13:07:29 -0000
@@ -50,6 +50,7 @@ details. */
 #include "winsup.h"
 #include <stdio.h>
 #include <stdlib.h>
+#include <string.h>
 #include <sys/mount.h>
 #include <mntent.h>
 #include <unistd.h>
@@ -3657,6 +3658,8 @@ realpath (const char *path, char *resolv
   /* Make sure the right errno is returned if path is NULL. */
   if (!path)
     {
+      if (resolved)
+	resolved[0] = '\0';
       set_errno (EINVAL);
       return NULL;
     }
@@ -3677,11 +3680,7 @@ realpath (const char *path, char *resolv
   if (!real_path.error && real_path.exists ())
     {
       if (!resolved)
-	{
-          resolved = (char *) malloc (strlen (real_path.normalized_path) + 1);
-          if (!resolved)
-	    return NULL;
-        }
+	return strdup (real_path.normalized_path);
       return strcpy (resolved, real_path.normalized_path);
     }
 

--------------090705020608060605090301--
