Return-Path: <cygwin-patches-return-8804-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44898 invoked by alias); 10 Jul 2017 07:50:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43673 invoked by uid 89); 10 Jul 2017 07:50:43 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*c:application, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Jul 2017 07:50:41 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id A48C8721E280D	for <cygwin-patches@cygwin.com>; Mon, 10 Jul 2017 09:50:37 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id D16625E0409	for <cygwin-patches@cygwin.com>; Mon, 10 Jul 2017 09:50:36 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id BA835A80522; Mon, 10 Jul 2017 09:50:36 +0200 (CEST)
Date: Mon, 10 Jul 2017 07:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fix guard on struct siginfo_t
Message-ID: <20170710075036.GB30071@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20170707223811.229596-1-yselkowi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="jho1yZJdad60DJr+"
Content-Disposition: inline
In-Reply-To: <20170707223811.229596-1-yselkowi@redhat.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
X-SW-Source: 2017-q3/txt/msg00006.txt.bz2


--jho1yZJdad60DJr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1417

On Jul  7 17:38, Yaakov Selkowitz wrote:
> Add line breaks to make it clearer that the struct packing applies to more
> than one struct.
>=20
> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
> ---
> We probably should consider a 2.8.2 sooner rather than later.
>=20
>  winsup/cygwin/include/cygwin/signal.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/cygwin/include/cygwin/signal.h b/winsup/cygwin/includ=
e/cygwin/signal.h
> index e73874c62..af0833688 100644
> --- a/winsup/cygwin/include/cygwin/signal.h
> +++ b/winsup/cygwin/include/cygwin/signal.h
> @@ -175,7 +175,10 @@ typedef struct sigevent
>    pthread_attr_t *sigev_notify_attributes; /* notification attributes */
>  } sigevent_t;
>=20=20
> +#if __POSIX_VISIBLE >=3D 199309
> +
>  #pragma pack(push,4)
> +
>  struct _sigcommune
>  {
>    __uint32_t _si_code;
> @@ -190,8 +193,6 @@ struct _sigcommune
>    };
>  };
>=20=20
> -#if __POSIX_VISIBLE >=3D 199309
> -
>  #define __SI_PAD_SIZE 32
>  #ifdef __INSIDE_CYGWIN__
>  # ifndef max
> @@ -251,6 +252,7 @@ typedef struct
>  #endif /*__INSIDE_CYGWIN__*/
>    };
>  } siginfo_t;
> +
>  #pragma pack(pop)
>=20=20
>  #endif /* __POSIX_VISIBLE >=3D 199309 */
> --=20
> 2.12.3

ACK, please push.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jho1yZJdad60DJr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZYzHMAAoJEPU2Bp2uRE+gtQMP/ii/XsO+03naWwJIvEfJUgxO
qmCLSxnI8kMxeeRIpKRGz8SdEfKuypgDa6FyljG9YJbdYNQhlz37xNrhIm8alOg1
txyqWfSmGZN0bA109EjQJvSKHywk1ddE17TolP6XuYqj0/7fGyTTkA0/woUbGZ/3
b16d1Li7lwxvHQWw1aNJW7MahtT9xPSPBETlC+QaQpxouWQvP3qpmd7VxOeqFG/i
jfvKRG5I6k5br9vZyQwEhTBammdSb+DEAfW3arz13RdV/yrSeY3QlSMlczC3/mVa
MgnKArDf3Gar8aEwesCynPDDC1DRQf1mPRw4AwO2GeU/Q9qQI3eYb+2Yvv4KVjfA
Ug+tLP779CEIav0TC56QBlDYa6PkPlTOxerwXERk8XuZMSE32VAm9SkHizGPK9//
UWRtW9XIH4yAhvHQncUyPnBHVw6NoZ456S4O/dlMvhpYbJlm4fW4asbSHLCgcH/J
holr3C6JwtdVRqu/gg3t0wp1zVxJqqju3Z1DLsOUOntSG3g2OVhVo0hTRWF+oh9v
9s2+tiiworGI3Nz0SzcNe5AiVmekfPelCiZCTPqGmgGfplD6jcK4i7MGDpfX68Vu
2bKXP4LWd9EhN+vk/YjP3nRiprZ5MOVEIFRE1tnmzq7f4oqWXMuOt3IGpDI/kXgF
Fofk1sK3wNF6a4IVj3ZI
=xcHw
-----END PGP SIGNATURE-----

--jho1yZJdad60DJr+--
