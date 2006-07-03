Return-Path: <cygwin-patches-return-5909-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24730 invoked by alias); 3 Jul 2006 12:10:59 -0000
Received: (qmail 24719 invoked by uid 22791); 3 Jul 2006 12:10:58 -0000
X-Spam-Check-By: sourceware.org
Received: from sccrmhc13.comcast.net (HELO sccrmhc13.comcast.net) (204.127.200.83)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 03 Jul 2006 12:10:55 +0000
Received: from [192.168.0.101] (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225])           by comcast.net (sccrmhc13) with ESMTP           id <2006070312105301300b03ure>; Mon, 3 Jul 2006 12:10:53 +0000
Message-ID: <44A90949.6040209@byu.net>
Date: Mon, 03 Jul 2006 12:10:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: Fix UINT{8,16}_C
References: <44A8347F.2000206@byu.net> <20060703094136.GB14901@calimero.vinschen.de>
In-Reply-To: <20060703094136.GB14901@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00004.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Corinna Vinschen on 7/3/2006 3:41 AM:
>   
> 
> I have checked the stdint.h headers on glibc 2.3.4 and 2.4, as well as
> on Solaris 10, NetBSD, FreeBSD and OpenBSD.  Only FreeBSD and OpenBSD
> define them as just x, all others as x##U, one way or the other.

And gnulib rejects Solaris 10 and glibc's versions as buggy as well:

http://lists.gnu.org/archive/html/bug-gnulib/2006-06/msg00118.html

> 
> ISO/IEC 9899:TC2 (http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1124.pdf)
> has the following to say:
> 
>   7.18.4.1 Macros for minimum-width integer constants
> 
>   The macro INTN_C(value) shall expand to an integer constant expression
>   corresponding to the type int_leastN_t.

The problem is that there is no integer constant expression for unsigned
char; instead, you get an integer constant expression for the type that
unsigned char promotes to.  Therefore, UINT8_C should give an int, not
unsigned int.

This snippet from gnulib is valid C code, but fails if you use the wrong
type specifier:

  /* Detect bugs in glibc 2.4 and Solaris 10 stdint.h, among others.  */
  int check_UINT8_C:
	(-1 < UINT8_C (0)) == (-1 < (uint_least8_t) 0) ? 1 : -1;
  int check_UINT16_C:
	(-1 < UINT16_C (0)) == (-1 < (uint_least16_t) 0) ? 1 : -1;


- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEqQlJ84KuGfSFAYARAiZ6AJ96BYisYJGTcK89Nbc+LWzeaaOCTQCbBdy6
fvwEMp2hXBTtEsSaVSOg30w=
=ddci
-----END PGP SIGNATURE-----
