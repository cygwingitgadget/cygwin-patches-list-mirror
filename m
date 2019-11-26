Return-Path: <cygwin-patches-return-9859-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18035 invoked by alias); 26 Nov 2019 17:47:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 18022 invoked by uid 89); 26 Nov 2019 17:47:22 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1174
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 26 Nov 2019 17:47:20 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MTiDV-1iNBXy3dnB-00U2hs; Tue, 26 Nov 2019 18:47:15 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B5304A80415; Tue, 26 Nov 2019 18:47:14 +0100 (CET)
Date: Tue, 26 Nov 2019 17:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] newlib/libc/include/sys/features.h: update __STDC_ISO_10646__
Message-ID: <20191126174714.GN13501@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Brian Inglis <Brian.Inglis@systematicsw.ab.ca>,	Cygwin Patches <cygwin-patches@cygwin.com>
References: <20191125084633.GC13501@calimero.vinschen.de> <20191126153441.63022-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
Content-Disposition: inline
In-Reply-To: <20191126153441.63022-1-Brian.Inglis@SystematicSW.ab.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00130.txt.bz2


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1143

On Nov 26 08:34, Brian Inglis wrote:
> newlib wide char conversion functions were updated to
> Unicode 11 on 2019-01-12
> update standard symbol __STDC_ISO_10646__ to
> Unicode 11 release date 2018-06-05 for Cygwin
> ---
>  newlib/libc/include/sys/features.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/newlib/libc/include/sys/features.h b/newlib/libc/include/sys=
/features.h
> index f28dd071b..218807178 100644
> --- a/newlib/libc/include/sys/features.h
> +++ b/newlib/libc/include/sys/features.h
> @@ -521,9 +521,13 @@ extern "C" {
>  /* #define _XOPEN_UNIX				    -1 */
>  #endif /* __XSI_VISIBLE */
>=20=20
> -/* The value corresponds to UNICODE version 5.2, which is the current
> -   state of newlib's wide char conversion functions. */
> -#define __STDC_ISO_10646__ 200910L
> +/*
> + * newlib's wide char conversion functions were updated on
> + *	2019-01-12
> + * to UNICODE version:
> + *	11.0.0 released 2018-06-05
> + */
> +#define __STDC_ISO_10646__ 201806L
>=20=20
>  #endif /* __CYGWIN__ */
>=20=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3dZSIACgkQ9TYGna5E
T6DRcw/+Ivbn7mn7/Gs3p0cEz+rR2cL5RjETUXR6I2hcAKkWUPn8qnTLO/X5ZMTD
ZUc/DIe+ELZdS0AyKALwiAwW3rcqd/zAPBk4aa2wSetVm7X2kTnVKncP1wZ2fIHY
19Ak5Q1rGcTj/AvqxGfkEGOc4MxCP1vs0vV16LfYRtqW5DSnm6F66xyouKYda9tr
pe71AxlG0KUffXyeUHYqFc2oEtdWa7CPugj0h7EaKzrF1G1sjmF9JwuOs+cclg9w
az1TeEDX0/u1VfZUIuWF++bfT6eiFta+QYQTnX377gqFKq/C8phmXP5NaxYM+vkV
TtENS/snfuAr9/FjdOOBmML3jUTdQrusPuH0Q/vs2fOu0cJdjLSt/qa7qUxYiTzC
J/xP/lifECUAScFZ1BeygID6ZVh4kelodKAzWbAHw6RAe3VCjjNtUwCqu6ZT+x5i
2JYsADcqlCiiBnhB2c7oOdPjdD3yNFFfInuaoQC6I0lq/9savyd+uhoEk94WBo+z
+4epb2tnHVJvy9s51Iy1K5UI4m+BbTAAJW2Qh9HHNnlm8+IQcl9CuH/Lb4TduPSu
rtOqA70DuOlIJhLY67LQwLgJB/z7IiJoRd0dcVAiBFHu0lFrNonn/LLOs5ztiukJ
/7BCWQH5x7dBusCKApTMWBMF7vaNcPY3fCMoTLNJW7s2FrqpbsQ=
=C+sQ
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
