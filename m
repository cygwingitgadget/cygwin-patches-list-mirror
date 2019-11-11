Return-Path: <cygwin-patches-return-9822-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 44200 invoked by alias); 11 Nov 2019 09:18:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 44179 invoked by uid 89); 11 Nov 2019 09:18:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=stays, pty, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.130) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 11 Nov 2019 09:18:00 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MVJZv-1iMhAR1EoR-00SNK9 for <cygwin-patches@cygwin.com>; Mon, 11 Nov 2019 10:17:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8D1D5A806F4; Mon, 11 Nov 2019 10:17:55 +0100 (CET)
Date: Mon, 11 Nov 2019 09:18:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191111091755.GF3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp> <20191022134048.GP16240@calimero.vinschen.de> <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp> <20191023120542.GA16240@calimero.vinschen.de> <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp> <20191024093817.GD16240@calimero.vinschen.de> <20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp> <20191024133305.GF16240@calimero.vinschen.de> <20191108110955.GC3372@calimero.vinschen.de> <20191108224232.c58ba683250a438a44e15e56@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="REOXmE5zpOGz6VLu"
Content-Disposition: inline
In-Reply-To: <20191108224232.c58ba683250a438a44e15e56@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00093.txt.bz2


--REOXmE5zpOGz6VLu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1785

Hi Takashi,

On Nov  8 22:42, Takashi Yano wrote:
> Hi Corinna,
>=20
> On Fri, 8 Nov 2019 12:09:55 +0100
> Corinna Vinschen wrote:
> > On Oct 24 15:33, Corinna Vinschen wrote:
> > > On Oct 24 19:17, Takashi Yano wrote:
> > > > On Thu, 24 Oct 2019 11:38:17 +0200
> > > > Corinna Vinschen wrote:
> > > > > Well, what I see when starting cmd.exe with this patch is a short
> > > > > flicker in the existing output in mintty, but the cursor position
> > > > > stays the same. and cmd.exe output is where you'd expect it.
> > > >=20
> > > > I mean:
> > > > 1) start mintty
> > > > 2) ps
> > > > 3) script
> > > > 4) cmd
> > > >=20
> > > > In my environment, output of ps command disappears.
> > >=20
> > > In mine, too.  This does not occur w/o running script.
> >=20
> > Any news here?  Why does this only occur with script?  Is that something
> > about reusing (or not reusing) the existing pseudo console?
>=20
> This does not occur only with script. If you run
> ssh localhost
> instead of script in step 3), it also happens.
>=20
> This is because the console screen buffer is empty when pty
> (pseudo console) is started. By executing cmd.exe, screen
> is redrawn based on the console screen buffer. As a result,
> the screen contents which are not in the screen buffer is
> lost.
>=20
> I came up with another alternative. How about the attached
> patch? This forcibly redraws screen when the first native
> program is executed after creating new pty (pseudo console),
> instead of clearing screen.
>=20
> This does not solve missing screen contents, but can avoid
> cursor position problem in netsh.

I tested it and I think this is a great step forward.  Dropping
$TERM checks and clear screen sequence is the way to go!


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--REOXmE5zpOGz6VLu
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3JJ0MACgkQ9TYGna5E
T6DPnw//W7t4XBSHLfFoMqbP62bhUgkr6jLx8LkygwmpszrTOTuHtkqVENe/eAYO
1AsG6ZH+p4k0V5e1zHsqqwsCciPwCwAPYbXUHA7XPcrP7xO3BQ8Qw4cw4Zz0/VRk
1ABEXbUJyyR7obN3tfu31ZzroOhdRgKUbzSsbkeoyD+at5hYNN4GrG8nNv8mtrga
LP2vl94eUq7eMj3ksHlgtqcF7yJiTzWRQ8UY/HJmDMPL+5xizfcdzdBL7Psm/GHL
5Bz4wJawburpWR3iXLxLH2zmIgJV3+Fh/mDEnFhJCxzfTv5x3jPvwbvvZrhf/PnF
aRC73TRI6DIMQwikb73oQwWQnX86ogdS1oMw/UaXC2Ehr2xTo3V1/5Pf37Zi2OQF
Z7E6nyUYXhlIa2BSDhTLpzBqdwHvFuAtVWp4aaBvQx5toLMqHkM/xs66dO/4vZo0
K6/xyfwRlk+JvFgp6lBE1jO6pvKfxXJHdTw/cmTbkP1o4tN7ef5px9+zJJv9TgM8
ZC3wWUBE2WhpYwZeM85TiHp6RybifsdIuFeOirBLBl+d7UzJvqyRf3TMZIcAdH6Y
Si1RgaYhjTXa/vtm/P1gHAKWpuiBC5LCLlLXDEjPG97mR+n92SHfxfhssaEyKnN7
GlayiZ+BZjGJQEqzbjGUEhYMB8myXxsyiUATBIfs/3X2NN3nY+k=
=8JL/
-----END PGP SIGNATURE-----

--REOXmE5zpOGz6VLu--
