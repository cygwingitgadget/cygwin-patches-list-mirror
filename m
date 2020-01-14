Return-Path: <cygwin-patches-return-9936-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 130371 invoked by alias); 14 Jan 2020 16:31:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 130361 invoked by uid 89); 14 Jan 2020 16:31:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-108.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=HX-Languages-Length:1745
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 14 Jan 2020 16:31:07 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N94FT-1jlYAJ1zCZ-0164qM for <cygwin-patches@cygwin.com>; Tue, 14 Jan 2020 17:31:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id E9AC5A806E3; Tue, 14 Jan 2020 17:31:03 +0100 (CET)
Date: Tue, 14 Jan 2020 16:31:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Add code to restore console mode on close.
Message-ID: <20200114163103.GY5858@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200102131716.1179-1-takashi.yano@nifty.ne.jp> <20200113162553.GO5858@calimero.vinschen.de> <20200114103718.ca09c3251527ffcdc328c5cb@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="QLVwfW7TUsi22t4P"
Content-Disposition: inline
In-Reply-To: <20200114103718.ca09c3251527ffcdc328c5cb@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00042.txt


--QLVwfW7TUsi22t4P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1730

On Jan 14 10:37, Takashi Yano wrote:
> Hi Corinna, welcome back!
>=20
> On Mon, 13 Jan 2020 17:25:53 +0100
> Corinna Vinschen wrote:
> > On Jan  2 22:17, Takashi Yano wrote:
> > > - The console with 24bit color support has a problem that console
> > >   mode is changed if cygwin process is executed in cmd.exe which
> > >   started in cygwin shell. For example, cursor keys become not
> > >   working if bash -> cmd -> true are executed in this order.
> > >   This patch fixes the issue.
> >=20
> > Is that supposed to work for deeper call trees as well?
>=20
> I think so.
>=20
> > I'm asking because I tried something like
> >=20
> >   bash -> cmd -> bash -> cmd=20
> >=20
> > and it turned out that the cursor keys don't work at all in the second
> > cmd, while they work fine again in the first cmd when returning to it.
>=20
> The cursor key itsself works in this case. You can edit command line
> by left and right arrow keys. However, history does not work in this
> situation. This seems to be because the history buffers are exhausted.
>=20
> The same happens if you try
>=20
> cmd -> cmd -> cmd -> cmd -> ........ -> cmd
>=20
> in command prompt without cygwin.
>=20
> I confirmed that history works in this situation if NumberOfHistoryBuffers
> is increased using SetConsoleHistoryInfo(). The default value of
> NumberOfHistoryBuffers seems to be 4 in windows 10.
>=20
> The history buffer seems to be consumed by any process which attached to
> the same console. Therefore, the same happens by
>=20
> bash -> bash -> cmd

Ok, interesting.  I wasn't aware of that.

I pushed all of your outstanding patches now and I'll create a
developer snapshot in a bit.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--QLVwfW7TUsi22t4P
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl4d7McACgkQ9TYGna5E
T6C6GQ//QxRQuPhme8tjcpO5ZNxoXytltp1AP9lTWhzsI7cZ+B4R0O7bJa1ndQHc
J/CdfY9rRvV8jTk2sGWrLlDtjdfyKAFiaKthMzjdfHx8cm4TBrAfLLJMsQaxID6a
sG4Ms7Z6s1goi1OD9KrXZZHepao+RUH8D0dIkyfwAHHaQS/OJDAdhUnmb5e74aAz
T90F7OanJf8VyW/0sP6gqfEKFmRVNsFFX+4Q1Ayqk8x/fGJCqGinwuHN4Ycl+swt
3w5SB1Dz02mlgpkiHD8h7Jmjzw/vjPGlj3sB8yAJHinCa93kO6Ip/o05uqgsw3Cb
XOJJSyCQLkaBd+EQMVij+p8oSkrxDE4Nu5pTZN3qH+A2r5bU/ecq7Dd/A15O+e0L
vOlKqxASC4+Y9IMdGbpfth/dBsbixViSj7K9eQzFXrVaUD6/lRUB5F9+hLAaoLth
1eLjYywsPPPzYtRktv68bA4iTcEeY/YC9ufkn2JcXz7iW048uuovKiiuBDk7Os6C
ha4IgfjdSxajxJmYq8KzgU1dYdpnHFhRGx341vb4nuTvIZnjxcFy+eM3DPAXCd6O
H7iM4CdVxN8u0ECJsXQVjeSCHCIa0+HzGB/mDbC+jiGNvv2HL4EWVc7p+uK0Xdv9
yqZOlm4uWk2GO0+3ynQOCKD6ywoJq9IbyEv2QyETWDKw2PJyQNQ=
=Ke1t
-----END PGP SIGNATURE-----

--QLVwfW7TUsi22t4P--
