Return-Path: <cygwin-patches-return-5907-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3554 invoked by alias); 3 Jul 2006 09:41:48 -0000
Received: (qmail 3542 invoked by uid 22791); 3 Jul 2006 09:41:47 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 03 Jul 2006 09:41:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id B547E544001; Mon,  3 Jul 2006 11:41:36 +0200 (CEST)
Date: Mon, 03 Jul 2006 09:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix UINT{8,16}_C
Message-ID: <20060703094136.GB14901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <44A8347F.2000206@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A8347F.2000206@byu.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00002.txt.bz2

On Jul  2 15:02, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to POSIX, UINT{8,16}_C should result in an integer constant with
> "the same type as would an expression that is an object of the
> corresponding type converted according to the integer promotions."  And
> according to C, unsigned char promotes to signed int, when int is wider
> than char.  Gnulib now tests for bugs in stdint.h, and these are the
> remaining two issues that makes cygwin's version non-compliant:
> [...]
> @@ -169,8 +169,8 @@ typedef unsigned long long uintmax_t;
>  #define INT32_C(x) x ## L
>  #define INT64_C(x) x ## LL
>  
> -#define UINT8_C(x) x ## U
> -#define UINT16_C(x) x ## U
> +#define UINT8_C(x) x
> +#define UINT16_C(x) x
>  #define UINT32_C(x) x ## UL
>  #define UINT64_C(x) x ## ULL
>  

I have checked the stdint.h headers on glibc 2.3.4 and 2.4, as well as
on Solaris 10, NetBSD, FreeBSD and OpenBSD.  Only FreeBSD and OpenBSD
define them as just x, all others as x##U, one way or the other.

ISO/IEC 9899:TC2 (http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1124.pdf)
has the following to say:

  7.18.4.1 Macros for minimum-width integer constants

  The macro INTN_C(value) shall expand to an integer constant expression
  corresponding to the type int_leastN_t. The macro UINTN_C(value) shall
  expand to an integer constant expression corresponding to the type
  uint_leastN_t. For example, if uint_least64_t is a name for the type
  unsigned long long int, then UINT64_C(0x123) might expand to the
  integer constant 0x123ULL.

This is the case with our definition and with the definitions in glibc/
Solaris/NetBSD.  If the gnulib testsuite is right, then glibc fails the
test as well.  Has this been discussed/resolved on the appropriate
mailing lists?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
