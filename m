Return-Path: <cygwin-patches-return-9916-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50734 invoked by alias); 13 Jan 2020 16:15:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50671 invoked by uid 89); 13 Jan 2020 16:15:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=win10, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 13 Jan 2020 16:15:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MHXWL-1ivjD80wYD-00DXtT for <cygwin-patches@cygwin.com>; Mon, 13 Jan 2020 17:15:07 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C9AB2A806B2; Mon, 13 Jan 2020 17:15:06 +0100 (CET)
Date: Mon, 13 Jan 2020 16:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Add workaround for broken CSI3J in Win10 1809.
Message-ID: <20200113161506.GN5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200101065215.8944-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="sdJFN6SSISdF2ksn"
Content-Disposition: inline
In-Reply-To: <20200101065215.8944-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00022.txt


--sdJFN6SSISdF2ksn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1264

On Jan  1 15:52, Takashi Yano wrote:
> - In Win10 1809, the cursor position sometimes goes out of screen
>   by clear command in console. This seems to be caused by escape
>   sequence CSI3J (ESC[3J). This happens only for 1809. This patch
>   is a workaround for the issue.
> ---
>  winsup/cygwin/fhandler_console.cc | 12 +++++++++
>  winsup/cygwin/wincap.cc           | 41 ++++++++++++++++++++++++++++++-
>  winsup/cygwin/wincap.h            |  2 ++
>  3 files changed, 54 insertions(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index e4e21e65e..30b9165ca 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> @@ -1667,6 +1667,18 @@ bool fhandler_console::write_console (PWCHAR buf, =
DWORD len, DWORD& done)
>    if (wincap.has_con_24bit_colors () && !con_is_legacy
>        && memmem (buf, len*sizeof (WCHAR), L"\033[?1049", 7*sizeof (WCHAR=
)))
>      need_fix_tab_position =3D true;
> +  /* Workaround for broken CSI3J (ESC[3J) support in kterm compatible mo=
de. */
                                                        ^^^^^
                                                        xterm?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--sdJFN6SSISdF2ksn
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4cl4oACgkQ9TYGna5E
T6CWcw//bK0YI7vWYrI6WIxl3lq4dmxgQvGgAvGJrcrueUXHuMw2EJ8+SwfxHAjY
asXBmEheG+vsyDHENzrzptBYeyL/InGkvdMaL/O79qynmwCV88Sp68BRQn7oJA/P
3fn6uoWiChAqLFFd0+K0ZI5hkD6Vob1+io+HLJmXXK6yHJ3tegpiI5yf2ZyGHTJY
9sSWhghDH0qeIODCB/2mTQxH6xOz+K1CSEkGI264HR3OZK3zPIP4zszVUztJ1bPR
mvJwEW5z3aGM3O4lvRVCjYhN+qOQHj/T7+2PWgWA/vvdb+gP6x1Sll4G46Nz8kTq
zmeGVSgpAwBLUGsg7cGKdj8KmfNjbOis2SurgPRIe48pNr+MFAQ1t6gtpoD7wde0
2Kw4pL2QDDXIlUUbdOCvzJ24UFcXilnY/x3ANwr2FvUChOBcHXNCE20qZB/F8IqI
3yxGQ2bh/HEHdtAQcXoRJx/5QgGJpLJocIXuSKavvceGjFCJ2ez7NaZFmwqelfyw
iQniNwqOnc/scvUU2f0miFpEsgmVXO/wV3Mc4cPMO4/nlamINCIo3lT2Mu3448BB
x8ITLQfqukql3FamjvCeZzHa0E63qonZ2jtR3vWJw+vGrOBT+YcuO5U84fSX00bA
wEhkUJQpkC40a9FCtHBwbcc8ADHpq2xoks1UhcROZlzX9Mhd4fI=
=ywkZ
-----END PGP SIGNATURE-----

--sdJFN6SSISdF2ksn--
