Return-Path: <cygwin-patches-return-6521-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16294 invoked by alias); 20 May 2009 12:51:26 -0000
Received: (qmail 16284 invoked by uid 22791); 20 May 2009 12:51:25 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0 	tests=AWL,BAYES_00,J_CHICKENPOX_32,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta02.emeryville.ca.mail.comcast.net (HELO QMTA02.emeryville.ca.mail.comcast.net) (76.96.30.24)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 20 May 2009 12:51:18 +0000
Received: from OMTA01.emeryville.ca.mail.comcast.net ([76.96.30.11]) 	by QMTA02.emeryville.ca.mail.comcast.net with comcast 	id tnsl1b0050EPchoA2orJKW; Wed, 20 May 2009 12:51:18 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA01.emeryville.ca.mail.comcast.net with comcast 	id torG1b00C0Lg2Gw8MorHNG; Wed, 20 May 2009 12:51:17 +0000
Message-ID: <4A13FCC7.6010603@byu.net>
Date: Wed, 20 May 2009 12:51:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: avoid compiler warning with DEBUGGING
Content-Type: multipart/mixed;  boundary="------------050704060902040608030905"
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
X-SW-Source: 2009-q2/txt/msg00063.txt.bz2

This is a multi-part message in MIME format.
--------------050704060902040608030905
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 705

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I noticed a complaint about comparing signed and unsigned values, when
compiling with DEBUGGING enabled.  net.cc also has a lot of trailing blanks.

2009-05-20  Eric Blake  <ebb9@byu.net>

	* net.cc (gethostby_helper): Use correct signedness.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoT/McACgkQ84KuGfSFAYB5yACbBSHBbYlplWSHVtl32doXLLRP
tFYAni2YcsLFsNUgUp62jYlqGc82jD/y
=WPYH
-----END PGP SIGNATURE-----

--------------050704060902040608030905
Content-Type: text/plain;
 name="cygwin.patch15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch15"
Content-length: 601

diff --git a/winsup/cygwin/net.cc b/winsup/cygwin/net.cc
index cb0a5cd..79b2dfa 100644
--- a/winsup/cygwin/net.cc
+++ b/winsup/cygwin/net.cc
@@ -960,7 +960,8 @@ gethostby_helper (const char *name, const int af, const int type,

   record * anptr = NULL, * prevptr = NULL, * curptr;
   int i, alias_count = 0, string_size = 0, address_count = 0;
-  int complen, namelen1 = 0, address_len = 0, antype, anclass, ansize;
+  unsigned int complen;
+  int namelen1 = 0, address_len = 0, antype, anclass, ansize;

   /* Get the count of answers */
   ancount = ntohs (((HEADER *) msg)->ancount);
-- 
1.6.2.4


--------------050704060902040608030905--
