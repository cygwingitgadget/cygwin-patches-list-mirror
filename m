Return-Path: <cygwin-patches-return-6197-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8488 invoked by alias); 20 Dec 2007 03:58:24 -0000
Received: (qmail 8477 invoked by uid 22791); 20 Dec 2007 03:58:24 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta05.westchester.pa.mail.comcast.net (HELO QMTA05.westchester.pa.mail.comcast.net) (76.96.62.48)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 20 Dec 2007 03:58:07 +0000
Received: from OMTA13.westchester.pa.mail.comcast.net ([76.96.62.52]) 	by QMTA05.westchester.pa.mail.comcast.net with comcast 	id SaaJ1Y00A17dt5G051UG00; Thu, 20 Dec 2007 03:58:05 +0000
Received: from [192.168.0.103] ([67.166.125.73]) 	by OMTA13.westchester.pa.mail.comcast.net with comcast 	id Sry31Y00S1b8C2B3Z00000; Thu, 20 Dec 2007 03:58:05 +0000
X-Authority-Analysis: v=1.0 c=1 a=xe8BsctaAAAA:8 a=J8sk3NzB-c4ERVojT08A:9 a=157saweCwZ9B44hFcq0Ci1GztVkA:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10 a=rCSyoigQUNSxYYkPRlgA:9 a=OOsrYmONt3N2U7qpZ1IA:7 a=z0G1yCBOvGKntJG9FbH0SsNiEIAA:4 a=5WZzfXpOq_gA:10
Message-ID: <4769E90D.5090908@byu.net>
Date: Thu, 20 Dec 2007 03:58:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.9) Gecko/20071031 Thunderbird/2.0.0.9 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: memmem issues
References: <loom.20071219T210928-910@post.gmane.org>
In-Reply-To: <loom.20071219T210928-910@post.gmane.org>
Content-Type: multipart/mixed;  boundary="------------010609010809020108030001"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q4/txt/msg00049.txt.bz2

This is a multi-part message in MIME format.
--------------010609010809020108030001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1086

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 12/19/2007 2:22 PM:
> memmem isn't standardized, but even so, it has some bugs based on comparison 
> with strstr.
> 
> memmem(haystack,len,"",0) should return haystack, not NULL.  This should be an 
> easy one-line fix.
> 
> memmem currently has O(m*n) worst-case complexity (quadratic, when haystack and 
> needle are both long).  But with the Knuth-Morris-Pratt algorithm and a memory 
> allocation of size n, this could be trimmed to O(m+n) (linear).

Here's a patch:

2007-12-20  Eric Blake  <ebb9@byu.net>

	* libc/memmem.cc (memmem): Fix bug when searching for empty
	string.  Document O(n^2) bug.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHaekM84KuGfSFAYARArgXAJ9lz/Rk3GnD4i5q4Jy557TzVQoGoQCfb61v
4TUb18LiAQIdCasBx9nwFdw=
=5Vbo
-----END PGP SIGNATURE-----

--------------010609010809020108030001
Content-Type: text/plain;
 name="cygwin.patch11"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch11"
Content-length: 1190

Index: libc/memmem.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/libc/memmem.cc,v
retrieving revision 1.1
diff -u -p -r1.1 memmem.cc
--- libc/memmem.cc	8 Nov 2005 22:08:39 -0000	1.1
+++ libc/memmem.cc	20 Dec 2007 03:56:35 -0000
@@ -45,8 +45,8 @@ memmem (const void *l, size_t l_len,
   const char *cs = (const char *)s;
 
   /* we need something to compare */
-  if (l_len == 0 || s_len == 0)
-    return NULL;
+  if (s_len == 0)
+    return l;
 
   /* "s" must be smaller or equal to "l" */
   if (l_len < s_len)
@@ -59,6 +59,11 @@ memmem (const void *l, size_t l_len,
   /* the last position where its possible to find "s" in "l" */
   last = (char *) cl + l_len - s_len;
 
+  /* FIXME - this algorithm is worst-case O(l_len*s_len), but using
+     Knuth-Morris-Pratt would be O(l_len+s_len) at the expense of a
+     memory allocation of s_len bytes.  Consider rewriting this to
+     swap over the KMP if the first few iterations fail, and back to
+     this if KMP can't allocate enough memory.  */
   for (cur = (char *) cl; cur <= last; cur++)
     if (cur[0] == cs[0] && memcmp (cur, cs, s_len) == 0)
       return cur;

--------------010609010809020108030001--
