Return-Path: <cygwin-patches-return-9910-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 72687 invoked by alias); 13 Jan 2020 15:35:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 72659 invoked by uid 89); 13 Jan 2020 15:35:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-122.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:967, joke, wine, HTo:D*se
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 15:35:39 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1M8Qme-1ime2S1YdU-004QVK; Mon, 13 Jan 2020 16:35:36 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D6417A805B9; Mon, 13 Jan 2020 16:35:35 +0100 (CET)
Date: Mon, 13 Jan 2020 15:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Arseniy Lartsev <arseniy@alumni.chalmers.se>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fixed crash on wine by adding NULL check after memchr
Message-ID: <20200113153535.GH5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Arseniy Lartsev <arseniy@alumni.chalmers.se>,	cygwin-patches@cygwin.com
References: <1870553.yxu1Ok4Nxh@tux-precision-3520>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <1870553.yxu1Ok4Nxh@tux-precision-3520>
X-SW-Source: 2020-q1/txt/msg00016.txt


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 948

On Jan  7 16:34, Arseniy Lartsev wrote:
> This is not a joke, there are vendors out there who build software for cy=
gwin
> only. Besides, this NULL check is good to have anyway.
> ---
>  winsup/cygwin/path.cc | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index b5efd61b2..c8e73c64c 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -4307,6 +4307,8 @@ find_fast_cwd_pointer ()
>    const uint8_t *use_cwd =3D rcall + 5 + offset;
>    /* Find first `push %edi' instruction. */
>    const uint8_t *pushedi =3D (const uint8_t *) memchr (use_cwd, 0x57, 32=
);
> +  if (!pushedi)
> +    return NULL;
>    /* ...which should be followed by `mov crit-sect-addr,%edi' then
>       `push %edi', or by just a single `push crit-sect-addr'. */
>    const uint8_t *movedi =3D pushedi + 1;
> --=20
> 2.17.1

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cjkcACgkQ9TYGna5E
T6BYnw/+O1eI6oZT0dGIQZAsAirSK0tNlySEqmjOR8chx9E2IzEihe/a1/7gKBv0
tkkDm/KOMrfFjEjHBFQJSMixEcZM56LA8A99id2HRPaev7/1zxnBjl9ZIRnN0EF+
kfn3Dx56kaALqGsfhFe+cSTuRYWv4qDz9rIkEmL8mscFKyLnWM0ZP4BbUitW8kbj
BHheFOWjNOUeKQWk8dKhu/tMvVvx5AGAfYCDFc5M9Olo8JaCy2mJcpx5GyJuGHFZ
i0NtBt1Grt0m5I5r2dIJ9cKolzAdqUV0Y3IJA8Bvt5cqydlQurBDGjjcHrlAvBbi
trBmmycl1WeupAt6xvuXOs7g5H9GAU6l3WA+i5q0FFcXk4OCvoeRgFtm0w1n8I2K
ID620y7JA0AFzfAFZnPqjQZb8YgTB+xlFc0WjKMsnmXNcRvZs7KukpbgjiQHyU8Y
SRuMz0PONMjHY6xPLvuJBBxJMmtMnj1h2mbbuaIAiF/1ObpkSiIT5MnSSM053Ey1
SYLrurgNi+0S3j6Z65+PLtiDktc+MDajcI1BA+RrM+/z6isgKbD4g8gr9wqgwu4R
1/g2pnPjAp3EG+c1ljy9GjdKqcUqzuO5iFpqX+djingCLMbI2Nwt+02Znxtf+Y2/
AfPPmycpfMfRqDWGiDjih9asmR7a8nUj4anz2Qk5UFnxAe3iDoM=
=bjpp
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
