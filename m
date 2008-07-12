Return-Path: <cygwin-patches-return-6339-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8297 invoked by alias); 12 Jul 2008 16:08:25 -0000
Received: (qmail 8287 invoked by uid 22791); 12 Jul 2008 16:08:24 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO QMTA05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 12 Jul 2008 16:07:55 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA05.emeryville.ca.mail.comcast.net with comcast 	id p42n1Z01r1HpZEsA547tlK; Sat, 12 Jul 2008 16:07:53 +0000
Received: from [192.168.0.101] ([67.166.125.73]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id p47s1Z0051b8C2B8a47sMs; Sat, 12 Jul 2008 16:07:53 +0000
X-Authority-Analysis: v=1.0 c=1 a=5MYyIsXEptgA:10 a=8-eo-Wja9AMA:10  a=xe8BsctaAAAA:8 a=p_xv_2FteQ8bmc1to64A:9 a=mdcjpVFi3Bd2c8lUshEA:9  a=KUmy-5Bqkg7se8hYrAv141unP-wA:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10  a=KXRXq4qdbDGjeh1NR6EA:9 a=yaIoj4NEPkClBj8Ncc0A:9 a=zpz-DVt1vLAu_wcvSTIA:7  a=21BJCnemGYr_rNwWrRpNhoMRdQkA:4 a=5WZzfXpOq_gA:10
Message-ID: <4878D6DF.9060008@byu.net>
Date: Sat, 12 Jul 2008 16:08:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: use volatile when replacing Interlocked*
References: <4878A2C3.6060908@byu.net> <20080712153519.GA13069@calimero.vinschen.de>
In-Reply-To: <20080712153519.GA13069@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------030909040704050903080007"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00002.txt.bz2

This is a multi-part message in MIME format.
--------------030909040704050903080007
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 769

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

|> 2008-07-12  Eric Blake  <ebb9@byu.net>
|>
|> 	Fix usage of recently fixed Interlocked* functions.
|> 	* winbase.h (ilockincr, ilockdecr, ilockexch, ilockcmpexch): Add
|> 	volatile qualifier, to match Interlocked* functions.
|
| You missed to attach the patch, apparantly :)

I hate it when that happens.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkh41t8ACgkQ84KuGfSFAYCGiwCeNuRKSXc/TFaiNIX//Y2YoDOB
pBgAnR5jA1VcS6KODQe+Fof7I8HBLg+2
=i9Kb
-----END PGP SIGNATURE-----

--------------030909040704050903080007
Content-Type: text/plain;
 name="cygwin.patch13"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch13"
Content-length: 1303

Index: winbase.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/winbase.h,v
retrieving revision 1.13
diff -u -p -r1.13 winbase.h
--- winbase.h	7 Jun 2005 19:31:42 -0000	1.13
+++ winbase.h	12 Jul 2008 12:20:43 -0000
@@ -1,6 +1,6 @@
 /* winbase.h
 
-   Copyright 2002, 2003, 2004 Red Hat, Inc.
+   Copyright 2002, 2003, 2004, 2008 Red Hat, Inc.
 
 This software is a copyrighted work licensed under the terms of the
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
@@ -12,7 +12,7 @@ details. */
 #define _WINBASE2_H
 
 extern __inline__ long
-ilockincr (long *m)
+ilockincr (volatile long *m)
 {
   register int __res;
   __asm__ __volatile__ ("\n\
@@ -24,7 +24,7 @@ ilockincr (long *m)
 }
 
 extern __inline__ long
-ilockdecr (long *m)
+ilockdecr (volatile long *m)
 {
   register int __res;
   __asm__ __volatile__ ("\n\
@@ -36,7 +36,7 @@ ilockdecr (long *m)
 }
 
 extern __inline__ long
-ilockexch (long *t, long v)
+ilockexch (volatile long *t, long v)
 {
   register int __res;
   __asm__ __volatile__ ("\n\
@@ -47,7 +47,7 @@ ilockexch (long *t, long v)
 }
 
 extern __inline__ long
-ilockcmpexch (long *t, long v, long c)
+ilockcmpexch (volatile long *t, long v, long c)
 {
   register int __res;
   __asm__ __volatile__ ("\n\

--------------030909040704050903080007--
