Return-Path: <cygwin-patches-return-9152-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121946 invoked by alias); 26 Jul 2018 08:21:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 121934 invoked by uid 89); 26 Jul 2018 08:21:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=pipes
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 26 Jul 2018 08:21:30 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MR9Bb-1fZ5f32vhn-00UbKb; Thu, 26 Jul 2018 10:20:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 39779A818D7; Thu, 26 Jul 2018 10:20:00 +0200 (CEST)
Date: Thu, 26 Jul 2018 08:21:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Mark Geisert <mark@maxrnd.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Update _PC_ASYNC_IO return value
Message-ID: <20180726082000.GA6175@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Mark Geisert <mark@maxrnd.com>, cygwin-patches@cygwin.com
References: <20180725200643.10750-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
In-Reply-To: <20180725200643.10750-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00047.txt.bz2


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1130

On Jul 25 15:06, Yaakov Selkowitz wrote:
> >From discussion on IRC:
>=20
> <yselkowitz> corinna, just sent a patch for _POSIX_ASYNCHRONOUS_IO as a
> 	  follow-up to the AIO feature, but am still wondering about
> 	  _[POSIX|PC]_ASYNC_IO
> [snip]
> <corinna> in terms of _PC_ASYNC_IO, the test might be a bit tricky
> <corinna> let me check
> <corinna> actually, no
> <corinna> it's easy
> <corinna> Mark implemented the stuff with pread/pwrite only on disk files
> <corinna> but otherwise it's device independent in that he implemented a
> 	  workaround for pipes and stuff
> <corinna> so, in theory we can just return 1
>=20
> I'm not sure how to test this atm, but based on the above I have made
> the following patch so this doesn't get lost.
>=20
> Yaakov Selkowitz (1):
>   Cygwin: fpathconf: update _PC_ASYNC_IO return value
>=20
>  winsup/cygwin/fhandler.cc | 1 +
>  1 file changed, 1 insertion(+)
>=20
> --=20
> 2.17.1

Mark?  Any comment you want to make?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltZhDAACgkQ9TYGna5E
T6DFrQ//dzzaXSntDrYE30OXVBiZsIEY2vBghZFVV5A9DdI5ejqlX44/Xky8zVtL
WLV3l1JM4whXqxUr5bqLNFRTgbRqpj4g8g+hGxhxSUhIT2uSwHNl/ar9nXHyumzD
eVAePub5L6gVelmh3Rac2GlxVOBdnCz2Xe33zX4JkNw/lwgf5df+fktVRCcNXD+f
C8pMFJw90lOPpctclTtcUjjOPpbyFK3/rYO7Q6HKCooi/otcssPrsUkhPUp8Ydec
xbNmMZIJSDKHDwZDm0zt17SSqp9vYU89r6PVLA6zKMG80Ig+ZEYJYaGQsAHsLiGn
iesGMDas2r9ySSpesICbAJvQMk2kLcKmy0liYqS0uM2LVvJGhHI1wSAFWQOmpQWf
ioM8CHwhP7xdFroVYgKjRHrdRgOUXLfS4c37oZkh366RgORTpg1hDyCClNDYj6gs
5lqZ+8QL68hJWzuIBHkYZNym2lKHnUdFi+Unc36ixkIzvS5+JUmV56ZNaR156Srk
palxp81J3/Dt82SEpP6lRyjgIbEye2vy0oEOa5Gr80hQpuEm8Gyk1FjOyDc0BeVO
itGMRLspQR2alwEPwbdGWUPNZWc0e0didFUBHWopJELTw9AklEI0zFRWx1X6HQqy
U4d5ozw8NvvZlpjXYHrhY9Vo9h+v32WAR5xZ89MIUpDx8yk1LMw=
=HpX4
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
