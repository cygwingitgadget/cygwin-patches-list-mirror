Return-Path: <cygwin-patches-return-9816-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2819 invoked by alias); 8 Nov 2019 11:10:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 2805 invoked by uid 89); 8 Nov 2019 11:10:02 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.6 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=sessions, HX-Languages-Length:820, screen, H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 08 Nov 2019 11:09:59 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MCs9W-1ibrr22d6W-008q4W for <cygwin-patches@cygwin.com>; Fri, 08 Nov 2019 12:09:56 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E9E9BA8065B; Fri,  8 Nov 2019 12:09:55 +0100 (CET)
Date: Fri, 08 Nov 2019 11:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191108110955.GC3372@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191022162316.54c3bc2ff19dbc7ae1bdedf2@nifty.ne.jp> <20191022080242.GN16240@calimero.vinschen.de> <20191022182405.0ce3d7c17b0e7d924430b89c@nifty.ne.jp> <20191022134048.GP16240@calimero.vinschen.de> <20191023122717.66d241bd0a7814b7216d78f5@nifty.ne.jp> <20191023120542.GA16240@calimero.vinschen.de> <20191024100130.4c7f6e4ac55c10143e3c86f6@nifty.ne.jp> <20191024093817.GD16240@calimero.vinschen.de> <20191024191724.f44a44745f16f78595ae1b43@nifty.ne.jp> <20191024133305.GF16240@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Bi+HF1AHjw0mn3zx"
Content-Disposition: inline
In-Reply-To: <20191024133305.GF16240@calimero.vinschen.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00087.txt.bz2


--Bi+HF1AHjw0mn3zx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 756

Hi Takashi,

On Oct 24 15:33, Corinna Vinschen wrote:
> On Oct 24 19:17, Takashi Yano wrote:
> > On Thu, 24 Oct 2019 11:38:17 +0200
> > Corinna Vinschen wrote:
> > > Well, what I see when starting cmd.exe with this patch is a short
> > > flicker in the existing output in mintty, but the cursor position
> > > stays the same. and cmd.exe output is where you'd expect it.
> >=20
> > I mean:
> > 1) start mintty
> > 2) ps
> > 3) script
> > 4) cmd
> >=20
> > In my environment, output of ps command disappears.
>=20
> In mine, too.  This does not occur w/o running script.

Any news here?  Why does this only occur with script?  Is that something
about reusing (or not reusing) the existing pseudo console?


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--Bi+HF1AHjw0mn3zx
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl3FTQMACgkQ9TYGna5E
T6DSHw/8DYKXgCIoUP6ks/GFxtTUJr5bLqITQ2Uq1Ya8xy4aPMl2ByDvijU7KFYW
1FCX3q1wLY1Frcrx4OLYtWYbBvq6IJydeAaC5U31app9mmkDewKlcj7oca+ZgrRn
S6JnPfagWVig/K5fsMvO1gBafBf2MS8xsURncQJecYSw+WuHCiHvrx1t8B6BIO4H
O8OHfXjZlJVXCPSwgBsZ0rG7r8r8LjjpJKGjmzmj7jV5FE6JJGDTVvGVDlAcHMES
4mexGvK1yZJ3AhVf1P7R42uemCGK19/7s5TOj+EOrgxn9jadeBh/bXqtfdSUesY3
dJi5cr/gYADWiEzinVHArr5Av0OdSPSfrX29ga/Wu7hHvDGoXGs/Djl/J51K5X4A
fHjWHWarj+hUQJLr3jaZ2pfyYtgJV4tIeA6smID9TxAVKKaQQEOK638c3Np7WLx+
sbTAY02DslKADKlwh5KeQXXuUyUHrnKtNvIoMIy+rMOcX8ZB1CqKL3+7OY0njAPM
jjYhR8xpxLTuqUVWwaUS1SDntgEh/CAFA76GhexNGVLSLGcIw/IgGwI03W0NmwSW
i2PF8HIQi0VyhW6c2ZvEsUx3FhHzBKRPbuk9TfO7aCITyHpFeyBMLGbrvLd7D3Sn
E3GU88Zaetnf8JMILbdClhpHd8nh12/Ub5aoQyOlZ2NFWxo5yAM=
=mzqY
-----END PGP SIGNATURE-----

--Bi+HF1AHjw0mn3zx--
