Return-Path: <cygwin-patches-return-8166-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 100653 invoked by alias); 15 Jun 2015 17:15:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 100636 invoked by uid 89); 15 Jun 2015 17:15:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 17:15:19 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 26F29A807CE; Mon, 15 Jun 2015 19:15:17 +0200 (CEST)
Date: Mon, 15 Jun 2015 17:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 6/8] winsup/doc: Make it easier to extend xidepend to more targets
Message-ID: <20150615171517.GF26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-7-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-7-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00067.txt.bz2


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 743

On Jun 15 13:36, Jon TURNEY wrote:
> Change xidepend to create a variable containing all the XIncluded sources=
, which
> can be used as a dependency, rather than writing the dependency target it=
self.
>=20
> Future work: Makefile.dep should depend on xidepend, but xidepend should =
not be
> passed to itself.
>=20
> 2015-06-12  Jon Turney  <...>
>=20
> 	* xidepend: Write a Makefile fragment defining variables
> 	containing all the XIncluded sources, rather than a dependency on
> 	those sources.
> 	* Makefile.in: Use that variable to express the dependency.

Please apply.

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfwglAAoJEPU2Bp2uRE+gTXEP/3LXuYyS7wBWKtqVpNF0MfVO
sweu1m4yZFSuZKmCjeIoIuPi2FcAjS27X6lMwAoJa8g3PfT+V3eLiqKsFSH6xynH
tnecS9lojfLMVZmMSJcFn2UNEQ2lvvo07kGC51R+lB3ahF/n1PMx39cky0o6czyO
wMeL81xtUfhU3x8o5pxHqUTzvlxhe+ZW/R/exT6OcXtd9tp20arSV50GWqg5xdgJ
7bAJ4FcsKotqbm2BnjgGnQyrupl4MQ+JxvM+2apc/tJwqN/q2AhNzNK6VQFlhr5D
aGL6yJGnc5aEbua7SNQTY8l7RZF6N63GDanEHEdgonJ2OA83fkAZM5M0pDnCrtkZ
0cXDCiPmttYUXWVM+lB7LSAA1DYypdBB+yf4K2dYEF6TGtvpv0LpcXDtw5IDTqt3
iv9RZ40MBFecbJF+JNkivWUO2JP4aE6i+rZYTtoon48uPNn4YMMDTcYWu5/Rkc8j
CpThGCdamOQgzUKI1WkZkrUKANTQivK/YHxE1TxiafjuCelpoHkvXQMTpB9Wbmt2
2gZQ6KUQKiRMs39qBodIF152K9vLZowWGSyttJUgzGV6stUyop408UAfuWVEQERM
fQMAdJjLHhqPV3M11yzhrBAwRBSXVOqh3d5KWnv/bdqh2oQJSuKSYhCh/3qNRdqS
2SDa5xTALxR75T+F4qIB
=d+kG
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
