Return-Path: <cygwin-patches-return-10090-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120475 invoked by alias); 20 Feb 2020 13:45:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120442 invoked by uid 89); 20 Feb 2020 13:45:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.0 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1015
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 13:45:03 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Ml6i4-1jjMDg25NM-00lYfD for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 14:45:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D20D4A8086E; Thu, 20 Feb 2020 14:44:59 +0100 (CET)
Date: Thu, 20 Feb 2020 13:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200220134459.GS4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yklP1rR72f9kjNtc"
Content-Disposition: inline
In-Reply-To: <20200220133531.GR4092@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00196.txt


--yklP1rR72f9kjNtc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 984

On Feb 20 14:35, Corinna Vinschen wrote:
> On Feb 20 20:51, Takashi Yano wrote:
> > - In xterm compatible mode, 0x00 on write() behaves incompatible
> >   with real xterm. In xterm, 0x00 completely ignored. Therefore,
> >   0x00 is ignored by console with this patch.
> > ---
> >  winsup/cygwin/fhandler_console.cc | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > [...]
>=20
> Counter-proposal:
>=20
> diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_c=
onsole.cc
> index 66e645aa1774..1b3aa0f34aa6 100644
> --- a/winsup/cygwin/fhandler_console.cc
> +++ b/winsup/cygwin/fhandler_console.cc
> [...]

Btw., I tested this with

  write (1, "A\0B\0C\0D", 7);

it turned out that this results in broken output even with your patch.
The reason is that a NUL byte must not (cannot) be evaluated by=20
dev_console::str_to_con() -> sys_cp_mbstowcs().  The latter doesn't
handle embedded NUL bytes gracefully.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yklP1rR72f9kjNtc
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5OjVsACgkQ9TYGna5E
T6AGJA/9Fep9wXOMQkPTqxnnxeKzf6nQA9mxO2dDOvVVNzJnnD0P/vKnoAmIgAWr
JIQJfTX1fAnYygAEB/K2pQDCMXYdMqZcJP+TPQXoY4D49bQ2ZYHhbHmHMoFmJazg
OJCtCBmS4AkewZw+526xVv+K6uM0IskuI9h3aiqPnlVVnJszABUmT7eTKH1jAJrz
1nvO+KfLdvL31oCZ6LND+mYzfAbhFXeYf4MZBtDUYinBvNSFxLnrj6jhQgyEczQB
9zKmTRPSLuOuyE/CHDEOhyEp/BbWUpU6mGuXs30HK+EjaDzknQskk/AAC6cQaqAr
7aXRI+aAePvHAmcBNNlWnbIxcXsCxIj4GvTB9j2N2ME2r177YgRVkvrE3t+tgHCx
SxOaWuwfhdeJPvz+MchXnYdDxYlHqGGNeFox1qZfSDMdN4p0BcvdC7CSXO0KssDQ
B1m/TPxkc3Ww52LoicG5fBpVKpVepmnthvWu3x4nIj7XeWfdHT4h83uLJLuwexao
K+euVT1SYzMqTsYyX3X/ZO/CHKKo4lRMS0l5HPwE2/Od7hs7lRz5XuOdgv/QbSGs
sXEmH4lpHrMoyTYDp5LcR0lW/6Q3+GtGPMpgtbHcHDCUJdJROja40eiBAddHhz+P
RzpxqnMqFI/aljJ4m8dgo0EIK/dcYuA5O48mGWXYTqi2XLGR2Bc=
=nxB6
-----END PGP SIGNATURE-----

--yklP1rR72f9kjNtc--
