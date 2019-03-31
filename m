Return-Path: <cygwin-patches-return-9287-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 121507 invoked by alias); 31 Mar 2019 14:37:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120573 invoked by uid 89); 31 Mar 2019 14:37:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-116.3 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE,URIBL_BLOCKED autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 31 Mar 2019 14:36:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MKt3r-1hVixs1y9t-00LB8K; Sun, 31 Mar 2019 16:36:53 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0A508A8059A; Sun, 31 Mar 2019 16:36:51 +0200 (CEST)
Date: Sun, 31 Mar 2019 14:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/3] Cygwin: console: support 24 bit color
Message-ID: <20190331143651.GF3337@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Takashi Yano <takashi.yano@nifty.ne.jp>,	cygwin-patches@cygwin.com
References: <20190331094731.GC3337@calimero.vinschen.de> <20190331134718.1407-1-takashi.yano@nifty.ne.jp> <20190331134718.1407-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="6e7ZaeXHKrTJCxdu"
Content-Disposition: inline
In-Reply-To: <20190331134718.1407-2-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q1/txt/msg00097.txt.bz2


--6e7ZaeXHKrTJCxdu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3543

On Mar 31 22:47, Takashi Yano wrote:
> - Add 24 bit color support using xterm compatibility mode in
>   Windows 10 1703 or later.
> - Add fake 24 bit color support for legacy console, which uses
>   the nearest color from 16 system colors.
> ---
>  winsup/cygwin/environ.cc          |   7 +-
>  winsup/cygwin/fhandler.h          |   4 +
>  winsup/cygwin/fhandler_console.cc | 229 +++++++++++++++++++++++++-----
>  winsup/cygwin/select.cc           |   8 ++
>  winsup/cygwin/wincap.cc           |  10 ++
>  winsup/cygwin/wincap.h            |   2 +
>  6 files changed, 227 insertions(+), 33 deletions(-)
>=20
> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
> index 21f13734c..c27d10fe1 100644
> --- a/winsup/cygwin/environ.cc
> +++ b/winsup/cygwin/environ.cc
> @@ -869,10 +869,15 @@ win32env_to_cygenv (PWCHAR rawenv, bool posify)
>    char *newp;
>    int i;
>    int sawTERM =3D 0;
> -  static char NO_COPY cygterm[] =3D "TERM=3Dcygwin";
> +  static char NO_COPY cygterm[] =3D "TERM=3Dxterm-256color";
>    char *tmpbuf =3D tp.t_get ();
>    PWCHAR w;
>=20=20
> +  /* If console has 24 bit color capability, TERM=3Dxterm-256color,
> +     otherwise, TERM=3Dcygwin */
> +  if (!wincap.has_con_24bit_colors ())
> +    strncpy (cygterm, "TERM=3Dcygwin", sizeof (cygterm));
> +

This hunk is ok, but I wonder if the time hasn't come to simplify the
original code.  The `static char NO_COPY' only makes marginal sense
since it's strdup'ed anyway.

What if we just define two const char's like this

  const char cygterm[] =3D "TERM=3Dcygwin";
  const char xterm[] =3D "TERM=3Dxterm-256color";

and then just strdup them conditionally:

  if (!sawTERM)
    envp[i++] =3D strdup (wincap.has_con_24bit_colors () ? xterm : cygterm);

What do you think?

> +#ifndef ENABLE_VIRTUAL_TERMINAL_PROCESSING
> +#define ENABLE_VIRTUAL_TERMINAL_PROCESSING 0x0004
> +#endif /* ENABLE_VIRTUAL_TERMINAL_PROCESSING */
> +#ifndef DISABLE_NEWLINE_AUTO_RETURN
> +#define DISABLE_NEWLINE_AUTO_RETURN 0x0008
> +#endif /* DISABLE_NEWLINE_AUTO_RETURN */
> +#ifndef ENABLE_VIRTUAL_TERMINAL_INPUT
> +#define ENABLE_VIRTUAL_TERMINAL_INPUT 0x0200
> +#endif /* ENABLE_VIRTUAL_TERMINAL_INPUT */

Sorry, didn't notice this before:  Please prepend this block with
a comment along the lines of "/* Not yet defined in Mingw-w64 */"

> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 9b18e8f80..28adcf3e7 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -1053,6 +1053,14 @@ peek_console (select_record *me, bool)
>                 else if (irec.Event.KeyEvent.uChar.UnicodeChar
>                          || fhandler_console::get_nonascii_key (irec, tmp=
buf))
>                   return me->read_ready =3D true;
> +               /* Allow Ctrl-Space for ^@ */
> +               else if ( (irec.Event.KeyEvent.wVirtualKeyCode =3D=3D VK_=
SPACE
> +                          || irec.Event.KeyEvent.wVirtualKeyCode =3D=3D =
'2')
> +                        && (irec.Event.KeyEvent.dwControlKeyState &
> +                            (LEFT_CTRL_PRESSED | RIGHT_CTRL_PRESSED))
> +                        && !(irec.Event.KeyEvent.dwControlKeyState
> +                             & (LEFT_ALT_PRESSED | RIGHT_ALT_PRESSED)) )
> +                 return me->read_ready =3D true;
>               }
>             /* Ignore key up events, except for Alt+Numpad events. */
>             else if (is_alt_numpad_event (&irec))

Doesn't this belong into the select patch?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--6e7ZaeXHKrTJCxdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyg0IIACgkQ9TYGna5E
T6C0WhAAhsrNCdmykp/3xs87/t9qlKA4GbWO6gwRg7YcjSHvdUQKVO64lq6fCGm4
CavgPzim8UhOKsmQq8b6M1It/jCTUcrVuE0EbCbdJDk5LQ5qxpDu34OBsnM6328d
8KYx6tNsk8ILOknwrsoOT6DQq4C7yvfqWLcOr0XKUlJfFgqEsjm2DZL00tyyDSwH
Vu+F/PglPsKt7DC9RHnCqX8AmLVSlo+mpC86JoW3YftsMwug9C693k2+EZGo2w2r
93+PXFsosyfS0OCqV6eH8agfWgPts/HYZ61olO+Taj4c+scKK5++YZ46+PTJ8WSu
9vvW7+EpnUAUMitfMAbep9nsY1fxyp6aXlzmzfmZRNYhtAa2vEfeC1iioL/ciR4C
zttL20KeT3bvtchCAgAYO9TbBU4VSsoWf2aN+Y2XOQz7itysExwjUC1wD0Wu2q8+
+lmD/lXoNHtGLC7HA7VsXw4GebVQd4ZzSE6kJPJGWXc0MKGQoq47AVboIlKMvQK/
U1EgU5rkCCRqZz94gHQof/zwfX1oYc/G4gvsVJYq8/4DWpiFB9zwDelPoQk0CC2L
nPIb3pBQz5YfoP8jxlTlofTiWFt8GnDaIi1VF3oCVVa6fzpVtB/mcmlDLnM5uVA/
Wiy4nrWd6bTlrLHFOgzaejfqAQJoIBD/axCx/Cm6QeSC1LPCMp0=
=sMNZ
-----END PGP SIGNATURE-----

--6e7ZaeXHKrTJCxdu--
