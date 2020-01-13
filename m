Return-Path: <cygwin-patches-return-9909-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 67378 invoked by alias); 13 Jan 2020 15:33:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 67369 invoked by uid 89); 13 Jan 2020 15:33:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-120.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=our
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.74) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 15:33:22 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mq2Sa-1jV5cD2Che-00n7x8 for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 16:33:19 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 15ABBA806B2; Mon, 13 Jan 2020 16:33:19 +0100 (CET)
Date: Mon, 13 Jan 2020 15:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add missing Linux #define of CPU_SETSIZE
Message-ID: <20200113153319.GG5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <a34db430-a10e-9049-3d70-c5512b96ceb7@gmail.com> <20191223064554.23791-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
In-Reply-To: <20191223064554.23791-1-mark@maxrnd.com>
X-SW-Source: 2020-q1/txt/msg00015.txt


--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1084

On Dec 22 22:45, Mark Geisert wrote:
> Though our implementation of cpu sets doesn't need it, software from
> Linux environments expects this definition to be present.  It's
> documented on the Linux CPU_SET(3) man page but was left out due to
> oversight.
>=20
> Addresses https://cygwin.com/ml/cygwin/2019-12/msg00248.html
>=20
> ---
>  winsup/cygwin/include/sys/cpuset.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/s=
ys/cpuset.h
> index 1adf48d54..572565165 100644
> --- a/winsup/cygwin/include/sys/cpuset.h
> +++ b/winsup/cygwin/include/sys/cpuset.h
> @@ -89,6 +89,7 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *=
);
>  #define CPU_XOR(dst, src1, src2)  CPU_XOR_S(sizeof (cpu_set_t), dst, src=
1, src2)
>  #define CPU_EQUAL(src1, src2)     CPU_EQUAL_S(sizeof (cpu_set_t), src1, =
src2)
>=20=20
> +#define CPU_SETSIZE               __CPU_SETSIZE
>  #endif /* __GNU_VISIBLE */
>=20=20
>  #ifdef __cplusplus
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cjb4ACgkQ9TYGna5E
T6B+pRAAhmon0BCyI/+bPSXFUHCOlfYcp++qM9RmyhuKvHY26uRMd/c96sytQTqA
e0odKZafx/G+fWUEpGiai1mFYr66Go/eZTDehX3KP1O7B/TEODnFcI4a2sPeOboR
2yMyjStRCED+fBQa11lXWF+fu5zAvd9R8twzqgnlRjbyQTxpPA6NaBOBJHkF0ikg
a3pumTTOgaA78jHXDMuB4k6QVBfkcEkwanfJDkcC6NP0/7rHYQdFei6YtQE0HADN
zXNs1u/vDNepw7kYILVUya9IRDEm7+yUZZupJW5VuCdgmLJn/i0JWIMuF7vvgd9S
A7JlvectL02JDwSMjbctdqsnsIjWqD2uYg4k1QeI0xuxIuNZOMUVUaatKXWS4lUY
ioRmQNruIOM3o0t41gLDoQjDBNwVgeZDW4qXPIr8HqkOk4VWYhJ8dw1Oadr9Xca+
br8l7OUHKT+YFFy4iv9FFWpGmSNzO+TMHYtXT/5gHQJCziIW05nQ6cF3hWo9x6ef
vrJrrvxFPZOkYDSk/+hspo2Yq4wMZ0KA5wTgUnPPlCBqg/ldiTqyGtlwpuef9Eiu
SquJP/BFwfZaXR0GR1JfvuEot7ndXOFX0FknpeIsoa940z07J+rSdVA0gmk35npF
oAITa1D6dWR92SjEGSwqdNsj6evfXjM9yQffn2lSMHWLhPBO0Nc=
=eNfk
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--
