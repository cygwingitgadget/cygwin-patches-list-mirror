Return-Path: <cygwin-patches-return-10098-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30861 invoked by alias); 21 Feb 2020 09:33:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 29647 invoked by uid 89); 21 Feb 2020 09:33:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Feb 2020 09:32:58 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MvJsF-1jMKNb3lTN-00rFLl for <cygwin-patches@cygwin.com>; Fri, 21 Feb 2020 10:32:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id F1683A80863; Fri, 21 Feb 2020 10:32:53 +0100 (CET)
Date: Fri, 21 Feb 2020 09:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200221093253.GX4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp> <20200220142245.GU4092@calimero.vinschen.de> <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp> <20200220160401.GV4092@calimero.vinschen.de> <db2b11d3-8499-55be-5384-8d6c623138f0@towo.net> <20200220163804.GW4092@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="K3vkeaB0MlFjg8U+"
Content-Disposition: inline
In-Reply-To: <20200220163804.GW4092@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00204.txt


--K3vkeaB0MlFjg8U+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2200

On Feb 20 17:38, Corinna Vinschen wrote:
> On Feb 20 17:22, Thomas Wolff wrote:
> > On 20.02.2020 17:04, Corinna Vinschen wrote:
> > > On Feb 20 23:49, Takashi Yano wrote:
> > > > On Thu, 20 Feb 2020 15:22:45 +0100
> > > > Corinna Vinschen wrote:
> > > > > On Feb 20 23:13, Takashi Yano wrote:
> > > > > > On Thu, 20 Feb 2020 14:44:59 +0100
> > > > > > Corinna Vinschen wrote:
> > > > > > > But, here's a question: Why do we move the cursor to the righ=
t at all?
> > > > > > > I assume this is compatible with legacy mode, right?
> > > > > > Hmm. This may be a bug of legacy console.
> > > > > > https://en.wikipedia.org/wiki/Null_character
> > > > > > says
> > > > > > (some terminals, however, incorrectly display it as space)
> > > > > >=20
> > > > > > What about ignoring NUL in legacy mode too?
> > > > > I'd like that, but this may be a problem in terms of backward
> > > > > compatibility.  The behaviour is so old, it actually precedes eve=
n the
> > > > > import of Cygwin code into the original CVS repository, 20 years =
ago...
> > > > If so, can't we say it is the *specification* of TERM=3Dcygwin
> > > > that NUL moves the cursor right?
> > > Good point.  Yes, in that case it's "working as designed" and
> > > we just leave it as is.  I push my patch.
> > See `man 5 terminfo`: if NUL does anything else than just padding, the
> > terminfo entry must contain a pad or npc entry, which it doesn't.
> > Trouble to be expected. I'd rather suggest to align the design with
> > applications' expectations.
>=20
> Is that the cygwin terminfo or the xterm terminfo you're talking about?
>=20
> In case of the cygwin terminfo, that would mean the cygwin terminal
> emulation behaves differently from the terminfo for ages.  I guess
> you're right then, we should fix this in the cygwin terminal emulation
> to make sure it behaves as descibed in its terminfo.
>=20
> In case of the xterm terminfo, that would be no problem because my patch
> drops the cursor movement for NUL.

Yeah, never mind, I checked the cygwin terminfo entry myself.

I pushed a patch removing the cursor movement on NUL and added
a matching comment instead.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--K3vkeaB0MlFjg8U+
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5Po8UACgkQ9TYGna5E
T6DwOg//WVc3HGO1o7uR5K/TEN35CoUp0FOVaXuoC+AtCrCzNNPDneNEysTyJzmr
Zfr5RTBw/osnfV/BgSilFJNYy+vMrthxdH/SAZX9MExZ+4vRjHQ/QrLe1RQDqbS+
aZ7b6HAfJ/apoSlcK9k7DHwwCZQouLxWF/zMo8NEOnWBOLAqJ/N3SsAxYJiJ6VjG
zbnqtX/1t3/cf8/tPydQuV6NuzIG6HAuDETfU2As4Yj9TE1JZy0C+xA6hL3In5Js
IRn+dgx35PfXCHD5fQVSBlmNsNpAwSvX6BKfDaGgEZ2+XSMOZNwc34w8R/Brd5Wc
xBlDzuEOuCC2hdlB3wrdlvAie97vhVJhUCyi3H3xE3z4bUtBwA7Ig2RCPJZ+ipbJ
u0An/8s0QV/eGX5z/F9trcRp2sONDtS4tM/5o/cnsBtlHv/IL4bQbrUda8SR4vID
mq4UjVxrYNgfWe5FB6+3qdOMWSMD8iocrrZRDMKC0ISDY0/MgPy/8wgUtD6PIsu0
rS3RUy9lZ5CtN9LDRl6VDQLlb3F/ZNjIHF79CNXIBdVJqXlcrIBgInYe94S7OJt0
uHdCuVTMzVe+EygLILhZW6OhVwQgFyxqV/WjhIvG1pFXynMi5q90GQ6XLGrIigeP
m4qnoytrxWkfsnOnSLylmJoqib0p6ixYGPTWz7iAj+N0Adn9juA=
=jycq
-----END PGP SIGNATURE-----

--K3vkeaB0MlFjg8U+--
