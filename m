Return-Path: <cygwin-patches-return-9944-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 92421 invoked by alias); 17 Jan 2020 09:19:40 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 92412 invoked by uid 89); 17 Jan 2020 09:19:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-121.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=letter
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 17 Jan 2020 09:19:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mnac9-1jJhqc0xRl-00jYYF for <cygwin-patches@cygwin.com>; Fri, 17 Jan 2020 10:19:35 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 86D22A80670; Fri, 17 Jan 2020 10:19:34 +0100 (CET)
Date: Fri, 17 Jan 2020 09:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: normalize_win32_path: allow drive without trailing backslash
Message-ID: <20200117091934.GB5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200115174632.7986-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="v4cNTr+tRGSs1txX"
Content-Disposition: inline
In-Reply-To: <20200115174632.7986-1-kbrown@cornell.edu>
X-SW-Source: 2020-q1/txt/msg00050.txt


--v4cNTr+tRGSs1txX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1371

On Jan 15 17:46, Ken Brown wrote:
> Commit 283cb372, "Cygwin: normalize_win32_path: improve error
> checking", required a prefix '\\?\' or '\??\' in the source path to be
> followed by 'UNC\' or 'X:\', where X is a drive letter.  That was too
> restrictive, since it disallowed the paths '\\?\X: and '\??\X:'.  This
> caused problems when a user tried to use the root of a drive as the
> Cygwin installation root, as reported here:
>=20
>   https://cygwin.com/ml/cygwin/2020-01/msg00111.html
>=20
> Modify the requirement so that '\??\X:' and '\\?\X:' are now allowed
> as source paths, without a trailing backslash.
> ---
>  winsup/cygwin/path.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> index c8e73c64c..a00270210 100644
> --- a/winsup/cygwin/path.cc
> +++ b/winsup/cygwin/path.cc
> @@ -1411,7 +1411,7 @@ normalize_win32_path (const char *src, char *dst, c=
har *&tail)
>        && src[2] =3D=3D '?' && isdirsep (src[3]))
>      {
>        src +=3D 4;
> -      if (isdrive (src) && isdirsep (src[2]))
> +      if (isdrive (src) && (isdirsep (src[2]) || !src[2]))
>  	beg_src_slash =3D false;
>        else if (!strncmp (src, "UNC", 3) && isdirsep (src[3]))
>  	/* native UNC path */
> --=20
> 2.21.0

Looks good, please push.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--v4cNTr+tRGSs1txX
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4hfCYACgkQ9TYGna5E
T6DBpRAAg5MGFBOimfZ8SkJlpE4NCqNa7Lql/3U1HOYClBE6mERD85CRGMO85R4r
ffDQmPqv31jtZlUktppnRAt5lDhUzW39q9QLeOTzGHFOuvXbsNOkZJWUnAXMk6Fd
9bpLvL/LHmUVXi5SNClUABFJKjKg1jTLhzN6IGoCWmnQGP1Ggzwo6jrAXA7L2URC
+44oc+s5+MoT1kO4InXm8M1BLX7QnX7XuDFlz05tU/Qm7DYZJMG1nRdOE2wbhljb
iMkB+RbTQ79R6Zh9uDPxtOjId3ISrLLb6dJSEah9hZAGH501qoiHXNO2na0MJv6Y
RmQIMbo7H+4CQBaNVX3RoxR/SPRFuGH1LNaww6wb78fqUd0ctnMmAz5DADNoTouL
ErS44EDgu9sszMq/3Pp+bHAdGi3DkFytVAkcKzRp/m1efngf0PexjHNN2bI/w9Ek
l9F+sWx/yU9nKJds5zr3sHBPrnzUDkjFW46okvb6ggpTq/3SW0PMoUFS7+A1AuU0
kAhdemB9QHo1MV/hWsCRnwojXrY+EAPZhC85YV+BXaLLKSSgVDtC3VNMwl4hy9+u
9l2/rqp6wwfj9BwqxLreVeCyyd94iqqJbAfViFVvs6FCO44xHv9yOgBT/fcV/l+N
zgBxaFI6UHqlEvVKKR4YwQR7FGbQEAL/5JYBk2T/J4wHs/uq/wc=
=cx9A
-----END PGP SIGNATURE-----

--v4cNTr+tRGSs1txX--
