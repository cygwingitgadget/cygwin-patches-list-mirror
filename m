Return-Path: <cygwin-patches-return-9508-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104510 invoked by alias); 22 Jul 2019 18:47:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104494 invoked by uid 89); 22 Jul 2019 18:47:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 22 Jul 2019 18:47:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MdeOl-1iPFCa2cCH-00ZcMz; Mon, 22 Jul 2019 20:46:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AB2F8A808BB; Mon, 22 Jul 2019 20:46:56 +0200 (CEST)
Date: Mon, 22 Jul 2019 18:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: fix one more check for positive virtual_ftype_t values
Message-ID: <20190722184656.GH21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190722180825.15840-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="K1n7F7fSdjvFAEnM"
Content-Disposition: inline
In-Reply-To: <20190722180825.15840-1-kbrown@cornell.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00028.txt.bz2


--K1n7F7fSdjvFAEnM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1875

On Jul 22 18:08, Ken Brown wrote:
> Also drop more comments referring to numerical virtual_ftype_t values.

Not sure how I missed that, thanks for catching!  Please push.


Thanks,
Corinna


> ---
>  winsup/cygwin/fhandler_process.cc  | 3 ---
>  winsup/cygwin/fhandler_registry.cc | 4 +---
>  2 files changed, 1 insertion(+), 6 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_process.cc b/winsup/cygwin/fhandler_p=
rocess.cc
> index 0dafc2f0f..2a0655475 100644
> --- a/winsup/cygwin/fhandler_process.cc
> +++ b/winsup/cygwin/fhandler_process.cc
> @@ -86,9 +86,6 @@ static bool get_mem_values (DWORD dwProcessId, size_t &=
vmsize, size_t &vmrss,
>  			    size_t &vmtext, size_t &vmdata, size_t &vmlib,
>  			    size_t &vmshare);
>=20=20
> -/* Returns 0 if path doesn't exist, >0 if path is a directory,
> -   -1 if path is a file, -2 if path is a symlink, -3 if path is a pipe,
> -   -4 if path is a socket. */
>  virtual_ftype_t
>  fhandler_process::exists ()
>  {
> diff --git a/winsup/cygwin/fhandler_registry.cc b/winsup/cygwin/fhandler_=
registry.cc
> index f7db01b99..5fc03fedd 100644
> --- a/winsup/cygwin/fhandler_registry.cc
> +++ b/winsup/cygwin/fhandler_registry.cc
> @@ -306,8 +306,6 @@ multi_wcstombs (char *dst, size_t len, const wchar_t =
*src, size_t nwc)
>    return sum;
>  }
>=20=20
> -/* Returns 0 if path doesn't exist, otherwise a virtual_ftype_t value
> -   specifying the exact file type. */
>  virtual_ftype_t
>  fhandler_registry::exists ()
>  {
> @@ -562,7 +560,7 @@ fhandler_registry::fstat (struct stat *buf)
>  		  buf->st_uid =3D uid;
>  		  buf->st_gid =3D gid;
>  		  buf->st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
> -		  if (file_type > virt_none)
> +		  if (virt_ftype_isdir (file_type))
>  		    buf->st_mode |=3D S_IFDIR;
>  		  else
>  		    buf->st_mode &=3D NO_X;
> --=20
> 2.21.0

--=20
Corinna Vinschen
Cygwin Maintainer

--K1n7F7fSdjvFAEnM
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl02BKAACgkQ9TYGna5E
T6CMqxAAhpOhGf7wszSO2zm9TES6TPQrz8GkwxhjHiBAWZtWypcryv9nGIVX5MPG
/v6v0Wb2MLmHZ23k3DNcXVZrFrk3cJ3Qy7nu2keYNKzOk3Wru6IerF+ZaVMk0LHy
6BzDpcvbBnWPcT7gpl7q72HqmKXhQ5oIwMoGaQk8MTahyD0ON5ievkbhK60aMKb+
HJhJm/RGAuKwgY0sg9kG/gK0Y28eh7Zp4/40qWRcuqP8E5SExm9oYXieI+96StwI
+L7d3511S05z33uNDwJzMDveTB69iq8/cZAistRd7hhw4AHhpYSYMr9gpmPrRJRJ
SwGDpyTItO0n7WmaLa3bAADzcjfbU76iRmHoIP1NEBKpwrkig2LslhF/sgzhpZjK
mt6DnrY6AXZEKjL8tGMKdcn92/Hch7N+aRPIfO6+4raUo20dPP24NNKFa5D8LzCA
dO6G3Id7Ct2v6lHIzypthdm9Cp2imwaieQ2Nand3rAz9FmJEIbNICbBh9ai4BEL6
3knHdeLXvEkahIgxZMiz62NI6tV+OOyns0McZWWxNsACkzFT/i8pKmMJHGqRb9iE
/FO2+o38hWlR0X7XjhOdnktF8qNbjTXDJB6sFYRH1Oi5srIkHEdrd2cP9Zo87aHO
MIb6okSbmf4g6uU29hwhGsnKUa3zXmkGB7lhl19DG7tm9AB6dPM=
=+DNq
-----END PGP SIGNATURE-----

--K1n7F7fSdjvFAEnM--
