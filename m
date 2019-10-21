Return-Path: <cygwin-patches-return-9772-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48124 invoked by alias); 21 Oct 2019 13:42:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 47801 invoked by uid 89); 21 Oct 2019 13:42:29 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-105.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=scenarios, H*F:D*cygwin.com, screen, personal
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Oct 2019 13:42:28 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MwQw1-1i3Uvs2j0X-00sMRr for <cygwin-patches@cygwin.com>; Mon, 21 Oct 2019 15:42:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 72236A80734; Mon, 21 Oct 2019 15:42:24 +0200 (CEST)
Date: Mon, 21 Oct 2019 13:42:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable clear screen for ssh sessions with -t option.
Message-ID: <20191021134224.GK16240@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20191018113721.2486-1-takashi.yano@nifty.ne.jp> <20191018143306.GG16240@calimero.vinschen.de> <20191019085051.4d2cc80811854d21b193fed6@nifty.ne.jp> <20191021094356.GI16240@calimero.vinschen.de> <20191021195515.7ca1a3a7f7f85cca79ad80b0@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Content-Disposition: inline
In-Reply-To: <20191021195515.7ca1a3a7f7f85cca79ad80b0@nifty.ne.jp>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SW-Source: 2019-q4/txt/msg00043.txt.bz2


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1174

On Oct 21 19:55, Takashi Yano wrote:
> On Mon, 21 Oct 2019 11:43:56 +0200
> Corinna Vinschen wrote:
> > So it seems cmd.exe is the only (or one of few) native CLI tools
> > actually trying to manipulate the screen buffer.  And what it does is
> > not so much clearing the screen, but to align buffer line 1 with the top
> > of the screen, even if line 1 has been produced before cmd.exe started.
>=20
> Powershell also redraws the screen.
> netsh is even worse. The cursor position will be broken by the follwing
> steps.
>=20
> 1) env TERM=3Ddumb script
> 2) netsh
> 3) winhttp show proxy
>=20
> > Other than that, my very personal opinion here is, not clearing the
> > screen is more desired than the terminal type and application name (or
> > SID) hacks just to pamper cmd.exe.  Others may disagree, so I'm open to
> > discussion.
>=20
> Even with Microsoft-provided OpenSSH server, the screen is cleared
> upon login. Therefore, clearing screen is not so strange, I suppose.

Yes, but I assume this is done in MSFT's OpenSSH server, not in the
kernel or system lib

To me the problem is if it breaks Cygwin scenarios.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl2ttcAACgkQ9TYGna5E
T6Dswg/8DV9cp1XudPGJvPt6QCIauImUTvCwtgUKr8q8/euEx4MdLVbky17xC/Nq
+b0z6nALiz3ML1uMtbqvPDT+f3MCGfIRHFwx8I5yEYBWhbpg6a1dxD2hpXZkaXby
eaFu1ZvW+aPMniQjmYT4Z6ZS4wtR1Ekf2OMZS4gS5/4LuWCdio6kZ16BeES0v9CU
a09J4DcRJ6uyNnm88Uwg/hlxwmCGzb6q/IT9zRxWEPfXeqBICaERLE1WKZFOkYcs
qZEN/zq6G14ZhQC3bZsvhj7D6qE5JePuUmYvV8fz5GKiOqEIa4A+gq6wHl3wsdtD
N3AyrB3a7XwQOQMO61botuBVT4V6RvW2Z+PJdLviNJNJOvVV4dDt+N2U0loPPmk6
rEcGJC+eU6JOuz9FzSvyJf5f+TZgRnwH6JxpFhCBMo1IEhLG1DqGS8dFM3Te7D5s
nzYvWM5S7iXp7IGB4PLozH1Rm4ByhH0jI9qFXJfoBanweCru0PuCuHRLLIfF6Doy
ymadZ4886jsT79rJS/FZNhMU7ipFiW87IMr/MGQXm5XZwj5b4o8eJRs7WmGwlduS
XDRMnoHSATIXrYkTLphebTYjR/zYst6Tm+Kxho9M1InRQf32eA78XGrKg/g6+R6D
HOXmFIGPpR7zCEz2ncVXf1TOplyxyxWnrI2Q2WJhq22khsNEDJ4=
=Z7Bk
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
