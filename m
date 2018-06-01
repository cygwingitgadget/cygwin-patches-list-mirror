Return-Path: <cygwin-patches-return-9064-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 65662 invoked by alias); 1 Jun 2018 10:10:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 65645 invoked by uid 89); 1 Jun 2018 10:10:33 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-123.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.133) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 01 Jun 2018 10:10:31 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MeXgF-1ffVk21cNz-00QEHC for <cygwin-patches@cygwin.com>; Fri, 01 Jun 2018 12:10:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EC1B9A81935; Fri,  1 Jun 2018 12:10:28 +0200 (CEST)
Date: Fri, 01 Jun 2018 10:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix declaration of pthread_rwlock_* functions
Message-ID: <20180601101028.GC14289@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <cfb6a3b0-57f6-8594-0872-db65d371a997@cornell.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:uIfscOfnV3Y=:+S4h4xIXJo9gJnUViET46i lVGaoJZhZYhP8GCrq95tZX1/LGozXE6/QN2bJQ9U+hKatxm/Yhgf08+3XzVqU89r+G+59c46g Eeb5kbPDuzyABSsk6A43OHpNjALHjP+jFiqHobyQCHB7/Y5BQE5QZvOvgbOy0K60SrfDpklCL OMRpxsQLjSiLi7wKBQUQleXf5/uVpL2bRDYcC+H2LsL+okiT6mdFOugGfe4iEgkFCSIROJM4y +eP8T0iU4GPDNbtgPa+lnU5ozT8yCM0cyq2NAViDcBeM9vuQXuedfifmZzIjypMblOxjcgl43 8dOD2bgT1f28JE7hIFF74jkWcYgsWX5Ov5BlMWsX1kBM2eVySor4tCHhwhPAGPje5K1uPAas+ egJ0CYPi9iDbvwPqxSaD1I1fYo1UFajwLWB3w+ex9LgAJLEmhtQ4naMkjyMupZccOVMeJuuJu ZsGyW6Ityx6QbSzuxHegTQGryb1urUbqtSVYKoKTxlYhAWXaXy9NXTyUr3RGo1Dhr4DG4W3ea r6Vpx89xnnQfCtl+NFHrukXP1pXn95vBvwBtvpRErWdGIcUiavzahG3kgnx/AdXFpehg66cIh 6MgsFMaWU2NDJfTnqzA6/PETwlV6rH0r5/D5GO8fSgCM9DGa4xKMuPMu3uE2E9D+GNll9XKCV j7PVgC9was6kvK9gNTWykxWbS9krUPlO8Va204lu41uHUWbBT3ZWaDAT04EF/QfF9KWE=
X-SW-Source: 2018-q2/txt/msg00021.txt.bz2


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1533

On May 30 16:28, Ken Brown wrote:
> The attached patch fixes the second problem reported in
> https://cygwin.com/ml/cygwin/2018-05/msg00316.html, though I'm not sure i=
t's
> the right fix.
>=20
> Ken

> From 4940baac08cd9339d771d9db90a880c61610ae4c Mon Sep 17 00:00:00 2001
> From: Ken Brown <kbrown@cornell.edu>
> Date: Wed, 30 May 2018 16:19:01 -0400
> Subject: [PATCH] Declare the pthread_rwlock_* functions if __cplusplus >=
=3D
>  201402L
>=20
> Some of these functions are used in the <shared_mutex> C++ header.
> ---
>  winsup/cygwin/include/pthread.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/include/pthread.h b/winsup/cygwin/include/pthr=
ead.h
> index 3dfc2bc80..fed616532 100644
> --- a/winsup/cygwin/include/pthread.h
> +++ b/winsup/cygwin/include/pthread.h
> @@ -187,7 +187,7 @@ int pthread_spin_unlock (pthread_spinlock_t *);
>  #endif
>=20=20
>  /* RW Locks */
> -#if __XSI_VISIBLE >=3D 500 || __POSIX_VISIBLE >=3D 200112
> +#if __XSI_VISIBLE >=3D 500 || __POSIX_VISIBLE >=3D 200112 || __cplusplus=
 >=3D 201402L
>  int pthread_rwlock_destroy (pthread_rwlock_t *rwlock);
>  int pthread_rwlock_init (pthread_rwlock_t *rwlock, const pthread_rwlocka=
ttr_t *attr);
>  int pthread_rwlock_rdlock (pthread_rwlock_t *rwlock);
> --=20
> 2.17.0
>=20

Pushed.  Any text for winsup/cygwin/release/2.10.1, perhaps?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlsRG5QACgkQ9TYGna5E
T6DsCw/+PsCyE10XvMma0FD6mcNpAT/fPf+OCssnkJNiH8T6R5V5xA0TX8VX9bkT
yDPmErSYVReq9Z2ErXBL6N34CnIla2rdO1Z3jokhEKC0e7wuXR3g/EPNaIOQPTd7
SROiSX3YGe2ZTiaF3e8vXWgkYdBXsOAAcN/GlZKpO5c83PXlo8d5V1+qhmgsCgL5
BZh85tkE5UZqqQy8bgWW/xNE9aBXD6d536LOrHLTPbgpPLF6a0vurzynvy+S2MUN
2ww7RBnAsGEnpArmDAE2Jb0kwsRT0/ug0n6USnNEcClRb0Od97shv4a8tyNtd0Q/
UqLQ+QZohGX8Z8LCzEcZQi7KIuHYO1lMCIX2gSDsolJqErfkrREAdUAncfFBZGGA
mPJgcjx5s82N4bk5QrZvkfTeKaoP1ePOHQanjV94ScBFtOgB2fEelwuljhLR3B8Z
d/bBQtSEnhs1zOls6sjVD+0UQP1BN8e26wU151VFWvYnDaT//sO1yixaVG8kNjME
IrTRZiMUNTjcd4KD4XbVhq7fCRTW9Fek+I9flO5LK0DDGQvVDo3SHkjPcJBSmsQt
0+6Cq+CmqaFBUcXjE96kC+hfDYuWbAhCZrNr5fLlz49RyLNsT8kyGkkDIfmRiMYm
7uGAdd9DaSCzqX2Oespx3YFJoXMdV99+mjCm98aj0MXFlsxlT1g=
=ABp1
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
