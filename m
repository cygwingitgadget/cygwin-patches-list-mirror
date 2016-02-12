Return-Path: <cygwin-patches-return-8303-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3602 invoked by alias); 12 Feb 2016 14:25:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 3574 invoked by uid 89); 12 Feb 2016 14:25:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=Hx-languages-length:1918, H*F:U*corinna-cygwin, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 12 Feb 2016 14:25:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 74818A80595; Fri, 12 Feb 2016 15:25:37 +0100 (CET)
Date: Fri, 12 Feb 2016 14:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] POSIX barrier implementation, take 2
Message-ID: <20160212142537.GD3415@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56BDB206.9090101@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline
In-Reply-To: <56BDB206.9090101@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00009.txt.bz2


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1948

Hi V=C3=A1clav,


the patch looks pretty good, I have just a few (minor) nits:

On Feb 12 11:20, V=C3=A1clav Haisman wrote:
> diff --git a/newlib/libc/include/sys/types.h b/newlib/libc/include/sys/ty=
pes.h
> index 5dd6c75..bfe93fa 100644
> --- a/newlib/libc/include/sys/types.h
> +++ b/newlib/libc/include/sys/types.h
> @@ -431,6 +431,7 @@ typedef struct {
>=20=20
>  /* POSIX Barrier Types */
>=20=20
> +#if !defined(__CYGWIN__)
>  #if defined(_POSIX_BARRIERS)
>  typedef __uint32_t pthread_barrier_t;        /* POSIX Barrier Object */
>  typedef struct {
> @@ -440,6 +441,7 @@ typedef struct {
>  #endif
>  } pthread_barrierattr_t;
>  #endif /* defined(_POSIX_BARRIERS) */
> +#endif /* __CYGWIN__ */

Instead of adding YA `if !CYGWIN', I think it might be prudent to
just move the `if !CYGWIN' up from the following _POSIX_SPIN_LOCKS
block.

> diff --git a/winsup/cygwin/common.din b/winsup/cygwin/common.din
> index d7f4d24..18e010a 100644
> --- a/winsup/cygwin/common.din
> +++ b/winsup/cygwin/common.din
> @@ -882,6 +882,13 @@ pthread_condattr_getpshared SIGFE
>  pthread_condattr_init SIGFE
>  pthread_condattr_setclock SIGFE
>  pthread_condattr_setpshared SIGFE
> +pthread_barrierattr_init SIGFE
> +pthread_barrierattr_setpshared SIGFE
> +pthread_barrierattr_getpshared SIGFE
> +pthread_barrierattr_destroy SIGFE
> +pthread_barrier_init SIGFE
> +pthread_barrier_destroy SIGFE
> +pthread_barrier_wait SIGFE
>  pthread_continue SIGFE
>  pthread_create SIGFE
>  pthread_detach SIGFE

These should be added in alphabetic order.

> +#define LIKELY(X) __builtin_expect (!!(X), 1)
> +#define UNLIKELY(X) __builtin_expect (!!(X), 0)

May I suggest to use lowercase "likely/unlikely" just as in the Linux
kernel and to move the definitions into a header like winsup.h or
miscfuncs.h?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWvethAAoJEPU2Bp2uRE+g8ywP/2PS6LAm+hky/w/4sYlGuVUT
mEfdjvEvYAJkrlPwgIA+q/jCYp2pIwIUgCxT2EnypkJgboTO4XXLx+XhdLO29suQ
snL0egfuXCPnWqUJyWHecVRUPdjZgsqDhzu1IyvzleW3jqtKay6lut3/AmAGL9g5
/B/sa/969FHxPP2DPwhpCExIWF/fIIb7rqDF4ZHVoOeVrTOQjovQ6thjHJdL4ZYv
5Z2RZ4g0PQZjFDeBzgx9MFK/y7+TkVO9A/pgHruhHJTPE0yePR/6oPfXkgqe/PnF
wri4HeSVT1wUmrXjarPOt03VJFho3KHOa3017jXPP5wKMcxbUoIyUlAvgGUNk4LB
Bk4D3e54nFtpS/uMu5YMj0CG0uYAoY8twCPpc/bd1IV1t5BNSgV3JWkYrcy9jPIG
n5CQUozg6CtGV0VqwKGGxwShlhjuIYDhbk6a6H9POaB/Cei0VDSUkJz3IroxpmAe
92maM5Q4uhQijFmo+6/6tyEM29speZDewWZECK0jb2NVpl/g9lBApNZPcGGBvn9G
17FaocVlvzbk8PrdXUw85Ijaw5XeaEBFrI8Z3k1szGGkQ+pz81X2ogH0EamgB/Cl
qz0O3TviOdVrIz5Bq5FYeTK2vzQ/yJDVaKvNdinvxHMEDaP5eqGa4NERiwJSwqub
vc6whmFxr4aNEH25BtZn
=rLd2
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
