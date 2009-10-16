Return-Path: <cygwin-patches-return-6772-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12858 invoked by alias); 16 Oct 2009 00:40:45 -0000
Received: (qmail 12801 invoked by uid 22791); 16 Oct 2009 00:40:43 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta13.emeryville.ca.mail.comcast.net (HELO QMTA13.emeryville.ca.mail.comcast.net) (76.96.27.243)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 16 Oct 2009 00:40:37 +0000
Received: from OMTA13.emeryville.ca.mail.comcast.net ([76.96.30.52]) 	by QMTA13.emeryville.ca.mail.comcast.net with comcast 	id tCF11c00n17UAYkADCgciA; Fri, 16 Oct 2009 00:40:36 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA13.emeryville.ca.mail.comcast.net with comcast 	id tCgZ1c00H0Lg2Gw8ZCgcAf; Fri, 16 Oct 2009 00:40:36 +0000
Message-ID: <4AD7C107.6000803@byu.net>
Date: Fri, 16 Oct 2009 00:40:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: Honor DESTDIR in w32api and mingw
References: <4AD78C5B.2080107@cwilson.fastmail.fm>
In-Reply-To: <4AD78C5B.2080107@cwilson.fastmail.fm>
Content-Type: text/plain; charset=ISO-8859-1
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
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00103.txt.bz2

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Charles Wilson on 10/15/2009 2:55 PM:
> 	Honor DESTDIR for winsup/mingw and winsup/w32api.
> 	* winsup/mingw/Makefile.in: Honor DESTDIR and add to
> 	FLAGS_TO_PASS.

> +++ winsup/mingw/Makefile.in    15 Oct 2009 20:30:09 -0000
> @@ -26,6 +26,8 @@ srcdir = @srcdir@
>  top_srcdir = @top_srcdir@
>  top_builddir = @top_builddir@
>  
> +DESTDIR =
> +

Why are you setting DESTDIR?  My understanding is that for DESTDIR to work
reliably, you need to use $(DESTDIR), but not set it.  Then make will
default it to empty, which can be changed by either 'make DESTDIR=...' or
'env DESTDIR=... make -e'.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrXwQcACgkQ84KuGfSFAYCbJwCfSi45P5XzLRsybfwMt9MtaFxD
CQMAnA9pZHooPM2KttgO5hvxH63cY7oe
=OfZx
-----END PGP SIGNATURE-----
