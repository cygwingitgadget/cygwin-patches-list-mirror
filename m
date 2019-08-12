Return-Path: <cygwin-patches-return-9563-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 39692 invoked by alias); 12 Aug 2019 15:14:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 39683 invoked by uid 89); 12 Aug 2019 15:14:36 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.0 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*Ad:U*cygwin-patches
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Aug 2019 15:14:35 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N5mOb-1iLenj1x0N-017ATC for <cygwin-patches@cygwin.com>; Mon, 12 Aug 2019 17:14:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C2924A80730; Mon, 12 Aug 2019 17:14:31 +0200 (CEST)
Date: Mon, 12 Aug 2019 15:14:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix deadlock at calling fork() in console
Message-ID: <20190812151431.GK11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190812134623.2102-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="BldhxuJQ12PvT3+j"
Content-Disposition: inline
In-Reply-To: <20190812134623.2102-1-takashi.yano@nifty.ne.jp>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00083.txt.bz2


--BldhxuJQ12PvT3+j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 481

On Aug 12 22:46, Takashi Yano wrote:
> In cygwin test release 3.1.0-0.1, calling fork on console ocasionally
> falls into deadlock. The reason is not clear, however, this patch fixes
> this problem anyway.
>=20
> Takashi Yano (1):
>   Cygwin: console: Fix deadlock at calling fork().
>=20
>  winsup/cygwin/fhandler_console.cc | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> --=20
> 2.21.0

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--BldhxuJQ12PvT3+j
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1RglcACgkQ9TYGna5E
T6Cs5Q/+IV2pSnSxaBBu0Xw2TYP16ECwK+DD2zgCVd/2IUhhtEqHJuRnWaUaaXY4
SWhihUl99ysTKvDJ8bqWW3lc388A65R7Ify6whVNjRrVNt5Qy9V+qPVn0NoCf3bt
FhL6TUzETPQpJNoCZ4U80Gp+YBITvjJa9Lo3e1mrCVbtb5Amaf+mzzvy+jluJ059
mJY9FR/w+OIXTSO13tOyu0IbLPfF8uVzDe4OHOoATRDDZS8cBH/iSai4HGBpINXA
OON61T6eBKvA09EVX3xgWUCspFG2QVCq7euATbM1o5PKbIEvshyP/RDNBXiKHtM6
WG5z6ALh/qLr7SUZ+8q34zRenOHsZQ3PGqilTAFeo1Hh9vnPfvwDjk9Bs66NqRGE
qn3IkbCpgq3kNHJwOXv+9yOVZvcF8ifm4G173mN7wXVBYx+Ga6F2uEss4vIrRmcF
Ui2U3w+iebOxtUVFco8FovMzB8ADKxbq02QUsYt+CXTmB/T3GgNgQ61CsvuCHbWd
L9DKR/T7Hd3qR0uiIe8tyXu2r7dPFWibhBV0pJI7NChrnhFMlTD01yHsKQ8BA5fy
FFT7CsFmTdA9/S6NoAWKKZM/Nrk1heKiwfUsAKsXNJYwB9CvDZc25jwQ3SxyEwWS
su6R9kmz9yZuFk8rpfSWahbGbyETJduo5s0B4EqczN8TT54rvFw=
=iWvR
-----END PGP SIGNATURE-----

--BldhxuJQ12PvT3+j--
