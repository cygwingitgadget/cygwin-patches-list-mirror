Return-Path: <cygwin-patches-return-10139-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72596 invoked by alias); 28 Feb 2020 13:31:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71180 invoked by uid 89); 28 Feb 2020 13:31:26 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 28 Feb 2020 13:31:25 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MGxYh-1jCMYr2MOR-00E3Xp; Fri, 28 Feb 2020 14:31:22 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 2A5FFA819D3; Fri, 28 Feb 2020 14:31:22 +0100 (CET)
Date: Fri, 28 Feb 2020 13:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200228133122.GG4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,	Hans-Bernhard =?utf-8?Q?Br=C3=B6ker?= <HBBroeker@t-online.de>
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="foM9DbudB2CcldhH"
Content-Disposition: inline
In-Reply-To: <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00245.txt


--foM9DbudB2CcldhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 803

[CC Hans]

On Feb 28 11:14, Takashi Yano wrote:
> On Thu, 27 Feb 2020 18:03:47 +0000
> Jon Turney wrote:
> > > +#define wpbuf_put(x) \
> > > +  wpbuf[wpixput++] =3D x; \
> > > +  if (wpixput > WPBUF_LEN) \
> > > +    wpixput--;
> > > +
> >=20
> > So I think either the macro need it contents contained by a 'do { ... }=
=20
> > while(0)',  or that instance of it needs to be surrounded by braces, to=
=20
> > do what you intend.
>=20
> Thanks for the advice. Fortunately, "if" statement does not
> cause a problem even if it is accidentally executed outside
> "else" block in this case.
>=20
> Hans,
> as for making a patch for this issue, may I leave it to you
> because you are already working on it?=20
>=20
> --=20
> Takashi Yano <takashi.yano@nifty.ne.jp>

--=20
Corinna Vinschen
Cygwin Maintainer

--foM9DbudB2CcldhH
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5ZFikACgkQ9TYGna5E
T6ANSQ/6A+NVpLgqlea+YIiYJffIUWY08yH9zjvhHXdsmCwhV5x+ZycutEpopkf6
P9ct84YzM1vmS/DvugXWsw3sRicGWZvXKlHcwyk5UoC0GZxWgyngJnxjWRU2Icd/
rLqCXConan1ADGP5rXfYzTOiRiJmyJA5sPIzfz7v89J5/t2jr1KfFTSZb3w6NsNi
3Ow1VQ04kmW+ZfZSmW/Uzu6nelvsnzOiSpOh1S4c9BKE3Rx1NuTICeYWTJg5C8I4
i1wHlhnFKoE3TwQjLZ43C5wjSLiqseWeQe56QnqlfRMLnw8Jk5u7q1CLv/ofbbVj
sdPQqi9/z74Ywh/iO8k5TUv3QOnoiH0pDILPkwfXiTrGTci7UIIkO97p3comgIku
yTaDwatzBf6VYGU1OpqtcEtdd7EQpJayrGK8RS4jtJ2m5q3MGMFQTohCUbUjljhE
eQ+nIigjf/fYIXYxd8uB0m5qn4W6NPG+O9/tkyqqEXmhFLNsnWwBtKbq+F+P/DLC
fOJMTgdzl0boIhx9ITBFu7qSDOP1gxg2cETaHJsU5H8HwNV+1cqjpzI7rfHHJdDO
E+4/HAdzxhONMDkmOxmQpRKpUahK4CeY1TD6Gpc5HLzRmquyYMPWc7yAZkWlkjgH
fPO4kuWfZ+iU8kg+G2JaKWGVrDfUmb6Zf6EHX35iOfO7WWq+crg=
=3zq0
-----END PGP SIGNATURE-----

--foM9DbudB2CcldhH--
