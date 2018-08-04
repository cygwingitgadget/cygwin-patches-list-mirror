Return-Path: <cygwin-patches-return-9166-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 45633 invoked by alias); 4 Aug 2018 20:23:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45622 invoked by uid 89); 4 Aug 2018 20:23:35 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-123.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*r:500
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sat, 04 Aug 2018 20:23:33 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue007 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LnHlS-1gQLSG3ine-00haNJ for <cygwin-patches@cygwin.com>; Sat, 04 Aug 2018 22:23:30 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E389AA8185D; Sat,  4 Aug 2018 22:23:29 +0200 (CEST)
Date: Sat, 04 Aug 2018 20:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix return value on aio_read/write success
Message-ID: <20180804202329.GA4180@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180804084426.4128-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <20180804084426.4128-1-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00061.txt.bz2


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1302

On Aug  4 01:44, Mark Geisert wrote:
> Oops. Something that iozone testing had found but I regarded as an
> iozone bug.  Re-reading the man pages set me straight.
> ---
>  winsup/cygwin/aio.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/aio.cc b/winsup/cygwin/aio.cc
> index fe63dec04..571a9621b 100644
> --- a/winsup/cygwin/aio.cc
> +++ b/winsup/cygwin/aio.cc
> @@ -712,7 +712,7 @@ aio_read (struct aiocb *aio)
>        ; /* I think this is not possible */
>      }
>=20=20
> -  return res;
> +  return res < 0 ? res : 0; /* Return 0 on success, not byte count */

The comment only makes sense in comparison to the former code.
I'd reduce this to just "Return 0 on success".

>  }
>=20=20
>  ssize_t
> @@ -902,7 +902,7 @@ aio_write (struct aiocb *aio)
>        ; /* I think this is not possible */
>      }
>=20=20
> -  return res;
> +  return res < 0 ? res : 0; /* Return 0 on success, not byte count */

Ditto.

>  }
>=20=20
>  int
> --=20
> 2.17.0

While we're at it, I just found that asyncread/asyncwrite return int.
Shouldn't they return ssize_t?  That's 32 vs. 64 bit on x86_64.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltmC0EACgkQ9TYGna5E
T6CFrg//Vvoy7uwyETNqbAKPBYCaHux1rbE8igfTT8Uwud+StpeZg+xu27OArSMm
Y3YHoPWmWz1YZqkNinR6Mf0saQMfj5aliBxHY4B0h7NXcILlikmUA3V6UcaTFrdy
8QA9n+Fffn7OA4mQ5AZUkAGcl5Pw8dvvRYfflHR2VpC78ehr2aT9VFRP7RM0WcMM
3Mds6xLH8b9XfiQP5ECRTQPO86GDUgW/QvTCyTT7Bb0wcFVkh2vpKapNnWo6HMr7
GfdeLO9L8A8Tjq+/aEbdifExKWpe9uc1RZSV0sJfLf5ut9EjJqBCaCvPzcBzzL9m
ZXSO7ljMNS+gW0ciZldbCiyFyIVhx2ePLtoAm0fIbUgRr5xmG3rm6UUiCABh7iEK
vKW/m2MiCe6k3yqHi1nAN+Jl7FsyLMGXMiFHt3H/8jyILb+YN9qAZAbmaph0a0zq
OqVderJfCMF/KWzi1V/71N+2f0JntFfBMbre5rRklcNuVHo8GHmJdkcmIAPQ3thg
Z710jWmHMwTTswUKgErEwHMRxWMeiJech4y8PnZCIEXFvBnW5L/Q5n8f80Qn0rRg
Ww+aWAvrA9K9wEUI2989sul7XJj3bsSmjZkF8b0P46p6v4JLpJz99X0nCbC+DSTH
eA+htbktuJnS5suLoVuN+bhIV8f8hmaID2WTLliLBAThrVbMH+Y=
=8TEK
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
