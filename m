Return-Path: <cygwin-patches-return-9565-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 47665 invoked by alias); 12 Aug 2019 15:15:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47462 invoked by uid 89); 12 Aug 2019 15:15:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 15:15:14 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MA7Su-1i8mc92AXK-00Bcgo for <cygwin-patches@cygwin.com>; Mon, 12 Aug 2019 17:15:03 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 3E12BA80786; Mon, 12 Aug 2019 17:15:03 +0200 (CEST)
Date: Mon, 12 Aug 2019 15:15:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix cursor position restoration on console
Message-ID: <20190812151503.GM11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190812134845.2249-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="+JxO0BCtE2fudOKI"
Content-Disposition: inline
In-Reply-To: <20190812134845.2249-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00085.txt.bz2


--+JxO0BCtE2fudOKI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 583

On Aug 12 22:48, Takashi Yano wrote:
> In cygwin test release 3.1.0-0.1, the cursor position is not restored
> correctly after screen alternation in the case of xterm compatible mode
> is enabled. For example, the shell prompt is shown at incorrect position
> after using vim. This patch fixes this problem.
>=20
> Takashi Yano (1):
>   Cygwin: console: Fix cursor position restore after screen alternation.
>=20
>  winsup/cygwin/fhandler_console.cc | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna
--=20
Corinna Vinschen
Cygwin Maintainer

--+JxO0BCtE2fudOKI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1RgncACgkQ9TYGna5E
T6BP4A//e7P2nbZtt2iQF3HeKM2oLOa+7FjsH8qdi5GqdjFq56bAhTEMm20LSn36
iZtv2J1c6WNcxxMGZ1KHNVUTZFE9dQpQURchFjcgGzsbOhbuA4wj3LEy+ffyJfNm
GNq6vDEqY0wElMSJ7PucsCjjQrghfntGb1hCJ5x/NGGcnneVXfn4CK9jYCjyBmYH
3nFwB4MxhKAptW/t8IRh9VBpKNE8XNq1Nwsc4O/iHV1F+xrfcsjL7Bi+hfzkqq2T
6gzHoeFubJqLFCXkp001ZfZ42ZZQbfGuyiDxF22AdqWpHL8aH+9OhN9lYBVj6xXr
OGLTd8RRcYxByXszHCyO7HHBoz7PEollC54x7UWDXvucZQPacTls39gk5YKgjKti
/j7DLOQKlwWWoht60ylwLsvxnp2XZP6s+eri639B7KpTsVMb+JjEiGwZ5ZkjPWw0
kNJZ3AlTgDgkoRFUtjxiCAMY2BU+XxHhLYjGNOXDgA8CVLQYQWOmYCR6ZvPwshPA
gC1Q6RG4Y3/VDLKvurtiTnhBcNT2/2wZBw8Vbekkc6/D14BmyNAYUpTIu9c5JPSE
t9brgVwUDAhbZP1VE0kSLpXII/wdYMc0fppfDxejRoUIkNnRQLRD1DaT3T6IhRH8
w+DzktZco5Xfqtou4+EeGKjPjxtoyJ3sHZ67iQxv+XkxAaAh/9I=
=ClDp
-----END PGP SIGNATURE-----

--+JxO0BCtE2fudOKI--
