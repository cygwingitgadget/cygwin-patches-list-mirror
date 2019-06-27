Return-Path: <cygwin-patches-return-9476-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 53710 invoked by alias); 27 Jun 2019 07:17:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 53617 invoked by uid 89); 27 Jun 2019 07:17:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-117.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 27 Jun 2019 07:17:53 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mfpf7-1iDoX93zmT-00gE9Z for <cygwin-patches@cygwin.com>; Thu, 27 Jun 2019 09:17:50 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 6C164A8075E; Thu, 27 Jun 2019 09:17:50 +0200 (CEST)
Date: Thu, 27 Jun 2019 07:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Use correct string conversion
Message-ID: <20190627071750.GC5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190626092744.GT5738@calimero.vinschen.de> <20190627053156.57473-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nT6ukc3bqTvTgwkF"
Content-Disposition: inline
In-Reply-To: <20190627053156.57473-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00183.txt.bz2


--nT6ukc3bqTvTgwkF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 955

On Jun 26 22:31, Mark Geisert wrote:
> Correct the string conversion calls so both argv elements get converted
> at full precision.
> ---
>  winsup/utils/cygwin-console-helper.cc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/winsup/utils/cygwin-console-helper.cc b/winsup/utils/cygwin-=
console-helper.cc
> index 8f62ed7e6..0e04f4d18 100644
> --- a/winsup/utils/cygwin-console-helper.cc
> +++ b/winsup/utils/cygwin-console-helper.cc
> @@ -5,9 +5,9 @@ main (int argc, char **argv)
>    char *end;
>    if (argc !=3D 3)
>      exit (1);
> -  HANDLE h =3D (HANDLE) strtoul (argv[1], &end, 0);
> +  HANDLE h =3D (HANDLE) strtoull (argv[1], &end, 0);
>    SetEvent (h);
> -  h =3D (HANDLE) strtoul (argv[2], &end, 0);
> +  h =3D (HANDLE) strtoull (argv[2], &end, 0);
>    WaitForSingleObject (h, INFINITE);
>    exit (0);
>  }
> --=20
> 2.21.0

Both patches pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--nT6ukc3bqTvTgwkF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0UbZ4ACgkQ9TYGna5E
T6D11Q//eMXieJe6JgBVtSn/e0umanmzyvidNQPS0GHGJrnoQigJHKgKVTrgKRpU
aqN68SYIPSx0JPq9Akj8m1lQVqDdvnfkAinhcmCh90NtlKg3thXAoI0bzgj8q0aa
cArWYrTtZnIzFMmGtHZI0XenbSowJsFs4mBbfRCLjWsWfoB69KtrjTtTNPll+XXT
kutuC51/jO5R0EyyQ+rYtkjwsRhXM8eA3CJae4mZ1ylgvUagKDFx1vu4mFTThbs4
dEtl7FNxWDFrGc/qLdRXedWcT8FFqD4ZgsJXyqR1N5zL3VFh4ovXBe/RMRFHs4xJ
30R8i4d5eVOa270nKl4G5mOMNhg+immoRwNB2WYVmMFTC8gDI96ChAzvDChpe4OD
R2aQxmZe/R+bM+NLSsZ9HEOmGInWETkK2MAMmVdzwT82p2UGh1NqEuxTbF3kmJkA
/vJFijkZmzN4Ne0VQk1edIfpho6S1hEdTcQ/1zKugtWc0sGuUkdar0S9IOVzfVA7
MsfVGxAsTCMKV87JnHjsNKnZ41hevGrcsuke2KNTK+Ot5+sPMudDCeYT5VjR2RLR
3754phwI1nFUQzxL4J3/puI5ZWH50qBICyJY1XDZCo0SV75rZaLaphgLC92iwyuz
SFKbgZj9H2241Qvu6o1hePTKcEHp6zBWNgkf7VsK3mgPxiw6rNA=
=9c5O
-----END PGP SIGNATURE-----

--nT6ukc3bqTvTgwkF--
