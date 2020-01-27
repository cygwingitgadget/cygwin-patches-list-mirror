Return-Path: <cygwin-patches-return-10010-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70411 invoked by alias); 27 Jan 2020 09:28:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70402 invoked by uid 89); 27 Jan 2020 09:28:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-107.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.10) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 27 Jan 2020 09:28:05 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1N0WPK-1jq3Fu1OAG-00wRly for <cygwin-patches@cygwin.com>; Mon, 27 Jan 2020 10:28:02 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EF058A80753; Mon, 27 Jan 2020 10:28:01 +0100 (CET)
Date: Mon, 27 Jan 2020 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Revise code waiting for forwarding again.
Message-ID: <20200127092801.GC3549@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200122160755.867-1-takashi.yano@nifty.ne.jp> <20200123043007.1364-1-takashi.yano@nifty.ne.jp> <20200123125154.GD263143@calimero.vinschen.de> <20200123231623.ed57b0af319d1de545f2ab7c@nifty.ne.jp> <20200124110730.GG263143@calimero.vinschen.de> <20200125203837.e37257365f30d33002f9e9f6@nifty.ne.jp> <20200126223319.211269b451e91da6eb7f4795@nifty.ne.jp> <20200127113822.98cc07b396b6dba26d53edeb@nifty.ne.jp> <20200127132232.43aa849e14d9a4b5bc0313e9@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline
In-Reply-To: <20200127132232.43aa849e14d9a4b5bc0313e9@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00116.txt


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2174

On Jan 27 13:22, Takashi Yano wrote:
> On Mon, 27 Jan 2020 11:38:22 +0900
> Takashi Yano wrote:
> > On Sun, 26 Jan 2020 22:33:19 +0900
> > Takashi Yano wrote:
> > > On Sat, 25 Jan 2020 20:38:37 +0900
> > > Takashi Yano wrote:
> > > > On Fri, 24 Jan 2020 12:07:30 +0100
> > > > Corinna Vinschen wrote:
> > > > > Too bad.  It's pretty strange that CreatePseudoConsole returns a
> > > > > valid HPCON but then isn't ready to take input immediately.
> > > > >=20
> > > > > > I do not come up with other implementation so far.
> > > > > >=20
> > > > > > Let me consider a while.
> > > > >=20
> > > > > I wonder how others solve this problem.  I see that the native Op=
enSSH
> > > > > is using Sleeps, too, in their start_with_pty() function, calling
> > > > > AttachConsole in a loop, but I'm not sure if these are related to=
 pseudo
> > > > > console usage.  The commit message don't explain anything there :(
> > > >=20
> > > > The essence of the difficulty is that we have to support both cygwin
> > > > programs and native console apps. If we consider only of native con=
sole
> > > > apps, any time we can use pseudo console. However, pseudo console is
> > > > not transparent at all, so it cannot be used for cygwin programs.
> > > >=20
> > > > Therefore, current cygwin is switching handles to be used between
> > > > named-pipe and pseudo console.
> > > >=20
> > > > However, because pseudo console has relatively long latency, if pipe
> > > > is switched just after writing to pseudo console, the forwarding
> > > > does not get in time. So the "wait" is needed before switching.
> > > >=20
> > > > I had tried WriteFile(), ReadFile() and DeviceIoControl() for
> > > > HANDLE hConDrvReference, however, all atempts of them failed.
> > >=20
> > > After much struggle, I finally found a solution.
> > > Please look at v3 patch.
> >=20
> > v3 patch does not seem to work as expected in Win10 1809.
> > I will submit v4 patch.
>=20
> Sorry for again and again.

This is tricky stuff.  No worries at all.

> I think v5 is more fundamental fix than v4.

I didn't see a v5 yet.  It's still in the works, I take it?


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4urSEACgkQ9TYGna5E
T6DgJhAAlOjJU6NFSJlMJZqEIVPhwyZ6xdE8Dr4u06oIrpIhsm1imXND4aCE3Mug
BI3O+q/iDCN/u0wRJxtBlD1MAbwQtJku3F0D440cHnzpSE8aW65bX2axEYKAeFUA
09ithwuJ6PT7chrM2nib9+AQBOUH34mhhK9LyrBj07IuXVssJ84KKpVwP+GWTlgx
5dQSGt5KwQw7SjgE6dY2SISnBITleivOICn/J4DKgZjeo75oG5Vr55i2VrC4pQMA
gDPiv3TsLnlSb9Ad284uFTcJRzfoHxnojNwKsRuEY2RcrivFgQs3ZKfNe5P+x/Ny
XyoLoHHNcBfbtb5f+y2zq/5ABO22iRfBiX5tA8U6yzjjVhKVnCv/ucM1akGtp2K2
SsVtTFS4auyBB88gDdB6eRisBNgU7Y0Zm2cJpvMmDuLNFIaLxg1VPt20uuYW0yQH
Ngp27O7fgs+Hbvxx5l0bbO3roSb3VTTdgIV2vQD527zTf8ja8nxw0zfwU1rKB03d
Dv4RrWW6biCT0gy7Wt9PTtkwpaEMKqXG2hAtAt+2DpVUpwjb31i6jdppmt+zUP2t
Qp/FUXARASUuN0J/SqCqYRlpXdawYP8MVclje1S1y6vKPfZOskHmzr+5LFI4bkR6
z4py1bGlxT0fb2gqiCYgfJ90UbojzQqYKmd6Xq/GQ+VdgnJkC20=
=HE2+
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
