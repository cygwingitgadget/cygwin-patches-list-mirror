Return-Path: <cygwin-patches-return-10092-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77280 invoked by alias); 20 Feb 2020 14:22:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77271 invoked by uid 89); 20 Feb 2020 14:22:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1865
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 14:22:49 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MXH3Y-1iwciu28EA-00YgDZ for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 15:22:46 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C2E79A8086E; Thu, 20 Feb 2020 15:22:45 +0100 (CET)
Date: Thu, 20 Feb 2020 14:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200220142245.GU4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="S0GG+JvAI2G0KxBG"
Content-Disposition: inline
In-Reply-To: <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00198.txt


--S0GG+JvAI2G0KxBG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1857

On Feb 20 23:13, Takashi Yano wrote:
> On Thu, 20 Feb 2020 14:44:59 +0100
> Corinna Vinschen wrote:
> > On Feb 20 14:35, Corinna Vinschen wrote:
> > > On Feb 20 20:51, Takashi Yano wrote:
> > > > - In xterm compatible mode, 0x00 on write() behaves incompatible
> > > >   with real xterm. In xterm, 0x00 completely ignored. Therefore,
> > > >   0x00 is ignored by console with this patch.
> > > > ---
> > > >  winsup/cygwin/fhandler_console.cc | 10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > > [...]
> > >=20
> > > Counter-proposal:
> > >=20
> > > diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandl=
er_console.cc
> > > index 66e645aa1774..1b3aa0f34aa6 100644
> > > --- a/winsup/cygwin/fhandler_console.cc
> > > +++ b/winsup/cygwin/fhandler_console.cc
> > > [...]
> >=20
> > Btw., I tested this with
> >=20
> >   write (1, "A\0B\0C\0D", 7);
> >=20
> > it turned out that this results in broken output even with your patch.
> > The reason is that a NUL byte must not (cannot) be evaluated by=20
> > dev_console::str_to_con() -> sys_cp_mbstowcs().  The latter doesn't
> > handle embedded NUL bytes gracefully.
>=20
> Indeed. Your patch is much better.
>=20
> On Thu, 20 Feb 2020 14:35:31 +0100
> Corinna Vinschen wrote:
> > But, here's a question: Why do we move the cursor to the right at all?
> > I assume this is compatible with legacy mode, right?
>=20
> Hmm. This may be a bug of legacy console.
> https://en.wikipedia.org/wiki/Null_character
> says
> (some terminals, however, incorrectly display it as space)
>=20
> What about ignoring NUL in legacy mode too?

I'd like that, but this may be a problem in terms of backward
compatibility.  The behaviour is so old, it actually precedes even the
import of Cygwin code into the original CVS repository, 20 years ago...


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--S0GG+JvAI2G0KxBG
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5OljUACgkQ9TYGna5E
T6B+FA//cRIXFPpjTXxGpu7+qMNOceGOLUvv37yIVigMRB5vJC15I1yMBRso6gep
vJyvmajUe/K+vZU0LpGYBNI8vMBV01G+yGP2137FeBMBhCVwAHXDtpHqkFgd2uBZ
ZLCAmmTLuuCctVMgxwzviTEk869Wt0LzJDUdootVOHo5XwYiMi+ejgH8RayT6jQ8
CgCMUAtZ0r9a8378cQm3AlOYKd2FmMr61ej28RE8D/WTBj5C/qpczDzsCSUnuwD/
PI9VS0DDmMqFid1SInz2hXgq0N/NzFb14d3YMF2b3s8p77Y4y5p5bqQyfARw9bd9
ilOZGUUrnd9Y9ya4TL+zVZFQx4Ffc69k96Bv8OTgk8B5zwFqiv6Pbxm3a18UpVSc
NwrsbvjedthWvgLMnWswKYfOz24lb9P6N3zsMIBj5z3RTyk9ESTMUZ2Zy7al9go8
QbuFCygnVsQtSrtQGbYp9t0G9+cfsJs+aQIJi/YhBFJC2FqEP8y4rKJfq8ZJ8PEb
CGyQjk1eSM4Pd7ZAPhoDaJpM/jLcNG6Bv0o5SqCBRNOKePYFPao/t3ECSqCf/r63
Xwb6Nj/KltS258xu/aOFclMp+7SwVg1gt6cdPcJrSZz1/w1bpToxjjEFoBgUfRZh
kWyaSq1FO5CkHO+88wUISWE5IVxA2pLJZkhja+kbNXb7LPHFmxY=
=iDvh
-----END PGP SIGNATURE-----

--S0GG+JvAI2G0KxBG--
