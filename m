Return-Path: <cygwin-patches-return-6061-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30566 invoked by alias); 6 Apr 2007 01:35:22 -0000
Received: (qmail 30551 invoked by uid 22791); 6 Apr 2007 01:35:21 -0000
X-Spam-Check-By: sourceware.org
Received: from alnrmhc13.comcast.net (HELO alnrmhc13.comcast.net) (204.127.225.93)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 06 Apr 2007 02:35:19 +0100
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])           by comcast.net (alnrmhc13) with ESMTP           id <20070406013517b1300jpf2ne>; Fri, 6 Apr 2007 01:35:17 +0000
Message-ID: <4615A415.4080700@byu.net>
Date: Fri, 06 Apr 2007 01:35:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.5.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: stdint.h bug
References: <loom.20070403T201330-772@post.gmane.org> <20070403191301.GA13159@ednor.casa.cgf.cx> <4612FF7F.6080705@byu.net> <20070404073832.GG20261@calimero.vinschen.de>
In-Reply-To: <20070404073832.GG20261@calimero.vinschen.de>
Content-Type: multipart/mixed;  boundary="------------080206040505050806070808"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00007.txt.bz2

This is a multi-part message in MIME format.
--------------080206040505050806070808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 918

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 4/4/2007 1:38 AM:
> On Apr  3 19:29, Eric Blake wrote:
>> 	* include/stdint.h (WINT_MIN, WINT_MAX): Fix definition.
> 
> Thanks, applied.

A two-line patch, and I _still_ managed to botch it.  POSIX requires that
WINT_MIN be unsigned if (wint_t)0 promotes to an unsigned type.

Or in other words, (-1 < WINT_MIN) == ((wint_t) -1 < 0) must be true.

2007-04-05  Eric Blake  <ebb9@byu.net>

	* include/stdint.h (WINT_MIN): Fix sign.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGFaQV84KuGfSFAYARAmW8AJ9QGdXtWbUxllUGN9n0FgONCtOHWACcDxRT
gD5ZhCiGstr+Dx4lr8tsgi8=
=sA5w
-----END PGP SIGNATURE-----

--------------080206040505050806070808
Content-Type: text/plain;
 name="cygwin.patch7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch7"
Content-length: 460

Index: include/stdint.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/stdint.h,v
retrieving revision 1.8
diff -u -p -r1.8 stdint.h
--- include/stdint.h	4 Apr 2007 07:37:53 -0000	1.8
+++ include/stdint.h	6 Apr 2007 01:31:37 -0000
@@ -158,7 +158,7 @@ typedef unsigned long long uintmax_t;
 #endif
 
 #ifndef WINT_MIN
-#define WINT_MIN 0
+#define WINT_MIN 0U
 #define WINT_MAX UINT_MAX
 #endif
 

--------------080206040505050806070808--
