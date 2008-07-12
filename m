Return-Path: <cygwin-patches-return-6337-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27595 invoked by alias); 12 Jul 2008 12:26:02 -0000
Received: (qmail 27585 invoked by uid 22791); 12 Jul 2008 12:26:02 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta08.emeryville.ca.mail.comcast.net (HELO QMTA08.emeryville.ca.mail.comcast.net) (76.96.30.80)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 12 Jul 2008 12:25:35 +0000
Received: from OMTA14.emeryville.ca.mail.comcast.net ([76.96.30.60]) 	by QMTA08.emeryville.ca.mail.comcast.net with comcast 	id ozsq1Z00B1HpZEsA80RZi6; Sat, 12 Jul 2008 12:25:33 +0000
Received: from [192.168.0.101] ([67.166.125.73]) 	by OMTA14.emeryville.ca.mail.comcast.net with comcast 	id p0RY1Z0041b8C2B8a0RZKf; Sat, 12 Jul 2008 12:25:33 +0000
X-Authority-Analysis: v=1.0 c=1 a=VwBxh0Yp3-sA:10 a=_TXjZqb-V6gA:10  a=w_pzkKWiAAAA:8 a=xe8BsctaAAAA:8 a=IM1sL7UhQGSV6w_Q9D4A:9  a=Rs1gQhEPyZwu801S_HoA:9 a=J5nPAv0cWxH6OmwzhP5n4PxmnAwA:4 a=eDFNAWYWrCwA:10  a=rPt6xJ-oxjAA:10
Message-ID: <4878A2C3.6060908@byu.net>
Date: Sat, 12 Jul 2008 12:26:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: use volatile when replacing Interlocked*
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00000.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Based on a recent patch to the win32 headers
(http://cygwin.com/ml/cygwin-cvs/2008-q2/msg00157.html), the Interlocked*
functions in winbase.h are now properly prototyped to take volatile
arguments.  This patch makes cygwin match.

2008-07-12  Eric Blake  <ebb9@byu.net>

	Fix usage of recently fixed Interlocked* functions.
	* winbase.h (ilockincr, ilockdecr, ilockexch, ilockcmpexch): Add
	volatile qualifier, to match Interlocked* functions.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkh4osMACgkQ84KuGfSFAYCy7gCfbLBKoJANhtDsoaTkjkISBGGp
EAgAoKwCaV9qic2sdJvrJsaWH2kwnF+S
=xkGN
-----END PGP SIGNATURE-----
