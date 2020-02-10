Return-Path: <cygwin-patches-return-10056-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 120883 invoked by alias); 10 Feb 2020 10:05:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 120873 invoked by uid 89); 10 Feb 2020 10:05:17 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-109.6 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_2,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_SBL autolearn=ham version=3.3.1 spammy=HX-Languages-Length:525
X-HELO: mout-xforward.kundenserver.de
Received: from mout-xforward.kundenserver.de (HELO mout-xforward.kundenserver.de) (82.165.159.5) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 10 Feb 2020 10:05:16 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MlfL0-1jjk672IYk-00ilzD for <cygwin-patches@cygwin.com>; Mon, 10 Feb 2020 11:05:13 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 45F09A80CFA; Mon, 10 Feb 2020 11:05:13 +0100 (CET)
Date: Mon, 10 Feb 2020 10:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix state mismatch caused in mintty.
Message-ID: <20200210100513.GC4442@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200209144730.489-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="uXxzq0nDebZQVNAZ"
Content-Disposition: inline
In-Reply-To: <20200209144730.489-1-takashi.yano@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00162.txt


--uXxzq0nDebZQVNAZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 485

On Feb  9 23:47, Takashi Yano wrote:
> - PTY has a bug reported in:
>   https://cygwin.com/ml/cygwin/2020-02/msg00067.html.
>   This is the result of state mismatch between real pseudo console
>   attaching state and state variable. This patch fixes the issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 16 ++++++++++++++--
>  winsup/cygwin/fork.cc         |  2 ++
>  2 files changed, 16 insertions(+), 2 deletions(-)

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--uXxzq0nDebZQVNAZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5BKtkACgkQ9TYGna5E
T6AvVQ/9E2pP2Er5wFe/VMhlGShfH9nxW+G9JLH2O6vVim3J5BcpRzm7eKzr2Rjt
yJRRdDkjAk1rpqpGBKgFQ28iNSyilt7R0MQtIRD2FlcC2fgS/Mg2zqubAlMrPQCc
m711QWbaUGdORsrPWn9HioKLfZIxH42OnKwRj+tuJOO/tBTN7U3I4fUEwaWvNKmd
HjQjifCrlFDeY3eP+8Utb6U3D2BfGEfMUVFrSUBkJSS1nr2PSYSIRCDRS85zxxyI
Qv+UpSd1y0uJZoJF3Mq6kB2U1XRaTpgyTFqTMaUzca460EATY0gPjRuB3EYODaEo
5QU54d2FsuswfkI4QtxoSq+kOq3Hw7ZeQFRIq2+9ptPS7quZgp58jkRoMriwD7w0
HQxLw3ZkVeQG+AboovcRpilY7I8Js2LAvoPQNgYpXpavFRC1LepRL69X4Ufk3q4l
wRoHtMIEnhy/aNWQY5FPzQdG7OG7XbdLE54jl/hTcsIPukR3nicbsXDSTP6ISwik
+LypoP9FPSamCHKAetz4fV1/UaJCjoJPkAI53s5sGrqonDVkWfGWlYxF5wvXEmtI
oAlzVERlBr4AGZrFkXPd8GAeGSL0htv6PEUYkxQ97ODm3gs6WXYSqnzF3Rn1BkdN
i/M2kR9lzQzpIK8MqzK7lHoEjSOal5BqbXUDuES2dvsy3KezTw4=
=nb4B
-----END PGP SIGNATURE-----

--uXxzq0nDebZQVNAZ--
