Return-Path: <cygwin-patches-return-9797-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35232 invoked by alias); 31 Oct 2019 20:41:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35221 invoked by uid 89); 31 Oct 2019 20:41:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, H*Ad:U*cygwin-patches, H*R:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 31 Oct 2019 20:41:21 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M2OEw-1iOd5t0eQY-003uek; Thu, 31 Oct 2019 21:41:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 268B9A80670; Thu, 31 Oct 2019 21:41:09 +0100 (CET)
Date: Thu, 31 Oct 2019 20:41:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: getpriority() consistent with process priority
Message-ID: <20191031204109.GF16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Anton Lavrentiev <lavr@ncbi.nlm.nih.gov>,	cygwin-patches@cygwin.com
References: <20191030154725.4720-1-lavr@ncbi.nlm.nih.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Eldrgvv4EWsIM1sO"
Content-Disposition: inline
In-Reply-To: <20191030154725.4720-1-lavr@ncbi.nlm.nih.gov>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00068.txt.bz2


--Eldrgvv4EWsIM1sO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 949

On Oct 30 11:47, Anton Lavrentiev via cygwin-patches wrote:
> https://cygwin.com/ml/cygwin/2019-08/msg00122.html
> ---
>  winsup/cygwin/syscalls.cc | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index a914ae8..20126ce 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -3977,7 +3977,12 @@ getpriority (int which, id_t who)
>        if (!who)
>  	who =3D myself->pid;
>        if ((pid_t) who =3D=3D myself->pid)
> -	return myself->nice;
> +        {
> +          DWORD winprio =3D GetPriorityClass(GetCurrentProcess());
> +          if (winprio !=3D nice_to_winprio(myself->nice))
> +            myself->nice =3D winprio_to_nice(winprio);
> +          return myself->nice;
> +        }
>        break;
>      case PRIO_PGRP:
>        if (!who)
> --=20
> 2.8.3

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Eldrgvv4EWsIM1sO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl27RuQACgkQ9TYGna5E
T6CeOxAAjeI9sN/r68re7KxEkxVR9wY0jAxzV55WCnXnhPWQLaf50IH+v3AKn2wq
H4rR2RStRLYqeypCxKIdfdGosXFppChdmrja7KE6NUZb9KC2wMmWFd9uXBb3TX2S
W/qxlGnnQ+N/NiNYffaOO72bTvxLlciqIK1Q+CnbZYWmDb3T8HFu5zaqOKCQNPFr
oUq1kE0Wd+lGGywcyNWn0CUIWD4EhB5P6X1ltN0rRfunDfVlPy8VYolwZYT+uhfa
y9bqWLSM4AhjTobfBjWcPFy5oI/lJdVmexYaRToJFQY7IHekGfafOZ483xKncZvO
0BcNnhPV85fDcCtzKR2ZcGX/nsQKprNxXP99whLHXJrCQ2no1+QFmFedenw8ykGe
P83js4pWhMgAk0KT+7fcCiOHZdh1xRuDsbHWnHdjwPKoG3FibGFgKnik2x2dNdUf
qFpAS02s2Mt767++tqAzfPPOpcKF/08+U/1ibD4VECxlV8CHUTWceHM6/MojYpLh
5T7TmCB/IfcdgBqncqJK2h+KlZHAXdWHdNedocvrgqHZiEgytitNg4p5YkXdCrYx
yj17rUzt5MS8m/rtht33GMMYDDe1B8E/DHfWBBvrcwejue0nuAcRxZ6mHd7WRHZV
ZSdOJvbxD8HVCqfD5ImxewEsWgn2fQYK2ipN8No10/cplbQYgyM=
=xbW3
-----END PGP SIGNATURE-----

--Eldrgvv4EWsIM1sO--
