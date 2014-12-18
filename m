Return-Path: <cygwin-patches-return-8044-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9901 invoked by alias); 18 Dec 2014 17:24:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 9846 invoked by uid 89); 18 Dec 2014 17:24:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.9 required=5.0 tests=AWL,BAYES_00 autolearn=ham version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 18 Dec 2014 17:24:24 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3B7428E12DF; Thu, 18 Dec 2014 18:24:22 +0100 (CET)
Date: Thu, 18 Dec 2014 17:24:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] spelling fix for struct passwd
Message-ID: <20141218172422.GG10824@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <54930D04.6030608@cygwin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="LGr9gtkSK9ARF7Ax"
Content-Disposition: inline
In-Reply-To: <54930D04.6030608@cygwin.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2014-q4/txt/msg00023.txt.bz2


--LGr9gtkSK9ARF7Ax
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 521

On Dec 18 11:21, Yaakov Selkowitz wrote:
> This field is spelled pw_passwd on Linux, and I haven't found a different
> spelling on other platforms (it is not mandated by POSIX). Patch attached.
>=20
> --
> Yaakov
>=20

> 2014-12-18  Yaakov Selkowitz  <yselkowitz@...>
>=20
> 	* ntsec.xml (ntsec-logonuser): Fix spelling of pw_passwd field.

Thanks, please apply.


Corinna


--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--LGr9gtkSK9ARF7Ax
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUkw3GAAoJEPU2Bp2uRE+gVWYQAJL3ImQI6CFr920T3a5CmzBO
aKh4ZGcg2KqGoFUmCdvyJ4IzqiakSNk4zJwfesNqP19BPul6jKybp5zhtArt/f0h
MjpYeGR+qZrLj79L+G613ZnlBCQCW/eRzTfltXY1PL1YjEtxVCCa83aymC6V5/Sv
PY6lv3RTb8Z1ETnnjY8l/tJQbMfEuGbA8D7TRx2GQ2awfYxuXjTu1KkFyfCeTZGa
b0YbFN0I37yKCROkljBWKUOGSV/XBik4tWDnWYKV3yyrJBQ5c5qt/XcOJp67frs5
chUaGSfDV/zE2L4nHPZPpXTChRN0IK3SXuhIubyn4qKYjzy4vJzcuDqbA436phaC
KAAXyCLcigY6UHZ9boawAFqQ+YcfmdaxCvum/pAqRQNEXdE2wTYOAF5wtA4E1UuZ
sWsi4X5XqJ0ThoDtOm0CDmeB7K8winACi80rJtyhpq8HmCXhAV/113mPQvGre7Sw
OMammCMwkcs5q4tkhbmHmifFF9UWD/8jICifiGrz+kZl8L6fORDhI0hjiZXiB0yM
AaZT6GH2V5JJyWAvlDk74TviLHc9UnsRPpD/iuSZNoOYxBnd8sdwVScX+OAPADPs
HC905W4aDLlhYrYj7yNJ+NUKaretgfnLtfaUHM0czC1IdoAPieCLvO48+GxlLQ0a
ViCYOzTsdnnOwjFt7tSi
=hWGQ
-----END PGP SIGNATURE-----

--LGr9gtkSK9ARF7Ax--
