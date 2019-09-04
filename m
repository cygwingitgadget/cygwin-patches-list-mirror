Return-Path: <cygwin-patches-return-9611-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 86052 invoked by alias); 4 Sep 2019 10:47:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 86043 invoked by uid 89); 4 Sep 2019 10:47:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-115.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 10:47:42 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N5max-1iFavg27KN-017B5h for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 12:47:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E7651A80659; Wed,  4 Sep 2019 12:47:38 +0200 (CEST)
Date: Wed, 04 Sep 2019 10:47:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-ID: <20190904104738.GP4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qYrsQHciA3Wqs7Iv"
Content-Disposition: inline
In-Reply-To: <20190904014618.1372-3-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00131.txt.bz2


--qYrsQHciA3Wqs7Iv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1142

On Sep  4 10:46, Takashi Yano wrote:
> - Pseudo console support introduced by commit
>   169d65a5774acc76ce3f3feeedcbae7405aa9b57 shows garbage ^[[H^[[J in
>   some of emacs screens. These screens do not handle ANSI escape
>   sequences. Therefore, clear screen is disabled on these screens.
> ---
>  winsup/cygwin/fhandler_tty.cc | 26 +++++++++++++++++++-------
>  winsup/cygwin/tty.cc          |  1 +
>  winsup/cygwin/tty.h           |  1 +
>  3 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
> index 283558985..a74c3eecf 100644
> --- a/winsup/cygwin/fhandler_tty.cc
> +++ b/winsup/cygwin/fhandler_tty.cc
> @@ -972,6 +972,19 @@ skip_console_setting:
>  void
>  fhandler_pty_slave::reset_switch_to_pcon (void)
>  {
> +  if (get_ttyp ()->need_clear_screen)
> +    {
> +      const char *term =3D getenv ("TERM");
> +      if (term && strcmp (term, "dumb") && !strstr (term, "emacs"))

Why do you check the TERMs again here?  After all, need_clear_screen
is only true if one of these terms are used.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qYrsQHciA3Wqs7Iv
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1vlkoACgkQ9TYGna5E
T6A1ZxAAkiIy2sfgBIuDT5qUEAXzwfzdgSEI6ndSE3052Auj8zV5dGEmCIUdrb5H
PFot6OWTPn3A+jV0QDsYKxkS/+1s35jEABpKU706RvGyl0qjUgc0u0uy6hiY4ARP
1ky4hZVpyLCyGcY7eY5FIa9KVoM1VlNUnRn1fDjpb4hd+LV5H0LI3sT1dckFeqKO
P+3DoO/caF52pOfpXFgYWkLK5X3g6Wc5pJm2cZ7ISZus6EcP7zS+JWszD0RnqaEP
McywhN+AiIzWXL4P4bjHyV/bYmps4No15aSJpJIDDLHWc0+AsJpLE2aJT72Ajr1r
m/e+CoAV7TJ/zvg49smH85FokZ91I4orsr0nwyIHR3Z8ZJnumusM1PLsxynS0jTQ
NIQBpYqUcIggzJvVdaOaj88NhfgomEhVZ78MDovVtrkwNih1b47QSRyY+3UQ/uCF
iRsQkqTEADNMpY5QY/y6NO3nEedCIQFyZwOHrlHz5kDBOa9k2eppFMlqR9B0vqAz
JU8qvs+42phMUt/FBFxi1E/BeRuntRmNsZ4p8MXufXxpmSp+6Dhnu2m6/+jIQHCL
5nE4diNEiWg3W95CVewCaQZFiNPkWCoC9ynjJCpNigLk8EQZbqlSdM4N+1h1AjZO
YsI6Jz6jOIVSWQD66HEzmOeHAJ+Fd9qTVxQel4Ymx1MT8olu6Ws=
=PWiI
-----END PGP SIGNATURE-----

--qYrsQHciA3Wqs7Iv--
