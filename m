Return-Path: <cygwin-patches-return-6054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2527 invoked by alias); 4 Apr 2007 01:28:47 -0000
Received: (qmail 2509 invoked by uid 22791); 4 Apr 2007 01:28:47 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc12.comcast.net (HELO rwcrmhc12.comcast.net) (204.127.192.82)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 04 Apr 2007 02:28:44 +0100
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])           by comcast.net (rwcrmhc12) with ESMTP           id <20070404012837m1200celade>; Wed, 4 Apr 2007 01:28:43 +0000
Message-ID: <4612FF7F.6080705@byu.net>
Date: Wed, 04 Apr 2007 01:28:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:  cygwin@cygwin.com,  cygwin-patches@cygwin.com
Subject: Re: stdint.h bug
References: <loom.20070403T201330-772@post.gmane.org> <20070403191301.GA13159@ednor.casa.cgf.cx>
In-Reply-To: <20070403191301.GA13159@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------060307090204020708020201"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.
--------------060307090204020708020201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1215

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Christopher Faylor on 4/3/2007 1:13 PM:
> On Tue, Apr 03, 2007 at 06:15:14PM +0000, Eric Blake wrote:
>> Cygwin defines wint_t as unsigned int (valid, per POSIX), but then defines
>>
>> #ifndef WINT_MIN
>> #define WINT_MIN (-2147483647 - 1)
>> #define WINT_MAX (2147483647)
>> #endif
>>
>> which is invalid given the underlying type of wint_t.  Can we get this fixed 
>> (either make wint_t a signed type, or change WINT_MIN and WINT_MAX)?
> 
> Patch?

Well, I was hoping for some feedback as to whether changing wint_t to be
signed was preferable over changing WINT_MIN.  But further research shows
Linux also uses an unsigned type for wint_t, so:

2007-04-03  Eric Blake  <ebb9@byu.net>

	* include/stdint.h (WINT_MIN, WINT_MAX): Fix definition.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGEv9/84KuGfSFAYARAo1OAJ9Ig6W0WqaMfGWN4njXieB8AJb0pwCgh3FE
x5B6wtRLeWqvadttHSbl6Hw=
=fB6i
-----END PGP SIGNATURE-----

--------------060307090204020708020201
Content-Type: text/plain;
 name="cygwin.patch6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch6"
Content-length: 732

Index: include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.7
diff -u -p -r1.7 stdint.h
--- include/stdint.h	3 Jul 2006 12:30:04 -0000	1.7
+++ include/stdint.h	4 Apr 2007 01:27:08 -0000
@@ -1,6 +1,6 @@
 /* stdint.h - integer types
 
-   Copyright 2003, 2006 Red Hat, Inc.
+   Copyright 2003, 2006, 2007 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -158,8 +158,8 @@ typedef unsigned long long uintmax_t;
 #endif
 
 #ifndef WINT_MIN
-#define WINT_MIN (-2147483647 - 1)
-#define WINT_MAX (2147483647)
+#define WINT_MIN 0
+#define WINT_MAX UINT_MAX
 #endif
 
 /* Macros for minimum-width integer constant expressions */

--------------060307090204020708020201--
