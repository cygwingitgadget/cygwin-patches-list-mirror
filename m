Return-Path: <cygwin-patches-return-8994-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32614 invoked by alias); 16 Jan 2018 09:28:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 30163 invoked by uid 89); 16 Jan 2018 09:27:56 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1096, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jan 2018 09:27:54 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id AB05572106C26	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 10:27:50 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id EBAE75E00DF	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 10:27:49 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D7422A807E5; Tue, 16 Jan 2018 10:27:49 +0100 (CET)
Date: Tue, 16 Jan 2018 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: add LFS_CFLAGS etc. to confstr/getconf
Message-ID: <20180116092749.GB3009@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180116031900.18732-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20180116031900.18732-1-yselkowi@redhat.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2018-q1/txt/msg00002.txt.bz2


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1259

On Jan 15 21:19, Yaakov Selkowitz wrote:
> These are used, for instance, when cross-compiling the Linux kernel.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
>  newlib/libc/include/sys/unistd.h | 4 ++++
>  winsup/cygwin/sysconf.cc         | 6 +++++-
>  winsup/utils/getconf.c           | 4 ++++
>  3 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/u=
nistd.h
> index f216fb95c..5386bd49d 100644
> --- a/newlib/libc/include/sys/unistd.h
> +++ b/newlib/libc/include/sys/unistd.h
> @@ -582,6 +582,10 @@ int	unlinkat (int, const char *, int);
>  #define _CS_POSIX_V7_THREADS_LDFLAGS          19
>  #define _CS_V7_ENV                            20
>  #define _CS_V6_ENV                            _CS_V7_ENV
> +#define _CS_LFS_CFLAGS                        21
> +#define _CS_LFS_LDFLAGS                       22
> +#define _CS_LFS_LIBS                          23
> +#define _CS_LFS_LINTFLAGS                     24

Basically ok, but while at it, wouldn't it make sense to add the LFS64
macros too?


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlpdxZUACgkQ9TYGna5E
T6DPkg/9EVpDyMLcAm2+SUV9MAAtzEXbxX6uEnVc0nGINHhuwA9GK7E3TNfIfNBF
U72m7mlu7i06Mznti0P5iEn1+ptWi9LN6VP1yVPMY6AhT1AcoK7gavV3gKKVwq+7
fcSxTA2gbs42KzoaLzXC6RYnKuszhu4dndiyPpKl6eRmEmJQsnLRm9rwd/ZfWYXo
XgSZ56IBnRM58RXhvr70tZrA45eS5phMHL0UxuDqPCGIrBAq8orK42DrvtfaHFpE
BQ6ypGJuI7Ba9Y00P6ogfi4S0nSWXkqNi3jB6U6Axqjkoeo1j2FotlwbgPuKd26O
B7u58J83GLQdjlBPnFPAdpRFlZaFH/gs4veL2xDpJXLW+ax61NtPemJ4qO0x28hz
zlNzp8Zlj4uchDEfjOXIanC2mHeYr+4Q8rC8kMdiCIX1HF+qpaYeiuHU+BRqF1SB
Oez9w669WbAPmJ2SEvQroDOWqoh1JZZLPqdDFS+UJw86FGZzDbJaI4i+NxdU2k4M
GqcA334yb7ZptGjdHHOlmM0RROKxgnrTMCeDW741IVIfzyTqe2gE5EUgCRBIG6PB
NtiSJMAjgL1gu5EcXzzMlGLCoqLwTDE+opUgi5ocfUfxhi252yVkFg+FBO9W8Np1
STCqIjAynOO7qUZEz0fRitK6kAidxkg1fn5RUPuma67qbTCFGfI=
=V5Bs
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
