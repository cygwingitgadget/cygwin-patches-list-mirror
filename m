Return-Path: <cygwin-patches-return-9550-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92352 invoked by alias); 7 Aug 2019 09:11:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92340 invoked by uid 89); 7 Aug 2019 09:11:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 07 Aug 2019 09:11:51 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M8xwu-1i0Df01IBi-0068dr for <cygwin-patches@cygwin.com>; Wed, 07 Aug 2019 11:11:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A1372A80690; Wed,  7 Aug 2019 11:11:47 +0200 (CEST)
Date: Wed, 07 Aug 2019 09:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: build_env: fix off-by-one bug when re-adding PATH
Message-ID: <20190807091147.GB11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190807085116.7985-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CMx2Qe8y1jN1ar4Y"
Content-Disposition: inline
In-Reply-To: <20190807085116.7985-1-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00070.txt.bz2


--CMx2Qe8y1jN1ar4Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1361

On Aug  7 10:51, Michael Haubenwallner wrote:
> Adding default winvar 'PATH=3DC:\cygwin64\binZ' to an environment that is
> already allocated for 'SYSTEMROOT=3DZWINDIR=3DZ', we need to count that
> trailing (Z)ero as well.  Otherwise we trigger this assertion failure:
>=20
> $ /bin/env -i SYSTEMROOT=3D WINDIR=3D /bin/env
> assertion "(s - envblock) <=3D tl" failed: file "/home/corinna/src/cygwin=
/cygwin-3.0.7/cygwin-3.0.7-1.x86_64/src/newlib-cygwin/winsup/cygwin/environ=
.cc", line 1302, function: char** build_env(const char* const*, WCHAR*&, in=
t&, bool, HANDLE)
> Aborted (core dumped)
> ---
>  winsup/cygwin/environ.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> index 124842734..8fa01b2d5 100644
> --- a/winsup/cygwin/environ.cc
> +++ b/winsup/cygwin/environ.cc
> @@ -1295,7 +1295,7 @@ build_env (const char * const *envp, PWCHAR &envblo=
ck, int &envc,
>  	 during execve. */
>        if (!saw_PATH)
>  	{
> -	  new_tl +=3D cygheap->installation_dir.Length / sizeof (WCHAR) + 5;
> +	  new_tl +=3D cygheap->installation_dir.Length / sizeof (WCHAR) + 5 + 1;
>  	  if (new_tl > tl)
>  	    tl =3D raise_envblock (new_tl, envblock, s);
>  	  s =3D wcpcpy (wcpcpy (s, L"PATH=3D"),
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--CMx2Qe8y1jN1ar4Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1KldMACgkQ9TYGna5E
T6CBiA/8D9giUFL6+AqZzoXAUEPcMJxBAlReiyXTtb7RDBD86GF78ZQzdpua0PSI
EOL8SuLSGoQR/bnsqD3UNrKSIBPpCJ+gx7hlogEPFL/Macp/eQMpQIPPrl8Vf5qQ
AmBkvEsQDWPOu+T3yHrus1Cd748eTaHy/wqfPjaGxzufFn5yf5aGpvbxxtW1leP0
IWkVCpi9CYWhYf1qgByZR9OrJYIv1irNKmZBixFxz5sQV1TkxNpwO6QiHkbH9d68
qmUN6MIo5n7rkK4IMyzhYLQ8kAmGGNgOy3BAfx38qxIdCUop9uv4BFsE/OOT9IBt
m3NIu6zsCgAtdim29IojRQlDuIrtg1+vmiyLLGAUOIwpN0w4HdYI97sGJDiOnHPo
ItVqdVnC5UtwfeyN4h6dknE8uI4hASoWehQeIvc0zgLViVYAgKmBGJZwmcFK1ZTQ
hQhHEh6sIP0ofsYeZVJwACe4MCT49MLJrlEO2mkjuaqjZ5yMoQYAb9odRSkfXhAC
p2TGhGj0Ch/runqWLWc2dlOR7Mnx8hXz/Iy496xMkbRa3/x6L4Hb0NdLu1+vAmAH
ZsKxi+39ugDTVhC811rz1JfCzbTJvNA8PYNs8MGVqFSEiJQjXJ7yZvbPIA87NHmD
qAnrVr2LWxc5NK+kZNSzNRH8x9RcjW0WZM5u79kEq9a+c/anfjU=
=3OFZ
-----END PGP SIGNATURE-----

--CMx2Qe8y1jN1ar4Y--
