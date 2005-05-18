Return-Path: <cygwin-patches-return-5453-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19539 invoked by alias); 18 May 2005 00:13:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19408 invoked from network); 18 May 2005 00:12:52 -0000
Received: from unknown (HELO mg2.works.net.au) (203.22.251.251)
  by sourceware.org with SMTP; 18 May 2005 00:12:52 -0000
Received: from aardvark.ozdial.net.au (aardvark.ozdial.net.au [203.22.251.121])
	by mg2.works.net.au (8.12.11/linuxconf) with ESMTP id j4I0CkpO004252
	for <cygwin-patches@cygwin.com>; Wed, 18 May 2005 10:12:46 +1000
Received: from lifelesswks.robertcollins.net (dsl-137.0.240.220.rns01-kent-syd.dsl.comindico.com.au [220.240.0.137])
	by aardvark.ozdial.net.au (8.12.8/linuxconf) with ESMTP id j4I0Cenn028023
	for <cygwin-patches@cygwin.com>; Wed, 18 May 2005 10:12:46 +1000
Received: from [3ffe:8002:1004:0:20e:35ff:fe07:eee9] (helo=lifelesslap.robertcollins.net ident=Debian-exim)
	by lifelesswks.robertcollins.net with asmtp (Exim 4.34)
	id 1DYCAz-0004wU-Aa
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 10:12:41 +1000
Received: from localhost ([127.0.0.1] ident=robertc)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.34)
	id 1DYCAw-0008AK-LR
	for cygwin-patches@cygwin.com; Wed, 18 May 2005 10:12:38 +1000
Subject: Re: [patch] gcc4 fixes
From: Robert Collins <rbcollins@cygwin.com>
To: cygwin-patches@cygwin.com
In-Reply-To: <20050517233150.GB9001@trixie.casa.cgf.cx>
References: <428A7520.7FD9925C@dessent.net>
	 <20050517233150.GB9001@trixie.casa.cgf.cx>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4y2My7b1gzFK+iYdHBGD"
Date: Wed, 18 May 2005 00:13:00 -0000
Message-Id: <1116375158.11131.88.camel@localhost>
Mime-Version: 1.0
X-MG2-Works-MailScanner-Information: Please contact the ISP for more information
X-MG2-Works-MailScanner: Found to be clean
X-MG2-Works-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-MailScanner-From: rbcollins@cygwin.com
X-SW-Source: 2005-q2/txt/msg00049.txt.bz2


--=-4y2My7b1gzFK+iYdHBGD
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Content-length: 935

On Tue, 2005-05-17 at 19:31 -0400, Christopher Faylor wrote:
> On Tue, May 17, 2005 at 03:50:08PM -0700, Brian Dessent wrote:
> >
> >This is just a trivial change of argument to execl() testcases, which
> >supresses the warning 'missing sentinel in function call' in gcc4 that
> >causes the tests to fail.
> >
> >winsup/testsuite
> >2005-05-17  Brian Dessent  <brian@dessent.net>
> >
> >	* winsup.api/signal-into-win32-api.c (main): Use 'NULL' instead
> >	of '0' in argument list to avoid compiler warning with gcc4.
> >	* winsup.api/ltp/execle01.c (main): Ditto.
> >	* winsup.api/ltp/execlp01.c (main): Ditto.
> >	* winsup.api/ltp/fcntl07.c (do_exec): Ditto.
> >	* winsup.api/ltp/fcntl07B.c (do_exec): Ditto.
>=20
> Go ahead and check these in but please use GNU formatting conventions,
> i.e., it's (char *) NULL, not (char *)NULL.  Actually, isn't just NULL
> sufficient?

Should be: NULL is '(void *) 0' on most compilers.=20

Rob

--=-4y2My7b1gzFK+iYdHBGD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part
Content-length: 189

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCioh2M4BfeEKYx2ERAoa8AJ4++t36qD6T5UVs2AQxeSaBRQ55jwCcDfwz
eShovRhsF9Y3P7y8d7S3Yrw=
=nl/a
-----END PGP SIGNATURE-----

--=-4y2My7b1gzFK+iYdHBGD--
