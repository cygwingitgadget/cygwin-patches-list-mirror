Return-Path: <cygwin-patches-return-9461-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 122857 invoked by alias); 25 Jun 2019 11:27:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 122847 invoked by uid 89); 25 Jun 2019 11:27:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=careful!, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Jun 2019 11:27:07 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MysiI-1iRo9N2rKs-00vz5x for <cygwin-patches@cygwin.com>; Tue, 25 Jun 2019 13:27:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0C6B6A8076E; Tue, 25 Jun 2019 13:27:03 +0200 (CEST)
Date: Tue, 25 Jun 2019 11:27:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Build cygwin-console-helper with correct compiler
Message-ID: <20190625112703.GH5738@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190625075441.1209-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Content-Disposition: inline
In-Reply-To: <20190625075441.1209-1-mark@maxrnd.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00168.txt.bz2


--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1682

On Jun 25 00:54, Mark Geisert wrote:
> ---
>  winsup/utils/Makefile.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/utils/Makefile.in b/winsup/utils/Makefile.in
> index b64f457e7..cebf39572 100644
> --- a/winsup/utils/Makefile.in
> +++ b/winsup/utils/Makefile.in
> @@ -64,7 +64,7 @@ MINGW_BINS :=3D ${addsuffix .exe,cygcheck cygwin-consol=
e-helper ldh strace}
>  # List all objects to be compiled in MinGW mode.  Any object not on this
>  # list will will be compiled in Cygwin mode implicitly, so there is no
>  # need for a CYGWIN_OBJS.
> -MINGW_OBJS :=3D bloda.o cygcheck.o dump_setup.o ldh.o path.o strace.o
> +MINGW_OBJS :=3D bloda.o cygcheck.o cygwin-console-helper.o dump_setup.o =
ldh.o path.o strace.o
>  MINGW_LDFLAGS:=3D-static
>=20=20
>  CYGCHECK_OBJS:=3Dcygcheck.o bloda.o path.o dump_setup.o
> --=20
> 2.21.0

Careful!  This leads to a warning when building on 64 bit:

  cygwin-console-helper.cc: In function 'int main(int, char**)':
  cygwin-console-helper.cc:8:48: warning: cast to pointer from integer of d=
ifferent size [-Wint-to-pointer-cast]
   HANDLE h =3D (HANDLE) strtoul (argv[1], &end, 0);
                                                ^
  cygwin-console-helper.cc:10:41: warning: cast to pointer from integer of =
different size [-Wint-to-pointer-cast]
   h =3D (HANDLE) strtoul (argv[2], &end, 0);
                                         ^

Note that strtoul returns an unsigned long.  Mingw compiles
for native Windows, which is LLP64 rather than LP64:

  mingw:sizeof(long) =3D=3D 4
  cygwin:sizeof(long) =3D=3D 8

This needs fixing as well (use strtoull).


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl0SBQYACgkQ9TYGna5E
T6Av7Q/9HC+3HUYVoepPpdSxOicAJMR+0YUoXK4MHH3pCcPM2ixC3oZzQPs1Sgv3
tThw8XFy7NrBccxE0G+2zJeeg7KmOxLTmab659dd9BmKVAvBrj0i+tNItjX0hKc4
Mf0/3OOSR+SjXeW61fKLuH1+J0YjSxI4+mhMQY82hM6iHWLyktJkQWtPMzTtJK1X
Gay7+Ag0dfKSvSHmnZT48mLSDKvQAP1wV/5sVIm4OdE4zlBHiaeAOtpq5AxZoDjx
pTsR5zIjLaRsD0KuUMif0yv+YDhzhGLWvZAv2zekI9iiWUpO+A1uiyLkG6bj5EoZ
PQHWAnabL9W7MPdAdAMxS3WpWy0ccJD5pkWMmM+9kSXqzrhMvB+sYu2s0riRKx76
P7vMqQ2ehZ/JxDKqRPe4tYbEH+v1wP5f0zStOyvOyxTilIbTVBam0k+nGppg3fxY
tAgKlnPVLCjokACWPM5g1RDY1g+HJgJrMR2b+Bg9axN8LNxs7iZTt3pE70bXceJN
CCJUVZ7OQLmTO3AXB5q+/F7wooxuzbIFlWyW+rgV8Zecr2oULXmK4/v6wbnXQ95m
C5+bHSsvNfyC8LMh20rSef8yUk48blp6zBzjIB4QFX04drd7hTHDAC/aMeB6+31z
DW+uTZfyEvo1DHHM7isko3mb6Mc4AAP1G7O4h/SQ9FCQ3kFlYZs=
=A9nD
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
