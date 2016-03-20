Return-Path: <cygwin-patches-return-8432-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40269 invoked by alias); 20 Mar 2016 10:57:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40254 invoked by uid 89); 20 Mar 2016 10:57:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:877, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 20 Mar 2016 10:57:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AEA60A805AC; Sun, 20 Mar 2016 11:56:58 +0100 (CET)
Date: Sun, 20 Mar 2016 10:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 02/11] Remove dead code from fhandler_console.
Message-ID: <20160320105658.GE25241@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458409557-13156-1-git-send-email-pefoley2@pefoley.com> <1458409557-13156-2-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="zaRBsRFn0XYhEU69"
Content-Disposition: inline
In-Reply-To: <1458409557-13156-2-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00138.txt.bz2


--zaRBsRFn0XYhEU69
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 943

On Mar 19 13:45, Peter Foley wrote:
> This if is unconditionally false, so remove it.
>=20
> winsup/cygwin/fhandler_console.cc: In member function 'bool dev_console::=
fillin(HANDLE)':
> winsup/cygwin/fhandler_console.cc:740:22: error: self-comparison always e=
valuates to false [-Werror=3Dtautological-compare]
>        if (b.dwSize.Y !=3D b.dwSize.Y || b.dwSize.X !=3D b.dwSize.X)
>            ~~~~~~~~~~~^~~~~~~~~~~~~
> winsup/cygwin/fhandler_console.cc:740:50: error: self-comparison always e=
valuates to false [-Werror=3Dtautological-compare]
>        if (b.dwSize.Y !=3D b.dwSize.Y || b.dwSize.X !=3D b.dwSize.X)
>                                        ~~~~~~~~~~~^~~~~~~~~~~~~
>=20
> winsup/cygwin/ChangeLog
> * fhandle_console.cc (fillin): remove dead code

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--zaRBsRFn0XYhEU69
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW7oH6AAoJEPU2Bp2uRE+gHQkP/j+8z7YuV1Wyn6JPNXEFYSys
5jrK03tTKkNnKJ2ielhdLZIqiV2oN5apoF/BoN1qoRZPYxldCwt9FK6uikpFfcFC
7a/iYUGOwVcp1xm6RdouBec263rkrARIwOxUpmIgKm7d55pwqae5BoYvgt9DJguX
peSAN6k8jvZUEXRoe55yMMBdJLpZmgsTyWz+X30pVn1eprNjB17Ps19XNJMI01h/
R6TpTX793XfBP1NBTqVriPzjPA1d2vfd8vJ1Qplg1zhGESfwICq0zEIyfDeaCit9
hwQvwcsHnzNPrXtchaXjj5FE7GkZyJ3EdmJYvPDGRnXU41IQ/K2VvLxbXU06jqkb
Y/d0OhL4/TSGysP/bDwLAiNUqo+u5coBeHuhLC2sI4it11TdH5bfli0OP7AD1AmR
VKZiJ1UyiH4qkA1xbn70+YLtgsJcK1RFq1l54MlF4Uk0ZTykq0z/s8jeskxkeK4j
LsEHTG0gW5uO2Yf8dUg53fidLXl67ebieBx5RqC34uJ4Dw+XYvZpzWZoLB+g944f
fGDnyzvfR287Ici1u2rGkKabnLSWzujrwH/8fEfIOaezqHCuVU+Es7sET8kUqS5d
LnwS7kqiW+bIBc3+BbgnFyHCR7mIk5ESDlTc6GHvmrbG0gsct3NobGHbI99ZUwhe
/Vu9aFOethkRmj/N6K7r
=DqE7
-----END PGP SIGNATURE-----

--zaRBsRFn0XYhEU69--
