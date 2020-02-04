Return-Path: <cygwin-patches-return-10041-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 87636 invoked by alias); 4 Feb 2020 16:33:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 87625 invoked by uid 89); 4 Feb 2020 16:33:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 04 Feb 2020 16:33:42 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MowOm-1jKKnV1i4U-00qUvh for <cygwin-patches@cygwin.com>; Tue, 04 Feb 2020 17:33:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DB40BA80F08; Tue,  4 Feb 2020 17:33:38 +0100 (CET)
Date: Tue, 04 Feb 2020 16:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Remove meaningless pointer increment.
Message-ID: <20200204163338.GF3403@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200204122552.993-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
Content-Disposition: inline
In-Reply-To: <20200204122552.993-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00147.txt


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 938

On Feb  4 21:25, Takashi Yano wrote:
> - Since commit 73742508fcd8e994450582c1b7296c709da66764, a pointer
>   increment in master write code which has no effect was remaining.
> ---
>  winsup/cygwin/fhandler_tty.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index c1c0fb812..1dd57b369 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -2338,7 +2338,7 @@ fhandler_pty_master::write (const void *ptr, size_t=
 len)
>        WriteFile (to_slave, "\003", 1, &n, 0);
>      }
>=20=20
> -  line_edit_status status =3D line_edit (p++, len, ti, &ret);
> +  line_edit_status status =3D line_edit (p, len, ti, &ret);
>    if (status > line_edit_signalled && status !=3D line_edit_pipe_full)
>      ret =3D -1;
>    return ret;
> --=20
> 2.21.0


Pushed.

Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl45nOIACgkQ9TYGna5E
T6CvUA/9GxCZADq/3nQs4oTQSMbXVtYCZW8GJCMDW7hB9S3KGKGyAwiCu4T+wAgz
wF3TKIPzEbVir9UU/EwCFCgFZZyNkarBTx/XG/iyE/BULtfqTJAfPMPQ5BkdTy4b
IkvgAXhAyW46etljrm8T92hKxhQA/uJ8HGN6vKn2L+SIOpr0NCMIVy+F6TDzYkAe
BSp1Lx/+0vV0b3/Ils+utM/ArKZqtL2011B8Kk1ddxtqLvzHb+z8B+uFReTgSN93
yNdtQYFPYbvwbPgumrvj1tameLx7psnbEwYmfp19EtTjkTQYLhPZ2tzAGr2JgQ5B
p0rNmYA2fGQOkQAgaDdqR7y6AD9rsLEcfN1vpoQL2O60V4eeqnlOgDfdHY7lIORd
9AUGfl1WDBr+t7f64QumfQdwBYSg6Zm1FPKuQfMurHFb3648YT1ic4OSGVvd1OOI
RertFyb8L0gJEbS5uU+VlJsgFXKQeV5JQU5e9HLOWklvT9XELvWNgh/ojsa7/nXm
dkkjHICQx/4RkU1BpE4vOhzkp+VcHwPachb/ghFaloPS1f6gijcaypM7Ux9DonKQ
TJcS/m10wLoby9SWjqNlkVtELbUcV2sbv4TxyEEC6zM4q7fmvs1Y/zyknAqu96sY
TVkOnfNJVqp4dcX8jJA4FFuPE7F6X/n2DUubazF9hi2D/GTSH0E=
=Fcel
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--
