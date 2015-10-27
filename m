Return-Path: <cygwin-patches-return-8269-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 56919 invoked by alias); 27 Oct 2015 14:11:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 56862 invoked by uid 89); 27 Oct 2015 14:11:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 27 Oct 2015 14:11:11 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7FE7AA803FA; Tue, 27 Oct 2015 15:11:08 +0100 (CET)
Date: Tue, 27 Oct 2015 14:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Remove spurious execute permissions from some Cygwin source and text files
Message-ID: <20151027141108.GU5319@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1445953968-4932-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Dp1s8ZelCQsTdIdV"
Content-Disposition: inline
In-Reply-To: <1445953968-4932-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q4/txt/msg00022.txt.bz2


--Dp1s8ZelCQsTdIdV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 552

On Oct 27 13:52, Jon Turney wrote:
> 2015-08-21  Jon Turney  <jon.turney@dronecode.org.uk>
>=20
> 	* cygwin-cxx.h: Remove execute permissions.
> 	* fenv.cc: Ditto.
> 	* how-startup-shutdown-works.txt: Ditto.
> 	* include/arpa/nameser.h: Ditto.
> 	* include/arpa/nameser_compat.h: Ditto.
> 	* include/fenv.h: Ditto.
> 	* include/resolv.h: Ditto.
> 	* libstdcxx_wrapper.cc: Ditto.

Shoot.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Dp1s8ZelCQsTdIdV
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWL4X8AAoJEPU2Bp2uRE+gVZ0QAJJUy5bdhW5jbBCQpBCcPBXV
M3Vpb1/2IhEDyb5F2ztqjHRyBKBqWkFHXiNgIuEndUPZLf5U1CukwEQv5CujEfwH
2yAAtw2XmUH3j8QgV0Q7Nlr7/0LOpKZIDVFyhEKoY3oFKJLAwQdO9A9kJeIxpu59
zCZSIfR2YnjbTGUcXGcsDoifMsS7RcKZ392ussNPx5SX2gpcVUt5VDvUCFDuoQOO
f8sysNn7yUoYh17FJC9cC/OlHdknEVGVyfFnX257rTExyN6efaUCY5L8mIwGoKGk
zT0BtKLsaQlZ0hOy6jjSzCLW9DE53dZHg73s3t0K5258hHceuP2lCxzFeAx7v/Kq
4NFsOdDE7A/fFBk5ExI1uU4J3J2WY/yC5HdiNN8v0hlJseianCdnAoIu05q3OlSK
nostM1TGssJ74xtK5ihLvNeWdKYsJtfh/IJ/Iu4B/SFC9VL1PFi7M7nbW7TbYVom
SsHGIPsGTgYE8R4Vhb3XOs3rDQVcQxvrGPN/iEeUi2ugtiwpmua2ntWwx7JB6uc9
I0+zlk4eKALnUedQCJX774GZBqfplE7QJKSusuMoZco+jJ7lPhyVxvmTi5iiMU2q
qt9sElsT14NKsNjPhOzmBGuwJ6uc10vJ1FrE87NiceopGpemwiRf8wSF7irxa3mf
uwzXGNoLhY+lOOUA0yiS
=EgRy
-----END PGP SIGNATURE-----

--Dp1s8ZelCQsTdIdV--
