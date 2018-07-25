Return-Path: <cygwin-patches-return-9149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 55302 invoked by alias); 25 Jul 2018 07:48:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 55222 invoked by uid 89); 25 Jul 2018 07:47:47 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=believed
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 25 Jul 2018 07:47:46 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id 0Lzna3-1g5F9g1og7-0150VN for <cygwin-patches@cygwin.com>; Wed, 25 Jul 2018 09:47:43 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 28457A809C3; Wed, 25 Jul 2018 09:47:43 +0200 (CEST)
Date: Wed, 25 Jul 2018 07:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH final] POSIX Asynchronous I/O support
Message-ID: <20180725074743.GI3312@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180724053159.2676-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jt0yj30bxbg11sci"
Content-Disposition: inline
In-Reply-To: <20180724053159.2676-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00044.txt.bz2


--jt0yj30bxbg11sci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 873

On Jul 23 22:31, Mark Geisert wrote:
> (Let's try that again from the correct directory...)
>=20
> This is believed to be the final patch set implementing POSIX AIO.  It
> incorporates updates and fixes for all issues brought up over several
> review cycles the last few months.  The implementation has been tested
> with a couple different spot-check programs, as well as with iozone for
> stress testing.  It's time to open it up for wider usage.
> Thanks & Regards,
>=20
> ..mark

Pushed.  Thanks a lot for this valuable addition.  I'm creating
developer snapshots right now.

I guess it's time to start the release cycle for 2.11 soon.  I'm
planning to push out test releases in the next couple of days.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jt0yj30bxbg11sci
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltYKx8ACgkQ9TYGna5E
T6CwexAApYUkjxfwf4t0Y/2n1fGGY6mSJ2qbjXPJPbqsVq1Wk0zgFbs0jo9irZa0
iJS9w8Im7nuQl1TsmjxjzHvRbRzyzqT9yr8a+c97TvG8Zh5B/+0bC1NoP5YUOeYm
Vp4jyUCtJOh1+jFvWIszhSEllVAiFsJuU5YD1AMRq1WXxzvp3py0PDzJU+b0xcf4
fpoCS3E59iXL4Rok/TapJDdReuLyCup6a254X7KccpD4tdl7EOux6YuIgeO+GHZ7
CTkwCwUqnvnu94HSUYYWZN/HJ0GpQzJ+MxwyjIhE2nyDj1a66kB1kl4X+Qge2NqA
zJk07G6HXLZINYyIVLMBn0bp6FfX9SsndDBhKGLCY9toRhoD0mpHFIJxuur6eaha
SKhvMmFOGg0V1+Z4+Og/hSXUtGlIT/lD3BzUy0MgZpyL2zwTkAPKrWqnIPx2XJ4n
mE4K/SlxHAODQSQpx3VwOmkm6F3zm55Cdpv72mKxdt6pr447lsuEV1A2JI9JtxpK
QoanmDHafCs9N66c5i9PE0mR8D80ZnthZDn6xCljgsi6AoYf0IPo3n9bcFeKYnbn
xmNsu/wFFi/x4y0KtWYiOit79a4uPwt9O+94pOEYNk35fXBOSNQlo5dEOFKXfIJX
oXOJSTRKqQtcPpjx4pd1CvRobgOK84G31vXLtRLE7W2odAH7ImE=
=fkHB
-----END PGP SIGNATURE-----

--jt0yj30bxbg11sci--
