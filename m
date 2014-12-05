Return-Path: <cygwin-patches-return-8040-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27096 invoked by alias); 5 Dec 2014 10:07:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 27083 invoked by uid 89); 5 Dec 2014 10:07:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 05 Dec 2014 10:07:21 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 628868E12E1; Fri,  5 Dec 2014 11:07:19 +0100 (CET)
Date: Fri, 05 Dec 2014 10:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] qsort_r (pending newlib patch)
Message-ID: <20141205100719.GA32747@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <548121B7.2010803@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
In-Reply-To: <548121B7.2010803@cygwin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00019.txt.bz2


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 655

On Dec  4 21:08, Yaakov Selkowitz wrote:
> Attached.
>=20
> --
> Yaakov

> 2014-12-04  Yaakov Selkowitz  <yselkowitz@...>
>=20
> 	doc/
> 	* new-features.xml (ov-new1.7.34): Document qsort_r and __bsd_qsort_r.
> 	* posix.xml (std-bsd): Add qsort_r.
> 	(std-gnu): Ditto.
> 	(std-notes): Add section for qsort_r.
>=20
> 	cygwin/
> 	* common.din (__bsd_qsort_r): Add.
> 	(qsort_r): Add.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Ok to apply when the newlib change is in.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgYPXAAoJEPU2Bp2uRE+gaxUP/imCX1J9bb5Pj9gaF63UUgJ6
MyW1yt++ENZw4cHqW2DOgQpHIrXeWQWxvFOOdpF6yg3ucN+pdFaojYzoDEnUY2sy
vyj8vZgD/ixnnQSOLWKblmAHOwm2Kc9qIS8PLDZO0RWN+/NvVIcUIF24l7l/Trl5
534Nf1Foa/iS3Y//XU/S8Vam66k6uSYhppAQ/pVV1b7b+H7v0+V9TbmWZ2ph0H2l
4HiUsC00t5hN+lAAjpT29SIGz1uwFymI7WmoULRjo+VlQ2Y66ra0M4ti+aVBNNP2
d/8rWwbKzeeGEZ76CppdlpKzxYz5sGwgK23CA6bF1xkTIFtMb3pqjx6MZ1Ynth8J
EZcbSuFII8Mo92lm/zzoHPTeFAoYdL798aHfFsooi/2onq1Em2cYoYlxEule6qZ6
k6aMfgpBzvja/qeTgBHoCaUBTAQ/ds/d8v6W1DoUL5G3WdvMjP0fAB9/qyv//ztb
r8tDRi5g2elYHhKvgdnyQRqdTAwej1Rmfd+QEin3GnK3Fs8Rm0NXyeiWj7zLvwIE
7zNQtwTb2F9Plymu1b2yOlcyIsklqpumBMyB6+Yx0zE4HKSoIYTNAAiJWEpGAEnU
0lEmj11w6o781Q6Hg5XDHT3K1LGMx5kp/vS945/TVNz+NX/9ki8AnVmypTRoKAh7
M/SSQ/VQ3aSo3VizcoxA
=EA2x
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
