Return-Path: <cygwin-patches-return-5483-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2423 invoked by alias); 23 May 2005 11:59:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2344 invoked by uid 22791); 23 May 2005 11:59:38 -0000
Received: from rwcrmhc11.comcast.net (HELO rwcrmhc11.comcast.net) (204.127.198.35)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 23 May 2005 11:59:38 +0000
Received: from [192.168.0.100] (c-24-10-254-137.hsd1.ut.comcast.net[24.10.254.137])
          by comcast.net (rwcrmhc11) with ESMTP
          id <2005052311593601300ej01pe>; Mon, 23 May 2005 11:59:36 +0000
Message-ID: <4291C5A7.9040509@byu.net>
Date: Mon, 23 May 2005 11:59:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: bug in stdint.h
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-SW-Source: 2005-q2/txt/msg00079.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Found a typo in /usr/include/stdint.h:

2005-05-23  Eric Blake  <ebb9@byu.net>

	* include/stdint.h (INTMAX_C, UINTMAX_C): Fix definition.

Index: include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.5
diff -u -p -r1.5 stdint.h
- --- include/stdint.h    29 Oct 2003 08:43:10 -0000      1.5
+++ include/stdint.h    23 May 2005 11:58:49 -0000
@@ -176,7 +176,7 @@ typedef unsigned long long uintmax_t;

 /* Macros for greatest-width integer constant expressions */

- -#define INTMAX_C(x) x ## L
- -#define UINTMAX_C(x) x ## UL
+#define INTMAX_C(x) x ## LL
+#define UINTMAX_C(x) x ## ULL

 #endif /* _STDINT_H */

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCkcWm84KuGfSFAYARAkouAJ92IO6+m9chFepjeWBOFSwVgOvx+ACgr5z4
7h8RS3a0K2PdAgP4OUfj4Tk=
=rZ9K
-----END PGP SIGNATURE-----
