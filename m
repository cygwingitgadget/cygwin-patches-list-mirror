Return-Path: <cygwin-patches-return-9784-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22316 invoked by alias); 22 Oct 2019 13:40:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 22303 invoked by uid 89); 22 Oct 2019 13:40:54 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com, screen, installation
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 22 Oct 2019 13:40:52 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N0Zfg-1i8pOw09mG-00wTY7 for <cygwin-patches@cygwin.com>; Tue, 22 Oct 2019 15:40:50 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D95BDA80773; Tue, 22 Oct 2019 15:40:48 +0200 (CEST)
Date: Tue, 22 Oct 2019 13:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191022134048.GP16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <20191018143306.GG16240@calimero.vinschen.de> <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp> <20191021094356.GI16240@calimero.vinschen.de> <20191022090930.b312514dcf8495c1db4bb461@nifty.ne.jp> <20191022065506.GL16240@calimero.vinschen.de> <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp> <20191022080242.GN16240@calimero.vinschen.de> <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Content-Disposition: inline
In-Reply-To: <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00055.txt.bz2


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1379

On Oct 22 18:24, Takashi Yano wrote:
> On Tue, 22 Oct 2019 10:02:42 +0200
> Corinna Vinschen wrote:
> > On Oct 22 16:23, Takashi Yano wrote:
> > > On Tue, 22 Oct 2019 08:55:06 +0200
> > > Corinna Vinschen wrote:
> > > > On Oct 22 09:09, Takashi Yano wrote:
> > > > > I confirmed the dwSize has right screen size and dwCursorPosition
> > > > > is (0,0) just after creating pty even though the cursor position
> > > > > in real screen is not at top left.
> > > > >=20
> > > > > Clearing screen fixes this mismatch.
> > > >=20
> > > > And calling SetConsoleCursorPosition instead does not?
> > >=20
> > > For SetConsoleCursorPosition, it is necessary to know the cursor
> > > position of course. I cannot come up with any other way than
> > > using ANSI escape sequence "ESC[6n". Do you think this is
> > > feasible?
> >=20
> > Hmm, interesting point.  I think that should be ok for a start.
> > assuming it works.
>=20
> Unfortunately, this does not work as expected. Please try
> attached patch. Cursor position is kept as expected, but the
> screen contents before opening pty are lost when cmd.exe is
> executed.
>=20
> However, this fixes cursor position problem of netsh and WMIC.

Am I doing something wrong?  This code crashes mintty on my
installation.  At start, a string of "6n6n6n6n..." appears and then
mintty exits.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2vBuAACgkQ9TYGna5E
T6Du/w//dTt8CFDwWA1Gk5SCr8qGLETDxkm4eeeq170zGLFlE193pmd60cZ/ixMB
X9qj/EVOXD3s/9yfbLLfKpfPhOpMUEqD84uFmfJIK/QO9xSHqkFK1xjqi5+Ecg6J
3Qd8AHMZyNww2GEbn/rRDZ6ApSvdv6T80hYoulcsZQ1JY5yd7fd94/vFGhPh6RuR
jlquFHMy3TtiZIzhQs0CF5sSlUpYEbpK+1MNJ/bvFeIvBoPcaKIr046yXSKVAREe
eOQ/TaZVguTMvYFQTp0uN7l/yZ2GM0UE8i0PK1O11yUP7MCKb7UVXxxblbBi6koT
Re/zFphhODYo7rVJwdHTDdo/E8JqZbuDlFhlXKu6Gmu7KaFThAMix+Vqvaor4GMP
gRX/y4jtF9zhC3Ddxta581jntTu+qL9qFueHxbVagBFxI0Iy6/Ht6UXPx2ia/ziS
MbmH17KMQJtRUB704znAh4DPIkHZ7VKGK+Ty365PoF1bm3Qrc/CQwN9+Yj/34rnz
m21WjaI1A0BSZRTVnuKwl5O80Szv9oRvorhjq4cVedrMbONZ21No0/JctFBAaBML
qF7/YI6mB1HuQG42NN6u8amC1eGYeGcILDLfoHo4D8cy1LBNdCHakkoXErRQwNmU
xTasC0P6gpW7BRxrjiRxYwDgi4MSdyTY5/7wi9NiKrW2H2pZIUE=
=nOAE
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--
