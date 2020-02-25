Return-Path: <cygwin-patches-return-10115-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36085 invoked by alias); 25 Feb 2020 09:17:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36019 invoked by uid 89); 25 Feb 2020 09:17:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.8 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:2233, ages, screen
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.187) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 25 Feb 2020 09:16:59 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id 1Mvs2R-1jNdLa0TYN-00su4n for <cygwin-patches@cygwin.com>; Tue, 25 Feb 2020 10:16:57 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7ED8EA82770; Tue, 25 Feb 2020 10:16:56 +0100 (CET)
Date: Tue, 25 Feb 2020 09:17:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix segfault on shared_console_info access.
Message-ID: <20200225091656.GJ4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200221191000.1027-1-takashi.yano@nifty.ne.jp> <20200221194333.GZ4092@calimero.vinschen.de> <20200222170123.23099cf86117791daa1722c5@nifty.ne.jp> <20200222223534.82ef1b99a3359106ce35996b@nifty.ne.jp> <20200224100835.GD4045@calimero.vinschen.de> <20200225011011.7d2c6b5350c0738b705480ba@nifty.ne.jp> <20200224183318.GH4045@calimero.vinschen.de> <20200225120816.3abe69332aace2b7f1b392ae@nifty.ne.jp> <20200225125325.52039a023b7f21c497a05933@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
In-Reply-To: <20200225125325.52039a023b7f21c497a05933@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00221.txt


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2179

On Feb 25 12:53, Takashi Yano wrote:
> On Tue, 25 Feb 2020 12:08:16 +0900
> Takashi Yano wrote:
> > On Mon, 24 Feb 2020 19:33:18 +0100
> > Corinna Vinschen wrote:
> > > Is there some kind of workaround for that problem?  Otherwise default=
ing
> > > to a (broken) xterm mode instead of a (working) cygwin mode is a bit
> > > questionable, isn't it?
> >=20
> > In my environment, legacy cygwin mode is not 'working' with
> > gray background and black foreground.

I'm using the windows console with grey background and black
foreground for ages.  Apart from bugs we had in the past, this
setting always worked as expected, except in some border cases.

What's important is that you start your shell from a shortcut
with these console settings.  I.e., you have to change the
settings in the shortcut properties.  Otherwise, if you start
the shell with default grey on black and just switch the color
settings on the fly for this console, there will always be
artifacts.  Somehow the legacy console doesn't like switching
colors during a session that much.

> > You can confirm what
> > happens if xterm mode is disabled by reverting cygwin to 3.0.7.

I simply set has_con_24bit_colors to false and rebuilt the DLL.
With this enforced cygwin term setting, my vim example works
fine, just as /bin/echo -e '\033[H\033[5L'

> > If you type 'aaa' in shell prompt and hit backspace, then
> > whole line after cursor gets black. Furthermore, if you run
> > vim, whole screen gets into black background and gray fore-
> > ground.
> >=20
> > Do not these happen in your environment?

No, as I wrote, it works as expected and the background stays
grey.

> > Oh, wait. I was setting foreground and background color in
> > "terminal" tab in property. If I set them in "colors" tab,
> > cmd.exe behaves differently. In this setting, your problem
> > does not seems to occur.
>=20
> I was wrong. The problem also occur with "colors" tab setting.
> However, in this case, ScrollConsoleScreenBuffer() test case
> does not cause the problem. Therefore it may be possible to
> make a workaround for this. I will try.

That would be great!


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5U5ggACgkQ9TYGna5E
T6ANZg/+NLG07Aclk0PVD8mo5rGazTTDzDeUXW5SdMt4uR2kcLYo8sq4dy3Cpujm
lX9BolI7tXFouh65PRImj7GrGJQLpR0shYtEEMFCdawCItucIuKsxC3cnG6S4sxg
TUj/lRqo9WA2CQL0i/B/+tqId4SqEpdV4aUHcxOGc9FYoO0B0aqumeO7sdcn7pWH
4azIaVhgvkDNOZs1TwOaX3FIldQT/eKpjZZAo2J2QasmdOF5ZMxBAZ0Ki07LYdSy
L1D4dpKMwWG7Ps4/v46kL+Iv5jsMhZOHeyzD8JbXAvlypR3QlVFnksYSzn76Fw+w
w4vi6bDMJUsw0kCFVPK0gY6GeQux7qgUMiAZ4WP+yJvMfxbd6ESA/tt6cmJCbBc0
vKwZSYfSdDa/sW19kPAZJjrNxZ2TllMiAkEAQqKJbA+8oLqCj29oDU/43cE/aOhu
CtQFAhYdQH0nlgsTGA9Xb3mxjP2pKOXCtlNAXt2atzd2cdIxzQcCVZ9gaa56ggTE
HoqYaF6jtk4vR0tuPmdSueXQoec37y2lRikuBGsnvsXECEfXIZFnQv8dC1YxHK7m
KRcfmdaBgZQCv498QRUNA9DjiD1kuD7pJTi22SQ7oL6PpDe5BZo0h8qCsiM0mAF/
U1Gk9oe9ZFYCwpQ9j3tS/NO4Vp4wqbBgjz6Cy2kweB/HX+BvlPk=
=7zQD
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
