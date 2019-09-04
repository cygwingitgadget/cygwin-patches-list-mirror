Return-Path: <cygwin-patches-return-9626-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98565 invoked by alias); 4 Sep 2019 15:19:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98424 invoked by uid 89); 4 Sep 2019 15:19:10 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-103.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*f:sk:544d0b3, H*i:sk:544d0b3, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Sep 2019 15:19:08 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MGxYh-1i0KG91Bjf-00E9Mx for <cygwin-patches@cygwin.com>; Wed, 04 Sep 2019 17:19:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 75557A80659; Wed,  4 Sep 2019 17:19:05 +0200 (CEST)
Date: Wed, 04 Sep 2019 15:19:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: pty: Disable clear screen on new pty if TERM=dumb or emacs*.
Message-ID: <20190904151905.GZ4164@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20190904014618.1372-1-takashi.yano@nifty.ne.jp> <20190904014618.1372-3-takashi.yano@nifty.ne.jp> <20190904104738.GP4164@calimero.vinschen.de> <20190904214953.50fc84221ea7508475c80859@nifty.ne.jp> <20190904135503.GS4164@calimero.vinschen.de> <20190904234222.4c8bfbb31d9a899eb2670082@nifty.ne.jp> <544d0b3f-0623-f2d6-8e35-b21140ea323a@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="HzaOE8X7KzPzAQEl"
Content-Disposition: inline
In-Reply-To: <544d0b3f-0623-f2d6-8e35-b21140ea323a@cornell.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q3/txt/msg00146.txt.bz2


--HzaOE8X7KzPzAQEl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1360

On Sep  4 15:11, Ken Brown wrote:
> On 9/4/2019 10:42 AM, Takashi Yano wrote:
> > On Wed, 4 Sep 2019 15:55:03 +0200
> > Corinna Vinschen wrote:
> >> The code in fixup_after_attach() is the only code snippet setting
> >> need_clear_screen =3D true.  And that code also requires term !=3D "du=
mp" &&
> >> term =3D=3D "*emacs*" to set need_clear_screen.
> >=20
> > term !=3D "*emacs*"
> >=20
> >> The code in reset_switch_to_pcon() requires that the need_clear_screen
> >> flag is true regardless of checking TERM.  So this code depends on the
> >> successful TERM check from fixup_after_attach anyway.
> >>
> >> What am I missing?
> >=20
> > Two checking results may not be the same. Indeed, emacs changes
> > TERM between two checks.
> >=20
> > fixup_after_attach() is called from fixup_after_exec(),
> > which is called before executing the program code.
> > reset_switch_to_pcon () is mainly called from PTY slave I/O functions.
> > This is usually from the program code.
>=20
> But the first check (the one in fixup_after_attach()) could be dropped, c=
ouldn't it?

IIUC the second test first checks for need_clear_screen but then the
TERM might have changed in the meantime which in turn requires to change
the behaviour again.  But yeah, this sound like the first patch is not
actually required at all.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--HzaOE8X7KzPzAQEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1v1ekACgkQ9TYGna5E
T6BI9A//bhGFE3fnxpEqEBXkvFy0T5pmGBaThBVJlpWiCt1v6wSVantszS7sz33q
2ShcWbXXu6/RUPGj1N8jjVOqekJw3HHkZUw5DXJona+k26NBs0wMMH93+yBZigw/
HhnhSDKH0i8bJ22915YHqMIeZsWWRZwdLCALuu1zvKo1+1hAEdg39zlRObdjBS6g
LbEhUsvVKAzF9pZwfX6KVu6tnRDeP6rvC85m2zN2KCk0BfKtz7apWxFNNj7YGqGw
XE9VZjb1QvRLaCGbcfsxobLelqKZa0VYHBImjUwru/LDeNKKhEgi0D+Igr6Kvudn
Bvi8z+bjRxXwvLvxrOf8XrTb79R3V33Z9vav+tYDwQvZxuZnHaIIyHnVQmLr0Fxi
wPvm88snTyx/v2mdAZStRn9VaEV+IRKcXIXE1iCfYgjZRaC15t56CL4Hcz8PBfoz
53nti4p/5125hU2XrApTlWVzmuE/hYKSReIpGjISo2WkjsXpDQ91F99mDHU/VtFG
clFlyPypECZARcO6IwMBbtNgGkV9pfS40sBfO7jqOxR5nKs+caMndBL0ivktRj+L
QSp8OkunwI44D5b7mbBnQt3SY+iTegydJObKMYmLrOZplrxWT7rKAqs2oBZx2hwb
Pgvjo/etWC84zFtDm0THDxjjoRQtGcNYRlHZzCpJEArBA/EU1zo=
=eRzy
-----END PGP SIGNATURE-----

--HzaOE8X7KzPzAQEl--
