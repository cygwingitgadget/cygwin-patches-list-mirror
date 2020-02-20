Return-Path: <cygwin-patches-return-10094-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95080 invoked by alias); 20 Feb 2020 16:04:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95070 invoked by uid 89); 20 Feb 2020 16:04:07 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-119.2 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 20 Feb 2020 16:04:06 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MfHIb-1jfnwm2SXz-00gt6W for <cygwin-patches@cygwin.com>; Thu, 20 Feb 2020 17:04:03 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E2EFAA8086E; Thu, 20 Feb 2020 17:04:01 +0100 (CET)
Date: Thu, 20 Feb 2020 16:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Ignore 0x00 on write().
Message-ID: <20200220160401.GV4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200220115145.2033-1-takashi.yano@nifty.ne.jp> <20200220133531.GR4092@calimero.vinschen.de> <20200220134459.GS4092@calimero.vinschen.de> <20200220231312.8d7f478d578970fca29098bf@nifty.ne.jp> <20200220142245.GU4092@calimero.vinschen.de> <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wg9FEZT+WCTrEXgJ"
Content-Disposition: inline
In-Reply-To: <20200220234943.2d3bf6ca40d95166a5960051@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00200.txt


--wg9FEZT+WCTrEXgJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2369

On Feb 20 23:49, Takashi Yano wrote:
> On Thu, 20 Feb 2020 15:22:45 +0100
> Corinna Vinschen wrote:
> > On Feb 20 23:13, Takashi Yano wrote:
> > > On Thu, 20 Feb 2020 14:44:59 +0100
> > > Corinna Vinschen wrote:
> > > > On Feb 20 14:35, Corinna Vinschen wrote:
> > > > > On Feb 20 20:51, Takashi Yano wrote:
> > > > > > - In xterm compatible mode, 0x00 on write() behaves incompatible
> > > > > >   with real xterm. In xterm, 0x00 completely ignored. Therefore,
> > > > > >   0x00 is ignored by console with this patch.
> > > > > > ---
> > > > > >  winsup/cygwin/fhandler_console.cc | 10 ++++++++++
> > > > > >  1 file changed, 10 insertions(+)
> > > > > > [...]
> > > > >=20
> > > > > Counter-proposal:
> > > > >=20
> > > > > diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fh=
andler_console.cc
> > > > > index 66e645aa1774..1b3aa0f34aa6 100644
> > > > > --- a/winsup/cygwin/fhandler_console.cc
> > > > > +++ b/winsup/cygwin/fhandler_console.cc
> > > > > [...]
> > > >=20
> > > > Btw., I tested this with
> > > >=20
> > > >   write (1, "A\0B\0C\0D", 7);
> > > >=20
> > > > it turned out that this results in broken output even with your pat=
ch.
> > > > The reason is that a NUL byte must not (cannot) be evaluated by=20
> > > > dev_console::str_to_con() -> sys_cp_mbstowcs().  The latter doesn't
> > > > handle embedded NUL bytes gracefully.
> > >=20
> > > Indeed. Your patch is much better.
> > >=20
> > > On Thu, 20 Feb 2020 14:35:31 +0100
> > > Corinna Vinschen wrote:
> > > > But, here's a question: Why do we move the cursor to the right at a=
ll?
> > > > I assume this is compatible with legacy mode, right?
> > >=20
> > > Hmm. This may be a bug of legacy console.
> > > https://en.wikipedia.org/wiki/Null_character
> > > says
> > > (some terminals, however, incorrectly display it as space)
> > >=20
> > > What about ignoring NUL in legacy mode too?
> >=20
> > I'd like that, but this may be a problem in terms of backward
> > compatibility.  The behaviour is so old, it actually precedes even the
> > import of Cygwin code into the original CVS repository, 20 years ago...
>=20
> If so, can't we say it is the *specification* of TERM=3Dcygwin
> that NUL moves the cursor right?

Good point.  Yes, in that case it's "working as designed" and
we just leave it as is.  I push my patch.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--wg9FEZT+WCTrEXgJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5OrfEACgkQ9TYGna5E
T6CfEA/7B9qDmfd8fX/sVAdqD4k8xbqQ+enPQuDfF1HIJkPAoiW576UI3EF5tRih
kD9bzKhcBkNL670tMM9xixGmCQKAIvvlX6ZyqRQcPiHeFC9p474yaGYzxYP2ACB9
f5U+99UpXDeXDWmPMOqiqnPzexRGyFNCTUEv+UxVaqW+wcxlRcZYX9z73RqndNgD
jP5rbYfyCcF7XCSyJ46eSzTjHDGl0oAwFnCPUxabWVWO+PLZegUUWMXMuI+7GYnE
lTMKSP6CaEgNP8NQuWwG+fmCIWxwcX41R7YIx6x93rmvHg2/1HRKzxfTSGMjFavB
dbTxovPef8dLzvue4FYQBikUfeiyhI6ig7GnCQwu2OH+Z8IUQehJS/Swg/wzzLMY
NfvTN+Bp72/AcPeu5DTd8ZTOSXm2NcD20ceByvd2waA3pcvXg9PK13YPG5t1/sX7
B793EpC7Dokxi5t8c64Sq2XhecFgOBeFoM2+7MeLLEndl1/NiUWDfr8kcSM6rCjE
aOHgM79u2X02H0S5NAvI6jhdgzB9Cv8vy3cDROpejkQA/6sCR3r8NqbpT1k7m8yO
EjI47ECsa3J52Bbqr+n0F1OYBbK2juY1Docxi+/QsYOznkTY+wFR41aefwNE1rZy
e9JxRdVciK/+J7sw+E3TOrPEX12jhIKZiy9EPcj3wIHiQ/wPdbY=
=laXV
-----END PGP SIGNATURE-----

--wg9FEZT+WCTrEXgJ--
