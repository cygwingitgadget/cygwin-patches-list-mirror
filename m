Return-Path: <cygwin-patches-return-9247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109470 invoked by alias); 27 Mar 2019 18:48:50 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 109246 invoked by uid 89); 27 Mar 2019 18:48:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, para
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 27 Mar 2019 18:48:43 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MmyzH-1gizL51NLz-00k3sz for <cygwin-patches@cygwin.com>; Wed, 27 Mar 2019 19:48:40 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 98F74A8057E; Wed, 27 Mar 2019 19:48:39 +0100 (CET)
Date: Wed, 27 Mar 2019 18:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: document the recent FIFO changes
Message-ID: <20190327184839.GL4096@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190327180959.59644-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <20190327180959.59644-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00057.txt.bz2


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1486

On Mar 27 18:10, Ken Brown wrote:
> ---
>  winsup/cygwin/release/3.1.0 | 14 ++++++++++++++
>  winsup/doc/new-features.xml | 12 ++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 winsup/cygwin/release/3.1.0
>=20
> diff --git a/winsup/cygwin/release/3.1.0 b/winsup/cygwin/release/3.1.0
> new file mode 100644
> index 000000000..1f017bfd1
> --- /dev/null
> +++ b/winsup/cygwin/release/3.1.0
> @@ -0,0 +1,14 @@
> +What's new:
> +-----------
> +
> +
> +What changed:
> +-------------
> +
> +- FIFOs can now be opened multiple times for writing.
> +  Addresses: https://cygwin.com/ml/cygwin/2015-03/msg00047.html
> +             https://cygwin.com/ml/cygwin/2015-12/msg00311.html
> +
> +
> +Bug Fixes
> +---------
> diff --git a/winsup/doc/new-features.xml b/winsup/doc/new-features.xml
> index e14fbb1e8..c87601e9d 100644
> --- a/winsup/doc/new-features.xml
> +++ b/winsup/doc/new-features.xml
> @@ -4,6 +4,18 @@
>=20=20
>  <sect1 id=3D"ov-new"><title>What's new and what changed in Cygwin</title>
>=20=20
> +<sect2 id=3D"ov-new3.1"><title>What's new and what changed in 3.1</title>
> +
> +<itemizedlist mark=3D"bullet">
> +
> +<listitem><para>
> +FIFOs can now be opened multiple times for writing.
> +</para></listitem>
> +
> +</itemizedlist>
> +
> +</sect2>
> +
>  <sect2 id=3D"ov-new3.0"><title>What's new and what changed in 3.0</title>
>=20=20
>  <itemizedlist mark=3D"bullet">
> --=20
> 2.17.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlybxYcACgkQ9TYGna5E
T6B6dA//VG+GXZViDlKDBd1zVYI5/txgdJUhTtU8IdM3o2FECnrLh+Bt836nK7pv
vzI3F+qgHxPvULcDzQyurPnbAbRcH9TFH113lsstH2Ka7UqhfHJLlqGooN0z3Opm
K7Pe2F4qAJk/gepaN/tnbsBH30sgdKy1w7HwPeh6BlvWqPmb3FfF4j14XDaK0xkq
pfFs0xsgnJgynqdgEZd+3BItmI9EjnXLvuNtOAYIiggYmXJvhNans7GX5HQQcV9H
824rJIRCrSWTQuf8LuIcwWtCSLMMdm5fhwBNQ0Rc6aGkEhDtB5onbCdbwLrNdo0T
ggRO2drUPGDq3JfxjbAEpcyqkPjk1T/owIMUIBD1rG0JKcPpDUHbIY1kP9YPH3N8
H3j3IRmUM58uxrfEIhzyP+vfXtPAWJIIHDpd/5ktT0LJSid3ZTj9PSJ25rdV3g8c
/JKg6ppykva0iQL1yeErGB4IoQ6igGe9q3ZDB+UdFsWA+oAfL+ZJuAVt9VGELuRs
yRW4wsY888/s7j5pH8gCnNG7Z31/ucWrcRSGITDqSelyGq+Izp/NAghPjEcUSlom
evjPYvlQDBnYbh9ZBHwBraB9lzBIPwLeIbAQ6COvofqbDH+uvC/Fm3gGa+gXgUZb
G7CjheMzHMW/hF5WSX6ds22/o4nUq8rYHFSyMOSdq8IgULyV2w8=
=tZ2O
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
