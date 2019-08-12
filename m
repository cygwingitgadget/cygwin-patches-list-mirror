Return-Path: <cygwin-patches-return-9564-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 40283 invoked by alias); 12 Aug 2019 15:14:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 40262 invoked by uid 89); 12 Aug 2019 15:14:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.5 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 15:14:47 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mi4un-1iRb6a1AED-00e62O for <cygwin-patches@cygwin.com>; Mon, 12 Aug 2019 17:14:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 02AF5A80730; Mon, 12 Aug 2019 17:14:45 +0200 (CEST)
Date: Mon, 12 Aug 2019 15:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/1] Cygwin: console: Add workaround for windows xterm compatible mode bug.
Message-ID: <20190812151444.GL11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190812134742.2151-1-takashi.yano@nifty.ne.jp> <20190812134742.2151-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="b1CVx77D595wdcW8"
Content-Disposition: inline
In-Reply-To: <20190812134742.2151-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00084.txt.bz2


--b1CVx77D595wdcW8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1650

On Aug 12 22:47, Takashi Yano wrote:
> - The horizontal tab positions are broken after resizing console window.
>   This seems to be a bug of xterm compatible mode of windows console.
>   This workaround fixes this problem.
> ---
>  winsup/cygwin/fhandler_console.cc | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 075593523..3d26a0b90 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -326,6 +326,25 @@ fhandler_console::send_winch_maybe ()
>      {
>        con.scroll_region.Top =3D 0;
>        con.scroll_region.Bottom =3D -1;
> +      if (wincap.has_con_24bit_colors ())
> +	{
> +	  /* Workaround for a bug of windows xterm compatible mode. */
> +	  /* The horizontal tab positions are broken after resize. */
> +	  DWORD dwLen;
> +	  CONSOLE_SCREEN_BUFFER_INFO sbi;
> +	  GetConsoleScreenBufferInfo (get_output_handle (), &sbi);
> +	  /* Clear all horizontal tabs */
> +	  WriteConsole (get_output_handle (), "\033[3g", 4, &dwLen, 0);
> +	  /* Set horizontal tabs */
> +	  for (int col=3D8; col<con.dwWinSize.X; col+=3D8)
> +	    {
> +	      char buf[32];
> +	      __small_sprintf (buf, "\033[%d;%dH\033H", 1, col+1);
> +	      WriteConsole (get_output_handle (), buf, strlen (buf), &dwLen, 0);
> +	    }
> +	  /* Restore cursor position */
> +	  SetConsoleCursorPosition (get_output_handle (), sbi.dwCursorPosition);
> +	}
>        get_ttyp ()->kill_pgrp (SIGWINCH);
>        return true;
>      }
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna
--=20
Corinna Vinschen
Cygwin Maintainer

--b1CVx77D595wdcW8
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1RgmQACgkQ9TYGna5E
T6BuSQ/+ImsQUf3xpIt1BK/o+O0Suh/6FvfTNaNFt3J7/IzGP+MPHaTneS8I8WE5
0avK8cv/F9njuVzKUjVTrOW1p7Neh5CLDT7dJeS+/0/+FuU7SB29vNH9K3x+yLgP
AUBmJYLAofqfsq+cyDDgyAYMAdwc2CB6jyJ6/UVpsCWUnD/Rg0GMuzyGyHprbPUl
EjZVBcOqRQT1b+v4fce/wKqNTV+3S9Ksq7yNvkLlK9TGlSYf31+lWJS8SE65j5sB
PXmM5drC1F7eRoPA5l0y1+Pfym5ANrVoGITsMEfeITX4csDMqc+PmBABm6ad1UgG
tSMBx/QK7GHCM94+pR2P1CU7QmQGyxmsdBEuHnZw9Fu1ewtImYHExvBz6RZn1AzF
w3Nw2fP9LOWZkO4jcWcvvgLz9GD9tcwXrB6KMdWponwRlmOD4fvjDnDODsPljNA+
3i0C/kIlRYBwlXmGd++lJ9zM7jJ4QjSCuxu11dnwWE58IKaKhk/kvd141KAy7tgB
bkEfvSo7GVEo1/ynJSqtbeQxyRfx1sEptHps+ARftabxya8RfYcpGpOdHo/B11nG
fspx5MxlcEAJuCrdpcKskbgLldpP3QO1ok4MtVC3B/OgDST03c7bpGFUmtAwjfvz
iAlxfVn4y0e2EHeh0xqwtXzv4Nt4rzL/QZ+th/Ap4dJopYtZ0Sk=
=mRhC
-----END PGP SIGNATURE-----

--b1CVx77D595wdcW8--
