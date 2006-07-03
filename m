Return-Path: <cygwin-patches-return-5910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3199 invoked by alias); 3 Jul 2006 12:31:19 -0000
Received: (qmail 3183 invoked by uid 22791); 3 Jul 2006 12:31:18 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 03 Jul 2006 12:31:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 18BE5544001; Mon,  3 Jul 2006 14:31:07 +0200 (CEST)
Date: Mon, 03 Jul 2006 12:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix UINT{8,16}_C
Message-ID: <20060703123107.GY18873@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <44A8347F.2000206@byu.net> <20060703094136.GB14901@calimero.vinschen.de> <44A90949.6040209@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A90949.6040209@byu.net>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00005.txt.bz2

On Jul  3 06:10, Eric Blake wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> According to Corinna Vinschen on 7/3/2006 3:41 AM:
> >   
> > 
> > I have checked the stdint.h headers on glibc 2.3.4 and 2.4, as well as
> > on Solaris 10, NetBSD, FreeBSD and OpenBSD.  Only FreeBSD and OpenBSD
> > define them as just x, all others as x##U, one way or the other.
> 
> And gnulib rejects Solaris 10 and glibc's versions as buggy as well:
> 
> http://lists.gnu.org/archive/html/bug-gnulib/2006-06/msg00118.html
> 
> > 
> > ISO/IEC 9899:TC2 (http://www.open-std.org/jtc1/sc22/wg14/www/docs/n1124.pdf)
> > has the following to say:
> > 
> >   7.18.4.1 Macros for minimum-width integer constants
> > 
> >   The macro INTN_C(value) shall expand to an integer constant expression
> >   corresponding to the type int_leastN_t.
> 
> The problem is that there is no integer constant expression for unsigned
> char; instead, you get an integer constant expression for the type that
> unsigned char promotes to.  Therefore, UINT8_C should give an int, not
> unsigned int.
> 
> This snippet from gnulib is valid C code, but fails if you use the wrong
> type specifier:
> 
>   /* Detect bugs in glibc 2.4 and Solaris 10 stdint.h, among others.  */
>   int check_UINT8_C:
> 	(-1 < UINT8_C (0)) == (-1 < (uint_least8_t) 0) ? 1 : -1;
>   int check_UINT16_C:
> 	(-1 < UINT16_C (0)) == (-1 < (uint_least16_t) 0) ? 1 : -1;

Convinced.  I checked in your patch.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
